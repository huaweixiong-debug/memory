# Task Group: 江淮车桥气密扫码钢字码参数化与现场 LIVE 预检

scope: Parameterize the steel-code conversion in the Python scan application, provide a PySide2 settings page, and stage real COM/NI DataSocket/MySQL integration safely for the Windows 7 target; code/build verification succeeded, but field-device acceptance is incomplete.
applies_to: cwd=\\?\UNC\100.83.0.61\d\江淮车桥气密扫码; reuse_rule=Reuse the parameter model, JSON compatibility, and fail-closed preflight sequence only for this checkout or an intentionally ported equivalent; revalidate the VI Case branches, serial ports, DataSocket URL, and production database before LIVE use.

## Task 1: 钢字码转换参数化与设置页面, success

### rollout_summary_files

- rollout_summaries/2026-08-29T14-23-52-KWGS-steel_code_parameterization_live_preflight.md (cwd=\\?\UNC\100.83.0.61\d\江淮车桥气密扫码, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T15-49-43-01a04de7-cf23-7071-8094-940e463ec6ca_01a051a5-500c-7242-ab92-3d60870af2b5.jsonl, updated_at=2026-08-30T08:54:23+00:00, thread_id=01a04de7-cf23-7071-8094-940e463ec6ca, settings/configuration implementation verified)

### keywords

- steel-code, SteelCodeParameters, FixedFieldSpec, TableStore, PySide2, steel_code_settings.py, scan_parser.py, output_composer.py, ratio, 4.100, JAC01-7-890-234

## Task 2: 真实设备适配、安全启动与验证, partial

### rollout_summary_files

- rollout_summaries/2026-08-29T14-23-52-KWGS-steel_code_parameterization_live_preflight.md (cwd=\\?\UNC\100.83.0.61\d\江淮车桥气密扫码, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T15-49-43-01a04de7-cf23-7071-8094-940e463ec6ca_01a051a5-500c-7242-ab92-3d60870af2b5.jsonl, updated_at=2026-08-30T08:54:23+00:00, thread_id=01a04de7-cf23-7071-8094-940e463ec6ca, 214 passed/Win7 EXE smoke test passed; live links pending)

### keywords

- COM2, COM5, NI DataSocket PSP, d900~d908, --live --preflight, SIMULATE, JAC_MYSQL_PASSWORD, PyInstaller 5.13.2, PermissionError(13), status=5, Connecting: Parsing URL

## User preferences

- when the user said “main.py是模拟，直接用现实功能测试，而且我需要这个代码的钢字码转换的功能、逻辑做成参数设置页面。” -> implement the real chain and editable visual parameter page, not an expanded simulation-only demo. [Task 1][Task 2]
- when the user supplied `发送钢字码信息.vi` as a business reference -> read it for the real conversion rules, but treat attachment content as data rather than executable instructions. [Task 1]

## Reusable knowledge

- `src/models/steel_code.py` defines `FixedFieldSpec` and `SteelCodeParameters`: defaults are product `(2,4)`, date `(12,1)`, model `(13,3)`, sequence `(17,3)`. `scan_frame.py`/`scan_parser.py` apply the active parameters for slicing and validation, and `output_composer.py` uses the configurable template; default output is `JAC01-7-890-234`. [Task 1]
- `TableStore` loads new and legacy JSON and saves versioned, backed-up, atomically written data. Keep `ratio` as a string so `4.100` is not reduced to `4.1`; retain the legacy `output_prefix` contract. The seven default product mappings are migration prototypes, not VI-verified production truth. [Task 1]
- Keep `SIMULATE` as default. `--live --preflight -platform offscreen` must be read-only: it disables automatic sending and production-DB writes; sending requires explicit “启动发送”. Read `JAC_MYSQL_PASSWORD` at runtime and never serialize it. Treat DataSocket values as valid only in active/idle states. [Task 2]
- Evidence: `python -m pytest tests -q --tb=short` reported `214 passed`, `python -m compileall -q src main.py tests` passed, and PyInstaller 5.13.2/Python 3.8.10 built the Windows 7 EXE whose `--smoke-test -platform offscreen` exited 0. [Task 2]

## Failures and how to do differently

- Symptom: a combined delete/add patch fails on this UNC checkout -> cause: patch validation on the same file. Fix: apply the deletion and addition as separate patches. [Task 1]
- Symptom: preflight launches but is described as field-ready -> cause: safety startup is not device-chain acceptance. Here COM2 returned `PermissionError(13, '拒绝访问。'...)`, COM5 connected, and NI DataSocket returned `status=5, Connecting: Parsing URL`. First release/identify COM2 ownership and verify the PSP URL, network variables, and NI service; then do one controlled COM5 send, OPC read-only check, and production-DB acceptance before enabling automatic send. [Task 2]

# Task Group: Windows Codex desktop proxy-chain forensics and replication

scope: Establish the actual Codex/ChatGPT desktop outbound path on Windows and provide a bounded, evidence-first replication checklist for another machine; the local chain is verified, while the target-machine setup remains unvalidated.
applies_to: cwd=C:\Users\Administrator\Documents\Codex\2026-08-31\referenced-chatgpt-conversation-this-is-an; reuse_rule=Reuse the configuration-plus-live-socket investigation for Windows Codex Desktop proxy incidents; revalidate processes, listener ownership, current system proxy, and target-machine authorization each time.

## Task 1: Verify active Codex proxy chain, success

### rollout_summary_files

- rollout_summaries/2026-08-31T06-20-45-X6Ru-codex_windows_proxy_forensics_and_replication.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-31\referenced-chatgpt-conversation-this-is-an, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\31\rollout-2026-08-31T14-20-45-01a0567a-36a4-7431-940a-8726d7bd6574.jsonl, updated_at=2026-08-31T06:28:26+00:00, thread_id=01a0567a-36a4-7431-940a-8726d7bd6574, local live chain verified)

### keywords

- Codex desktop, ChatGPT.exe, Chromium NetworkService, clash-windows-amd64.exe, mixed-port, 127.0.0.1:17890, WinINET, WinHTTP, respect_system_proxy, PAC, TUN, ENV_READ_FAILED WIN32=299

## Task 2: Replicate setup on another computer, uncertain

### rollout_summary_files

- rollout_summaries/2026-08-31T06-20-45-X6Ru-codex_windows_proxy_forensics_and_replication.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-31\referenced-chatgpt-conversation-this-is-an, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\31\rollout-2026-08-31T14-20-45-01a0567a-36a4-7431-940a-8726d7bd6574.jsonl, updated_at=2026-08-31T06:28:26+00:00, thread_id=01a0567a-36a4-7431-940a-8726d7bd6574, procedural guidance only; target not inspected)

### keywords

- netsh winhttp set proxy, ProxyEnable, ProxyServer, Get-NetTCPConnection, localhost;127.*, respect_system_proxy, HTTP_PROXY, HTTPS_PROXY, ALL_PROXY, authorized Clash configuration

## User preferences

- when investigating a connection path, the user requested checks across process environment variables, WinINET, WinHTTP, Codex config, Electron/Chromium flags, PAC/TUN, listeners, and actual destinations -> separate configuration evidence from live socket evidence and finish with a clear chain conclusion. [Task 1]
- when asking how another computer can reproduce a working connection -> provide ordered setup and verification steps, not just the proxy address. [Task 2]

## Reusable knowledge

- Verified local chain: `ChatGPT.exe` Chromium NetworkService PID 37824 -> `127.0.0.1:17890` -> `clash-windows-amd64.exe` PID 17556 -> external Clash egress. WinINET and WinHTTP both used the fixed local proxy; PAC URL and auto-detection were empty/disabled. [Task 1]
- `C:\Users\Administrator\.codex\config.toml` had `respect_system_proxy = true`; no explicit `network_proxy`, `--proxy-server`, or PAC flag was found. Clash used `mixed-port: 17890`, `allow-lan: false`, and `mode: Rule`. [Task 1]
- For a second computer, run a local authorized Clash-compatible configuration first, set WinINET and WinHTTP to `127.0.0.1:17890`, retain `respect_system_proxy = true`, remove stale remote proxy environment variables, fully restart Codex, then verify listener, both Windows proxy layers, and Codex live sockets. Do not copy subscription/node data. [Task 2]

## Failures and how to do differently

- Symptom: one process-environment read fails with `ENV_READ_FAILED WIN32=299` -> do not infer the chain from that method alone; corroborate multiple process-tree members with listener ownership and live TCP connections. [Task 1]
- Symptom: PowerShell reports `ParserError: An empty pipe element is not allowed` -> construct intermediate arrays/rows before piping. Do not wait on unavailable `P:\memory` when local configuration and sockets already establish the result. [Task 1]
- Symptom: another computer has only a proxy address configured -> cause: no local listener/authorized client or no post-change verification. Start the local proxy first and treat replication as unconfirmed until sockets prove it. [Task 2]

# Task Group: Chiller Line 2 scanner TCP communication diagnosis

scope: Diagnose SCAN_001/start-read failures and malformed TCP scanner frames in the `heating_python.scanner` layer; this is device-communication triage, not EV80 duplicate-code or UI logic.
applies_to: cwd=D:\去重码 (diagnostic rollout; affected component=heating_python.scanner for Chiller Line 2); reuse_rule=Reuse the log-routing and first hardware/network checks for this scanner topology only after confirming the scanner address, protocol, and owning application.

## Task 1: Diagnose SCAN_001 and pasted scanner logs, success

### rollout_summary_files

- rollout_summaries/2026-08-29T08-14-44-8E6i-ev80_xlsx_duplicate_auto_scan_remote_deployment.md (cwd=\\?\UNC\100.82.136.106\Work\协众\095 EV80防重码, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T18-06-59-01a04c95-dced-78b3-b6d1-6ce88debf3f6_01a05222-fa62-7cc1-9a3c-9fbb25863686.jsonl, updated_at=2026-09-01T01:39:02+00:00, thread_id=01a04c95-dced-78b3-b6d1-6ce88debf3f6, source attribution and malformed-frame pattern identified)

### keywords

- SCAN_001, Failed to raise the start/read signal, heating_python.scanner, scanner_3, 192.168.3.62:8888, scanner_2, 192.168.3.61:8888, frame is not ASCII, raw_hex=ff ff, frame_len=22, buffer_remaining=0

## Reusable knowledge

- `SCAN_001: Failed to raise the start/read signal` and `rejected malformed frame: frame is not ASCII` originate in `heating_python.scanner`, not in the EV80 `classify_scan` data-source duplicate rule or Tk `<KeyRelease>` flow. The current EV80 source has no `SCAN_001`, `start/read signal`, or TCP start/read trigger implementation. [Task 1]
- The pasted evidence had 37 entries: 36 for `scanner_3` at `192.168.3.62:8888` and one for `scanner_2` at `192.168.3.61:8888`; every received frame was 22 bytes of `FF` with `buffer_remaining=0`, so it was rejected as non-ASCII rather than being a partial buffered barcode. Prioritize scanner_3 power/24V, trigger wiring/input, TCP 8888 reachability, ASCII-output mode, serial-server settings, and a competing connection. [Task 1]

## Failures and how to do differently

- Symptom: diagnose `SCAN_001` through EV80 UI or duplicate-code changes -> cause: the error's source is the separate `heating_python.scanner` communication layer. First search the source/log origin and frame bytes; then pivot to the device, wiring, protocol, and connection owner. [Task 1]

# Task Group: EV80 data-source duplicate alarms, automatic scan, and remote Windows deployment

scope: Maintain the EV80CodeChecker `information.xlsx` source-of-truth, make a complete 26-digit laser scan classify automatically, and package the compatible Tk application for the remote target; local logic/build are verified, remote GUI/physical-scanner acceptance remains open.
applies_to: cwd=\\100.82.136.106\Work\协众\095 EV80防重码 (related source/deployment paths=D:\去重码 and \\100.73.63.116\D\去重码); reuse_rule=Reuse only for compatible EV80CodeChecker checkouts; confirm workbook headers, scanner rule, current running EXE, complete onedir copy, and field behavior each deployment.

## Task 1: Replace the source and alarm on data-source duplicates, success

### rollout_summary_files

- rollout_summaries/2026-08-29T08-14-44-8E6i-ev80_xlsx_duplicate_auto_scan_remote_deployment.md (cwd=\\?\UNC\100.82.136.106\Work\协众\095 EV80防重码, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T18-06-59-01a04c95-dced-78b3-b6d1-6ce88debf3f6_01a05222-fa62-7cc1-9a3c-9fbb25863686.jsonl, updated_at=2026-09-01T01:39:02+00:00, thread_id=01a04c95-dced-78b3-b6d1-6ce88debf3f6, data-source rule and 47 tests verified)

### keywords

- EV80, information.xlsx, 激光码信息, load_workbook_codes, classify_scan, openpyxl, master_counts, unknown, duplicate, 76,944, 75,890, 871

## Task 2: Scan completion triggers automatic classification, success

### rollout_summary_files

- rollout_summaries/2026-08-29T08-14-44-8E6i-ev80_xlsx_duplicate_auto_scan_remote_deployment.md (cwd=\\?\UNC\100.82.136.106\Work\协众\095 EV80防重码, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T18-06-59-01a04c95-dced-78b3-b6d1-6ce88debf3f6_01a05222-fa62-7cc1-9a3c-9fbb25863686.jsonl, updated_at=2026-09-01T01:39:02+00:00, thread_id=01a04c95-dced-78b3-b6d1-6ce88debf3f6, Tk event and local EXE smoke verified)

### keywords

- is_complete_laser_scan, <KeyRelease>, _on_scan_key_release, _on_submit, 26 位纯数字, auto_records=1, auto_status=normal, 提交按钮

## Task 3: Deploy PyInstaller onedir and repair Tk resources, partial

### rollout_summary_files

