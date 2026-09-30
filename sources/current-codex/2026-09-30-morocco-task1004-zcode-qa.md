# Morocco TASK-1004 ZCode QA and scope correction (2026-09-30)

- ZCode CLI via `zcode-failover.ps1` successfully used Start Plan OAuth GLM-5.3-Flash at max reasoning for independent QA; no API-key tokens or plan switch occurred.
- On the task's original 2026-09-28 package path, ZCode independently matched both TOML hashes and reran the two SIMULATE commands with exit code 0. This does not approve release: the repository candidate lacks `points.toml`, contains ICU, old immutability has no checksum baseline, OpenSSL 3 dynamic use is unresolved, and duplicate-root-EXE staging policy remains open. TASK-1004 remains `REPAIR_REQUIRED / OPENCODE`.
- A Codex 2026-09-30 rebuild used an unnamed path and violated TASK-1004's explicit `Do not rebuild` scope; exclude it from task acceptance. Its PyInstaller `--clean` cleared the per-user cache and was disclosed. ZCode's temporary empty cwd was removed after verification.
- `zcode-failover.ps1` declares `TimeoutSec=600` but does not apply it to the CLI process, so calls may outlive that limit. This was recorded as a tool improvement; the script was not edited.
