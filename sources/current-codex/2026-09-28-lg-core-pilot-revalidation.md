# LG Industrial Core offline pilot revalidation — 2026-09-28

- Updated only `README.md` and `docs/pilot-compatibility.md` in private `huaweixiong-debug/lg-industrial-core`; commit `b5e031385780b72c0011f014a6f9054020e228ad` is on `codex/lg-core-rename-foundation`.
- Directly rechecked the live P: source mirror: `events.py` and `recording.py` raw SHA-256 values match the pinned Core commit; their Git blob IDs match `HEAD` (`6bf8094e...` and `8fcf2bca...`). The mirror has no `.git` metadata.
- Offline validation: Core 69 passed; compatibility checker passed Morocco and ATEQ-F620-Laser; Morocco 166 passed / 2 known source-snapshot baseline failures; ATEQ 90 passed. No device, customer database, deployment, or production connection was used. Compatibility results do not prove station-cycle or production readiness.
- GPT-6 Luna/high intermediate review passed. Final Codex CLI acceptance used GPT-6 Luna at maximum reasoning and returned ACCEPT. Current CI and Release test matrices for Python 3.10–3.12 passed; package preflight passed and publishing was skipped.
- PR #1 remains open and draft: https://github.com/huaweixiong-debug/lg-industrial-core/pull/1. No merge, tag, release, or deployment was performed.
- Model routing correction for this project: no Terra; use GPT-6 Luna/high for intermediate review and GPT-6 Luna/max for final acceptance. OpenCode executor used DeepSeek V4.1 Flash/max for the documentation work.
- Next expansion gate remains actual reuse of the shared template/interfaces in both isolated pilots. The current checker proves interface shape and label/mark translation only; keep the work offline until the pilots exercise those adapters in representative simulated flows.
