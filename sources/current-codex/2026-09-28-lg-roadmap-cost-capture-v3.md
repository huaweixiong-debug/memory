# LG industrial roadmap and cost capture workbook — 2026-09-28

Source: Codex current account. Scope: company 10-capability phased roadmap.

- Created the blank v3 cost-capture pilot workbook at P:\Langguo_AI\company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\项目成本估算与实际记录_试点版_v3.xlsx from the existing v2, preserving v2. It documents capacity (100 projects, 200 BOM/purchase rows, 200 labor/rework rows) and protects formula cells while leaving yellow input cells unlocked; it contains no real project/customer/supplier/cost data.
- Excel formula verification used only a separate synthetic TEST_ONLY copy: complete case 700 estimate / 870 actual / 170 variance / 120 rework labor; incomplete actuals retain a pending status and suppress final variance. The delivered workbook was reopened read-only; tables, formulas, validations, conditional formats, protection and empty input areas were verified.
- Current offline evidence: Core plus template 134 tests pass with explicit staged source/template paths; Morocco active app 108 pass with staged Core; ATEQ suite 91 pass with staged Core. The first Core test attempt imported an obsolete site-packages build; corrected explicit import paths passed. Do not treat any of these offline results as production approval.
- Core PR #2 remains Draft/Open. CI Python 3.10–3.12 and package preflight are green; release publishing is skipped. No merge/release/deployment was performed.
- Stage-two capabilities remain gated until at least one follow-on project actually reuses the interfaces and a new project completes real estimate-to-actual cost records. No cost savings percentage or baseline is established yet.
- See company output ROADMAP status file and cost workbook verification record for current evidence.
