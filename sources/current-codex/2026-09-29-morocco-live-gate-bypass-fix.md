# Morocco LIVE gate correction — 2026-09-29

Date: 2026-09-29
Source: Codex current account.

- In the isolated Morocco copy, static review found that Setup.ini parsing incorrectly set `ports_confirmed=True`, `--b-live-ui` skipped the global LIVE preflight, and an unconfirmed A/B mapping did not stop preflight from probing TCP, serial, printer, and database services.
- The correction keeps Setup.ini mappings unconfirmed, makes both LIVE UI flags use `config/live.toml` and the same complete preflight, returns locally before any external probes when A/B is unconfirmed or duplicated, and passes the exact checked Settings object to the UI. LIVE UI constructors reject unless preflight/mode/mapping gates pass.
- A second static review found B-only CLI port/slave parameters could differ from the mapping that preflight checked. Both CLI and UI now reject a mismatch before the B serial adapter is created; the status text and tooltip use the configured port/slave.
- Seven focused offline tests passed after the changes. No PLC, ATEQ, scanner, printer, database, or network service was contacted. ZCode Desktop (user personal Coding Plan, GLM-5.3-Flash highest setting) independently reviewed the gates; it confirmed the B mapping mismatch is fixed and found no new high-severity gap. No API-key token path was used.
- Timestamped source backups are under the isolated copy's `backups/` directory; the original live TOML is preserved at `config/live.toml.bak.20260929-181457-631`.
- Follow-ups: `python_app/app/config.py` remains an older fail-closed configuration variant that rejects the current live.toml schema; a B-only LIVE startup exception after opening ATEQ does not explicitly close the adapter before process exit. The documented isolated `--b-test` path still opens only B ATEQ and was not run.