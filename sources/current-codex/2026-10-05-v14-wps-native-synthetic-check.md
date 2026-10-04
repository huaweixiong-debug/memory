# 2026-10-05 V14 WPS native synthetic recalculation

Source: Codex current account.

- V14 estimate-to-actual workbook was validated in a new isolated WPS COM instance (Application.Version 12.0) using two disposable copies. Original V14 was read-only inspected for formula identity but never opened by WPS or modified; existing WPS sessions were not touched.
- Formula text parity: 4,200/4,200. Complete synthetic case: 15/15 cell assertions passed. Missing-rework-reason case: 9/9 passed, with labor actual held as incomplete and project variance left blank. Both copies were closed without saving; source and copy hashes remained unchanged.
- These are synthetic formula-engine results, not actual cost evidence or Microsoft Excel rendering. Payment/invoice/delivery/acceptance and complete BOM/labor/rework records remain missing; no cost gate or roadmap phase advances. Overall estimate remains about 33% (30–35%).
- Detailed report and machine results: `C:\Users\Administrator\.codex\opencode-executor\runs\20261005-v14-wps-native-synthetic-check`.