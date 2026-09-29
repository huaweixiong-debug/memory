# 2026-09-29 LG roadmap: cost workbook synthetic formula verification

Source: Codex current account. The cost-capture workbook was imported into Artifact Tool and exercised only in memory with synthetic records.

- Fifteen assertions passed for procurement and labor estimate/actual rollups, rework material and labor totals, variance calculations, and status gates.
- Complete synthetic rows rolled up; incomplete actual rows remained pending with actual totals and variance blank. Explicitly recorded zero rework hours were accepted as complete.
- The workbook file hash was unchanged before and after; no synthetic values were saved to the workbook.
- This verifies formula behavior only. It does not supply real purchase, labor, or rework evidence, so the real estimate-to-actual cycle remains open.