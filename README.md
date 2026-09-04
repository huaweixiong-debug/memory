# 三个 AI 统一 Memory

这里保留 Codex 两个账号与 OpenCode 的独立归档，并通过本文件统一检索入口。

统一关联规则见 [`UNIFIED_MEMORY.md`](UNIFIED_MEMORY.md)：三个来源按同一用户的连续记忆联合使用，来源仍保留。

三方 Agent（Codex / ZCode / OpenCode）的统一模型路由与升级规则见 [`sources/shared-unified/MODEL_ROUTING.md`](sources/shared-unified/MODEL_ROUTING.md)。

- [`account_memory/MEMORY.md`](account_memory/MEMORY.md)：Codex 第二账号，149 个已整理会话
- [`current_account_memory/MEMORY.md`](current_account_memory/MEMORY.md)：Codex 本机当前账号，会话卡片与索引
- [`opencode_memory/MEMORY.md`](opencode_memory/MEMORY.md)：OpenCode 共享记忆，包含用户画像、环境与项目上下文
- [`skills/`](skills/)：跨机器复用的部署/设备技能库（如 [`skills/chatgpt-proxy-guard/`](skills/chatgpt-proxy-guard/SKILL.md)：ChatGPT 代理节点自动切换守护）
- [`current_account_memory/chat_index.jsonl`](current_account_memory/chat_index.jsonl)：当前 Codex 账号机器可读索引
- [`current_account_memory/rollout_manifest.txt`](current_account_memory/rollout_manifest.txt)：本机全部原始 rollout 路径
- `sources/current-codex/` — memory produced by the current Codex account (mirrored from `~/.codex/memories/`, last synced 2026-09-02).
- `sources/claude-code/` — Claude Code global memory (`~/.claude/CLAUDE.md`), also loaded by OpenCode sessions.
- `sources/shared-unified/` — unified memory, linked account indexes, and global agent rules (`AGENTS.md`) already maintained on the workstation.
- `sources/opencode/` — OpenCode account memory.
- `sources/other-codex/` — memory from the other Codex account.
- `index/current-account-conversations.md` — an index of currently visible Codex tasks and ChatGPT conversations, without raw transcript content.

远端已维护的 `sources/` 与 `index/` 目录也保留，便于其他账号直接按英文入口读取。原始对话导出、认证文件、token、密码、cookies 和私钥均不纳入共享仓库；路径、主机名和操作结论使用前应重新验证。

## 更新规则（所有 AI 账号必须遵守）

自 2026-09-02 起，用户要求：**每次对话（Codex / ChatGPT / OpenCode / Claude Code）产生稳定结论、决策、用户偏好或完成有价值工作时，都必须更新本仓库的共享 memory 并 push**。

流程：

1. 本机工作克隆位于 `C:\Users\Administrator\Documents\memory-share`；会话开始可 `git pull`，结束时先 `git pull --rebase` 再提交，避免与其他账号冲突。
2. 追加内容到对应来源文件（Codex 当前账号 → `sources/current-codex/`，OpenCode → `sources/opencode/`，Claude Code → `sources/claude-code/`，跨账号通用结论 → `sources/shared-unified/UNIFIED_MEMORY.md`），保留来源标记和日期。
3. 只写稳定结论、决策和待办，不复制完整聊天日志；不写入密码、token、API key 等敏感凭据。
4. 提交信息格式：`memory: <账号> <一句话主题>`。
5. 冲突时以最新、最具体且有明确来源的记录为准；需要精确历史时按各来源索引核对。
