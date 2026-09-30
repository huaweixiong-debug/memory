# 2026-10-01 ZCode CLI failover wrapper

Source: current Codex account.

- ZCode CLI 0.16.9 is available at `C:\Users\Administrator\AppData\Roaming\npm\zcode.cmd`; the default selection was verified as `account:bigmodel-start-plan / GLM-5.3-Flash`.
- The wrapper is `C:\Users\Administrator\Documents\Codex\zcode-failover.ps1`. It invokes the account provider in plan mode, switches only on a non-zero CLI exit with a recognized quota marker, then retries once using `account:bigmodel-individual-coding-plan`. It does not supply an API key.
- Fixed config replacement: `File.Replace(..., $null)` failed in this PowerShell/.NET environment. The script now uses a unique temporary backup path, atomically replaces the provider config, and removes the backup.
- Added explicit CLI error-code matching for `quota_exceeded`, `coding_plan_required`, and known quota/billing codes.
- Verified PowerShell parsing; mock `quota exceeded` and code-only `coding_plan_required` each switched and retried once; a mock authentication error kept Start Plan selected and returned the original failure. An isolated switch-back test changed the default from individual to Start Plan, retained GLM-5.3-Flash, and left no backup file.
- A real short plan-mode request returned `收到`; the current default remained Start Plan. No API key was used or displayed.
- Actual quota exhaustion and a real personal-plan retry were not exercised. The failover path is verified with mock CLI output; recognition of any new server error format may need a matching rule.