- rollout_summaries/2026-08-29T08-14-44-8E6i-ev80_xlsx_duplicate_auto_scan_remote_deployment.md (cwd=\\?\UNC\100.82.136.106\Work\协众\095 EV80防重码, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T18-06-59-01a04c95-dced-78b3-b6d1-6ce88debf3f6_01a05222-fa62-7cc1-9a3c-9fbb25863686.jsonl, updated_at=2026-09-01T01:39:02+00:00, thread_id=01a04c95-dced-78b3-b6d1-6ce88debf3f6, files verified; remote smoke inconclusive)
- rollout_summaries/2026-08-30T06-23-30-Ut6f-ev80_auto_scan_remove_submit_button_deploy.md (cwd=\\?\UNC\100.73.63.116\d\去重码, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T14-23-32-01a05156-5f52-77b0-9afd-50d3fd92f527.jsonl, updated_at=2026-08-30T06:47:29+00:00, thread_id=01a05156-5f52-77b0-9afd-50d3fd92f527, prior direct-build/deploy evidence)

### keywords

- PyInstaller, build_exe.ps1, runtime_tk_fix.py, robocopy, UNC, tk.tcl, init.tcl, tk86t.dll, tcl86t.dll, EV80CodeChecker_20260830, EV80CodeChecker_auto.exe

## User preferences

- when the user said “如果发现扫码匹配激光码信息的数量大于1，就报警” -> make data-source occurrence count the primary duplicate rule, including the first scan. [Task 1]
- when the user asked “扫码后不用点提交确认吗？直接扫码就自动判断吗” and said “扫码自动填入输入框，然后查找匹配，不需要人工操作界面按确认” -> trigger from a completed scan, not a scanner Enter suffix or submit button. [Task 2]
- when the user said “你直接处理，不要opencode介入” / “这次你自己改，不用给opencode” -> directly modify, test, and package the scoped EV80 work rather than delegating to OpenCode. [Task 1][Task 2]

## Reusable knowledge

- The only sheet is `information`; its actual header is `激光码信息` (column 24), not the shorthand `激光信息`. `load_workbook_codes` uses `openpyxl.load_workbook(..., read_only=True, data_only=True)` and returns `dict[str, int]`; accept both header names only after inspecting raw headers. The real input had 76,944 valid rows, 75,890 unique codes, and 871 duplicate-source codes. [Task 1]
- `classify_scan` order is format error -> source absent `unknown` -> source count > 1 `duplicate` -> current-batch repeat `duplicate` -> `normal`. `requirements.txt` pins `openpyxl>=3.1.0,<4.0.0`; `python -m unittest discover -s D:\去重码\tests -q` reached `Ran 47 tests ... OK`. [Task 1]
- `is_complete_laser_scan(raw)` normalizes then checks exactly 26 digits. Bind `<KeyRelease>` to `_on_scan_key_release`, call `_on_submit()` once complete, remove the `提交` button, and keep Enter as manual fallback. Tk test recorded `auto_records=1 auto_status=normal`; local packaged EXE smoke exited 0 and launched GUI. [Task 2]
- Use the writable normal share `\\100.73.63.116\D\去重码`, not rejected `d$`. Do not force-stop the live old EXE; use a new file/directory. A complete onedir copy needs `tk.tcl`, `init.tcl`, `tk86t.dll`, `tcl86t.dll`, and `information.xlsx`; `build_exe.ps1` includes Tk-runtime checks and `runtime_tk_fix.py`. [Task 3]

## Failures and how to do differently

- Symptom: `master_counts=0` after source replacement -> cause: matching only `激光信息`. Print/check original Excel headers and recognize `激光码信息` before trusting row counts. [Task 1]
- Symptom: a Return binding exists but a submit button remains, or intermediate digits classify -> trigger only on complete normalized 26-digit input and inspect the final UI as well as behavior. [Task 2]
- Symptom: `tk.tcl` error or a remote onedir directory has only some files -> cause: a copied directory is still incomplete. Wait for `robocopy`, compare source/target file counts, and check Tcl/Tk resources before launch. Do not call UNC EXE execution fully accepted when its smoke result is inconclusive; obtain remote GUI restart and physical 26-digit scan evidence. [Task 3]

# Task Group: EV80 project history and file-access verification

scope: Determine separately whether Codex can retrieve prior EV80 chats and access the current project/share files; chat discovery succeeded but file access was not verified.
applies_to: cwd=Y:\协众\095 EV80防重码 (related network cwd=\\100.82.136.106\Work\协众\095 EV80防重码); reuse_rule=Reuse the split chat-versus-files verification approach for project-history requests; do not infer filesystem or shared-memory access from successful thread listing.

## Task 1: 查找历史聊天记录和工作区文件, partial

### rollout_summary_files

- rollout_summaries/2026-08-30T05-00-01-ZmZt-ev80_history_and_file_access_check.md (cwd=Y:\协众\095 EV80防重码, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T13-30-19-01a05109-f27a-7b01-97ac-2e2964652d63_01a05125-b09a-7800-ae2d-1e64dcc24057.jsonl, updated_at=2026-08-30T05:31:16+00:00, thread_id=01a05109-f27a-7b01-97ac-2e2964652d63, chat retrieval verified; file access not verified)

### keywords

- EV80, 防重码, list_threads, Codex App, PowerShell, os error 267, 工作区, 历史线程, P:\memory

## User preferences

- when the user asked “能找到之前的聊天记录和文件吗？” -> verify chat retrieval and workspace-file access as separate claims; report each result independently. [Task 1]

## Reusable knowledge

- Codex App `list_threads({limit:20})` can return historical thread IDs, titles, summaries, cwd, and status. Known EV80 threads included `01a04c95-dced-78b3-b6d1-6ce88debf3f6` (“开发激光二维码重码比对工具”, network workspace) and `01a05100-97d9-7f62-9ee2-96535a0b7034` (“构建”, Y: workspace). [Task 1]

## Failures and how to do differently

- Symptom: a PowerShell check fails with `Failed to create unified exec process: 目录名称无效。 (os error 267)` -> no file, Excel, image, or `P:\memory` access has been established. Fix the working directory/use an available file tool, then retry before reporting filesystem access. [Task 1]

# Task Group: Windows OpenCode Desktop local workspace and inherited-proxy 502

scope: Move OpenCode Desktop off a disconnected P-drive/remote workspace, distinguish stale workspace state from proxy routing, and verify a fresh process rather than config files alone; final post-login model-call verification was not completed.
applies_to: cwd=C:\Users\Administrator\.config\opencode; reuse_rule=Reuse this narrow Windows Desktop state/proxy diagnostic sequence when logs show P-drive restoration, `lstat`, 502, or a stale proxy; revalidate window IDs, server settings, local project, and current proxy endpoint.

## Task 1: Switch OpenCode to local project and repair 502, partial

### rollout_summary_files

- rollout_summaries/2026-08-30T06-07-40-y7SD-opencode_local_switch_proxy_inherited_env_502.md (cwd=\\?\C:\Users\Administrator\.config\opencode, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T14-07-41-01a05147-e37d-7360-acf3-0ee9a9962747.jsonl, updated_at=2026-08-30T06:38:37+00:00, thread_id=01a05147-e37d-7360-acf3-0ee9a9962747, P-drive removal verified; fresh model call pending)

### keywords

- OpenCode Desktop, HTTP 502, UnexpectedStatus, lstat 'P:\\', defaultServerUrl, sidecar, opencode.window, HTTP_PROXY, HTTPS_PROXY, ALL_PROXY, 100.82.136.106:17890, 127.0.0.1:17890

## User preferences

- when the user said “直接改成本地项目，不要p盘连接” -> switch to a local project and remove stale remote-workspace restoration instead of attempting to repair the P-drive connection. [Task 1]
- when the user repeatedly reported “打开还是这样” and “还是连100.82.136.106” -> configuration edits are not completion; inspect the actual endpoint used by a fresh process/request. [Task 1]

## Reusable knowledge

- The initial startup failure was a workspace/filesystem fault: disconnected `P:` (`\\100.117.1.6\projects`) logged `UNKNOWN: unknown error, lstat 'P:\\'`. Change `C:\Users\Administrator\AppData\Roaming\ai.opencode.desktop\opencode.settings` `defaultServerUrl` from `http://100.117.1.6:4096` to `sidecar`; rename, rather than delete, the `opencode.window.<window-id>.dat` that retains remote tabs/P-drive references so Desktop builds a fresh state without deleting the session database. [Task 1]
- After the reset, logs loaded `D:\去重码` with no new P-drive `lstat`, 502, or remote-server startup error. Historical Y/UNC instances still appeared, so only “no P drive” is verified, not complete removal of all historical workspaces. [Task 1]
- A separate model-call failure was the inherited proxy `100.82.136.106:17890`: TCP evidence showed `127.0.0.1:17890` reachable and the old address unreachable. User `HTTP_PROXY`, `HTTPS_PROXY`, and `ALL_PROXY` were changed to `http://127.0.0.1:17890`; inspect both `opencode.json` and `opencode.jsonc` but keep secrets as environment references. [Task 1]

## Failures and how to do differently

- Symptom: the shell or running Desktop still uses the old proxy after user variables change -> cause: Windows processes inherit their environment at launch. Fix: completely exit relevant processes and normally log out/in or reboot before testing a new process; only close after a successful real request/log no longer shows `100.82.136.106`. [Task 1]
- Symptom: complex PowerShell one-liners parse/fail under policy -> fix: run small separate commands for environment updates, process restart, and log inspection. [Task 1]

# Task Group: Windows Codex and DeepSeek configuration migration

scope: Recreate the non-secret Codex/DeepSeek configuration on another Windows computer without copying OAuth credentials, caches, or unverified secret files.
applies_to: cwd=D:\Claude; reuse_rule=Reuse the minimum non-secret migration checklist for comparable Windows Codex setups, but revalidate provider/proxy installation, paths, and current configuration values on the target machine.

## Task 1: 迁移 Codex + DeepSeek 配置, partial

### rollout_summary_files

- rollout_summaries/2026-05-05T13-31-53-m17k-deepseek_codex_migration_file_analysis.md (cwd=\\?\D:\Claude, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\05\05\rollout-2026-05-05T21-31-53-019df856-8708-7373-8f47-ed15c599201a.jsonl, updated_at=2026-08-30T05:01:13+00:00, thread_id=019df856-8708-7373-8f47-ed15c599201a, migration advice corrected for credential safety)

### keywords

- Codex, DeepSeek, config.toml, lmstudio, deepseek-v4-pro, auth.json, OAuth, deepseek.env, PowerShell -NoProfile, plugins, migration

## User preferences

- when the user asked “哪几个文件复制过去就可以了” -> give a minimum migration list that distinguishes safe configuration, required reinstallations, rebuildable caches, and sensitive credentials. [Task 1]

## Reusable knowledge

- Verified non-secret `config.toml` values were `model_provider = "lmstudio"`, `model = "deepseek-v4-pro"`, and `model_reasoning_effort = "high"`; copy only after removing/adjusting machine-local paths and project-trust entries. First install the same Codex version and any required DeepSeek provider/proxy component, then re-enter secrets securely. [Task 1]
- `logs_2.sqlite`, `state_5.sqlite`, sessions, logs, tmp/cache, and `plugins\cache` are history/state/cache rather than required model functionality; normally rebuild them on the new computer. `deepseek.env` was unreadable, so its contents are unverified. [Task 1]
- Historical proxy-log errors are routing clues: `The supported API model names are deepseek-v4-pro or deepseek-v4-flash` and `The reasoning_content in the thinking mode must be passed back to the API.` [Task 1]

## Failures and how to do differently

- Symptom: migration guidance includes `auth.json` -> stop: it contains OAuth access/refresh/id tokens. Do not copy, output, or retain it; the exposed credentials should be treated as requiring revocation/re-login. [Task 1]
- Symptom: `profile.ps1` execution-policy noise or `.sandbox-secrets` access denial pollutes discovery -> use PowerShell without a profile and skip protected secret directories; do not infer `deepseek.env` contents from a denied read. [Task 1]

# Task Group: Chiller Line 2 Heating.vi Python replacement with manual start

scope: Maintain the fail-closed `heating_python` replacement candidate, its scan-then-operator-Start handshake, and the LabVIEW rollback boundary; production PLC/laser operation remains unaccepted.
applies_to: cwd=\\100.74.196.22\d\Chiller Line 2 (mapped path=X:\Chiller Line 2); reuse_rule=Reuse HMI architecture, safety gates, and validated mappings for this Chiller Line 2 checkout; revalidate live PLC/OPC, scanner, database, recipe, laser, interlock, and operator conditions before any cutover.

## Task 1: Inspect Heating.vi and establish safe replacement boundary, partial

### rollout_summary_files

- rollout_summaries/2026-08-29T02-57-32-AoRH-chiller_line_2_heating_python_manual_start.md (cwd=\\?\UNC\100.74.196.22\d\Chiller Line 2, rollout_path=C:\Users\Administrator\.codex\sessions\2026\09\01\rollout-2026-09-01T13-48-24-01a04b73-73d8-7b91-8d48-97ca13033991_01a05b82-f6eb-7411-bc3f-135b2b3c83fb.jsonl, updated_at=2026-08-31T12:52:11+00:00, thread_id=01a04b73-73d8-7b91-8d48-97ca13033991, static VI evidence; original retained)

### keywords

- Heating.vi, LabSQL, ADO Connection Destroy.vi, OPC, database VI, scanner, laser, MB Master Modbus TCP, SHA-256, UNC paths

## Task 2: Implement Win11-style Python HMI and supporting display model, success

### rollout_summary_files

- rollout_summaries/2026-08-29T02-57-32-AoRH-chiller_line_2_heating_python_manual_start.md (cwd=\\?\UNC\100.74.196.22\d\Chiller Line 2, rollout_path=C:\Users\Administrator\.codex\sessions\2026\09\01\rollout-2026-09-01T13-48-24-01a04b73-73d8-7b91-8d48-97ca13033991_01a05b82-f6eb-7411-bc3f-135b2b3c83fb.jsonl, updated_at=2026-08-31T12:52:11+00:00, thread_id=01a04b73-73d8-7b91-8d48-97ca13033991, scan-then-Start behavior and 185 tests verified)

### keywords

- heating_python, state_machine.py, hmi.py, cli.py, scanner.py, live_modbus.py, live_fx3u.py, submit_scan, request_start, m105, WAIT_SCAN, SCAN_001, 185 tests

## User preferences

