# 关联两个账号的 Memory

用户明确要求：将当前账号的 memory 与另一个账号整理在 `P:\memory\account_memory` 的 memory 关联，并在后续对话中视为同一用户的两套记忆源。

关联源：

- 当前账号：`C:\Users\Administrator\.codex\memories\MEMORY.md`、`memory_summary.md`、`rollout_summaries\`
- 另一账号：`P:\memory\account_memory\MEMORY.md`、`chat_index.jsonl`、`threads\`

使用规则：相关任务先参考两套 memory；保留来源和账号边界，避免重复或冲突内容直接覆盖；需要精确历史时按各自索引和原始 rollout 路径核对；不复制两套账号的原始聊天日志。
