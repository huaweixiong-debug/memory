$ErrorActionPreference = 'Stop'
$source = 'C:\Users\Administrator\.codex\sessions'
$root = 'P:\memory\current_account_memory'
$threads = Join-Path $root 'threads'
New-Item -ItemType Directory -Force -Path $threads | Out-Null
$files = Get-ChildItem -LiteralPath $source -Recurse -File -Filter 'rollout-*.jsonl'
$index = [System.Collections.Generic.List[string]]::new()
$cards = [System.Collections.Generic.List[string]]::new()
function Clean([string]$s) {
  if ([string]::IsNullOrWhiteSpace($s)) { return '' }
  $s = $s -replace '(?i)(password|passwd|token|api[_-]?key|secret)\s*[:=]\s*[^\s,;]+', '$1: <REDACTED>'
  $s = $s -replace '(?i)(sk-[A-Za-z0-9_-]{10,}|ghp_[A-Za-z0-9]{10,}|eyJ[A-Za-z0-9._-]{20,})', '<REDACTED>'
  $s = $s -replace '\r?\n+', ' '
  if ($s.Length -gt 1200) { $s = $s.Substring(0,1200) + '...' }
  return $s.Trim()
}
foreach ($file in $files) {
  $meta = $null; $users = [System.Collections.Generic.List[string]]::new(); $assistants = [System.Collections.Generic.List[string]]::new()
  foreach ($line in Get-Content -LiteralPath $file.FullName) {
    try { $o = $line | ConvertFrom-Json } catch { continue }
    if ($o.type -eq 'session_meta') { $meta = $o.payload }
    if ($o.type -ne 'response_item') { continue }
    $p = $o.payload
    if ($p.type -ne 'message') { continue }
    $text = (($p.content | Where-Object { $_.type -in @('input_text','output_text') } | ForEach-Object { $_.text }) -join "`n")
    if ($p.role -eq 'user' -and $text) { $users.Add((Clean $text)) }
    if ($p.role -eq 'assistant' -and $text) { $assistants.Add((Clean $text)) }
  }
  if (-not $meta) { continue }
  $id = [string]$meta.id
  $date = ([datetime]$meta.timestamp).ToString('yyyy-MM-dd')
  $title = if ($users.Count) { $users[0] } else { '(无用户文本)' }
  $last = if ($assistants.Count) { $assistants[$assistants.Count-1] } else { '(无助手文本)' }
  $card = "# $title`n`n- 账号：本机当前账号`n- 会话 ID：$id`n- 日期：$date`n- 原始记录：$($file.FullName)`n`n## 用户请求`n`n$title`n`n## 最后结果摘录`n`n$last`n"
  Set-Content -LiteralPath (Join-Path $threads "$id.md") -Value $card -Encoding UTF8
  $entry = [ordered]@{ id=$id; date=$date; title=$title; source=$file.FullName; card="threads/$id.md" } | ConvertTo-Json -Compress
  $index.Add($entry); $cards.Add("- [$title](threads/$id.md) — $date")
}
$index | Set-Content -LiteralPath (Join-Path $root 'chat_index.jsonl') -Encoding UTF8
$sorted = $cards | Sort-Object
$body = @('# Current account chat memory','',"Generated: $([datetime]::Now.ToString('o'))",'',"Sessions: $($index.Count). User request and last assistant result are retained; common credentials are redacted.",'', '## Session index','') + $sorted
$body | Set-Content -LiteralPath (Join-Path $root 'MEMORY.md') -Encoding UTF8
@('# Current account Memory','', '- `MEMORY.md`: entry point and session index', '- `chat_index.jsonl`: machine-readable index', '- `threads/`: per-session memory cards', '- Raw rollouts are not copied; cards retain local read-only paths.') | Set-Content -LiteralPath (Join-Path $root 'README.md') -Encoding UTF8
