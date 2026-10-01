# 2026-10-01 Codex rollout restore and Langguo Agent Factory

- The requested Codex conversation `01a0dc5b-a613-7a30-9675-6be7a44f5ddd` cannot be read when its rollout JSONL is missing: Codex history lookup returns `missing source rollout`.
- Checked the reported path under the default `.codex` home, the configured `.codex-langguo-factory` home, the recycle bin, and local Codex documents; no copy of that rollout was present.
- Langguo Agent Factory's Codex runner sets an isolated `CODEX_HOME` and launches a fresh `codex exec`; it does not implement Desktop conversation restoration. Changing that setting cannot recreate a deleted rollout, and mixing the factory home with the Desktop home would change the intended isolation without recovering this history.
- Recovery of this specific conversation requires a backup of the original JSONL. Continue new work in a new conversation when no backup exists.
