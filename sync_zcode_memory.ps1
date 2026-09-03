# Sync ZCode memory into the shared GitHub repo.
# Usage: powershell -File sync_zcode_memory.ps1 -Message "one-line topic"
param([Parameter(Mandatory=$true)][string]$Message)

$repo = "C:\Users\Administrator\Documents\memory-share"
Set-Location $repo
git pull --rebase
if ($LASTEXITCODE -ne 0) { Write-Error "pull failed"; exit 1 }

# Edit sources/zcode/MEMORY.md (and other files) BEFORE running this script,
# or pass -File to stage extra files.
git add -A
git commit -m "memory: zcode $Message"
if ($LASTEXITCODE -eq 0) {
    git push origin main
} else {
    Write-Host "Nothing to commit."
}
