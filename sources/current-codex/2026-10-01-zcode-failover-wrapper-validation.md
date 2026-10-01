# ZCode failover wrapper validation

Source: Codex current account. Date: 2026-10-01.

- Inspected `C:\Users\Administrator\Documents\Codex\zcode-failover.ps1` (SHA-256 `A25B8F73D626FE58DB2642B43727BE30C940615AFF74A7B25181083A2AE09B8C`). Its default mode is `plan`; it tries the configured Start Plan provider first and only switches after a non-zero result whose output matches a quota-exhaustion pattern. The fallback is `account:bigmodel-individual-coding-plan`, followed by one retry.
- Two minimal live `-Mode plan` calls succeeded with the existing `account:bigmodel-start-plan / GLM-5.3-Flash` selection. The provider-config SHA-256 stayed `21F80F39AFFD7FDB0C3898756A43357686D51400619524F659967990A5BB2965` before and after.
- Calling the `.cmd` CLI wrapper while PowerShell's current directory is a UNC path emitted `CMD.EXE`'s unsupported-UNC warning and fell back to `C:\Windows`; invoking from a local path succeeded without that warning. Use a local working directory when project context matters.
- Actual quota exhaustion and failover were not tested. An isolated mock attempt was blocked before execution by the local command policy. Do not represent the switch/retry path as verified.
- The script rewrites the full provider configuration JSON during a switch. This has not been exercised against the real config; preserve a backup before any future explicit failover-path validation.
