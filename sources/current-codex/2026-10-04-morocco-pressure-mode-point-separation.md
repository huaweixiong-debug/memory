# Morocco pressure output and test-mode separation

Date: 2026-10-04. Source: current Codex task.

- Original Morocco PLC workbook and OPC variable library both label A=M0.5 and B=M0.4 as positive/negative-pressure-open outputs; the original file hashes were rechecked.
- A disposable copy at D:\CodexIsolated\morocco-pilot removed the unsourced test_mode PLC mapping and UI writes while preserving pressure coordinates, application-level single/dual cycle records, and the administrator manual-output confirmation path.
- Offline evidence: focused tests 38 passed, Morocco root 179 passed, python_app 141 passed. Full tree manifest had 867 original entries; exactly seven allowlisted source files changed, no source files out of scope, and 92 test-cache files were generated.
- ZCode review used GLM-5.3-Flash/high through the configured BigModel Coding Plan fallback and returned PASS. The Start Plan attempt did not return a verdict within the bounded wait. The saved ZCode model selection was restored.
- The shared Morocco source directory remains unchanged: all seven source hashes still match the pre-edit baseline. The correction exists only in the reviewed disposable copy. PLC runtime behavior, ports, LIVE/field acceptance, and production use remain unverified; no roadmap gate advanced.
- Ten-capability roadmap workload estimate remains about 33% (rough range 30–35%), an approximate weighted estimate rather than formal earned value.
- Evidence: C:\Users\Administrator\.codex\opencode-executor\runs\20261004-morocco-pressure-mode-point-separation-isolated\REVIEW_PACKET.md and ZCODE_REVIEW.md.
