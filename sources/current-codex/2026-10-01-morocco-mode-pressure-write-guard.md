# Morocco PLC mode/pressure write guard (2026-10-01)

来源：Codex 当前账号。

- Read-only inspection of the authoritative Morocco PLC point workbook found that all 26 A/B point addresses match the application map; M0.5 and M0.4 are the documented pressure outputs, and neither the workbook nor `OPC.lvlib` documents a single/dual mode bit.
- An isolated offline candidate on `codex/morocco-mode-pressure-write-guard-20261001` removes automatic test-mode writes while preserving local mode propagation and the separately permission/confirmation-gated manual pressure command. The branch remains uncommitted and unmerged.
- Focused offline tests pass (2 passed). The full suite has 2 known baseline failures, reproduced on pristine HEAD. ZCode reviewed in plan mode through the Morocco failover wrapper and returned PASS using Start Plan GLM-5.3-Flash/max; no fallback and no API-key provider were used.
- Before LIVE use, confirm the field source of single/dual mode. Follow-up: add write-spy coverage for scan, validation-start, and restore paths; track the two unrelated full-suite failures.
- Evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-morocco-mode-pressure-write-guard` and `P:\Langguo_AI\repos\lg-industrial-core-stage-20260928\docs\pilot-compatibility.md`.