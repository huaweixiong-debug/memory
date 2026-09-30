# 2026-10-01 — LG Core receipt gate and cross-pilot rerun

Source: Codex current account.

- Fixed and merged into PR branch `codex/lg-industrial-core-reconcile-20260928` the fail-open `ProductOutputAdapter.submit()` case where the string `"false"` became truthy. Current PR #2 head is `a822e5a2fa24d2a5a7cec3d0c2457a8b7312515f`; the adapter now requires a real bool and tests accept/reject both label and mark receipts.
- Exact-head validation: Core 170 tests and template 7 tests pass locally; GitHub Actions passed Python 3.10, 3.11, and 3.12 with package build/import preflight. Morocco pilot passed 168 with 1 package-layout skip (no generated EXE in the source copy); ATEQ passed 93; Core compatibility checks passed for both pilots.
- Independent ZCode review used the Morocco `zcode-failover.ps1` wrapper in plan/read-only mode. Start Plan GLM-5.3-Flash at max remained selected; no fallback or API-key route was used. The real quota-exhaustion branch remains untested. A wrapper shell exit discrepancy followed a complete PASS JSON response and cache warning; it was not treated as quota exhaustion.
- PR #2 remains OPEN, mergeable, and unmerged; no tag/release, production equipment, or production database was touched. User approval remains needed before merge.
- Remaining roadmap evidence includes Morocco packaged executable and authoritative PLC points, ATEQ electrical point/port/alarm sources, and actual BOM/purchase/labor/rework records for the cost pilot. Offline passing tests are not site acceptance.
