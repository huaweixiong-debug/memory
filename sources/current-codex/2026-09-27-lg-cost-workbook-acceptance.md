# 2026-09-27 — LG Industrial cost workbook acceptance

- Completed the first estimate-to-actual cost-capture workbook for project quote, BOM/purchasing, labor/rework, and instructions. Deliverable: \\100.117.1.6\projects\Langguo_AI\company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\项目成本估算与实际记录.xlsx.
- The blank template has four sheets. Detail statuses now require a project number before BOM P/Q and labor R/S can say estimate-complete or actual-recorded; incomplete/unknown inputs remain gated, explicit numeric zero remains a recorded value, and project variances appear only after complete estimate and actual capture.
- The workbook engine treats 0="" as true, so numeric presence checks must use ISNUMBER.
- GPT-6 Luna ultra final acceptance passed after an independent formula-engine import/recalculate check confirmed all four missing-project-number status pairs, zero formula errors, probe cleanup, and the unchanged blank export. XLSX formula results are not cached by the exporter; Excel/WPS should recalculate on open.
- This is a data-collection pilot only; no project prices, supplier costs, labor rates, or actual values were invented or entered.