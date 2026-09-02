thread_id: 01a04599-f73a-7030-a3f2-d20d0e3f0960
updated_at: 2026-08-27T23:58:26+00:00
rollout_path: C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T07-41-53-01a04599-f73a-7030-a3f2-d20d0e3f0960.jsonl
cwd: \\?\C:\Users\Administrator\Documents\Codex\2026-08-28\referenced-chatgpt-conversation-this-is-an

# Diagnosed recurring OpenCode Desktop startup failure and separated it from model/network errors

Rollout context: Windows 11 environment, OpenCode Desktop 1.18.23, project accessed through SSHFS drive P:, with an uploaded debug ZIP and later screenshots/logs.

## Task 1: Diagnose OpenCode Desktop HTTP 500 and GLM errors

Outcome: success

Preference signals:
- The user wanted the uploaded ZIP inspected and asked to preserve data while finding the “safest minimal fix,” indicating future troubleshooting should begin read-only, avoid deleting authentication/session/database data, and distinguish confirmed causes from hypotheses.
- The user repeatedly reported the problem returning after reopening, indicating fixes must account for persistence across desktop restarts rather than only one temporary shell session.

Key steps:
- Extracted `opencode-debug-20260827T233906.zip` and inspected desktop logs plus the 23 MB server log.
- Matched `err_4e8bd887` and subsequent error IDs to `EPERM: operation not permitted, mkdir 'P:\\codex_opencode\\.opencode'` during project instance bootstrap.
- Verified P: is an SSHFS mapping to `/home/huaweixiong/projects`; `.opencode` existed, and OpenCode 1.18.23 was repeatedly trying to initialize it.
- Confirmed the global configuration had been disabled and a schema-only config still produced the same startup failure, ruling out GLM/provider/plugin configuration as the cause of the desktop HTTP 500.
- Inspected bundled code showing `ensureGitignore()` calls `ensureDir()` and that project config discovery can be bypassed with `OPENCODE_DISABLE_PROJECT_CONFIG`.
- Started OpenCode with the environment variable; logs showed `server ready` with no HTTP 500 or `err_...`, confirming the workaround.
- Later startup without the persistent variable reproduced the same failure as `err_444677b5`, confirming the workaround had only been process/session-scoped.

Failures and how to do differently:
- The initial temporary environment-variable workaround disappeared when OpenCode was reopened. Use a persistent per-user environment variable or avoid project initialization on the SSHFS workspace.
- Do not treat `WSALookupServiceBegin failed with: 10108`, `ResizeObserver loop completed`, GLM network errors, or historical `opencode-go` endpoint errors as the startup root cause; they are separate warnings/request failures.
- The final persistent-variable setup was proposed but not independently verified after reboot/logon.

Reusable knowledge:
- Root cause of the desktop 500: OpenCode Desktop 1.18.23 repeatedly attempts `FileSystem.makeDirectory(P:\\codex_opencode\\.opencode)` during instance bootstrap; SSHFS returns `EPERM`, which surfaces in the renderer only as HTTP 500 / `Unexpected server error`.
- GLM-5.3-Flash had separate provider-side network errors (`providerID=zhipuai-coding-plan`, `modelID=glm-5.3-flash`); these affect model calls after startup and are not the desktop initialization failure.
- No plugin initialization failure was found for `opencode-mem`; plugin-related log hits were normal path/permission activity. An older background dependency install warning was unrelated.
- Safe workaround: set `OPENCODE_DISABLE_PROJECT_CONFIG=1` for the user, then restart OpenCode. This skips project-local config discovery while preserving sessions, credentials, database, and project files; global GLM configuration remains available.
- Long-term architectural workaround: run the OpenCode server on the Ubuntu native filesystem and connect Desktop to it, avoiding SSHFS writes to `.opencode`.

References:
- [1] ZIP extracted to `C:\\Users\\Administrator\\Documents\\Codex\\2026-08-28\\referenced-chatgpt-conversation-this-is-an\\work\\opencode-debug-20260827T233906`.
- [2] Server log evidence: `server-1\\opencode.log`, lines around 73634–73649 and 73745–73758, showing `EPERM ... mkdir 'P:\\codex_opencode\\.opencode'` and `ref=err_4e8bd887` / `err_c4d24aa0`.
- [3] Bundled code in `resources\\app.asar`: `Config.ensureGitignore` invokes `fs52.ensureDir(dir)`; `loadInstanceState` propagates the failure; `OPENCODE_DISABLE_PROJECT_CONFIG` skips project `.opencode` discovery.
- [4] Successful recovery log: `C:\\Users\\Administrator\\AppData\\Roaming\\ai.opencode.desktop\\logs\\20260827T235419`; contains `server ready { url: 'http://127.0.0.1:58066' }` and no fatal 500.
- [5] Persistent reproduction: `C:\\Users\\Administrator\\.local\\share\\opencode\\log\\opencode.log`, line 74147, `ref=err_444677b5`, same SSHFS `.opencode` EPERM.
- [6] Safe persistence command proposed: `[Environment]::SetEnvironmentVariable("OPENCODE_DISABLE_PROJECT_CONFIG","1","User")`.
