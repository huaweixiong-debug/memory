# 2026-10-02 — Langguo Morocco/ATEQ exact-Core offline rerun

## Results

- Python 3.10.11; all suites were offline. Core source pin: branch `codex/core-output-receipt-boolean-fix`, HEAD `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7`; the `src` tree was clean against that HEAD.
- Morocco `codex/morocco-core-pilot` at `b54c4eb12f7271a60b4a1cc7ad67a87088dfe2f7`: root `tests` 169 passed, 1 skipped (58.83s); `python_app/tests` 60 passed, 1 skipped (4.78s).
- ATEQ `codex/ateq-core-pilot` at `c22accdf965bf25ea8b6bca14c10910a6f82d0c9`: `tests` 102 passed (2.16s).
- Both Morocco skips are the package-layout check whose reason is that `package_dist_final` build output is absent from the source-only offline copy. They remain skips, not passes. Test-run logs and SHA-256 values are in `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-phase1-offline-revalidation-current-worktrees\offline-pilot-results.json`.

## Scope and gates

- Before/after Git status snapshots were identical for Morocco and ATEQ; current normalized status matches each after snapshot. Morocco `ports_confirmed=false`; ATEQ `points_confirmed=false` and `ports_confirmed=false`.
- Added evidence-only sections to the roadmap revalidation report and gate overview. Only those two files changed in the 26-file output directory; old byte prefixes, strict UTF-8, and existing CR bytes were preserved.
- No phase advanced. Actual cost receipts and native Excel/WPS recalculation remain open. Core PR #2 is open/mergeable and was not merged or pushed. No LIVE, device, database, customer-network, packaging, or release action occurred.

## Reviewer

- Two bounded read-only ZCode CLI attempts (first with packet plus diffs, second with diffs only) returned no review text and no PASS; both were interrupted after their wait windows. Codex's final acceptance covered documentation scope and evidence consistency only; it did not substitute for ZCode review or advance any gate.

## Evidence paths

- Roadmap output directory: `P:\Langguo_AI\company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\`.
- Pilot evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-phase1-offline-revalidation-current-worktrees\`.
- Documentation REVIEW_PACKET: `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-offline-pilot-roadmap-doc-sync\REVIEW_PACKET.md`.
