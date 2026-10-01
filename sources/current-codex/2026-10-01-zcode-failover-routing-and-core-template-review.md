# 2026-10-01 — ZCode failover routing and Core template review

Source: current Codex account. User-directed stable workflow: use `C:\Users\Administrator\Documents\Codex\zcode-failover.ps1 -Mode plan` for ZCode read-only reviews instead of calling `zcode -p` directly. The wrapper starts with the account Start Plan GLM-5.3-Flash at the configured maximum reasoning level and only switches to the personal Coding Plan after a recognized quota-exhaustion failure; do not use API-key tokens for Start Plan work. A cache-breakpoint warning is not a quota error. Real quota exhaustion/fallback is still not verified against the live gateway.

On 2026-10-01, used that wrapper for a bounded read-only review of Core PR #2 local head `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7`. ZCode returned PASS; provider remained Start Plan / GLM-5.3-Flash / max. OpenCode removed an unused `SimulatedStation.policy` field and clarified Fake-only execution versus the separate LIVE policy example; template tests passed 7/7, and `git diff --check` passed. The workflow `contents: read` adjustment and template changes remain local and uncommitted/unpushed; PR #2 remains OPEN.

Project evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-core-template-policy-clarity\` and `P:\Langguo_AI\company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\路线图实施台账_2026-09-28.md`.
