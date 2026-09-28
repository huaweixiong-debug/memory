# Langguo ZCode desktop automation follow-up

Date: 2026-09-29

- Use ZCode Desktop Computer Use for the Langguo QA automation; do not substitute the CLI or API-key provider. The model selector showed GLM-5.3-Flash checked under the `Start Plan / Free` group and reasoning set to highest. This UI selection alone does not prove the request reached inference or which quota was charged.
- A manually triggered desktop run at 2026-09-29 02:50 failed after 10 seconds. The UI history also showed failures at 02:28 (7 seconds), 02:19 (10 seconds), and scheduled runs at 00:00, 01:00, and 02:00 (7–17 seconds). Runs at 21:00–23:00 on 2026-09-28 had succeeded in about 1m54s–1m57s.
- The history menu offered only “jump to session” and “delete record”; attempting to open the recent failed session stayed on the history screen, and no error detail was shown. Treat this as an unresolved ZCode startup/request failure with no review verdict. Do not count as QA PASS.
## 2026-09-29 follow-up: quota cause and successful desktop rerun

- The failure cause was confirmed in the ZCode Desktop session: it displayed “体验套餐可用额度已用完”. The session history showed the model changing from the trial plan to the personal plan.
- Updated only the `Langguo ZCode QA Worker (Hourly)` automation model provider from Start Plan/Free to the built-in BigModel Personal GLM-5.3-Flash account route. Reasoning remained at highest. Reopened settings and verified the BigModel Personal row was checked. No API-key tokens, prompt edits, permission changes, or purchase flow were used.
- A Computer Use “run now” at 2026-09-29 03:07 completed successfully in 24 seconds. Its session scanned `factory-smoke-test` and reported no pending QA tasks: no `IMPLEMENTED/ZCODE` task existed; three tasks were `APPROVED/ORCHESTRATOR`, and `TASK-0003` remained `BLOCKED/ORCHESTRATOR` at attempt 2. No files or Orchestrator state were changed. This is `ZCODE_NO_WORK`, not Morocco/ATEQ acceptance.
