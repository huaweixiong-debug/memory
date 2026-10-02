# 2026-10-02 Codex rollout metadata and thread lookup

- Follow-up to the 2026-10-01 restore diagnosis for thread `01a0dc5b-a613-7a30-9675-6be7a44f5ddd`.
- The reported rollout now exists at its expected path. It is 432,175,979 bytes; its first JSON record is `session_meta` with the matching ID, the raw file has no UTF-8 BOM, and all 37,241 JSONL records parse.
- Codex `read_thread`, page navigation, active-thread listing, and the returned archived-thread page still do not resolve the ID on the local host.
- Current diagnosis: the rollout contents are structurally intact, while the Codex thread store/host lookup does not register or resolve the thread. Refresh or restart Codex before modifying the rollout; preserve the original file. Root cause remains unconfirmed.
- Read-only Codex state inspection confirms `session_index.jsonl` and `state_5.sqlite` still contain the unarchived thread row with the expected rollout path. `thread_history_1.sqlite` contains 37,237 items, but its projection byte offset is 1,118,082,012 while the current rollout is 432,175,979 bytes.
- Codex logs show repeated `os error 3` projection failures for this thread at 2026-10-01 21:41 +08:00, when the rollout path was absent; the current file was created on 2026-10-02. This supports a stale projection/index mismatch after the file returned, but does not prove the exact UI spinner cause.
- The rollout and Codex databases were left unchanged. Any targeted reindex should be done only after Codex is fully closed and the relevant database is backed up.