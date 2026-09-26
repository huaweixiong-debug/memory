# Langguo GitHub and daemon smoke milestone — 2026-09-26

Codex current-account note.

- TASK-0001's safe GitHub issue intake completed Architect → OpenCode → ZCode → GPT-6 Luna/high Reviewer. Three findings were repaired across attempts; final state is APPROVED at attempt 2. Intake and auto-import remain disabled by default; no live issue import was run.
- The implementation was committed as `0fb44bd` on `feature/github-issue-intake` and pushed to the user-selected private repository `huaweixiong-debug/Langguo-Agent-Factory`. PR #1 is open and both Windows CI runs passed. Merge remains a user decision; do not merge without approval.
- Original TASK-0003 remains BLOCKED at attempt 2 because its final-attempt-zero acceptance conflicts with the recorded repair increment. It was not reset or overwritten.
- A fresh TASK-0006 completed the existing long-running Orchestrator daemon → Architect → OpenCode → scheduled ZCode → Reviewer path and reached APPROVED / ORCHESTRATOR / attempt 0. Repository-local daemon evidence was captured. The daemon stayed single-instance.
- The existing Windows Task Scheduler entry `Langguo Agent Factory Orchestrator` is enabled, interactive at user logon, `IgnoreNew`, `StartWhenAvailable`, with three restart attempts. During this session both P: and its UNC target were accessible. No duplicate scheduler entry was created; cold-boot/NAS timing was not tested.
- The ZCode QA automation prompt now explicitly forbids host process/task-scheduler queries and out-of-repository evidence access; daemon checks must use task-repository evidence or report the gap.
- Next approval gate: user review/merge of PR #1. Keep auto-deploy, hardware writes, GitHub auto-import, and auto-merge disabled.