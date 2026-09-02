# 三个 AI 统一 Memory

这里保留 Codex 两个账号与 OpenCode 的独立归档，并通过本文件统一检索入口。

统一关联规则见 [`UNIFIED_MEMORY.md`](UNIFIED_MEMORY.md)：三个来源按同一用户的连续记忆联合使用，来源仍保留。

- [`account_memory/MEMORY.md`](account_memory/MEMORY.md)：Codex 第二账号，149 个已整理会话
- [`current_account_memory/MEMORY.md`](current_account_memory/MEMORY.md)：Codex 本机当前账号，会话卡片与索引
- [`opencode_memory/MEMORY.md`](opencode_memory/MEMORY.md)：OpenCode 共享记忆，包含用户画像、环境与项目上下文
- [`current_account_memory/chat_index.jsonl`](current_account_memory/chat_index.jsonl)：当前 Codex 账号机器可读索引
- [`current_account_memory/rollout_manifest.txt`](current_account_memory/rollout_manifest.txt)：本机全部原始 rollout 路径
- `sources/current-codex/` — memory produced by the current Codex account (mirrored from `~/.codex/memories/`, last synced 2026-09-02).
- `sources/claude-code/` — Claude Code global memory (`~/.claude/CLAUDE.md`), also loaded by OpenCode sessions.
- `sources/shared-unified/` — unified memory, linked account indexes, and global agent rules (`AGENTS.md`) already maintained on the workstation.
- `sources/opencode/` — OpenCode account memory.
- `sources/other-codex/` — memory from the other Codex account.
- `index/current-account-conversations.md` — an index of currently visible Codex tasks and ChatGPT conversations, without raw transcript content.

远端已维护的 `sources/` 与 `index/` 目录也保留，便于其他账号直接按英文入口读取。原始对话导出、认证文件、token、密码、cookies 和私钥均不纳入共享仓库；路径、主机名和操作结论使用前应重新验证。