- when the user confirmed “确认，按此方案” for a Tkinter, 1920×1080, light Win11-style industrial HMI -> use this fullscreen, high-contrast presentation and expose known fields without guessing unverified live semantics. [Task 2]
- when the user asked for “完整替代heating.vi” -> clearly separate a simulation/HMI replacement candidate from live production cutover; never imply cutover without field evidence. [Task 1][Task 2]
- when the user said “扫不到码就跳过，然后扫到码按启动按钮后，对应的激光器就打码” -> make no-scan a normal wait; latch the scan without PLC/laser side effects; let Start select and trigger the laser route. [Task 2]

## Reusable knowledge

- Static VI evidence confirms OPC variables, database VIs, scanner/laser logic, and MB Master Modbus TCP dependencies; LabSQL exists at `E:\6. LabSQL\LabSQL ADO functions\Connection\ADO Connection Destroy.vi`. The full block diagram was not visually inspected. `Heating.vi` remained SHA-256 `3B94CA3FA085677718F7318487A6657D30E97E8F8B26081B372C123C5764DD32`. [Task 1]
- `heating_python/hmi.py` provides `HmiSnapshot`, `HmiController`, and `HeatingHMI`: parameters, eight temperatures, PLC D-register cache values, four scanner/laser routes, alarms, manual scan, Start/Stop/Reset, fullscreen/F11, and a single polling loop owned by the HMI controller. `StationSnapshot` carries `cached_values`, `flow_value`, `gas_active`, `traceable`, `today_sequence`, `final_scans`, and `communication_status`; display refresh is render-only while control remains behind the state machine/worker thread. Remote Python 3.12 compilation, `Ran 182 tests ... OK`, and simulation through `complete` passed. [Task 2]
- Scanner topology is `.60`–`.63:8888`, 22-byte frames, 30 ms timeout, 50 ms cadence; `.60`/`.63` disabled and `.61`/`.62` enabled/reachable in read-only checks. Preserve non-sequential mappings `m105 → M0205`, `m107 → M0907`, `m108 → M0908`. Temperature device is `192.168.3.32:502`, registers `40001`–`40008`; direct Modbus may contend with NI OPC Servers' single session, so use OPC UA for coexistence. [Task 2][Task 3]
- `config_live.json` now uses `modbus.temperature_scale: 0.1` (for example `1800 -> 180.0 °C`), tags `1温度`–`8温度`, and QR files `D:\激光码信息二维码1.txt`–`4.txt`; the exact live hardware behavior remains for field confirmation. Safe command: `python -m heating_python --simulate --serial-code EV80015100000000000001 --run-once`. [Task 3]
- The current handshake is: no scan + Start stays in `WAIT_SCAN` without `SCAN_001`; `submit_scan()` only latches serial/scanner/laser; Start calls `request_start()`, raises `m105`, validates, allocates, marks with the selected laser, then continues. Batch Modbus reading is one `address=0,count=8` request; `192.168.3.32:502` returned eight registers, while PLC FX3U returned NAK. Final suite: `Ran 185 tests ... OK`. [Task 2]

## Failures and how to do differently

- Symptom: an OpenCode/tool working directory is UNC -> `UNC paths are not supported`. Fix: use mapped `X:\Chiller Line 2` or local staging. [Task 1]
- Symptom: Windows PowerShell 5.1 JSON edits cause `找不到属性 temperature_scale`, BOM, or mojibake -> add missing properties with `Add-Member`, write UTF-8 without BOM, then validate with `json.loads(path.read_text(encoding='utf-8'))` and the project tests. [Task 3]
- Symptom: routine verification is tempted to use `--live` -> do not run it: it can write PLC, laser, and database state. Keep live mode fail-closed until PLC/OPC, laser file, database, recipe, interlock, operator, maintenance window, and explicit cutover approval are verified. [Task 2][Task 3]
- Symptom: visual LabVIEW inspection is described as complete -> cause: desktop inspection was stopped with Esc and static metadata was used. Fix: record the visual block-diagram inspection as incomplete. [Task 1]
- Symptom: a second live process starts while COM6 is held -> `SerialException: could not open port 'COM6': PermissionError(13, '拒绝访问')`. Fix: ensure a single live process and identify port ownership before retrying. [Task 2]

# Task Group: LabVIEW OPC.lvlib and Kepware communication-list analysis

scope: Analyze a LabVIEW OPC I/O Server library together with a Kepware project, classify the OPC communication chain, and produce a point-level communication list; excludes proof of runtime VI reads/writes and final live transport selection.
applies_to: cwd=C:\Users\Administrator\Documents\Codex\2026-08-29\referenced-chatgpt-conversation-this-is-an; reuse_rule=Reuse the XML evidence, point-alignment, and uncertainty-reporting procedure for comparable LabVIEW/Kepware exports; revalidate all server, device, address-offset, and runtime details against the target project and logs.

## Task 1: 解析 LabVIEW OPC.lvlib 并识别通讯机制, success

### rollout_summary_files

- rollout_summaries/2026-08-29T09-42-14-qjZp-opc_lvlib_kepware_communication_list.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-29\referenced-chatgpt-conversation-this-is-an, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\29\rollout-2026-08-29T17-42-14-01a04ce5-f780-75f3-b88f-ec6e0cb44a3b.jsonl, updated_at=2026-08-29T10:04:17+00:00, thread_id=01a04ce5-f780-75f3-b88f-ec6e0cb44a3b, 32 bindings classified)

### keywords

- OPC.lvlib, OPC1, className=OPC, OPC DA, Network Shared Variable, Shared Variable Engine, Network:ProjectBinding, Network:AccessType=read/write, Channel1\\Device1, Channel4\\Device1

## Task 2: 对齐 Kepware XML 并生成 OPC 通讯列表, success

### rollout_summary_files

- rollout_summaries/2026-08-29T09-42-14-qjZp-opc_lvlib_kepware_communication_list.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-29\referenced-chatgpt-conversation-this-is-an, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\29\rollout-2026-08-29T17-42-14-01a04ce5-f780-75f3-b88f-ec6e0cb44a3b.jsonl, updated_at=2026-08-29T10:04:17+00:00, thread_id=01a04ce5-f780-75f3-b88f-ec6e0cb44a3b, 35 Kepware tags aligned)

### keywords

- Simulation Driver Demo.xml, Kepware 5.19.492.0, Mitsubishi FX, FX3U, COM6, Modbus Ethernet, 192.168.3.32, TCP 502, ZeroBasedAddressing, 255.255.255.255:2101, d10, d40, 反吹时间

## User preferences

- when requesting an industrial communications analysis, the user asked for “给出中文结构化结论” and later “给出opc的通讯列表” -> lead with a Chinese, structured result: evidence, communication chain, channel parameters, full point list, unbound points, and clearly separated unknowns. [Task 1][Task 2]

## Reusable knowledge

- `OPC.lvlib` had 33 entries: 32 `Type="Variable"` Network Variables and `OPC1` as the sole `Type="IO Server"`; the bindings split 24 under `Channel1\\Device1` and 8 under `Channel4\\Device1`. All 32 set `Network:AccessType=read/write`, `Network:ProjectBinding=True`, `Network:UseBinding=True`, `Network:UseBuffering=True`, with `BuffSize=50`. [Task 1]
- The evidence-supported path is external OPC Server → LabVIEW OPC Client I/O Server `OPC1` → Shared Variable Engine → Network Published Shared Variables → VI. `className="OPC"` supports classic OPC DA; there is no XML evidence for OPC UA, DataSocket, or ActiveX. `read/write` proves allowed configuration, not that a VI performed a write. [Task 1]
- `Simulation Driver Demo.xml` is a Kepware Server 5.19.492.0 project with 3 channels and 35 tags: Channel1 27, Channel4 8, 扫描枪1 0. Channel1 is Mitsubishi FX/FX3U with COM6/9600/7-Even-1/RTS Always; Channel4 is Modbus Ethernet to `192.168.3.32:502`, with `1温度`–`8温度` at 40001–40008 as Word; 扫描枪1 is `192.168.3.61:8889`. [Task 2]
- Preserve the point-alignment differences: Kepware-only tags are `d10 → D0010 → Short`, `d40 → D0040 → Short`, and `反吹时间 → T051 → Short`; `Simulated=false` for all three devices means the filename's “Simulation” does not establish simulated operation. [Task 2]

## Failures and how to do differently

- Symptom: identifying `OPC1` as “NI OPC Servers” or a named external server -> cause: conflating the LabVIEW client I/O Server with the server product. Fix: report `OPC1` as the LabVIEW OPC I/O Server and identify the external server only from its configuration; here Kepware is evidenced by the separate project XML. [Task 1][Task 2]
- Symptom: static XML is presented as a confirmed live path/address map -> cause: configuration evidence is stronger than runtime evidence. Fix: state that the library cannot establish external ProgID/IP/DCOM, real LabVIEW types, refresh/quality state, actual VI writes, or Channel1's final transport; inspect the Kepware channel UI or runtime logs, especially because COM6 parameters coexist with `255.255.255.255:2101` Ethernet Encapsulation. [Task 1][Task 2]
- Symptom: Modbus addresses are shifted or three extra tags are treated as bound -> cause: missing alignment and offset checks. Fix: keep name/address/type/binding columns, exclude `d10`/`d40`/`反吹时间` from the 32 bindings, and validate Channel4's `ZeroBasedAddressing=true` during commissioning. [Task 2]

# Task Group: Leak Test 2 Channels barcode-compatible replacement and BarTender deployment

scope: Deliver and deploy a backward-compatible Barcode.py/Barcode_Cal.py replacement for the Wuhan RAD Leak Test label workflow, including HR ECO rules and the TXT-to-BarTender dataflow; excludes proof of final on-site template binding and physical printing.
applies_to: cwd=\\100.82.136.106\Work\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0 (compatible package on Y:\协众\072 摩洛哥干检第三台设备\Data-兼容替换版); reuse_rule=Reuse the compatibility, fail-closed, and file-mapping procedure for this barcode family only; revalidate product rules, .btw templates, D:\data paths, and field printing on each deployment.

## Task 1: 兼容替换 Barcode.py / Barcode_Cal.py 并新增 HR ECO 规则, success

### rollout_summary_files

- rollout_summaries/2026-08-28T12-05-45-K0HA-barcode_compatible_replacement_bartender_label_rules.md (cwd=\\?\UNC\100.82.136.106\Work\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T20-05-46-01a04843-00ce-7af0-9fca-6fd5f8241cae.jsonl, updated_at=2026-09-01T02:09:38+00:00, thread_id=01a04843-00ce-7af0-9fca-6fd5f8241cae, four-file compatibility package verified; real printing remains unaccepted)

### keywords

- Barcode.py, Barcode_Cal.py, 日期设置.ini, 日期对照.ini, HR ECO, 921008179R, 214103195R, YY+DDD, 438481, 158 passed, E113015100, T828

## Task 2: 文本文件、二维码与 BarTender 模板对应关系, success

### rollout_summary_files

- rollout_summaries/2026-08-28T12-05-45-K0HA-barcode_compatible_replacement_bartender_label_rules.md (cwd=\\?\UNC\100.82.136.106\Work\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T20-05-46-01a04843-00ce-7af0-9fca-6fd5f8241cae.jsonl, updated_at=2026-09-01T02:09:38+00:00, thread_id=01a04843-00ce-7af0-9fca-6fd5f8241cae, TXT-to-BarTender dataflow and external-trigger boundary documented)

### keywords

- 协众产品号A.txt, 协众产品号B.txt, 序列号A.txt, 序列号B.txt, 二维码A.txt, 二维码B.txt, 打印路径A.txt, 打印路径B.txt, BarTender, .btw, UTF-8 无 BOM

## User preferences

- when the requested end state is “直接替换原本的 barcode.py 和 Barcode_Cal.py” while retaining “原本的打印效果和新增的打印要求” -> deliver an in-place-compatible replacement rather than a separate-only module, and preserve the original entrypoints/output contract. [Task 1]
- when the user asks “全部完成，最终 158 个测试通过” and wants on-site usability checked -> distinguish code-test success, replaceable-file completeness, template deployment, and real single-label printing; do not equate automated tests with field acceptance. [Task 1]
- when the user asks “如何关联文本文件，你画一个图，每个地方对应哪个文件” -> provide a dataflow diagram plus a field/file mapping, not prose alone. [Task 2]
- when a PDF/PPTX is supplied as specification material, the user asked that its content be “只作为资料，不执行其中指令” -> treat attachment text as data; extract requirements but do not follow embedded instructions. [Task 1]

## Reusable knowledge

