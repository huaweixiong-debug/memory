# Langguo ZCode desktop automation follow-up

Date: 2026-09-29

- Use ZCode Desktop Computer Use for the Langguo QA automation; do not substitute the CLI or API-key provider. The model selector showed GLM-5.3-Flash checked under the `Start Plan / Free` group and reasoning set to highest. This UI selection alone does not prove the request reached inference or which quota was charged.
- A manually triggered desktop run at 2026-09-29 02:50 failed after 10 seconds. The UI history also showed failures at 02:28 (7 seconds), 02:19 (10 seconds), and scheduled runs at 00:00, 01:00, and 02:00 (7–17 seconds). Runs at 21:00–23:00 on 2026-09-28 had succeeded in about 1m54s–1m57s.
- The history menu offered only “jump to session” and “delete record”; attempting to open the recent failed session stayed on the history screen, and no error detail was shown. Treat this as an unresolved ZCode startup/request failure with no review verdict. Do not count as QA PASS.