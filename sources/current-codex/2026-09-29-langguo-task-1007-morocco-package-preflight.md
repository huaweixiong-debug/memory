# Langguo Morocco TASK-1007 package-preflight acceptance

Date: 2026-09-29
Source: Codex current account

- OpenCode executor repaired `python_app/tools/package_preflight.py` so process-start `OSError` (including Windows `PermissionError`) becomes a bounded failed run. Two regression tests prove staged launch denial is recorded as `run:staged-diagnose` and cannot produce `PREFLIGHT_PASS`; Codex reran the focused suite after the repair: 57 passed.
- The earlier actual preflight built the temporary bundle and passed both temporary SIMULATE runs, then Windows denied starting the staged EXE with `WinError 5`. Per the task SPEC, the staged executable was not retried after denial; no ACL was changed. The fixed denial behavior is covered by tests, while a real post-fix staged `PREFLIGHT_FAIL` run was not observed.
- ZCode Desktop independently reviewed the in-project sources using GLM-5.3-Flash from the BigModel Personal Coding Plan at highest reasoning, without API-key tokens. Its report is `QA_PASS`; it marks staged binary inventory, exact file counts/sizes, DLL inventory, recomputed SHA-256, and ZCode test execution as unverified limitations.
- Codex final review accepted the scoped preflight implementation and handed `TASK-1007` to `APPROVED / ORCHESTRATOR`, preserving `attempt=0`. This does not mean the candidate executed successfully or is approved for release or field use.