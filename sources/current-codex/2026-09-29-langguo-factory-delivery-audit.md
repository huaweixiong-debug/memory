# 2026-09-29 Langguo-Agent-Factory delivery audit

- User preference for this review window: operate ZCode Desktop through Computer Use and use the personal Coding Plan model GLM-5.3-Flash at the highest setting; do not use API-key tokens.
- ZCode Desktop performed a read-only review of the factory delivery changes. It found no blocking worktree/attestation bypass and three reproducible task-isolation/process-boundary defects: case-variant .agent path prefixes, nested paths beneath another task ID, and Git resolving to a .cmd/.bat/.ps1 shim.
- Codex fixed the path classifier to compare .agent and category names case-insensitively and scan every remaining path component. Git execution now rejects the same shell shim suffixes as GitHub CLI execution.
- Regression coverage includes mixed-case/backslash paths, nested task artifacts blocking QA handoff and delivery, and Git shim refusal.
- Verification: Python 3.10 tests/test_task_delivery.py passed 61 tests and 71 subtests; git diff --check passed with only LF/CRLF notices.
- Factory repository changes remain local and uncommitted. No GitHub delivery, PR, merge, production database, or device operation was performed.