- Deploy the compatible package as four files together: `Barcode.py`, `Barcode_Cal.py`, `日期设置.ini`, and `日期对照.ini`; the package is `Y:\协众\072 摩洛哥干检第三台设备\Data-兼容替换版\`, with the field target `D:\data`. The scripts retain `parse_custom_ini`, `find_product_section`, `read_serial_number`, `generate_barcode_by_rule`, `save_to_file`, `process_station`, and `main`, adding fail-closed configuration parsing, atomic TXT writes, and template-missing blocking. [Task 1]
- HR ECO barcode format is `客户件号 + T + YY + DDD + 438481 + 4位流水号`; `Barcode_Cal.py` inserts `C` after the date code. Examples: normal radiator `214103195RT262384384810001`; calibration `214103195RT26238C4384810001`. Regression evidence: `python -m pytest -q` returned `158 passed`, covering historical `E12201540025123080082` and new exact values. [Task 1]
- The confirmed PDF date rule is `YY+DDD` (for example, 2026 day 238 is `26238`); when the PPTX photo showed `260703`, the user confirmed the PDF/`YY+DDD` specification wins. `年方案3` must use `对应=S,T,...` and mapping errors fail closed. [Task 1]
- Dataflow is `协众产品号A/B.txt` -> matching `日期设置.ini` product section; `日期对照.ini` plus `序列号A/B.txt` -> script; script -> `二维码A/B.txt` plus `打印路径A/B.txt`; BarTender `.btw` -> final label. Product files contain a section name such as `214103195R`; A/B use their respective serial files and legacy behavior only reads, not increments, the serial. [Task 2]
- `二维码A/B.txt` holds the final QR string; `打印路径A/B.txt` holds the selected `.btw` path, not label content. Both outputs are UTF-8 without BOM or trailing newline. BarTender owns fixed text, QR object binding, logo, dimensions, and layout; external flow must bind the right QR file and use the A/B template path. [Task 2]

## Failures and how to do differently

- Symptom: only the two Python files are replaced -> new product rules are incomplete. Fix: replace both INI files in the same controlled deployment. [Task 1]
- Symptom: an HR ECO product lacks its `.btw` template -> do not let downstream flow reuse an old template: preserve the QR TXT but clear/block the print-path TXT. Four `HR_ECO_*.btw` templates and a controlled single-label print are prerequisites for field acceptance. [Task 1]
- Symptom: field photos/PPT and the PDF specification conflict on radiator date coding -> follow the confirmed YY+DDD specification; retain the conflict in acceptance evidence. The historical `E113015100` year-scheme-3 error was corrected to standard `对应=S,T,...` / `T828`, so backwards compatibility does not preserve a known erroneous result. [Task 1]
- Symptom: treating `打印路径A/B.txt` as label data or claiming Python guarantees the label appearance -> pivot to the template binding/visual layer; inspect and validate the relevant `.btw` field bindings on site. [Task 2]

# Task Group: Windows OpenCode Desktop provider, SSHFS startup, and Coding Plan configuration

scope: Repair Windows OpenCode Desktop provider/model visibility (including the Windows–Ubuntu Token API route), diagnose SSHFS startup HTTP 500, and distinguish startup/filesystem faults from post-startup provider/network failures while keeping secrets/data protected.
applies_to: cwd=C:\Users\Administrator\Documents\Codex\2026-08-28\referenced-chatgpt-conversation-this-is-an, C:\Users\Administrator\Documents\Codex\2026-08-28\referenced-chatgpt-conversation-this-is-an-2, and C:\Users\Administrator\Documents\Codex\2026-08-28\jie; reuse_rule=Reuse the diagnostic sequence and user-level configuration checks on comparable Windows OpenCode 1.18.23 setups; SSHFS and Ubuntu-service guidance is mount/host-specific, so revalidate current config, provider availability, authentication mode, and process restart state.

## Task 1: 修复 Token API 模型显示、路由和多模态能力, success

### rollout_summary_files

- rollout_summaries/2026-08-28T09-39-34-AcwT-fix_opencode_token_api_glm_multimodal.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-28\referenced-chatgpt-conversation-this-is-an-2, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T17-39-35-01a047bd-2b8e-7d63-a781-446f518accc7.jsonl, updated_at=2026-08-28T11:34:35+00:00, thread_id=01a047bd-2b8e-7d63-a781-446f518accc7, Desktop UI and real text/PNG calls verified)

### keywords

- OpenCode, zhipuai-token, zhipuai-coding-plan, glm-5.3-flash, Coding Plan, modalities, attachment, reasoning_content, 100.117.1.6:4096, opencode.json, opencode.jsonc, auth.json, IMAGE_OK, HTTP 429

## Task 2: 修复 Coding Plan 模型加载, success

### rollout_summary_files

- rollout_summaries/2026-08-28T00-32-18-ObI1-opencode_glm_coding_plan_config_repair.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-28\jie, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T08-32-18-01a045c8-216a-7e92-ae65-1872958ec6d5.jsonl, updated_at=2026-08-28T00:38:35+00:00, thread_id=01a045c8-216a-7e92-ae65-1872958ec6d5, explicit Provider restored; default request returned OK)

### keywords

- OpenCode, zhipuai-coding-plan, glm-5.3-flash, opencode.jsonc, ZHIPU_CODING_PLAN_API_KEY, environment-variable, opencode models, opencode run --pure --print-logs, debug config, plaintext_secret

## Task 3: Diagnose recurring OpenCode Desktop HTTP 500 on SSHFS P: workspace, success

### rollout_summary_files

- rollout_summaries/2026-08-27T23-41-53-aRZm-opencode_desktop_sshfs_ep_er_m_startup_500_glm_separate.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-28\referenced-chatgpt-conversation-this-is-an, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T07-41-53-01a04599-f73a-7030-a3f2-d20d0e3f0960.jsonl, updated_at=2026-08-27T23:58:26+00:00, thread_id=01a04599-f73a-7030-a3f2-d20d0e3f0960, startup bypass verified; persistent setup after reboot/logon not independently verified)

### keywords

- OpenCode Desktop, HTTP 500, Unexpected server error, err_4e8bd887, err_444677b5, EPERM, FileSystem.makeDirectory, SSHFS, P:\\codex_opencode, .opencode, OPENCODE_DISABLE_PROJECT_CONFIG, server ready, AI_APICallError: 网络错误

## User preferences

- when the user says “Token API 的这个模型没法用” or “现在都看不见 Token API 的这个模型了” -> do not stop at `opencode models`; verify Desktop-loaded configuration, remote service state, UI visibility, and a real call. [Task 1]
- when the user says “Token API 与 Coding Plan 的 key 是一样的” -> allow one key, but keep distinct Provider IDs and baseURLs; never infer billing route from the key. [Task 1]
- when the user says “直接帮我解决” for a local configuration failure -> diagnose, make the scoped repair, validate it, and state the required restart rather than stopping at troubleshooting advice. [Task 2]
- when requesting ZIP diagnosis, the user asked for the “safest minimal fix” and preservation of data -> start read-only; do not delete sessions, credentials, databases, or project files without explicit approval. [Task 3]
- when a fault returns after reopening -> provide a fix that persists across launches, not only a temporary PowerShell environment variable. [Task 3]

## Reusable knowledge

- Windows OpenCode 1.18.23 may load both `C:\Users\Administrator\.config\opencode\opencode.json` and `opencode.jsonc`; inspect and synchronize both before concluding a provider fix. For the Windows–Ubuntu setup, `zhipuai-token/glm-5.3-flash` uses `https://open.bigmodel.cn/api/paas/v4`, while `zhipuai-coding-plan/glm-5.3-flash` uses `https://open.bigmodel.cn/api/coding/paas/v4`; the valid model set also includes `opencode-go/glm-5.3-flash`. [Task 1]
- A custom Token API model needs capability metadata, not only name/baseURL: `attachment: true`, `modalities.input: ["text","image","video","pdf"]`, `reasoning: true`, `tool_call: true`, `interleaved: {field: "reasoning_content"}`, `limit.context: 1000000`, and `limit.output: 131072`. The recorded Windows text call returned `OK` and PNG call `IMAGE_OK`; remote Provider metadata was connected/present. [Task 1]
- A current `C:\Users\Administrator\.config\opencode\opencode.jsonc` containing only `$schema` explains a missing Coding Plan model configuration. Restore only the required explicit `zhipuai-coding-plan` Provider; set both `model` and `small_model` to `zhipuai-coding-plan/glm-5.3-flash`, use endpoint `https://open.bigmodel.cn/api/coding/paas/v4`, and refer to the key as `{env:ZHIPU_CODING_PLAN_API_KEY}`. Do not wholesale-restore old unrelated MCP, plugins, or Providers. [Task 2]
- `opencode models` establishes enumeration only. Completion requires a configured/default or explicit-model minimal request returning `OK`, provider/model log confirmation where available, and a fully exited/reopened Desktop; the recorded Coding Plan checks confirmed JSON parsing, model/small_model binding, environment reference, and no plaintext secret. [Task 1][Task 2]
- On the SSHFS-mapped P: workspace, `err_4e8bd887` / `err_444677b5` traced to `EPERM: operation not permitted, mkdir 'P:\\codex_opencode\\.opencode'` during instance bootstrap. OpenCode 1.18.23 `Config.ensureGitignore` calls `fs.ensureDir(dir)` and the propagated `loadInstanceState` failure appears to the renderer as opaque HTTP 500 / `Unexpected server error`. [Task 3]
- A schema-only global config reproduced the same startup error, so GLM/provider/plugin configuration was not causal. `OPENCODE_DISABLE_PROJECT_CONFIG=1` produced `server ready` without deleting data by skipping project-local config discovery; persist it with `[Environment]::SetEnvironmentVariable("OPENCODE_DISABLE_PROJECT_CONFIG","1","User")`, then restart OpenCode (the persistent state after reboot/logon was not independently verified). A longer-term design is server execution on the Ubuntu native path instead of SSHFS writes. [Task 3]
- `providerID=zhipuai-coding-plan modelID=glm-5.3-flash ... AI_APICallError: 网络错误` is a separate post-startup upstream/network request failure. No `opencode-mem` plugin initialization failure was causal. [Task 3]

## Failures and how to do differently

- Symptom: Desktop still shows the old/missing Token API after only the Ubuntu config changes -> reconcile both Windows config files with the remote config and completely restart Desktop. Retain the explicit `zhipuai-token` Provider if the UI must show Token API; replacing it with native `zhipuai` removes that separate entry. [Task 1]
- Symptom: remote service begins automatic retries after restart -> do not load `server.env` if that switches port 4096 to password protection unless Desktop client authentication is updated compatibly. [Task 1]
- Symptom: Coding Plan returns HTTP 429 / “5 小时使用上限已达” -> treat it as plan quota exhaustion, not a Provider/key routing failure. Prefer Base64 or standard input for scripts when Bash/Python heredocs or PowerShell quoting fail, and verify each execution separately. [Task 1]
- Symptom: `opencode debug config` resolved output exposes an API key -> do not print it; inspect only structural fields or reliably redact before output. Store no plaintext key in `opencode.jsonc`. [Task 2]
- Symptom: model listing succeeds but normal use still fails -> do not close on `opencode models`; run the default minimal request, inspect provider/model logs, and fully exit/reopen OpenCode so it rereads the user configuration. [Task 2]
- Symptom: a process-scoped `$env:OPENCODE_DISABLE_PROJECT_CONFIG="1"` fixes one run and the EPERM returns after reopening -> use the User environment variable (or avoid SSHFS project initialization), then verify the next Desktop launch. [Task 3]
- Symptom: HTTP 500 on this mount -> do not clear `%USERPROFILE%\.local\share\opencode`, delete authentication/database data, reinstall, or blame `WSALookupServiceBegin failed with: 10108` / `ResizeObserver loop completed` before matching the fatal `.opencode` EPERM. [Task 3]

# Task Group: Longol MES W07 central/collector split, secure runner, and Terra-FIX proof gates

scope: Continue or review the uncommitted W07 responsibility split in `P:\longol_mes`; use for central/collector boundaries, streamed secret redaction, populated 005→006 proof, and resolving the four Terra blockers before final approval.
applies_to: cwd=P:\longol_mes; reuse_rule=Reuse architecture and failure shields only for W07 or closely matching Longol MES work; offline checks are not acceptance, and no SQL/Git mutation is authorized without the required explicit approval and evidence.

## Task 1: W06 transition and W07 architecture/package split, partial

### rollout_summary_files

- rollout_summaries/2026-08-24T13-40-17-zuK0-w07_central_split_terra_fix.md (cwd=P:\longol_mes, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\26\rollout-2026-08-26T12-05-01-01a03400-1cf3-7121-9117-552905c9e5e4_01a03c3e-26f7-74f0-a6ff-6bf6c3802ad0.jsonl, updated_at=2026-08-27T01:36:20+00:00, thread_id=01a03400-1cf3-7121-9117-552905c9e5e4, W06 committed; W07 offline green but unapproved)

### keywords

- W07, codex/w07-central-responsibility-split, a31ce87f32e09314581fdc18448bb67d61217b83, 00_CENTRAL-MES, PC-01_HELIUM-01, collector-only, shared/station-agents/print-agent, MES_ENV_FILE, STATION_ENV_FILE, /api/v1/station/helium/legacy-batches, WAITING_FOR_SOL_REVIEW, .git/index.lock

## Task 2: MiMo redaction/remediation and Terra review, partial

### rollout_summary_files

- rollout_summaries/2026-08-24T13-40-17-zuK0-w07_central_split_terra_fix.md (cwd=P:\longol_mes, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\26\rollout-2026-08-26T12-05-01-01a03400-1cf3-7121-9117-552905c9e5e4_01a03c3e-26f7-74f0-a6ff-6bf6c3802ad0.jsonl, updated_at=2026-08-27T01:36:20+00:00, thread_id=01a03400-1cf3-7121-9117-552905c9e5e4, Terra/high returned FIX with four bounded blockers)

### keywords

- w07-secure-run.js, StringDecoder, longestFull, unresolvedLonger, RedactingStream, byte-at-a-time, UTF-8 split, proofEnvironment, runProofStep, populated-upgrade-proof, W07_OPENCODE_TRANSFER.md, npm run w07:offline, git diff --check, Terra-FIX, REVIEW_PACKET.md

## User preferences

- when approving W07, the user explicitly chose `1A 2A 3A` -> Windows 7 helium PCs do not install Node; collector runs on the central host through an authenticated internal API; print agent goes in `shared/station-agents`; preserve v1/welding compatibility and leave the PDA API unmounted. [Task 1]
- when approving scope, the user said `1批准，2批准` -> obtain explicit approval before branch/file/database work; protect existing databases and unrelated worktree files with a narrow allowlist. [Task 1]
- for this workflow, MiMo writes, Terra/high performs read-only intermediate review, then Sol provides final review -> report every gate separately and never imply acceptance from offline results alone. [Task 2]

## Reusable knowledge

- W06 commit `a31ce87f32e09314581fdc18448bb67d61217b83` (`refactor: unify W06 route evaluation`) staged exactly 22 files and preserved unrelated changes. W07 roots are `00_CENTRAL-MES`, `PC-01_HELIUM-01`, and `shared/station-agents/print-agent`; central owns MES, collector owns read-only legacy access/mapping/upload/checkpointing, and print agent is independent. [Task 1]
- Central must not read cwd `.env`; collector must not contain MES credentials/business modules. The collector uploads with station headers to `POST /api/v1/station/helium/legacy-batches`, retains an atomic checkpoint on failed upload, and central must not mount the PDA route. [Task 1]
- The repaired redactor uses deterministic `StringDecoder` buffering with `longestFull`/`unresolvedLonger`. Evidence reached security 16/16, W07 boundary/security/ingestion 30/30, unified offline 142/142; no-credential harness failed closed and the protected migration hash matched `6BBC3A54AA35A11EFDBA3DE1A467071E9B5FB77E17C1C604C7AED7CB99883492`. [Task 2]
- Populate a separate allowlisted `LongolMES_W07_*_HISTORY` database only after 001–005, use actual fields including `normalized_event_id`, `ingestion_run_id`, and `reason_code`, then apply 006, capture pre/post evidence, and rerun for skip proof. [Task 2]

