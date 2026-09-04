#requires -Version 5.1
# ChatGPT Proxy Guard (portable)
# Monitors the local Clash/mihomo ("南美" client) proxy. If ChatGPT is unreachable
# through the current node, switches the selector group node-by-node until one
# can reach ChatGPT. Never gives up: no overall timeout, cycles repeat endlessly.
# Ports and group are auto-detected from %APPDATA%\南美\config.yaml when present.
param(
    [switch]$RunOnce
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Console]::OutputEncoding = [Text.Encoding]::UTF8

# ----- auto-detect core settings -----
$MixedPort   = '17890'
$Controller  = '127.0.0.1:8765'
$GroupHint   = 'Pluto'
$nanmeiConfig = Join-Path $env:APPDATA ('南美' + [IO.Path]::DirectorySeparatorChar + 'config.yaml')
if (-not (Test-Path -LiteralPath $nanmeiConfig)) {
    # fallback: app install dir config
    $alt = Get-ChildItem 'C:\Program Files (x86)' -Directory -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.FullName 'resources\static\clash\config.yaml') } |
        Select-Object -First 1
    if ($alt) { $nanmeiConfig = Join-Path $alt.FullName 'resources\static\clash\config.yaml' }
}
if (Test-Path -LiteralPath $nanmeiConfig) {
    $cfg = Get-Content -LiteralPath $nanmeiConfig -Encoding UTF8
    $mPort = $cfg | Select-String '^\s*mixed-port:\s*(\d+)\s*$' | Select-Object -First 1
    if ($mPort) { $MixedPort = $mPort.Matches[0].Groups[1].Value }
    $mCtl = $cfg | Select-String "^\s*external-controller:\s*'?([0-9.]+:\d+)" | Select-Object -First 1
    if ($mCtl) { $Controller = $mCtl.Matches[0].Groups[1].Value }
    $mRule = $cfg | Select-String '^\s*-\s*MATCH,(\S+)\s*$' | Select-Object -First 1
    if ($mRule) { $GroupHint = $mRule.Matches[0].Groups[1].Value }
}

$ApiBase    = "http://$Controller"
$ProxyUrl   = "http://127.0.0.1:$MixedPort"
$TestUrl    = 'https://chatgpt.com/robots.txt'
$LogDir     = Join-Path $PSScriptRoot 'logs'
$LogFile    = Join-Path $LogDir 'guard.log'

$HealthyIntervalSec     = 60    # check interval when everything works
$ConfirmFailIntervalSec = 5     # quick re-check to confirm a failure
$AllFailIntervalSec     = 30    # pause between full candidate cycles when nothing works
$ProbeTimeoutSec        = 10    # per-request timeout (network level only)
$FailThreshold          = 2     # consecutive failed checks before switching
$InfoNodePattern        = '剩余|流量|官网|到期|过期|套餐|重置|订阅|时间|防失联'

# ----- single instance guard -----
$mutexCreated = $false
$script:mutex = New-Object System.Threading.Mutex($true, 'Global\ChatGptProxyGuard', [ref]$mutexCreated)
if (-not $mutexCreated) { exit 0 }

# ----- logging -----
function Write-Log {
    param([string]$Message)
    if (-not (Test-Path -LiteralPath $LogDir)) {
        New-Item -ItemType Directory -Path $LogDir | Out-Null
    }
    if ((Test-Path -LiteralPath $LogFile) -and ((Get-Item -LiteralPath $LogFile).Length -gt 5MB)) {
        Move-Item -Force -LiteralPath $LogFile -Destination ($LogFile + '.old')
    }
    $line = '{0} {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
    [IO.File]::AppendAllText($LogFile, $line + "`r`n", (New-Object Text.UTF8Encoding $false))
    Write-Host $line
}

# ----- Clash API helpers -----
# NOTE: use WebClient with explicit UTF-8. Invoke-RestMethod (PS 5.1) decodes
# responses as Latin-1 when the core omits charset, which mangles Chinese node
# names and makes every switch request fail with 400.
function Invoke-ClashApi {
    param([string]$Method, [string]$Path, [object]$Body)
    $uri = $ApiBase + $Path
    $wc = New-Object System.Net.WebClient
    $wc.Encoding = [Text.Encoding]::UTF8
    $wc.Proxy = $null
    try {
        if ($null -ne $Body) {
            $json = ConvertTo-Json $Body -Compress
            $reqBytes = [Text.Encoding]::UTF8.GetBytes($json)
            $wc.Headers.Add('Content-Type', 'application/json; charset=utf-8')
            $respBytes = $wc.UploadData($uri, $Method.ToUpperInvariant(), $reqBytes)
        } else {
            $respBytes = $wc.DownloadData($uri)
        }
        if ($respBytes -and $respBytes.Length -gt 0) {
            return [Text.Encoding]::UTF8.GetString($respBytes) | ConvertFrom-Json
        }
        return $null
    } finally {
        $wc.Dispose()
    }
}

function Get-SelectorGroup {
    $all = Invoke-ClashApi -Method Get -Path '/proxies'
    $names = @($all.proxies.PSObject.Properties.Name)
    if ($names -contains $GroupHint) {
        return $all.proxies.$GroupHint
    }
    foreach ($n in $names) {
        $p = $all.proxies.$n
        if ($p.type -eq 'Selector' -and $n -ne 'GLOBAL' -and @($p.all).Count -gt 3) {
            return $p
        }
    }
    throw 'no usable selector group found'
}

