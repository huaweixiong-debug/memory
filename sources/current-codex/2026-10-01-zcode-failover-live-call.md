# ZCode failover wrapper live call

Source: Codex current account. Date: 2026-10-01.

- At the user's direction, invoked the Morocco pilot copy `\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-morocco-20260927\zcode-failover.ps1` in `plan` mode using a temporary PowerShell process-scope execution-policy bypass. The Start Plan success path returned the requested short response with `account:bigmodel-start-plan / GLM-5.3-Flash`; local selection remained Start Plan with reasoning level `max`.
- The user-profile copy `C:\Users\Administrator\Documents\Codex\zcode-failover.ps1` and the Morocco pilot copy have different SHA-256 hashes and materially different implementations. Do not treat their validation as interchangeable. The user-profile copy has prior successful-call evidence in `2026-10-01-zcode-failover-wrapper-validation.md`.
- This invocation validates only the successful Start Plan path. Actual quota-exhaustion detection, persistent plan switch, and fallback retry remain unverified. No API-key provider was selected and no credentials were read or written.