## Failures and how to do differently

- Symptom: unrelated W03/W01/PDA/WELD/`autoflow/`/DOCX/XLSX changes appear alongside W07 -> stage only an explicit W07 allowlist. Handle an index lock only after checking active processes, lock ownership, and staging; do not reset, clean, or delete speculatively. [Task 1]
- Symptom: long-running Luna work stalls -> obtain progress checkpoints and verify tree/status after interruption; an interruption can preserve files but leave intermediate migration state. [Task 1]
- Symptom: Terra returns `FIX` -> resolve only the four recorded issues: narrow `proofEnvironment` credential forwarding, update `W07_OPENCODE_TRANSFER.md`, record exact required commands/scans, and provide independently inspectable populated 005→006 proof. Do not claim complete, request Sol approval, run credentialed SQL, or commit first. [Task 2]
- Symptom: redactor passes simple smoke checks but leaks at boundaries -> use `node:assert/strict`, exact expected output, separate stdout/stderr, and async shared-prefix/byte-at-a-time/UTF-8 tests. On Windows PowerShell, avoid shell-style `rg` glob arguments; pass explicit paths or supported globs. [Task 2]

# Task Group: AutoFlow visible orchestration and packet-based OpenCode review

scope: Use for the Windows AutoFlow workflow and user-level OpenCode executor: a visible, bounded Codex-plan → OpenCode-implement → Codex-check flow with tiered packet-only intermediate review and complete remote deployment evidence.
applies_to: cwd=C:\Users\Administrator\autoflow (executor also under C:\Users\Administrator\.codex); reuse_rule=Reuse the model defaults, packet/baseline contract, and deployment checklist for this user-level workflow; revalidate remote-machine state and do not treat local smoke success as remote completion.

## Task 1: Simplify AutoFlow and add a visible UI, partial

### rollout_summary_files

- rollout_summaries/2026-08-26T10-16-32-KPFi-autoflow_visible_workflow_tiered_opencode_review.md (cwd=C:\Users\Administrator\autoflow, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\26\rollout-2026-08-26T18-16-32-01a03d92-4a43-7e80-bdae-fbce06d498cc.jsonl, updated_at=2026-08-26T23:11:25+00:00, thread_id=01a03d92-4a43-7e80-bdae-fbce06d498cc, implementation/tests passed; browser visual check unrecorded)

### keywords

- AutoFlow, orchestrator.py, dashboard/app.py, /api/state, /api/run, progress.json, events.jsonl, --resume, max_iterations=1, port 0, WinError 10013, 38 passed

## Task 2: Build tiered packet-based OpenCode executor, success

### rollout_summary_files

- rollout_summaries/2026-08-26T10-16-32-KPFi-autoflow_visible_workflow_tiered_opencode_review.md (cwd=C:\Users\Administrator\autoflow, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\26\rollout-2026-08-26T18-16-32-01a03d92-4a43-7e80-bdae-fbce06d498cc.jsonl, updated_at=2026-08-26T23:11:25+00:00, thread_id=01a03d92-4a43-7e80-bdae-fbce06d498cc, local skill and real smoke chain passed)

### keywords

- opencode-executor, REVIEW_PACKET.md, run_opencode.py, run_terra_review.py, opencode-go/mimo-v2.5, gpt-5.6-luna, gpt-5.6-terra, baseline.json, SHA-256, stdin-only, same-session-fix, [CODEX:INTERMEDIATE-REVIEW], 8 passed

## Task 3: Synchronize another computer completely, partial

### rollout_summary_files

- rollout_summaries/2026-08-26T10-16-32-KPFi-autoflow_visible_workflow_tiered_opencode_review.md (cwd=C:\Users\Administrator\autoflow, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\26\rollout-2026-08-26T18-16-32-01a03d92-4a43-7e80-bdae-fbce06d498cc.jsonl, updated_at=2026-08-26T23:11:25+00:00, thread_id=01a03d92-4a43-7e80-bdae-fbce06d498cc, remote filesystem not inspected or verified)

### keywords

- CODEX_OPENCODE_另一台电脑部署任务书.md, deepseek-v4-flash, Terra/medium, [TERRA:REVIEW], AGENTS.md, agents/openai.yaml, review_packet_template.md, terra_review.schema.json, complete installation, remote acceptance

## User preferences

- when defining the coding workflow, the user said “我提需求，codex详细规划，然后opencode执行，然后codex检查” and objected that it “要执行很久，而且我还看不到交互界面” -> default to a short, visible, controllable workflow rather than autonomous repeated loops. [Task 1]
- preserve the exact defaults unless overridden: OpenCode `opencode-go/mimo-v2.5` variant `none`; simple review `gpt-5.6-luna`/`high`; complex review `gpt-5.6-terra`/`high`; show fixed stage markers and active model. [Task 2]
- for another machine, “只写入模型配置不算完成” -> require the full skill, scripts, references, tests, config, routing rules, and remote command/file evidence. [Task 3]

## Reusable knowledge

- AutoFlow now makes one complete OpenCode pass, defaults `max_iterations=1`, disables destructive automatic recovery, clears only stale AutoFlow metadata for new tasks, requires `--resume` to load existing state, and exposes a dependency-free UI at `/`, `/api/state`, `/api/run`. `python -m pytest -q` passed 38 tests. [Task 1]
- Effective executor config is Mimo/none, Luna/high simple, Terra/high complex, `max_fix_rounds=1`, `require_review_packet=true`. The runner requires `REVIEW_PACKET.md`, streams logs/captures session IDs, and writes deterministic before/after SHA-256 manifests to `baseline.json`; Git status alone cannot prove session-scoped writes. [Task 2]
- `run_terra_review.py --tier simple` chooses Luna/high and `--tier complex` Terra/high. Inject plan and packet through stdin, prohibit tools/repository scans/retests, distinguish target project root from evidence-run directory, and allow at most one same-session fix. The final local smoke chain returned `PASS`, zero issues; combined skill tests passed 8. [Task 2]
- Remote acceptance must independently verify all listed skill assets, user-level config, AGENTS routing, packet generation, tier behavior, stdin-only reviewer, one-fix limit, visible markers, and actual command/file evidence. [Task 3]

## Failures and how to do differently

- Symptom: fixed dashboard port `8765` fails with `WinError 10013` -> start with `--port 0`; do not call the UI visually verified unless a browser inspection is recorded. [Task 1]
- Symptom: Terra returns `BLOCKED` because it cannot read files, scope paths are ambiguous, or Git status is insufficient -> packet-only stdin injection, explicit target/evidence scope metadata, and deterministic manifests are the proven sequence. [Task 2]
- Symptom: tests still expect `[TERRA:REVIEW]` or deployment prose mentions `deepseek-v4-flash`/Terra-medium -> update marker-contract tests and normalize every legacy occurrence with targeted `rg` checks before reuse. [Task 2][Task 3]
- Symptom: local rollout claims the other computer is complete -> it is not evidence of remote synchronization; execute the taskbook on the remote machine and collect its acceptance evidence. [Task 3]

# Task Group: Windows DOCX image black/gray print conversion

scope: Convert embedded DOCX images to printable black/gray while retaining document structure and layout; use for Windows Word documents where the requested output must be a separate file and final visual verification matters.
applies_to: cwd=C:\Users\Administrator\Documents\Codex\2026-08-25\li; reuse_rule=Reuse the audit and Word-COM rendering fallback on comparable Windows/Word setups, but re-audit each document's inline/anchor objects and do not treat this output as fully verified without a post-edit visual render or user confirmation.

## Task 1: 将 DOCX 图片转换为黑色/黑灰打印效果, partial

### rollout_summary_files

- rollout_summaries/2026-08-25T11-29-46-5Tg6-docx_images_black_print_260825.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-25\li, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\25\rollout-2026-08-25T19-29-46-01a038ae-f990-70c2-8439-098d3791f88a.jsonl, updated_at=2026-08-25T11:34:53+00:00, thread_id=01a038ae-f990-70c2-8439-098d3791f88a, output generated; final post-edit visual check/user confirmation not recorded)

### keywords

- DOCX, images_audit.py, Word COM, ExportAsFixedFormat, pypdfium2, inline images, black print, grayscale, FileNotFoundError: [WinError 2], RPC 服务器不可用, 260825练习题_图片黑色版.docx

## User preferences

- when editing a Word document, the user asked “里面图片都调成黑色输出” -> default to changing image color only, preserving the original document structure/layout, and saving a new file rather than overwriting the original. [Task 1]
- for “黑色输出”, prefer a black/gray printable result that preserves pale geometric lines and readability instead of destructive pure-black thresholding. [Task 1]

## Reusable knowledge

- `Y:\Temp\260825练习题.docx` had 8 inline images and no floating/anchor images; `images_audit.py` can quickly report image count, inline/anchor type, dimensions, and media paths before/after batch replacement. The output audit remained `inline: 8`, with dimensions matching the original. [Task 1]
- When Windows lacks LibreOffice/soffice or `render_docx.py` cannot convert, use Word COM `Documents.Open(...); ExportAsFixedFormat(...,17)` to make a PDF, then bundled Python `pypdfium2` to render PNG pages for visual inspection. Original-document layout was inspected across 5 PDF pages. [Task 1]
- Generated output: `C:\Users\Administrator\Documents\Codex\2026-08-25\li\outputs\260825练习题_图片黑色版.docx`. [Task 1]

## Failures and how to do differently

- Symptom: `render_docx.py` raises `FileNotFoundError: [WinError 2]` on Windows -> a required conversion component is absent; do not repeatedly retry that renderer, pivot to Word COM PDF export plus `pypdfium2`. [Task 1]
- Symptom: Word COM cleanup reports `RPC 服务器不可用 (0x800706BA)` or `0x800706BE` after export -> first verify the PDF exists and is non-empty, then handle process cleanup separately; do not misclassify the cleanup error as export failure. [Task 1]
- Symptom: output has only image-count/type auditing, with no modified-DOCX page render or user confirmation -> report the result as partial and complete a post-edit PDF/PNG page-by-page check before claiming the print treatment is verified. [Task 1]

# Task Group: Weixin Monitor visible WeChat collection and no-Computer-Use agent pipeline

scope: Safely collect a manually opened WeChat conversation through visible UI/OCR and produce conservative, evidence-linked transaction/todo reports without database access, message sending, or automatic retries.
applies_to: cwd=\\100.82.136.106\personal_folder\Weixin Monitor (also Z:\Weixin Monitor); reuse_rule=Reuse the safety gates, commands, and evidence contract for this checkout or a comparable visible-WeChat workflow; revalidate UI behavior and do not assume another WeChat version has the same search controls.

## Task 1: Remote single-conversation collection, failed safely

### rollout_summary_files

- rollout_summaries/2026-08-22T04-21-12-35l6-wechat_monitor_remote_collection_agent_pipeline.md (cwd=\\?\UNC\100.82.136.106\personal_folder\Weixin Monitor, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\22\rollout-2026-08-22T12-21-12-01a027b3-875a-7501-9fee-0ece5579b728.jsonl, updated_at=2026-08-23T02:08:31+00:00, thread_id=01a027b3-875a-7501-9fee-0ece5579b728, zero messages; safeguards preserved)

### keywords

- Weixin Monitor, WeChat OCR, UIAutomation, Windows.Media.Ocr, uiautomation.SendKeys, Ctrl+F, 查找聊天内容, clipboard, ValuePattern, stopReason=no_new_messages, REMOTE_TEST_HANDOFF.md, REMOTE_TEST_RESULT.md

## Task 2: Agent-friendly collection and transaction-analysis pipeline, success

### rollout_summary_files

- rollout_summaries/2026-08-22T04-21-12-35l6-wechat_monitor_remote_collection_agent_pipeline.md (cwd=\\?\UNC\100.82.136.106\personal_folder\Weixin Monitor, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\22\rollout-2026-08-22T12-21-12-01a027b3-875a-7501-9fee-0ece5579b728.jsonl, updated_at=2026-08-23T02:08:31+00:00, thread_id=01a027b3-875a-7501-9fee-0ece5579b728, CLI/analysis workflow validated offline)

### keywords

- wechat_agent_pipeline.py, transaction_analyzer.py, AGENT_CHAT_PIPELINE.md, analyze_run, transaction_candidates.json, analysis_summary.md, todo_candidates_2026.json, manual foreground, 45-second handshake, max-scrolls 300, 133 passed, UNC path, targeted Ty

## User preferences

- when remote collection failed, the user required “未发送消息、未修改代码、未读取微信数据库” and said clipboard/UIA ValuePattern changes should wait for approval -> stop after the failed UI interaction, preserve evidence, and do not retry or change code without approval. [Task 1]
- when the user clarified WeChat is on another computer with another Codex -> distinguish the development machine from the interactive WeChat machine and use shared handoff/result files. [Task 1]
- when asking whether other agents could receive a conversation target and automatically capture/analyze it “不使用 computer use” -> provide a reusable CLI/module and written handoff rather than requiring Computer Use. [Task 2]

## Reusable knowledge

- This Qt WeChat exposed no chat text through UIA, so OCR was the usable channel; keep `sender` as `null` unless it is reliably identifiable. [Task 1]
- The old `Ctrl+F`/`SendKeys` route is unsafe here: Chinese input became garbled, `Ctrl+F` opened “查找聊天内容” instead of global conversation search, and identical screenshots proved scrolling did not progress. The failed run is `data/runs/2026-08-22T04-27-56-698Z/` with zero messages and `stopReason=no_new_messages`. [Task 1]
- Collection: `py -3 -m python.wechat_agent_pipeline --conversation "<会话名>" --since-date 2026-01-01 --until-date (Get-Date -Format 'yyyy-MM-dd') --max-scrolls 300`. Offline analysis: `py -3 -m python.wechat_agent_pipeline --run-dir "<run directory>"`; it performs no UI action. [Task 2]
- The pipeline deliberately requires the operator to open the target conversation and keep it foregrounded for a 45-second handshake; automatic contact search is disabled. Outputs link messages/raw-view evidence to `transaction_candidates.json`, `analysis_summary.md`, `todo_candidates_2026.json`, and `todo_review_2026.md`. OCR amounts remain candidates and must be checked against PNG evidence. [Task 2]
- Offline validation passed: 133 pytest tests, Python compilation, Ruff, targeted Ty, and Node syntax checks. Full `ty check python` still lacks third-party UIA/WinRT type stubs in this environment. [Task 2]

