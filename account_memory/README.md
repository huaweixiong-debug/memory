# 账号聊天记录 Memory

这是从本机 Codex 会话状态库整理出的可检索 memory 目录。

- `MEMORY.md`：按主题聚合的主入口，并包含已有长期记忆快照。
- `chat_index.jsonl`：一行一个会话的机器可读索引（瘦身格式，2026-09-03 起）：`id/title/topic/created_at/updated_at/cwd/archived/source_rollout/source_exists/message_count/user_message_count/first_user_message(≤120字符)`；不写入原始消息数组，完整内容见 threads 卡片或本机 rollout。
- `threads/<会话ID>.md`：每个会话的用户请求和助手结果摘录。
- 原始 rollout：卡片内给出本机只读路径；本目录没有复制原始日志。

敏感凭据在摘要中已脱敏。由于会话原文包含系统提示、工具输出和附件上下文，完整聊天仍以原始 rollout 为准。