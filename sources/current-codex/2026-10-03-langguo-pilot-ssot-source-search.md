# Langguo pilot SSOT source search

Source: Codex current account, 2026-10-03.

- A bounded read-only file search found the existing Morocco PLC point workbook (`PLC通讯点位表.xlsx`, 7,160 bytes) but no new engineering/PLC source resolving the M0.5/M0.4 `pressure` versus `test_mode` semantic conflict.
- No independent ATEQ electrical/point document was found in the mapped ATEQ project directory, Langguo archive, shared outputs, or repository filename search. The reference and pilot ATEQ `points.toml` files are byte-identical (SHA-256 `3659426668CEBA8D0C3D09ECA70D53437E735C6CF5F8F6BEA3A60F8056C01E0E`) and explicitly identify Morocco-derived addresses as placeholders.
- Current pilot live flags remain fail-closed: Morocco `ports_confirmed=false`; ATEQ `points_confirmed=false` and `ports_confirmed=false`.
- Added a bounded source-search addendum to the roadmap revalidation report, gate overview, and implementation ledger; each prior document is an exact byte prefix. No gate advanced and no device/LIVE action occurred.
- Search inventory and hashes: `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-lg-pilot-source-discovery\source-discovery.json`.