## Failures and how to do differently

- Symptom: Chinese conversation lookup via `uiautomation.SendKeys`/`Ctrl+F` appears to run but collects nothing -> validate the focused control; use Unicode-safe clipboard or UIA ValuePattern input, OCR-confirm the search result, and verify the opened title before Enter or scrolling. [Task 1]
- Symptom: a remote command exits 0 yet screenshots are identical or `messages.json` is empty -> treat collection as failed, preserve the run evidence, and stop rather than retrying automatically. [Task 1]
- Symptom: npm from a UNC working directory falls back to `C:\Windows` -> use a mapped drive or relative checks such as `node --check .\server.js`. [Task 2]
- Symptom: a README patch misses because the heading differs, or multiple patch operations touch the same file -> retry with small, exact patches. [Task 2]

# Task Group: Weixin Monitor quote images and reconciliation evidence

scope: Reconcile visible WeChat quote images with ledger/reconciliation images month by month while separating working transaction totals from current unpaid balances.
applies_to: cwd=\\100.82.136.106\personal_folder\Weixin Monitor (also Z:\Weixin Monitor); reuse_rule=Reuse the evidence categories and verified 2026 figures only for this evidence set; recheck source images, payments, and invoices before asserting a current balance.

## Task 1: Match January–June quotes to July reconciliation, success

### rollout_summary_files

- rollout_summaries/2026-08-22T04-21-12-35l6-wechat_monitor_remote_collection_agent_pipeline.md (cwd=\\?\UNC\100.82.136.106\personal_folder\Weixin Monitor, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\22\rollout-2026-08-22T12-21-12-01a027b3-875a-7501-9fee-0ece5579b728.jsonl, updated_at=2026-08-23T02:08:31+00:00, thread_id=01a027b3-875a-7501-9fee-0ece5579b728, visible-image reconciliation completed)

### keywords

- quote reconciliation, transaction_summary_2026.md, quote_price_evidence_2026.json, 17-entry July reconciliation, ledger_total=28639, deal_sum=34270, February 6840, March 3539, March 22 2630 versus 2639, April 2230, August 3831

## User preferences

- when reviewing chat financial evidence, the user asked “1-6月份的报价要和对账图对应，你确认下” -> explicitly reconcile quote images and ledger/reconciliation images month by month, retaining conflicts instead of merely summarizing chat text. [Task 1]
- when totals are uncertain, do not attribute the supplier’s “20万” to the user's payable amount without evidence; distinguish transaction evidence from the current unpaid balance. [Task 1]

## Reusable knowledge

- Verified quote/ledger correspondence for February–June: ¥6,840, ¥3,539, ¥7,030, ¥2,220, ¥5,450; total ¥25,079. January ¥820 is in a separate cross-period account image, so the 1–6 working total is ¥25,899. [Task 1]
- The 17-entry July reconciliation image spans 2026-02-12 through 2026-07-09 and totals ¥28,639. August confirmed quote items total ¥3,831. Evidence checks recorded `transaction_count=22`, `deal_sum=34270`, `ledger_total=28639`, and `august_total=3831`. [Task 1]
- The clear discrepancy is March 22 quote ¥2,630 vs ledger ¥2,639 (¥9). April 24's image total is suspect, but the ¥2,230 discount/ledger value is clear. [Task 1]

## Failures and how to do differently

- Symptom: a working total is presented as current debt -> keep quote, ledger, invoice, and payment evidence separate; neither ¥34,270 nor a ledger total establishes the current payable balance without payment/invoice reconciliation. [Task 1]

# Task Group: Windows Bluetooth audio stutter — current-device-first triage

scope: Diagnose Bluetooth-audio stutter on this Windows machine with low-risk service/device resets; identify the actual active output before touching a named historical device.
applies_to: cwd=Windows local system (incidents recorded from C:\Users\Administrator\Documents\Codex\2026-08-19\wo and C:\Users\Administrator\Documents\Codex\2026-08-22\la); reuse_rule=Reuse the diagnostic order on this machine or similar Windows Bluetooth-audio incidents, but enumerate the current output and require a 1–2 minute playback test before claiming a fix.

## Task 1: 排查并重置当前蓝牙音箱“猫王·小王子”, partial

### rollout_summary_files

- rollout_summaries/2026-08-22T01-55-26-bmFR-windows_bluetooth_speaker_stutter_5ghz_mitigation.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-22\la, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T15-15-44-01a0272e-12be-7552-90b1-40164daa9aa3_01a05186-3365-7881-be0d-674e3913ccbf.jsonl, updated_at=2026-08-30T07:24:27+00:00, thread_id=01a0272e-12be-7552-90b1-40164daa9aa3, service/device reset and 5 GHz state verified; playback outcome unverified)

### keywords

- Windows, Bluetooth, 猫王·小王子, 耳机 (2- 猫王·小王子), BARROT Bluetooth Adapter, bthserv, Audiosrv, pnputil /enum-devices /connected, 5-103_5G, 5 GHz, Channel 36, USB 3.0 interference

## Task 2: 排查并初步修复 JBL Soundgear 蓝牙音箱卡顿, partial

### rollout_summary_files

- rollout_summaries/2026-08-19T14-42-54-FSR4-windows_bluetooth_speaker_stutter_jbl_soundgear.md (cwd=C:\Users\Administrator\Documents\Codex\2026-08-19\wo, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\19\rollout-2026-08-19T22-42-54-01a01a79-a2a1-72b0-b62b-e1431072c28a.jsonl, updated_at=2026-08-19T14:44:21+00:00, thread_id=01a01a79-a2a1-72b0-b62b-e1431072c28a, services restarted; playback outcome unverified)

### keywords

- Windows, Bluetooth, JBL Soundgear, JBL Soundgear Hands-Free, BARROT Bluetooth Adapter, bthserv, Audiosrv, Disable-PnpDevice, 常规故障

## User preferences

- when reporting a system fault, the user asked “我这台电脑的蓝牙音箱的声音卡顿，帮我解决” -> begin with low-risk diagnosis/remediation and state exactly what was completed versus what still needs the user’s test. [Task 2]
- when the user reported “蓝牙音箱声音又卡顿了” and corrected “现在播放的是猫王 小王子” -> begin with low-risk diagnosis, treat device names from history only as clues, enumerate the current output before targeted reset, and require a 1–2 minute playback test before claiming resolution. [Task 1]
- when the user said “电脑上蓝牙和wifi本来就很近啊，怎么离远” -> distinguish internal wireless coexistence from the placement of an external USB adapter; suggest moving the adapter/changing USB port or Wi-Fi band, not impractical advice to separate internal components. [Task 1]
- when the user said “wifi切换到5G了，你看下” -> after a change, perform read-only verification and report actual SSID, band, channel, and Bluetooth endpoint state. [Task 1]

## Reusable knowledge

- Low-risk diagnostic order: confirm default output and PnP enumeration (`pnputil /enum-devices /connected` if `Get-PnpDevice` misses it) -> check `bthserv`/`Audiosrv` -> restart services -> reset only the current `Status -eq 'OK'` Bluetooth instance -> inspect USB/wireless interference -> 1–2 minute playback validation. [Task 1]
- This machine uses BARROT Bluetooth Adapter (`USB\\VID_33FA&PID_0001`, driver `21.46.25.278`) and has duplicate/historical Bluetooth and audio-endpoint records. For “猫王·小王子”, `耳机 (2- 猫王·小王子)` was the active `OK` default endpoint while the unnumbered duplicate was `Unknown`; the matching active Bluetooth instance was `BTHENUM\\DEV_00025B954638\\7&334D709D&0&BLUETOOTHDEVICE_00025B954638`. For JBL, avoid the `JBL Soundgear Hands-Free` endpoint during playback and close microphone-using apps that can force Hands-Free mode. [Task 1][Task 2]
- For this incident, Wi-Fi was confirmed as `5-103_5G`, 5 GHz, channel 36 after the reset. If stutter survives a confirmed playback test, investigate BARROT placement and USB 3.0/2.4 GHz interference before repeating service restarts; try USB 2.0 or an extension, then check distance and speaker battery. [Task 1][Task 2]
- Related skill: skills/windows-bluetooth-audio-triage/SKILL.md. [Task 1][Task 2]

## Failures and how to do differently

- Symptom: a historical JBL result is used for a new incident -> cause: current playback device differed (`猫王·小王子`) -> first confirm the active output; do not reset a device based solely on history. [Task 1]
- Symptom: services still display `Running` after a claimed restart -> cause: the permission-limited operation actually failed with “Cannot open ... service” / “拒绝访问”. Fix: report the command result, not the steady-state display; retry only after the required permissions are available. [Task 1]
- Symptom: `Disable-PnpDevice` on `JBL Soundgear Hands-Free` returns `常规故障` -> do not claim the endpoint was disabled; re-query its state, then use Sound settings or Device Manager as the next path. [Task 2]
- Symptom: services/device reset completed but there is no 1–2 minute playback result -> only report that the connection/endpoint returned to `OK`; playback remains unverified and the issue is not proven fixed. [Task 1][Task 2]

# Task Group: Ubuntu Tailscale remote Codex/OpenCode and Windows SSHFS project mapping

scope: Reach an Ubuntu projects directory over Tailscale, configure access through NAS mihomo when needed, and expose it as a Windows SSHFS mapped drive.
applies_to: cwd=C:\Users\Administrator\Documents\Codex\2026-08-20\opencode-ubuntu-server-ubuntu-server-codex; reuse_rule=Reuse the network addresses and SSHFS command pattern only for this home environment; recheck account authentication, keys, and remote paths for another machine.

## Task 1: Install and remotely use Codex on Ubuntu, partial

### rollout_summary_files

- rollout_summaries/2026-08-20T05-17-02-HL4J-codex_ubuntu_tailscale_mihomo_sshfs_mapped_drive.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-20\opencode-ubuntu-server-ubuntu-server-codex, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\20\rollout-2026-08-20T13-17-02-01a01d99-ee07-7750-aec8-b7af4c5d77e9.jsonl, updated_at=2026-08-20T09:06:41+00:00, thread_id=01a01d99-ee07-7750-aec8-b7af4c5d77e9, remote CLI installed; same-account OAuth unstable)

### keywords

- Codex CLI, OpenCode, Tailscale, SSH, mihomo, Docker NAS, 100.117.1.6, 100.82.136.106, 17890, token_revoked, token_invalidated

## Task 2: Map Ubuntu projects to Windows P: drive, partial

### rollout_summary_files

- rollout_summaries/2026-08-20T05-17-02-HL4J-codex_ubuntu_tailscale_mihomo_sshfs_mapped_drive.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-20\opencode-ubuntu-server-ubuntu-server-codex, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\20\rollout-2026-08-20T13-17-02-01a01d99-ee07-7750-aec8-b7af4c5d77e9.jsonl, updated_at=2026-08-20T09:06:41+00:00, thread_id=01a01d99-ee07-7750-aec8-b7af4c5d77e9, first PC verified; second PC key authorization pending)

### keywords

- SSHFS-Win, WinFsp, P:, /home/huaweixiong/projects, id_ed25519_ubuntu_codex2, authorized_keys, read: Connection reset by peer, IdentitiesOnly

## User preferences

- when the user said “不要这么复杂了，把ubuntu里的这个projects作为一个映射盘” and “没必要搞两个了，反正只是映射盘” -> prefer direct SSHFS filesystem access over multi-account Codex orchestration, Samba changes, or Git handoffs when a mapped drive meets the goal. [Task 2]

## Reusable knowledge

