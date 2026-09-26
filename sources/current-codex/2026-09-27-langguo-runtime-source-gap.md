# Langguo runtime/source gap — 2026-09-27

- Current active Orchestrator process is PID 37400, launched by the enabled Windows Scheduled Task, and logs continue to show 15-second scans.
- The active runtime script at `P:\Langguo_AI\runtime\orchestrator\langguo-orchestrator.py` has SHA-256 `519B04ABF6FAE96E2163116064BFEE0F45114E78C4C222910405C9384198B014` and does not contain GitHub intake or task delivery modules.
- The source checkout on `feature/github-issue-intake` has SHA-256 `B6910A9D0EDF809E61E4371E7977F51AB233C4486AD6E04BEE77EB88EFBB1EB5` and includes `github_intake` and `task_delivery`; PR #1 and PR #2 remain open with Windows CI green. PR #2 explicitly requires human review/merge and automation has no merge path.
- Active factory config has no GitHub block, so issue intake and PR delivery are inactive. `auto_deploy_live=false` and `industrial_hardware_live_write=false` remain set. No active runtime file/config was modified and the running process was not restarted.
- Current local source checkout contains uncommitted TASK-0004 artifacts/changes; preserve them during any future integration work.
