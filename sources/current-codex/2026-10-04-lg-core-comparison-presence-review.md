# Langguo Core missing-key versus explicit-null review — 2026-10-04

来源：Codex 当前账号；隔离 Core worktree，基于 PR #2 head `88a5b6e`。

- OpenCode DeepSeek V4.1 Flash/max changed only `recording.py` and `test_recording.py` in the bounded session delta. `ComparisonMismatch` now carries `expected_present` / `actual_present`; missing mapping keys are distinguishable from explicit JSON null while the old three-argument constructor defaults remain valid.
- Verification recorded for the isolated Core + template invocation: 219 passed; focused recording tests 71 passed; `git diff --check` clean. Existing unrelated dirty files in the worktree were preserved. No project commit, push, PR edit, merge, or release occurred.
- ZCode CLI Start Plan / GLM-5.3-Flash / high returned one unrelated stale report, then a fresh evidence-checked read-only review returned PASS. Codex independently reviewed the exact delta and accepted it. Temporary ZCode provider settings were restored byte-for-byte.
- This candidate remains isolated and is not included in PR #2; PR #2 remains open at the prior head. Roadmap readiness remains roughly 33% (30–35%); this diagnostic hardening did not advance a phase gate. Field/source and actual-cost evidence gates remain open.
- Evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-lg-core-comparison-presence\REVIEW_PACKET.md` and `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-lg-core-review-hardening-fix1\worktree`.