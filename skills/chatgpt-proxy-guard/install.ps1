#requires -Version 5.1
# One-shot installer for ChatGPT Proxy Guard on a new machine.
# Run:  powershell -NoProfile -ExecutionPolicy Bypass -File install.ps1
# Assumes the "nanmei" Clash client is installed and logged in (same account).
[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Console]::OutputEncoding = [Text.Encoding]::UTF8

$skillDir  = $PSScriptRoot
$targetDir = Join-Path $env:USERPROFILE 'Tools\ChatGptProxyGuard'

function Info($m) { Write-Host ('[INFO] ' + $m) }
function Warn($m) { Write-Host ('[WARN] ' + $m) -ForegroundColor Yellow }
function Fail($m) { Write-Host ('[FAIL] ' + $m) -ForegroundColor Red; exit 1 }

# "nanmei" without literal Chinese in this ASCII-only file: U+5357 U+7F8E
$nanmei = [string][char]0x5357 + [char]0x7F8E
$nanmeiConfig = Join-Path $env:APPDATA (Join-Path $nanmei 'config.yaml')
if (-not (Test-Path -LiteralPath $nanmeiConfig)) {
    $alt = Get-ChildItem 'C:\Program Files (x86)' -Directory -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.FullName 'resources\static\clash\config.yaml') } |
        Select-Object -First 1
    if ($alt) { $nanmeiConfig = Join-Path $alt.FullName 'resources\static\clash\config.yaml' }
}
if (-not (Test-Path -LiteralPath $nanmeiConfig)) { Fail ('config.yaml not found - install/start the nanmei client first: ' + $nanmeiConfig) }
Info ('runtime config: ' + $nanmeiConfig)

# ----- detect core settings from config -----
$MixedPort  = '17890'
$Controller = '127.0.0.1:8765'
$GroupName  = $null
$cfg = Get-Content -LiteralPath $nanmeiConfig -Encoding UTF8
$mPort = $cfg | Select-String '^\s*mixed-port:\s*(\d+)\s*$' | Select-Object -First 1
if ($mPort) { $MixedPort = $mPort.Matches[0].Groups[1].Value }
$mCtl = $cfg | Select-String "^\s*external-controller:\s*'?([0-9.]+:\d+)" | Select-Object -First 1
if ($mCtl) { $Controller = $mCtl.Matches[0].Groups[1].Value }
$mRule = $cfg | Select-String '^\s*-\s*MATCH,(\S+)\s*$' | Select-Object -First 1
if ($mRule) { $GroupName = $mRule.Matches[0].Groups[1].Value }
$ApiBase  = 'http://' + $Controller
$ProxyUrl = 'http://127.0.0.1:' + $MixedPort
Info ('core api: ' + $ApiBase + '  mixed-port: ' + $MixedPort + '  group: ' + $GroupName)

# ----- UTF-8 safe API helper (PS5.1 Invoke-RestMethod mangles Chinese names) -----
function Invoke-ClashApi {
    param([string]$Method, [string]$Path, [object]$Body)
    $wc = New-Object System.Net.WebClient
    $wc.Encoding = [Text.Encoding]::UTF8
    $wc.Proxy = $null
    try {
        if ($null -ne $Body) {
            $json = ConvertTo-Json $Body -Compress
            $wc.Headers.Add('Content-Type', 'application/json; charset=utf-8')
            return $wc.UploadData(($ApiBase + $Path), $Method.ToUpperInvariant(), [Text.Encoding]::UTF8.GetBytes($json))
        }
        return $wc.DownloadData($ApiBase + $Path)
    } finally { $wc.Dispose() }
}
function Invoke-ClashJson([string]$Path) {
    ([Text.Encoding]::UTF8.GetString((Invoke-ClashApi -Method Get -Path $Path)) | ConvertFrom-Json)
}

# ----- verify core is alive -----
try { $null = Invoke-ClashJson '/version'; Info 'clash core API reachable' }
catch { Fail ('core API not reachable at ' + $ApiBase + ' - start the nanmei client first') }

# resolve selector group via API if MATCH rule was missing
if (-not $GroupName) {
    $all = Invoke-ClashJson '/proxies'
    $GroupName = ($all.proxies.PSObject.Properties |
        Where-Object { $_.Value.type -eq 'Selector' -and $_.Name -ne 'GLOBAL' -and @($_.Value.all).Count -gt 3 } |
        Select-Object -First 1).Name
}
if (-not $GroupName) { Fail 'no selector group found' }

# ----- ChatGPT routing probe: port traffic vs per-node delay test -----
function Probe-ChatGpt {
    try {
        $r = Invoke-WebRequest -Uri 'https://chatgpt.com/robots.txt' -Proxy $ProxyUrl -UseBasicParsing -TimeoutSec 10 -Headers @{ 'User-Agent' = 'Mozilla/5.0' }
        return ('HTTP ' + $r.StatusCode)
    } catch {
        if ($_.Exception.Response) { try { return ('HTTP ' + [int]$_.Exception.Response.StatusCode) } catch {} }
        return 'FAIL'
    }
}
function Test-NodeDelay([string]$Node) {
    $enc = [Uri]::EscapeDataString($Node)
    try {
        $d = ([Text.Encoding]::UTF8.GetString((Invoke-ClashApi -Method Get -Path ('/proxies/' + $enc + '/delay?timeout=6000&url=' + [Uri]::EscapeDataString('https://chatgpt.com/robots.txt')))) | ConvertFrom-Json)
        return $d.delay
    } catch { return $null }
}