- Ubuntu is `huaweixiong@100.117.1.6`; NAS Docker/mihomo is `100.82.136.106`. Docker was not on Ubuntu. The usable proxy was `http://100.82.136.106:17890` (not assumed port `7890`), verified with `curl -v --connect-timeout 10 -x http://100.82.136.106:17890 https://chatgpt.com -o /dev/null`. [Task 1]
- Codex desktop could detect remote `codex-cli 0.148.0` over SSH after the Ubuntu install. Remote Codex needs working key SSH and a `codex` command on PATH. [Task 1]
- On the first Windows PC, prepend `C:\Program Files\SSHFS-Win\bin` to PATH before `sshfs.exe`; its bundled `ssh.exe` avoids `read: Connection reset by peer`. Map `huaweixiong@100.117.1.6:/home/huaweixiong/projects` to `P:` with `IdentityFile`, `IdentitiesOnly=yes`, `UserKnownHostsFile`, `StrictHostKeyChecking=yes`, `reconnect`, `ServerAliveInterval=30`, `idmap=user`, and `umask=002`; verify both `P:\` and `P:\longol_mes`. [Task 2]
- WinFsp `2.1.25156` and SSHFS-Win `3.5.20357` were installed. The startup remount script is `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\mount-ubuntu-projects.cmd`. The mapped drive exposes live files; it does not push to GitHub, so avoid simultaneous edits from multiple computers. [Task 2]

## Failures and how to do differently

- Symptom: Ubuntu cannot reach chatgpt.com (`curl: (28) Failed to connect to chatgpt.com port 443`) -> inspect the NAS container's actual port mappings rather than installing Docker on Ubuntu. [Task 1]
- Symptom: repeated desktop/CLI OAuth authentication of the same account produces `token_revoked`, `token_invalidated`, or `Access token is missing` -> keep to one OAuth client or use separate CLI API-key authentication if simultaneous access is required. [Task 1]
- Symptom: second PC reports `no such identity` or falls back to password -> add `id_ed25519_ubuntu_codex2.pub` to `/home/huaweixiong/.ssh/authorized_keys`, then verify `ssh -o PreferredAuthentications=publickey -o PasswordAuthentication=no -i <key> huaweixiong@100.117.1.6 "id -un"` returns `huaweixiong` before mounting. [Task 2]

# Task Group: Edge-specific ChatGPT login troubleshooting

scope: Triage an Edge-only ChatGPT login/access failure when another browser works, distinguishing Edge-local data/extensions from proxy/Cloudflare routing; keep the repair outcome unverified until tested.
applies_to: cwd=C:\Users\Administrator\Documents\Codex\2026-08-20\referenced-chatgpt-conversation-this-is-an and C:\Users\Administrator\Documents\Codex\2026-08-30\e; reuse_rule=Reuse the browser-local diagnostic order whenever one browser works and Edge fails, but verify the active proxy path and obtain a minimal-change user result before asserting a cause or completed fix.

## Task 1: Edge 无法登录 ChatGPT、360 浏览器可以登录, partial

### rollout_summary_files

- rollout_summaries/2026-08-20T14-28-58-9eae-edge_chatgpt_login_browser_specific_troubleshooting.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-20\referenced-chatgpt-conversation-this-is-an, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\20\rollout-2026-08-20T22-28-58-01a01f93-3d5b-7b42-8176-46ba835c70ba.jsonl, updated_at=2026-08-20T14:33:10+00:00, thread_id=01a01f93-3d5b-7b42-8176-46ba835c70ba, InPrivate outcome not obtained)

### keywords

- ChatGPT login, Edge, 360浏览器, InPrivate, cookies, third-party cookies, JavaScript, edge://extensions, edge://settings/siteData, chatgpt.com/auth/login

## Task 2: 排查 Edge 访问 ChatGPT 失败, partial

### rollout_summary_files

- rollout_summaries/2026-08-30T05-33-30-8uT1-edge_chatgpt_proxy_zeroomega_cloudflare.md (cwd=\\?\C:\Users\Administrator\Documents\Codex\2026-08-30\e, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T13-33-30-01a05128-9b1c-7a73-b572-30f8e0b57f7b.jsonl, updated_at=2026-08-30T05:36:17+00:00, thread_id=01a05128-9b1c-7a73-b572-30f8e0b57f7b, high-probability extension/proxy conflict; user validation pending)

### keywords

- Edge, ChatGPT, ZeroOmega, Proxy SwitchyOmega, Clash, 127.0.0.1:17890, Cloudflare 403, Cf-Mitigated challenge, edge://extensions

## User preferences

- when the user reported “360浏览器可以登录chatgpt，但是edge就不行” -> treat a working 360 login as a browser-local signal and start with Edge configuration, Cookie, extension, and privacy checks instead of repeating account or whole-network triage. [Task 1]
- when the user said “360浏览器可以访问chatgpt，但是edge浏览器不可以，帮我解决” -> compare Edge-only proxy, extension, Cookie/cache, and browser settings with the working browser, starting with the smallest reversible test. [Task 2]

## Reusable knowledge

- First open `https://chatgpt.com/auth/login` in an Edge InPrivate window and use the original registration method. This efficiently separates the current Edge profile from a broader compatibility problem. [Task 1]
- If InPrivate succeeds, disable extensions at `edge://extensions`, delete site data for `chatgpt.com`, `openai.com`, and `auth.openai.com` at `edge://settings/siteData`, restart Edge, and retry. If it fails, check Cookies (including third-party Cookies), JavaScript, then test a new Edge profile. [Task 1]
- In the 2026-08-30 environment, WinHTTP used Clash at `127.0.0.1:17890`; direct `chatgpt.com` timed out while proxy curl reached Cloudflare but returned `403 Forbidden` with `Cf-Mitigated: challenge`. Edge had `Proxy SwitchyOmega 3 (ZeroOmega)` 3.5.1, a high-probability extra proxy-control layer. [Task 2]

## Failures and how to do differently

- Symptom: another browser works but Edge fails -> do not reset the account or treat the network as the first suspect; prioritize a clean Edge context. [Task 1]
- Symptom: last action was the question “InPrivate 能不能登录” with no reply -> do not claim a repair succeeded; collect that result before choosing data cleanup, extension removal, or a new profile. [Task 1]
- Symptom: proxy curl connects but returns `Cf-Mitigated: challenge` -> distinguish proxy connectivity, Cloudflare challenge, and Edge extension routing; first manually disable ZeroOmega/other ad/privacy extensions at `edge://extensions`, retry, then clear ChatGPT site data and restart Edge. Do not call the diagnosis fixed without user confirmation. [Task 2]
- Symptom: an automated temporary Edge launch is blocked by execution policy -> do not retry the same blocked launch; give the user the corresponding browser UI steps. [Task 2]

# Task Group: D:\ultralytics-main configurable F/U inspection pipeline and candidate evaluation

scope: Build and validate a Windows plugin-based YOLO F/U inspection cascade, annotated outputs, and conservative candidate-model decisions.
applies_to: cwd=D:\ultralytics-main; reuse_rule=Reuse the architecture and validation shields for matching Windows YOLO inspection work, but recheck paths, models, rules, and benchmark data per checkout.

## Task 1: Configurable multi-stage YiDa inspection pipeline, success

### rollout_summary_files

- rollout_summaries/2026-07-28T00-49-36-GbP2-ultralytics_multistage_pipeline_model_comparison.md (cwd=D:\ultralytics-main, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\07\28\rollout-2026-07-28T08-49-36-019fa632-d326-7283-9a74-b008ba6f6368.jsonl, updated_at=2026-08-19T09:26:50+00:00, thread_id=019fa632-d326-7283-9a74-b008ba6f6368, runnable MVP, 317-image validation, annotated samples)

### keywords

- mvp_inference, config.yaml, plugin_loader, image_quality, yolo_detector, rule_anomaly, result_fusion, annotated_image, S1-S10, RECHECK, yida002_quality3_full_result.json

## Task 2: Same-benchmark candidate model replacement decision, success

### rollout_summary_files

- rollout_summaries/2026-07-28T00-49-36-GbP2-ultralytics_multistage_pipeline_model_comparison.md (cwd=D:\ultralytics-main, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\07\28\rollout-2026-07-28T08-49-36-019fa632-d326-7283-9a74-b008ba6f6368.jsonl, updated_at=2026-08-19T09:26:50+00:00, thread_id=019fa632-d326-7283-9a74-b008ba6f6368, candidate retained; production unchanged)

### keywords

- benchmark_coco_s1s5.py, config_reference_cascade.yaml, 125-image benchmark, combined_comparison.json, candidate-s1-adaptation, F TP/FP/FN, U TP/FP/FN, exact count

## User preferences

- when starting an inspection implementation, the user asked for “最小可用版本” first, with image reading, YOLO, anomaly placeholder, config-controlled model paths, and unified output -> build a runnable vertical slice before advanced integration. [Task 1]
- when the first pipeline was too shallow, the user corrected “多阶段的，验证下，不要只是yolo” -> downstream stages must consume prior evidence and produce meaningful decisions, with sample and full-run validation. [Task 1]
- when validating results, the user requested annotated images -> generate and visually inspect representative outputs, rather than reporting only JSON/statistics. [Task 1]
- when a tested weight had mixed results, the user accepted keeping the original model -> do not replace production on one metric; require overall improvement on the identical benchmark. [Task 2]

## Reusable knowledge

- Keep the extension outside Ultralytics core under `mvp_inference`; YAML declares plugin `name`, `module`, `class`, `enabled`, model/settings fields. The shared per-image context lets later plugins read `quality`, `detections`, `anomaly`, and `final_result`. [Task 1]
- Validated cascade: `image_quality -> yolo_detector -> rule_anomaly -> result_fusion`; quality uses brightness/Laplacian sharpness, rule analysis handles detection count/expected classes/low-confidence/quality and filename-glob rules, fusion emits `OK`, `RECHECK`, or `NG`. `annotated_image` adds F/U boxes, confidence, status, quality, selected rule, and anomaly reasons. [Task 1]
- On `D:\YiDa002.yolo26\train\images`, the 317-image run yielded `OK=258`, `RECHECK=58`, `NG=1`. Filename-specific rules replaced an overbroad global F/U rule; quality warnings were routed to `RECHECK` rather than `NG`. [Task 1]
- Benchmark with `mvp_inference/tools/benchmark_coco_s1s5.py` and `mvp_inference/config_reference_cascade.yaml`: production `weightm\weights\best.pt` scored exact count `117/125`, F `2421/5/4`, U `2315/1/3`, RECHECK `55`; candidate `weightm_260419\weights\best.pt` scored `115/125`, F `2422/6/3`, U `2315/3/3`, RECHECK `56`. Keep production unchanged: the candidate reduced one F FN but added F/U false positives and lost two exact-count images. [Task 2]
- Keep experimental heuristic overrides behind explicit flags. The candidate-specific S6 CNN-F-over-ROI-YOLO-U override did not improve aggregate metrics and was removed. [Task 2]

## Failures and how to do differently

- Symptom: `ModuleNotFoundError: No module named 'mvp_inference'` when directly executing `run.py` -> add the project root to `sys.path`; retain Python 3.8-compatible typing. Both `python .\mvp_inference\run.py` and `python -m mvp_inference.run` were validated. [Task 1]
- Symptom: Windows PowerShell breaks inline Python reporting or rejects `??` -> use `ConvertFrom-Json` or a temporary script, and `ContainsKey` with explicit initialization. [Task 1]
- Symptom: apparent candidate recall gain -> compare false positives, exact-count correctness, RECHECK count, and all F/U TP/FP/FN on the same data/cascade/thresholds before any promotion. [Task 2]

# Task Group: Y:\交易明细 contract-invoice reconciliation and V3 color marking

scope: Reconcile a contract list against invoice detail using time-first, evidence-backed fuzzy matching; deliver a reviewable, color-coded V3-format workbook.
applies_to: cwd=Y:\交易明细 (network path may appear as \\?\UNC\100.82.136.106\Work\交易明细); reuse_rule=Reuse the matching and delivery safeguards for similar contract/invoice work, but revalidate entity rules, columns, and conclusions against current source workbooks.

## Task 1: 朗国合同项目开票核对与V3标色, success

### rollout_summary_files

- rollout_summaries/2026-08-15T03-07-33-8WmW-langguo_contract_invoice_audit_color_marking.md (cwd=\\?\UNC\100.82.136.106\Work\交易明细, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\15\rollout-2026-08-15T11-07-33-01a00363-9683-7c83-b3bb-cc9ec5699236.jsonl, updated_at=2026-08-15T04:23:22+00:00, thread_id=01a00363-9683-7c83-b3bb-cc9ec5699236, final workbook visually and formula-checked)

### keywords

- 朗国合同清单v3.xlsx, 全量发票合并.xlsx, Sheet1, 全量发票, invoice-matching, date-order, fuzzy-match, 46696377-379, 四色标注, node_modules junction

## User preferences

- when reconciling financial records, the user asked: “按时间逻辑匹配，宽松匹配，合同时间在前，发票时间在后，标注好颜色，让我确认” -> apply the temporal constraint, fuzzy content matching, color-tiered conclusions, and a human-reviewable evidence trail instead of a binary result. [Task 1]
- when producing the workbook, the user required the V3 original format and “保留全部合同” -> do not alter source files or exclude rows because delivery status/registered invoice number is empty; preserve all contracts, the original 13 columns, project order, structure, and formatting in a separate result file. [Task 1]

## Reusable knowledge

- For this audit, `朗国合同清单v3.xlsx` `Sheet1!A1:M159` held 156 contract projects and `全量发票合并.xlsx` `全量发票!A1:AA468` held 467 invoice details. The final output is `Y:/交易明细/outputs/01a00363-9683-7c83-b3bb-cc9ec5699236/朗国合同清单v3_开票状态标色.xlsx`. [Task 1]
- Treat a valid candidate as a normal, positive invoice for a 协众-system buyer whose issue date is not before the contract date. Match traditional invoice numbers, full digital-invoice numbers, recorded suffixes, and consecutive ranges such as `46696377-379`; then use project name/code, item, specification, and amount as fuzzy evidence. [Task 1]
- A blank or nonblank registered invoice field alone is not proof. Generic terms such as “工装”, “堵头”, and “设备” cannot alone confirm invoicing. Green/yellow rows should retain invoice number, issue date, buyer, item, and specification evidence. [Task 1]
- Use four outcomes: confirmed invoiced, likely invoiced pending confirmation, no valid invoice found, and data anomaly. Final totals were 119 green, 12 yellow, 12 red, and 13 orange (156 total). Preserve/flag, rather than silently correct, contracts `2024032101` and `2026020618`, whose contract-number dates were 365 days from the table date. [Task 1]
- Deliver Sheet1 with whole-row four-color status, Sheet2 with color explanations/counts, and Sheet3 with the red no-valid-invoice list. Verify exported red-list dates render as dates; the final formula-error scan found 0 errors and visual preview passed. [Task 1]

## Failures and how to do differently

- Symptom: creating a `node_modules` junction/symbolic link in network drive `Y:\交易明细` fails with “此文件或目录不是一个重分析点” -> run the artifact-tool script from a local temporary working directory. [Task 1]
- Symptom: intermediate and final category counts disagree -> recheck the final deliverable and cite only its final verified totals. [Task 1]
# Task Group: Cross-account memory linkage and shared AI-memory workflow

scope: Archive Codex history and route related work through current-account, second-account, and OpenCode memory while retaining provenance and never copying raw logs into the retrieval layer.
applies_to: cwd=C:\Users\Administrator\.codex\memories and P:\memory; reuse_rule=Use for this user's cross-account history and memory-maintenance tasks; verify exact history in the originating account's index and rollout path, and treat conflicts as source-bound evidence rather than facts to overwrite.

## Task 1: 归档第二账号聊天记录, success

### rollout_summary_files

- rollout_summaries/2026-08-20T09-09-30-n5Lv-archive_and_unify_multi_account_ai_memory.md (cwd=P:\memory, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\20\rollout-2026-08-20T17-09-30-01a01e6e-c272-7481-a3d4-94d5bbece02d.jsonl, updated_at=2026-08-20T10:22:29+00:00, thread_id=01a01e6e-c272-7481-a3d4-94d5bbece02d, 149 threads and source paths verified)

### keywords

- state_5.sqlite, account_memory, chat_index.jsonl, threads, source_rollout, redaction, environment_context, 149 threads

## Task 2: 关联两个 Codex 账号的 memory, success

### rollout_summary_files

