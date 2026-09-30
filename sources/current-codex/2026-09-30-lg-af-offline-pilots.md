# 2026-09-30 — LG-AF first-stage offline gates

Source: Codex current account.

- ZCode one-shot through `P:\Langguo_AI\repos\lg-pilot-morocco-20260927\zcode-failover.ps1` succeeded on current `account:bigmodel-start-plan` / GLM-5.3-Flash with max reasoning. Provider selection stayed on Start Plan. The quota exhaustion and persistent fallback branch was not exercised; do not claim it was proven. No API key value was inspected or printed.
- ATEQ pilot contract now matches Core's PLC-triggered monitor / optional software-start split: base `AteqPort` omits `start_test`; optional `AteqStartPort` adds it. The F620 `external_start` guard remains. Offline results: focused 16 passed, full 129 passed; ZCode packet review PASS. Evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20260930-lg-roadmap\ateq`.
- Morocco verification must point at `lg-industrial-core-stage-20260928\src`. Packaged-app full suite: 141 passed. Root full suite: 179 passed only after setting both `PYTHONPATH` and `LG_INDUSTRIAL_CORE_SOURCE` to the staged Core source; omitting the latter causes collection to fail before tests.
- Traceability pilot uses the staged Core source. Full suite 43 passed; CLI smoke for synthetic run/query/replay exited 0, first-step failure and rejected-label flows exited 1 as expected. Artifacts were placed in the Codex run directory, not the project checkout.
- Offline evidence does not establish field/release approval. Morocco candidate remains stale and lacks the required point map; site PLC addresses, ATEQ COM/slave/program, and laser file contract need source confirmation. ATEQ `points_confirmed` and `ports_confirmed` remain false. Cost workbook estimates still must not be treated as actuals without purchase/invoice/labor/rework evidence.
