# 2026-10-01 — LG Industrial Core phase-one gates

Source: Codex current account.

- Current isolated Core revision: `eea4d2087f630f46a18541ec2aafb8362eff56ed`. On 2026-10-01, Core tests passed 129/129, template tests 5/5, and the Fake/in-memory compatibility checker passed for Morocco and ATEQ.
- Morocco local pilot base `b54c4eb12f7271a60b4a1cc7ad67a87088dfe2f7`: 168 passed, 1 skipped; the skip is the package-layout check because the source-only copy has no generated EXE. SIMULATE smoke passed. Do not present packaging as validated.
- ATEQ local pilot base `c22accdf965bf25ea8b6bca14c10910a6f82d0c9`: ZCode found that combined `--smoke-cycle --core-smoke-cycle` could silently bypass Core routing. The local fix now rejects both flags and converts missing Core imports to `CORE_SMOKE_BLOCKED`; 28 focused and 92 full tests passed, and ZCode re-reviewed PASS.
- Cost workbook was generated locally with four sheets, 11 blank QA probe ranges, and zero TEST-/formula-error matches. It is an empty capture template; actual project purchase, labor, and rework records are still needed before drawing cost conclusions.
- ZCode reviews used the account-based Start Plan GLM-5.3-Flash at max reasoning through the failover wrapper; no API-key route or fallback was used. A broad review timed out, while smaller focused reviews completed.
- The OpenCode executor twice failed on an unavailable stale shared path before editing anything. The local documentation refresh and small ATEQ guard correction were completed in the isolated local copies, tested, and reviewed.
- ATEQ `config/points.toml` labels its M-area values as placeholders borrowed from Morocco. Keep point/port confirmation false and do not consolidate or enable LIVE values until the electrical source is confirmed. Earlier Traceability staging test evidence is provisional until its exact snapshot and full logs are accessible.
- Next: audit source-confirmed points/alarms/HMI fields and the exact Traceability snapshot before phase-two adoption; populate the workbook only from the next real project’s estimates and actuals.