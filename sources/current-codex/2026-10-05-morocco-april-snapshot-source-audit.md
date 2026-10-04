# Morocco 2026-04 snapshot and configuration binding audit

Date: 2026-10-05. Source: current Codex account.

- Read-only inventory of `Y:\协众\001摩洛哥干检\260401 Leak Test 2 Channels` found a LabVIEW project snapshot (`Main.vi`, SHA-256 `C446834F7035CEF0558E5B1054DA746B692408C4702FD84C914131503C00E7BF`; project file SHA-256 `D7E701F820EA076DE7E3A7BBEB0C2AC4A949952E78089CE356D80988E6BD96EE`) but no accompanying `Data` directory or explicit config references in the `.lvproj` text.
- Sibling `Data` is a separate candidate: `Barcode.py` and `日期设置.ini` were last modified 2026-01-20; the INI has duplicate section `E119015200`. The older `251212\Data` and V0.1 snapshots also exist. No deployment/version manifest was found by the bounded filename search.
- Directory proximity and timestamps do not prove which barcode, label, or PLC configuration is current or deployed. Keep Traceability source/SSOT and PLC/port gates open; no LIVE/device access or archive modifications occurred.
- The roadmap received a 2026-10-05 append with exact file hashes and scope. The previous byte prefix remained identical. Overall estimate remains about 33% (30-35%).