function Get-LastDelay {
    param($ProxyObj)
    $h = @($ProxyObj.history)
    if ($h.Count -eq 0) { return $null }
    return $h[$h.Count - 1].delay
}

function Get-Candidates {
    param($Group, $AllProxies, [string]$CurrentName)
    $list = @()
    foreach ($name in @($Group.all)) {
        if ($name -match $InfoNodePattern) { continue }   # info/notice nodes
        if ($name -eq $CurrentName)        { continue }   # already failing
        $info = $AllProxies.proxies.$name
        if ($null -eq $info) { continue }
        $list += [pscustomobject]@{ Name = $name; Delay = (Get-LastDelay $info) }
    }
    # try nodes with a known recent delay first, fastest first; untested last
    return @($list | Sort-Object -Property `
        @{e={ if ($_.Delay) { 0 } else { 1 } }}, `
        @{e={ if ($_.Delay) { [double]$_.Delay } else { [double]99999 } }})
}

function Switch-GroupTo {
    param([string]$GroupName, [string]$NodeName)
    $path = '/proxies/' + [Uri]::EscapeDataString($GroupName)
    Invoke-ClashApi -Method Put -Path $path -Body @{ name = $NodeName } | Out-Null
}

# ----- ChatGPT reachability test -----
# Success ONLY on HTTP 200. 403 means Cloudflare-blocked exit IP; anything else
# (timeout, TLS error, 5xx) also counts as failure.
function Test-ChatGpt {
    try {
        $resp = Invoke-WebRequest -Uri $TestUrl -Proxy $ProxyUrl -UseBasicParsing `
            -TimeoutSec $ProbeTimeoutSec -Headers @{ 'User-Agent' = 'Mozilla/5.0' }
        if ($resp.StatusCode -eq 200) { return @{ Ok = $true; Detail = 'HTTP 200' } }
        return @{ Ok = $false; Detail = "HTTP $($resp.StatusCode)" }
    } catch {
        $code = $null
        if ($_.Exception.Response) {
            try { $code = [int]$_.Exception.Response.StatusCode } catch { $code = $null }
        }
        if ($code -eq 403) { return @{ Ok = $false; Detail = 'HTTP 403 (IP blocked by ChatGPT)' } }
        if ($code)         { return @{ Ok = $false; Detail = "HTTP $code" } }
        return @{ Ok = $false; Detail = ($_.Exception.Message -split "`r?`n")[0] }
    }
}

# ----- main loop -----
$threshold = 1
if (-not $RunOnce) { $threshold = $FailThreshold }

Write-Log ("guard started (api={0}, proxy={1}, group={2})" -f $ApiBase, $ProxyUrl, $GroupHint)
$failStreak = 0
while ($true) {
    try {
        $group = Get-SelectorGroup
        $groupName = $group.name
        $current = $group.now
        $check = Test-ChatGpt

        if ($check.Ok) {
            if ($failStreak -gt 0) { Write-Log "node '$current' works again: $($check.Detail)" }
            $failStreak = 0
            if ($RunOnce) { Write-Log "RunOnce: node '$current' healthy, done"; break }
            Start-Sleep -Seconds $HealthyIntervalSec
            continue
        }

        $failStreak++
        Write-Log ("check failed on '{0}' ({1}/{2}): {3}" -f $current, $failStreak, $threshold, $check.Detail)
        if ($failStreak -lt $threshold) {
            Start-Sleep -Seconds $ConfirmFailIntervalSec
            continue
        }

        # current node is (still) unusable -> run one full candidate cycle
        Write-Log "starting switch cycle from '$current'"
        $allProxies = Invoke-ClashApi -Method Get -Path '/proxies'
        $candidates = Get-Candidates -Group $group -AllProxies $allProxies -CurrentName $current
        Write-Log ("{0} candidate(s): {1}" -f $candidates.Count, (($candidates | ForEach-Object { $_.Name }) -join ' | '))

        $switched = $false
        foreach ($c in $candidates) {
            try {
                Switch-GroupTo -GroupName $groupName -NodeName $c.Name
                Start-Sleep -Milliseconds 800   # let the core apply the selection
                $t = Test-ChatGpt
                if ($t.Ok) {
                    Write-Log ("switched to '{0}': {1}" -f $c.Name, $t.Detail)
                    $switched = $true
                    break
                }
                Write-Log ("candidate '{0}' failed: {1}" -f $c.Name, $t.Detail)
            } catch {
                Write-Log ("candidate '{0}' switch error: {1}" -f $c.Name, ($_.Exception.Message -split "`r?`n")[0])
            }
        }

        $failStreak = 0
        if ($switched) {
            if ($RunOnce) { break }
            Start-Sleep -Seconds 3
        } else {
            Write-Log 'all candidates failed; retrying endlessly (no timeout by design)'
            if ($RunOnce) { break }
            Start-Sleep -Seconds $AllFailIntervalSec
        }
    } catch {
        Write-Log "loop error: $(($_.Exception.Message -split "`r?`n")[0])"
        if ($RunOnce) { break }
        Start-Sleep -Seconds 15   # API/core temporarily down -> wait and retry forever
    }
}
Write-Log '===== guard stopped ====='