$probe = Probe-ChatGpt
Info ('chatgpt.com through proxy port: ' + $probe)
if ($probe -ne 'HTTP 200') {
    # find any node that can reach chatgpt directly (delay test bypasses local rules)
    $groupInfo = Invoke-ClashJson ('/proxies/' + [Uri]::EscapeDataString($GroupName))
    $infoChars = [string][char]0x5269 + '|' + [string][char]0x6D41   # skip "remaining/traffic" info nodes
    $goodNode = $null
    foreach ($n in @($groupInfo.all)) {
        if ($n -match $infoChars) { continue }
        $d = Test-NodeDelay $n
        if ($d) { $goodNode = $n; Info ('node reachable to chatgpt: ' + $n + ' (' + $d + ' ms)'); break }
    }
    if ($goodNode) {
        Warn ('routing problem: nodes CAN reach chatgpt but port traffic does not (usually missing chatgpt domain rules + poisoned DNS/GEOIP)')
        # inject chatgpt/openai domain rules at top of rules section
        $bytes  = [IO.File]::ReadAllBytes($nanmeiConfig)
        $hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
        $text   = [Text.Encoding]::UTF8.GetString($bytes)
        if ($text -notmatch '(?m)^\s*-\s*.*chatgpt\.com') {
            $lines = $text -split "`r?`n"
            $out = New-Object System.Collections.Generic.List[string]
            $inserted = $false
            foreach ($line in $lines) {
                $out.Add($line)
                if (-not $inserted -and $line -match '^rules:\s*$') {
                    foreach ($r in @(
                        '  - DOMAIN-SUFFIX,chatgpt.com,' + $GroupName,
                        '  - DOMAIN-SUFFIX,openai.com,' + $GroupName,
                        '  - DOMAIN-SUFFIX,oaistatic.com,' + $GroupName,
                        '  - DOMAIN-SUFFIX,oaiusercontent.com,' + $GroupName,
                        '  - DOMAIN-KEYWORD,openai,' + $GroupName,
                        '  - DOMAIN-KEYWORD,chatgpt,' + $GroupName
                    )) { $out.Add($r) }
                    $inserted = $true
                }
            }
            if ($inserted) {
                $newText = ($out -join "`r`n")
                [IO.File]::WriteAllText($nanmeiConfig, $newText, (New-Object Text.UTF8Encoding($hasBom)))
                Info ('injected chatgpt/openai domain rules into ' + $nanmeiConfig)
                # reload core config so rules take effect immediately
                try {
                    Invoke-ClashApi -Method Put -Path '/configs?force=true' -Body @{ path = $nanmeiConfig; payload = '' } | Out-Null
                    Start-Sleep -Seconds 3
                    Info ('chatgpt.com after rule fix: ' + (Probe-ChatGpt))
                } catch {
                    Warn ('config reload failed: ' + $_.Exception.Message + ' - restart the nanmei client to apply rules')
                }
            } else {
                Warn 'rules: section not found in config; skipped rule injection'
            }
        } else {
            Info 'chatgpt domain rules already present in config'
        }
    } else {
        Warn 'no node can reach chatgpt right now - subscription may be dead; update subscription in the nanmei client. The guard will keep retrying either way.'
    }
}

# ----- install files -----
if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Force -Path $targetDir | Out-Null }
Copy-Item -Force (Join-Path $skillDir 'guard.ps1') (Join-Path $targetDir 'guard.ps1')
Info ('guard.ps1 installed to ' + $targetDir)

# ----- auto-start (Startup folder VBS, UTF-16LE so any user path works) -----
$startupDir = [Environment]::GetFolderPath('Startup')
$vbsPath = Join-Path $startupDir 'ChatGptProxyGuard.vbs'
$vbs = 'Set sh = CreateObject("WScript.Shell")' + "`r`n" +
       'sh.Run "powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File ""' + (Join-Path $targetDir 'guard.ps1') + '""", 0, False'
[IO.File]::WriteAllText($vbsPath, $vbs, [Text.Encoding]::Unicode)
Info ('autostart written: ' + $vbsPath)

# scheduled task only when elevated (optional extra resilience)
try {
    $identity   = [Security.Principal.WindowsIdentity]::GetCurrent()
    $elevated   = ([Security.Principal.WindowsPrincipal]$identity).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $highToken  = (whoami /groups | Select-String 'S-1-16-(12288|16384)') -ne $null
    if ($elevated -and $highToken) {
        $action  = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument ('-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "' + (Join-Path $targetDir 'guard.ps1') + '"')
        $trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
        $set = New-ScheduledTaskSettingsSet -ExecutionTimeLimit ([TimeSpan]::Zero) -RestartCount 999 -RestartInterval (New-TimeSpan -Minutes 1) -MultipleInstances IgnoreNew -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -Hidden
        Register-ScheduledTask -TaskName 'ChatGptProxyGuard' -Action $action -Trigger $trigger -Settings $set -RunLevel Highest -Force | Out-Null
        Info 'scheduled task registered (elevated shell)'
    } else {
        Info 'not elevated; startup-folder autostart is enough (mutex prevents duplicates)'
    }
} catch { Info ('scheduled task skipped: ' + $_.Exception.Message) }

# ----- start guard now -----
$log = Join-Path $targetDir 'logs\guard.log'
$logLenBefore = 0
if (Test-Path $log) { $logLenBefore = (Get-Item $log).Length }
Start-Process wscript.exe -ArgumentList ('"' + $vbsPath + '"') -WindowStyle Hidden
Start-Sleep -Seconds 8
if ((Test-Path $log) -and ((Get-Item $log).Length -gt $logLenBefore)) {
    Info '--- guard.log tail ---'
    Get-Content $log -Tail 5 -Encoding UTF8 | ForEach-Object { Write-Host ('       ' + $_) }
} else { Fail ('guard did not start (no new log entries) - check the VBS at ' + $vbsPath) }

Info 'DONE. The guard now auto-starts at logon and keeps ChatGPT reachable.'
