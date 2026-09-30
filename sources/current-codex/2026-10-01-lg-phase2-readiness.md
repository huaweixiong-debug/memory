# 2026-10-01 LG roadmap phase two readiness

Source: current Codex account.

- Phase two discovery uses local offline copies of LG Industrial Core, Morocco, ATEQ, and a new `traceability-pilot/` folder. Pilot edits remain local and uncommitted; Traceability has no selected product repository yet.
- Core has a transport-neutral delimited byte framer. The Traceability pilot records synthetic TCP receive chunks as Core events, replays chunks split across reads, and drives the scan/test/fake-print/label-rescan workflow to `TRACEABLE`. Invalid UTF-8 and truncated final frames fail closed.
- Validation after the replay work: Core `133 passed`, template `7 passed`, Traceability `23 passed`; the compatibility checker reports PASS for Morocco and ATEQ. These are offline/Fake/Replay results only.
- TCP replay did not use a socket or captured Keyence data and does not test reconnects. The Traceability pilot uses synthetic `DEMO-*` serials, in-memory records, fake adapters, and SIMULATE-only composition; it is not a durable MES product or production release.
- ATEQ point addresses remain placeholders pending the electrical point table and station/port mapping; `points_confirmed` and `ports_confirmed` stay false. Morocco cites a PLC point workbook absent from its checkout. No authoritative Morocco/ATEQ alarm matrices were found.
- Morocco and ATEQ share an identical UI text data block, but their complete theme modules differ. Decide ownership/dependency before extracting it so public Morocco remains independent of private Core.
- Next gates: obtain authoritative point/port data and alarm matrices; confirm barcode, label, NG, duplicate, recovery, persistence, and privacy rules; select or create a suitable private Traceability repository; settle HMI text ownership. Keep hardware, production databases, and live outputs disconnected until these gates are met.
