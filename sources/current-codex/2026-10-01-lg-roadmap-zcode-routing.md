# 2026-10-01 LG roadmap status and ZCode routing

Source: current Codex account.

- User reiterates that ZCode reviews should use the Morocco project copy of `zcode-failover.ps1`. Only recognized quota exhaustion may trigger plan switching/retry; timeout and other errors must not be treated as quota exhaustion, and API-key tokens are not authorized. The real quota-exhaustion branch remains untested.
- Appended a dated, append-only roadmap status to the company ledger. GitHub Core PR #2 is OPEN, Ready for review, mergeable, head `414c93d008a5fed86635ca66541f842e80e036b2`; it is not merged or released. CI matrix and package preflight pass.
- Latest isolated tests with the exact PR Core source: Morocco 168 passed / 1 skipped; ATEQ 93 passed. With Core unavailable, Morocco 124 passed / 2 skipped and ATEQ 64 passed / 2 skipped. These remain offline/Fake/Replay evidence, not site acceptance.
- Official V7 cost workbook has no actual BOM/labor/purchase/rework evidence for YIDA-014; the supplier estimate remains an estimate. No actual variance can be calculated yet.
