# Morocco/ATEQ offline revalidation and Core PR checkpoint — 2026-10-05

- Revalidated on Python 3.10.11 with the exact local Core candidate wheel installed offline into a disposable target: Morocco root 179 passed, Morocco `python_app` 141 passed, ATEQ 129 passed, Traceability 88 passed. The root suite's source-only integration test used the matching Core source tree; all eight package Python files matched the wheel. No hardware or LIVE configuration was used.
- The first `python_app` invocation used the parent directory and exposed a working-directory-sensitive guard; rerunning from `python_app` passed all 141 tests without code changes.
- Live Core PR #2 remains OPEN, non-Draft, MERGEABLE at `88a5b6e`; `reviewDecision` is empty. The local candidate remains detached/uncommitted; no commit, push, PR change, merge, or release was made.
- Product SSOT, Morocco/ATEQ field points/ports, and actual-cost evidence remain open; no roadmap gate advanced. Overall estimate remains about 33% (30–35%).
- Evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-morocco-historical-barcode-audit\CODEX_FINAL_ACCEPTANCE.md`.
