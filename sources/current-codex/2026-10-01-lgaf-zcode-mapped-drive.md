# 2026-10-01 — LG-AF ZCode mapped-drive invocation

Source: Codex current account.

- The Morocco `zcode-failover.ps1` call timed out from the task's raw UNC working directory after CMD emitted its UNC-CWD warning. Starting the same script after `Set-Location P:\Langguo_AI\repos\lg-pilot-morocco-20260927` produced a mapped-drive `CallerDir` and a short plan-mode prompt returned PASS.
- For future short ZCode reviews, launch from the mapped `P:\` project directory. Large `.xlsx` attachments and longer review prompts still timed out in this run; a small JSON audit attachment worked. No script edit, provider switch, or personal-plan invocation was made.
