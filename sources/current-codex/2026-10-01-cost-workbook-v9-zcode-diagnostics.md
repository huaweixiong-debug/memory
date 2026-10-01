# 2026-10-01 — Cost workbook V9 and ZCode wrapper diagnostics

Source: Codex current account.

- Preserved cost workbook V8 and created V9 (`ee46a126c5c4d437e5ce5da1699e0763f071946e42d2e4ab87414f53227304f8`) with only the full-recalculation workbook properties and instruction-sheet version label changed. All 4,200 formulas and 12 validations remain. 4,190 formulas still have no cached result; no actual purchase/labor/rework evidence exists.
- WPS was tested only on a temporary copy. Its saved copy still had 4,190 missing formula caches and differed in 1,600 formula strings and many OOXML members; do not use its output. V9 remains unchanged. Formula results need a compatible Excel recalculation and save before use as calculated totals.
- ZCode failover wrapper uses the currently configured provider as its first attempt. This account was Start Plan / GLM-5.3-Flash / max. A minimal read-only prompt returned PASS through the wrapper without switching. Longer review calls timed out; a UNC caller directory produced a Windows UNC working-directory warning, and using a local temp directory removed that warning but not the longer-call timeout. Provider configuration hash remained unchanged; actual quota failover was not triggered or tested, and no personal-plan/API-key invocation occurred.
