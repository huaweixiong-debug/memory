# Shared memory

This repository contains sanitized, reusable working memory shared by the user's Codex, ChatGPT, and OpenCode accounts.

## Sources

- `sources/current-codex/` — memory produced by the current Codex account.
- `sources/shared-unified/` — unified memory and linked account indexes already maintained on the workstation.
- `sources/opencode/` — OpenCode account memory.
- `sources/other-codex/` — memory from the other Codex account.
- `index/current-account-conversations.md` — an index of currently visible Codex tasks and ChatGPT conversations, without raw transcript content.

Raw conversation exports, session JSONL files, authentication files, environment files, tokens, passwords, cookies, and private keys are intentionally excluded.

Consumers should treat paths, hostnames, project details, and operational conclusions as context that may require revalidation before production use.
