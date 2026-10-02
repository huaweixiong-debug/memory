# 2026-10-02 — Cost workbook V9 independent formula-engine audit

Source: Codex current account.

- On a byte-identical copy of V9, isolated Python 3.10.11 with `formulas[excel]==1.3.4` resolved all 4,200 formula cells, reported zero unresolved cells and formula error values, and matched all 10 existing cached values. The outputs were 4,190 empty strings and 10 nonempty values. Source workbook SHA-256 remained `EE46A126C5C4D437E5CE5DA1699E0763F071946E42D2E4AB87414F53227304F8` (134,131 bytes); no workbook save/export occurred.
- This is independent in-memory calculation only. Excel/WPS native recalculation remains unverified; source receipts for actual purchase, invoices, labor and rework were not available, so blanks remain unknown rather than zero and actual-cost acceptance remains open. Morocco/ATEQ and later release gates remain open.
- The 2026-10-02 report supplement was corrected to avoid claiming unsupported XML extensions cannot affect solving. It now records both reader warnings and says their effect was not verified. Shared-formula inventory wording states 2,600 `t=shared` formula-text cells and 0 no-text dependents; this is not a count of shared-formula groups.
- The requested ZCode CLI / GLM-5.3-Flash / high review on `account:bigmodel-individual-coding-plan` could not start because the isolated app-server could not resolve the model in Provider Registry without an entitlement assertion. No review prompt or attachments were sent, persistent ZCode settings were unchanged, and no reviewer PASS was claimed.
- Audit report: `P:\Langguo_AI\company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\成本工作簿V9结构与重算状态审计_2026-10-01.md`. Machine-readable evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-v9-formula-engine-audit\`.
