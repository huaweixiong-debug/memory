# 2026-10-05 Traceability station allowlist guard

[Source: Codex current account]

- The Traceability pilot previously accepted any `TraceabilityPilot.station` value and could write it into cycle identifiers and persisted records. The local change now rejects values outside exact approved `PILOT-SIM` at the start of `run_cycle`, before scanner calls or persistence, using a generic error that does not echo the rejected value.
- Added a sentinel regression test asserting the field/reason/allowlist in the error, no sentinel echo, zero scanner/tester/printer calls, and zero cycle/event rows. Focused tests: 16 passed; full Traceability suite: 92 passed on Python 3.10.11 against the isolated exact Core PR #2 Release wheel (SHA-256 `8C4548F16136B298CD998F316054A680FED94F9116A3224C2483770B65B15A87`). Red proof on the pre-fix source failed as expected with `DID NOT RAISE ValueError`.
- Only `app/traceability.py` and `tests/test_traceability.py` changed in the pilot working tree; pre-existing working-tree state was preserved. No project commit, push, PR update, release, or device/LIVE action occurred.
- ZCode CLI plan-mode review was attempted but produced no output within the bounded wait; no ZCode verdict or actual model/provider identity was obtained. Codex final review found no blocking issue. This local SIMULATE-only fix does not advance a roadmap gate; overall 10-capability estimate remains about 33% (30–35%).
