# 2026-10-01 — Morocco `python_app` source-only package test gate

Source: Codex current account.

- The source-only Morocco `python_app` had one failing test because UI geometry assertions were combined with a requirement for a generated EXE absent from the offline source copy. The fix splits the tests: geometry always runs; package layout skips only when both flat and nested EXEs are absent, and remains strict when either exists.
- Original Morocco `python_app` verification with LG Industrial Core PR #2 source: focused UI suite 6 passed / 1 skipped; full suite 60 passed / 1 skipped. The skip reason is the absent `package_dist_final` build output. No EXE was generated or treated as field/package acceptance.
- Updated the single stale test-name reference in `python_app/review_package/13_sol_closure_matrix.md`. ZCode reviewed the actual isolated diff read-only through `zcode-failover.ps1 -Mode plan` and returned PASS. The configured provider remained Start Plan / GLM-5.3-Flash; no quota fallback, provider edit, commit, or project push occurred.
- Transferred only the accepted test and closure-matrix edits from the isolated review copy to the original Morocco tree after checking both source files were unchanged. Their SHA-256 hashes match the reviewed copies; the originals are backed up under the OpenCode evidence run directory.
- Refreshed the shared roadmap ledger for 2026-10-01 with current Core PR #2 head `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7`, offline test counts, the source-only skip boundary, and the latest Traceability evidence. PR #2 remains open, unmerged, and unpublished.
- Remaining blockers: Morocco's authoritative point sheet is unavailable; ATEQ `points_confirmed=false` and `ports_confirmed=false`; V9 workbook formula recalculation and actual procurement/labor/rework evidence are unverified; Traceability remains synthetic SIMULATE only. No live equipment or production database was used.
