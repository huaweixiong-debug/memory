# 2026-10-01 — Morocco Core serial record/replay coverage

Source: Codex current account.

- Added only `Morocco/tests/test_core_serial_replay.py` to the isolated local Morocco pilot branch `codex/morocco-core-pilot` (baseline `b54c4eb12f7271a60b4a1cc7ad67a87088dfe2f7`). It drives the existing `SerialAteq.run()` with a strictly synthetic, in-memory Modbus RTU read endpoint and tests Core `RecordingSerialFactory` → `ReplaySerialFactory`; the JSONL transcript stays under pytest `tmp_path`. The test hash is `CAAA64073A686C35D764C0ACF329591C7AF1794E72A1C2AC388937E39467C300`.
- Core source was pinned to PR #2 head `a822e5a2fa24d2a5a7cec3d0c2457a8b7312515f`. Final Python 3.10 results: focused test 1 passed; complete Morocco `tests/` suite 169 passed, 1 skipped for absent package build output. Existing dirty files were preserved; the new file was not committed or pushed.
- OpenCode used `opencode-go/deepseek-v4.1-flash` / max. ZCode reviews used only Morocco's `zcode-failover.ps1` in plan mode with Start Plan GLM-5.3-Flash / max; both reviews passed after two low-level test-hardening notes were fixed. No API-key tokens or quota fallback were used. Final simple packet review passed with 0 issues; Codex final review passed.
- The new evidence is offline protocol recording/replay only, not physical ATEQ/PLC, site, production, or release acceptance. The company roadmap ledger was updated. Core PR #2 remains open/unmerged; authoritative field point/port sources and actual cost records remain outstanding.
