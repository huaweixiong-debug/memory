# ATEQ dual-station PLC start edge implementation

- In the remote `D:\ATEQ` project, the confirmed PLC point table is authoritative: A/B start signals are `M16.0/M16.1`, scan-OK bits are `M0.1/M0.0`, and manual-mode bits are `M2.0/M2.1`.
- `ProductionCoordinator` now treats `M16.0/M16.1` as PLC-owned inputs: it primes the initial levels, detects only 0-to-1 edges, never writes or clears start bits, and dispatches A/B start workers independently.
- A rising edge runs the station's first test from `READY`; for a dual test, the next edge on that same station runs the second test from `WAIT_2`. Unsolicited or duplicate starts are fail-closed.
- Verification on 2026-09-11: `71 passed`, compileall passed, and simulate smoke cycle passed. Real ATEQ devices remain disconnected; LIVE remains blocked pending field acceptance.