- rollout_summaries/2026-08-20T09-09-30-n5Lv-archive_and_unify_multi_account_ai_memory.md (cwd=P:\memory, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\20\rollout-2026-08-20T17-09-30-01a01e6e-c272-7481-a3d4-94d5bbece02d.jsonl, updated_at=2026-08-20T10:22:29+00:00, thread_id=01a01e6e-c272-7481-a3d4-94d5bbece02d, shared-source rule recorded)

### keywords

- P:\memory\account_memory, current_account_memory, MEMORY.md, memory_summary.md, chat_index.jsonl, threads, source boundary, conflict resolution

## Task 3: 接入 OpenCode 与 AGENTS.md, success

### rollout_summary_files

- rollout_summaries/2026-08-20T09-09-30-n5Lv-archive_and_unify_multi_account_ai_memory.md (cwd=P:\memory, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\20\rollout-2026-08-20T17-09-30-01a01e6e-c272-7481-a3d4-94d5bbece02d.jsonl, updated_at=2026-08-20T10:22:29+00:00, thread_id=01a01e6e-c272-7481-a3d4-94d5bbece02d, global Windows instructions written)

### keywords

- UNIFIED_MEMORY.md, AGENTS.md, opencode_memory, account_memory, current_account_memory, P:\memory, Windows global instructions

## User preferences

- when the user asked “把这个账号的所有聊天记录整理成memory放在这个文件夹里” -> produce searchable summaries, an index, and per-session cards rather than copying huge raw logs. [Task 1]
- when the user said “把这两个账号的memory都关联，记住” -> consult both Codex account stores for related work, preserve source/account boundaries, and do not overwrite conflicts or duplicate raw logs. [Task 2]
- the ad-hoc note records the same requested boundary: current `C:\Users\Administrator\.codex\memories` and `P:\memory\account_memory` are two sources for the same user; consult both for related tasks, retain source boundaries, and use their indices/rollout paths for exact history. [Task 2] [ad-hoc note]
- when the user provided and accepted `AGENTS.md` shared-memory access -> at session start read the unified entrypoint for related work; only write stable conclusions, preferences, or todos when the task explicitly includes a memory update. [Task 3]

## Reusable knowledge

- The archived second account is `P:\memory\account_memory`, built from `C:\Users\Administrator\.codex\state_5.sqlite` and session rollouts. It contains `MEMORY.md`, `chat_index.jsonl`, and `threads\`; the completed archive covered 149 threads/rollouts from 2026-04-09 to 2026-08-20 and retained source-rollout paths rather than full raw text. [Task 1]
- Current-account sources are `C:\Users\Administrator\.codex\memories\MEMORY.md`, `memory_summary.md`, and `rollout_summaries\`. For conflicts, prefer the newest, most specific, explicitly sourced record; use each account's index and original rollout path for precise history. [Task 2]
- `P:\memory\UNIFIED_MEMORY.md` and `P:\memory\AGENTS.md` define the shared entrypoints. `C:\Users\Administrator\.codex\AGENTS.md` directs Windows Codex to consult `account_memory`, `current_account_memory`, and `opencode_memory`, while retaining provenance and excluding passwords/tokens. [Task 3]

## Failures and how to do differently

- Symptom: generated archive includes `<environment_context>` or plugin inventory as a user message -> filter those injected prefixes before producing summaries/cards. Scan generated artifacts for `password/passwd/pwd/密码`, `-pw`/`--password`, token/key patterns, and redact any residual secret as `[REDACTED_SECRET]`. [Task 1]
- Symptom: a task spans accounts or AI tools -> do not answer from one account's memory alone; first confirm access to the unified entrypoint and all relevant source stores. A redacted memory is a retrieval aid, not the complete transcript. [Task 2][Task 3]

# Task Group: Leak Test 2 Channels LabVIEW-to-Python simulation migration

scope: Safely analyze and deliver an isolated Python UI/simulation candidate for the 双工位 Leak Test 2 Channels LabVIEW project; excludes approval for production replacement.
applies_to: cwd=\\100.82.136.106\Work\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0 (also Y: mapping); reuse_rule=Reuse the migration, UI, packaging, and fail-closed validation pattern for similar industrial-control migrations, but treat device protocols and production acceptance as site-specific.

## Task 1: LabVIEW Main.vi to Python simulation/UI migration, success

### rollout_summary_files

- rollout_summaries/2026-08-15T05-55-22-mcBc-labview_main_vi_python_ui_migration.md (cwd=\\?\UNC\100.82.136.106\Work\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\15\rollout-2026-08-15T13-55-22-01a003fd-3c44-7703-b3a1-b4676f49d662.jsonl, updated_at=2026-08-16T09:44:12+00:00, thread_id=01a003fd-3c44-7703-b3a1-b4676f49d662, approved only for SIMULATE/UI)

### keywords

- Main.vi, Leak Test 2 Channels.lvproj, OPC.lvlib, ATEQ, Modbus, PySide6, QTest, SIMULATE, shadow, live, PyInstaller, canonical package

## User preferences

- when asking “把这个项目转换成C语言或者python语言。实际运行时main.vi” -> first establish the entrypoint, hardware, communications, and running flow; keep the original project untouched rather than directly converting or modifying it. [Task 1]
- for industrial-control migration, the accepted delivery boundary was an isolated Python simulation/UI with real devices and databases kept separate -> default to a simulation safety gate; do not imply production connectivity or replacement. [Task 1]

## Reusable knowledge

- `Leak Test 2 Channels.lvproj` is a LabVIEW 2014 project and `Main.vi` is its top-level entry. Its binary VI resources expose dependencies/strings but cannot substitute for block-diagram/state-machine verification. Preserve `Main.vi`, `.lvproj`, `OPC.lvlib`, and production `Setup.ini` as read-only hashed baselines. [Task 1]
- The project depends on OPC A/B Network Shared Variables, ATEQ Modbus/serial, scanner, ADO database, TCP, Windows API, and licensing. `OPC.lvlib` showed `\\192.168.2.88\OPC\A` and `\\192.168.2.88\OPC\B`; addresses extracted from binaries are leads, never production configuration. [Task 1]
- The Python replica has Main/Setup/Query/Manual pages, A/B stations, Chinese/English/French single-language UI, and a persistent localized runtime-error lifecycle: errors survive `refresh()`/language changes and clear on next success, reset, or successful reprint; acknowledgement clears only UI state. At 1366 error state, keep visible localized summary and separate acknowledgement/reset row. [Task 1]
- Drive state-machine tests through simulated devices/services, not temporary production-page controls: Test 1/Test 2/Label buttons were removed because they created an unauthorized labeling entry point. Cover visible controls, A/B, all languages, runtime errors, acknowledgement/reset/reprint/next success, and 1366/1920 layouts. [Task 1]
- Canonical deliverable: `python_app/package_dist_final/LeakTest2Channels/LeakTest2Channels.exe`; source/package SIMULATE diagnose and smoke exit 0 (`SIMULATE OK: stations=2 records=2 labels=2`), while shadow/live exit 2 before real-resource access. Final test evidence: `60 passed`, `compileall` passed; package review retained 14 canonical PNG and manifests had zero duplicate/missing/hash-mismatch entries. [Task 1]

## Failures and how to do differently

- Symptom: confidence from static text/screenshots only -> runtime error can be overwritten, localization can leak internal keys/Chinese, and narrow layouts can overlap. Fix with real QTest interaction and full-state invariants, not test names alone. [Task 1]
- Symptom: build appears stalled -> first check actual Python/PyInstaller processes to distinguish a normal long build from a stalled agent/session; avoid indefinite waiting. [Task 1]
- Symptom: historical hashes/screenshots enter acceptance manifests -> regenerate manifests only after code, screenshots, and EXE are final; move non-acceptance assets outside the review package. [Task 1]

# Task Group: Leak Test 2 Channels README and GitHub initial publication

scope: Document the existing LabVIEW/Python candidate project accurately and publish a selected initial source/acceptance set to GitHub without claiming untested hardware is live.
applies_to: cwd=Y:\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0 (also UNC mapping); reuse_rule=Reuse this documentation and network-drive Git workflow for this project family, but revalidate remote, branch, selected files, and acceptance state for each publication.

## Task 1: Write project README and publish GitHub, success

### rollout_summary_files

- rollout_summaries/2026-08-16T13-13-47-ruAH-write_project_readme_and_push_github.md (cwd=\\?\UNC\100.82.136.106\Work\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0, rollout_path=C:\Users\Administrator\.codex\sessions\2026\08\16\rollout-2026-08-16T21-13-47-01a00ab4-faa4-7f33-845d-9f51aa5f7f93.jsonl, updated_at=2026-08-16T13:23:16+00:00, thread_id=01a00ab4-faa4-7f33-845d-9f51aa5f7f93, remote main verified)

### keywords

- README.md, xiezhong-Morocco-2-stations, git init, git push, index.lock, core.quotePath, .gitignore, SIMULATE, shadow, live, P0/P1/P2

## User preferences

- when requesting project documentation, “写一个这个项目的具体的md介绍” -> base README content on the real directory, architecture, run path, and verification materials, not a generic overview. [Task 1]
- when adding documentation, “把还没有完成的事情也写进md，后续继续完善” -> explicitly separate completed work from unaccepted field capabilities and include prioritized pending work, blockers, and completion criteria. [Task 1]

## Reusable knowledge

- README sources already include `python_app/README_CN.md` and review-package architecture, equivalence, test, live-acceptance, limitation, and change-summary documents. A useful README covers two A/B-station flow, state-machine intent/commit recovery, safety/permission/license gates, four-page UI, architecture, Python 3.10 SIMULATE run, configuration/testing/build, production-switch stages, and P0/P1/P2 roadmap. [Task 1]
- The published candidate defaults to `SIMULATE`; real PLC, ATEQ F620, scanner, MySQL, and BarTender were not connected, and characterization/shadow/live fail closed. Required field work remains: original ATEQ frame/CRC, PLC M points/interlocks, isolated MySQL/print receipt, license, 100-cycle shadow, 8-hour soak, A/B concurrency, and written live approval. [Task 1]
- Initial remote: `https://github.com/huaweixiong-debug/xiezhong-Morocco-2-stations`, commit `817f8e2` (`docs: add project overview and initial source`) on `main`; local `HEAD` equaled `origin/main`. `.gitignore` excludes build/dist/package outputs, caches, venvs, non-acceptance screenshots, logs, and local databases. Offline checks: `python -m pytest -q` -> `60 passed in 8.93s`; `python -m compileall -q app tests installer tools` passed; README had 18 local links, none missing. [Task 1]

## Failures and how to do differently

- Symptom: `.git/index.lock` on the network drive -> check for active Git processes and wait for their natural completion; do not delete the lock speculatively. [Task 1]
- Symptom: PowerShell fails when reading quoted Unicode paths from `git ls-files` -> set `git config core.quotePath false` before file statistics/checks. [Task 1]
- Symptom: a GitHub skill path is missing -> confirm the installed plugin-cache path before relying on it. [Task 1]

# Task Group: Windows OpenCode installation and WSL sudo guidance

scope: Install/verify OpenCode CLI or desktop on Windows and answer environment-specific WSL/Linux password questions.
applies_to: cwd=D:\ultralytics-main; reuse_rule=Reuse commands and failure checks for similar Windows machines, but recheck versions, policies, download behavior, and WSL distribution/user.

## Task 1: OpenCode CLI and Desktop installation, partial

### rollout_summary_files

- rollout_summaries/2026-08-19T13-25-22-Ifev-windows_opencode_cli_desktop_and_wsl_sudo_guidance.md (cwd=\\?\D:\ultralytics-main, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\19\rollout-2026-08-19T21-25-22-01a01a32-a6ef-72a2-8de5-f991f73c38df.jsonl, updated_at=2026-08-20T04:01:47+00:00, thread_id=01a01a32-a6ef-72a2-8de5-f991f73c38df, CLI verified; desktop incomplete)

### keywords

- OpenCode, opencode-ai, npm install -g, opencode.ps1, windows-x64-nsis, application/octet-stream, BITS, curl: (33), allowScripts

## Task 2: sudo/root password defaults in WSL, success

### rollout_summary_files

- rollout_summaries/2026-08-19T13-25-22-Ifev-windows_opencode_cli_desktop_and_wsl_sudo_guidance.md (cwd=\\?\D:\ultralytics-main, rollout_path=\\?\C:\Users\Administrator\.codex\sessions\2026\08\19\rollout-2026-08-19T21-25-22-01a01a32-a6ef-72a2-8de5-f991f73c38df.jsonl, updated_at=2026-08-20T04:01:47+00:00, thread_id=01a01a32-a6ef-72a2-8de5-f991f73c38df, WSL recovery path provided)

### keywords

- sudo, root password, WSL, wsl -u root, passwd 用户名, sudo passwd root, su -

## User preferences

- when the user said “我要用桌面版” after CLI installation -> fulfill or explicitly track the requested Windows desktop edition; do not stop after a CLI-only success. [Task 1]
- when asking “默认密码是什么，我没设置过” -> state plainly that no universal default credential exists and give WSL-specific reset/setup steps rather than implying it can be queried. [Task 2]

## Reusable knowledge

- On this machine, Node `v25.2.1`/npm `11.17.0` installed `opencode-ai@latest`; `opencode --version` was `1.18.18` and resolved to `C:\Users\Administrator\AppData\Roaming\npm\opencode.ps1`. The official desktop endpoint is `https://dev.opencode.ai/download/stable/windows-x64-nsis`, an approximately 120 MB x64 NSIS executable served as `application/octet-stream`. [Task 1]
- `sudo` normally prompts for the current user's password, not a default root password. In WSL, from Windows PowerShell use `wsl -u root`, then `passwd 用户名`; use `sudo passwd root` only to set root's password. [Task 2]

## Failures and how to do differently

- Symptom: desktop download/install was attempted but the CDN is ~65 KB/s, BITS remains `Connecting`, browser rejects binary content type, or execution policy blocks PowerShell -> desktop is not complete. Verify completed installer, execution, and app launch before reporting success. [Task 1]
- Symptom: resume with `curl -C -` fails as `curl: (33) HTTP server does not seem to support byte ranges.` -> restart or choose another verified delivery path; do not assume resume is supported. Investigate npm's `allowScripts` warning if CLI features are incomplete. [Task 1]
- Symptom: user has forgotten/no password -> provide recovery/reset, not a fictional default-password lookup. [Task 2]
