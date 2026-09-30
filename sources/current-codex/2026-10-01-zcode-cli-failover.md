# 2026-10-01 ZCode CLI failover wrapper

Source: current Codex account.

- ZCode CLI 0.16.9 is available at `C:\Users\Administrator\AppData\Roaming\npm\zcode.cmd`; the default selection was verified as `account:bigmodel-start-plan / GLM-5.3-Flash`.
- Added `C:\Users\Administrator\Documents\Codex\zcode-failover.ps1`. It invokes the configured ZCode account provider in plan mode, switches only on a non-zero CLI exit with a recognized quota-exhaustion message, then retries once using `account:bigmodel-individual-coding-plan`. It does not call an API endpoint or supply an API key.
- The explicit `-PlanStart account:bigmodel-start-plan` command selects Start Plan again. The default is changed only after a quota marker is recognized.
- PowerShell parsing, representative quota/non-quota classifier cases, the Start Plan wrapper smoke call, and the unchanged Start Plan default were verified. Actual quota exhaustion and the personal-plan retry were not exercised; matching remains dependent on the CLI's emitted error text.
