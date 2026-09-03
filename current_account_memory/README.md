# Current account Memory

- `MEMORY.md`: entry point and session index
- `chat_index.jsonl`: machine-readable index (slim schema since 2026-09-03): `id/title/topic/created_at/updated_at/cwd/archived/source_rollout/source_exists/message_count/user_message_count/first_user_message(<=120 chars)`; no raw message arrays — full content lives in threads/ cards or local rollouts
- `threads/`: per-session memory cards
- Raw rollouts are not copied; cards retain local read-only paths.
