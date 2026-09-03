# archive/ — 历史记忆归档

按年份归档：`archive/<年份>/`。存放从活跃入口沉降的旧记忆快照与轮转索引。

- `2026/account_memory-chat_index-slim.jsonl` — 第二账号 149 会话瘦身索引（仅元数据+首条消息摘录，原始 user_messages 数组已移除；完整数据见 git 历史及本机 rollout）。
- `2026/current_account_memory-chat_index-slim.jsonl` — 当前账号 135 会话瘦身索引快照。

规则：活跃路径 `*/chat_index.jsonl` 始终是瘦身版；跨年时把旧年份快照固化到此处。
