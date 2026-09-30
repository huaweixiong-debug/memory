# 2026-10-01 LG roadmap phase two readiness

Source: current Codex account.

- Phase two discovery uses local offline copies of LG Industrial Core, Morocco, ATEQ, and a new `traceability-pilot/` folder. Pilot edits remain local and uncommitted; Traceability has no selected product repository yet.
- Core has a transport-neutral delimited byte framer. The Traceability pilot records synthetic TCP receive chunks as Core events, replays chunks split across reads, and drives the scan/test/fake-print/label-rescan workflow to `TRACEABLE`. Invalid UTF-8 and truncated final frames fail closed.
- Validation on 2026-10-01: Core `133 passed`, template `7 passed`, Traceability `23 passed`, Morocco `168 passed, 1 skipped`, and ATEQ `92 passed`; the Core compatibility checker reports PASS for both pilot copies. Morocco's skip is the package-layout check because the source-only copy has no generated EXE. These are offline/Fake/Replay results only.
- TCP replay did not use a socket or captured Keyence data and does not test reconnects. The Traceability pilot uses synthetic `DEMO-*` serials, in-memory records, fake adapters, and SIMULATE-only composition; it is not a durable MES product or production release.
- ATEQ point addresses remain placeholders pending the electrical point table and station/port mapping; `points_confirmed` and `ports_confirmed` stay false. Morocco cites a PLC point workbook absent from its checkout. No authoritative Morocco/ATEQ alarm matrices were found.
- Morocco and ATEQ share an identical UI text data block, but their complete theme modules differ. Decide ownership/dependency before extracting it so public Morocco remains independent of private Core.
- Next gates: obtain authoritative point/port data and alarm matrices; confirm barcode, label, NG, duplicate, recovery, persistence, and privacy rules; select or create a suitable private Traceability repository; settle HMI text ownership. Keep hardware, production databases, and live outputs disconnected until these gates are met.


## 2026-10-01 follow-up: Core PR and ZCode review

- Updated the existing private LG Industrial Core PR #2 with bounded delimiter framing, a configurable typed ATEQ Fake, configurable printer acceptance, tests, and documentation. New head: `414c93d008a5fed86635ca66541f842e80e036b2`. GitHub CI passed on Python 3.10, 3.11, and 3.12; wheel/sdist and import checks passed; Release preflight passed and publication was skipped.
- GitHub Actions logs for the exact PR merge commit show 156 Core tests and 7 template tests passed on each Python version 3.10, 3.11, and 3.12; wheel/sdist, package import, and Release preflight also passed, while publication was skipped.
- Reconstructed the exact PR source tree locally and checked that Morocco and ATEQ imported `lg_industrial_core` from that tree. Morocco full suite: 168 passed, 1 skipped (generated-EXE package layout); ATEQ: 92 passed; compatibility checker: PASS for both. Core local suite: 136 passed; template: 7 passed. Traceability's separate local synthetic suite remains 23 passed.
- ZCode review used `zcode-failover.ps1 -Mode plan`. The current default remained Start Plan `account:bigmodel-start-plan/GLM-5.3-Flash`; two read-only reviews ran without switching plans or using API-key credentials. The first review found completed-frame loss on an oversize error and partial-delimiter length accounting; fixes and tests were added, and the second review returned PASS. ZCode ran no commands/tests and made no edits.
- No hardware, production database, live deployment, tag, or release was used. PR #2 remains open and unmerged.
- Remaining phase gates: Morocco's generated EXE/package layout; authoritative Morocco PLC point workbook; ATEQ electrical point table, station/port map, start-trigger ownership, and alarm matrix; confirmed traceability barcode/label/NG/duplicate/recovery/persistence/privacy rules and a suitable private repository; HMI text ownership; a real project to populate the cost workbook. Traceability tests remain synthetic, and the cost tracker is still a blank template pending a chosen project.


## 2026-10-01 Traceability persistence pilot

- The local Traceability pilot now offers an optional SQLite repository for synthetic trace rows and Core event envelopes; memory remains the default unless an explicit `--database` path is passed. The adapter is local-only, SIMULATE/Fake-only, schema-versioned, rejects unversioned non-empty or newer-schema files, and enforces unique serials in SQLite. Current NG/duplicate/recovery behavior remains provisional demo policy; no customer codes are allowed until retention and workflow rules are confirmed.
- Traceability suite: `27 passed` with the exact LG Industrial Core PR #2 source on PYTHONPATH. The default memory CLI and explicit SQLite CLI both reached `TRACEABLE`; reopening the SQLite file recovered one completed row and six events. This is local prototype evidence, not a production MES integration.
- The long SQLite-specific ZCode review request produced no verdict and was interrupted after waiting; a subsequent short `zcode-failover.ps1 -Mode plan` smoke prompt returned successfully. Provider remained `account:bigmodel-start-plan/GLM-5.3-Flash`; no fallback or API key was used.
