# 2026-10-12 OpenCode Desktop startup HTML response

Source: current Codex account; live local diagnostics on 2026-10-12.

- Confirmed cause of startup `UnsupportedContentType: text/html`: Desktop 2.0.27 automatically connects to a saved HTTP server at `100.117.1.6:4096`; its `/global/health` reports 1.18.18. At 21:23:55 the remote `/api/info`, `/api/project`, and `/api/vcs` returned HTTP 200 with text/html. Direct probes reproduced the first two. These are incompatible API routes, not evidence of a model-provider or global proxy fault.
- Local bundled service actually reports 2.0.27; 13 authenticated local startup routes return JSON. Windows executable file-version resources and a separately installed PATH CLI may differ from the actual running service version.
- Desktop saved server list resides in `drafts.sqlite`, table `state`, name `opencode.global.dat`, key `server`. Preserve projects, layout, history, drafts, and credentials when changing only the saved server list. Back up and close Desktop before edits to avoid stale in-memory state overwrites.
- Repair completed after the other local OpenCode task finished: closed Desktop normally, backed up drafts.sqlite, removed exactly the one legacy remote item from the saved server list, preserved all other project/layout/history fields, and verified SQLite quick_check=ok. Remote service/data were unchanged.
- Verified fresh Desktop launch at 21:36:54: startup netlog has zero requests to the old remote server; local API responses are JSON and the event stream is SSE. Repeated local checks passed 13/13. Saved legacy connection remains absent. Verification covers startup API behavior, not a model chat or a remote upgrade.
- Backup: task work/drafts-before-server-fix.sqlite. To restore the old connection, close Desktop and restore only the relevant server-list entry; never overwrite newer drafts/history with the complete backup. Remote use remains pending version compatibility work.
- A clean git pull of the shared-memory repository succeeded using a one-command direct connection (`http.proxy=`); proxy-path attempts failed TLS EOF. This does not justify changing persistent system proxy settings.

## Follow-up: visible GUI launch

- User reported OpenCode could not reopen after the repair. The GUI and service remained alive, but GUI MainWindowHandle was 0. Prior Hidden process launch left the interactive window invisible; API verification alone did not establish usable desktop recovery.
- Confirmed no active tasks, ended only the GUI main process, and relaunched with WindowStyle Normal. Verified a responding OpenCode main window with a nonzero handle. The backend and saved data were preserved. Use a visible normal window when reopening the interactive app the user needs to operate, and verify window presence as well as APIs.
