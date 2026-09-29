# LG-AF ZCode desktop queue check — 2026-09-29

- User reconfirmed that ZCode work must be performed through the ZCode desktop app using Computer Use; do not switch to the ZCode CLI.
- The desktop showed GLM-5.3-Flash at highest reasoning. Its active `Langguo ZCode QA Worker` automation is a factory-wide hourly worker whose queue requires `IMPLEMENTED` with owner `ZCODE`; no eligible state means the run has no QA work.
- Morocco TASK-1004 and TASK-1005 remain `REPAIR_REQUIRED / OPENCODE`. Their ZCode desktop review conversations are separate from the generic hourly automation. TASK-1005's review independently confirmed missing `points.toml`; executable inventory and runtime checks remain unverified after the first Bash request was rejected under that task's stop rule.
- Do not force-run the no-work automation to substitute for the Morocco package repair. Continue with the implementation owner and request ZCode desktop review after a qualifying artifact is ready.
