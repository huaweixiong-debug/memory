# Morocco pressure output correction integrated in the shared source tree

Date: 2026-10-04. Source: current Codex task. This follow-up supersedes the earlier same-day checkpoint that only described the disposable copy.

- Integrated the reviewed seven-file pressure/test_mode separation patch into P:\Langguo_AI\repos\lg-pilot-morocco-20260927. The seven current source-file SHA-256 values match the reviewed reference copy byte-for-byte.
- The source no longer maps test_mode to M0.5/M0.4 or writes those bits from UI mode selection. pressure remains A=M0.5/B=M0.4; single/dual selection remains application cycle state; administrator manual-output authorization and confirmation remain.
- Tests on the canonical shared source tree: focused 38 passed, Morocco root 179 passed, python_app 141 passed. Python 3.10.11, Fake/offline, Qt offscreen; no pytest cache or bytecode writes.
- The filtered full source inventory remained 867 entries: exactly seven allowlisted source files changed, zero missing, zero new paths, zero out-of-allowlist metadata changes, and zero hash mismatches against the reviewed reference.
- ZCode review of the byte-identical patch was PASS using GLM-5.3-Flash/high through custom:bigmodel-plan. Start Plan did not return a verdict; the saved selection was restored.
- Physical PLC behavior, port confirmation, LIVE/field acceptance, and production acceptance remain open; no roadmap phase gate was advanced. The ten-capability estimate remains about 33% (rough range 30–35%).
- Evidence: C:\Users\Administrator\.codex\opencode-executor\runs\20261004-morocco-pressure-mode-point-separation-source-integrate\CODEX_FINAL_ACCEPTANCE.md and REVIEW_PACKET.md.
