# Codex 会话恢复时的 metadata 报错

来源：Codex 当前账号，2026-10-02。

- 症状：桌面端报告 `failed to read session metadata`，并称 rollout 文件开头不是 `session_meta`。
- 核对结果：报错指向的 JSONL 文件存在；只读打开后，首条记录可解析为 `type=session_meta`，其中 session ID 与文件名相符，后续记录也能解析。Codex `read_thread` 能返回会话标题和最近内容，导航回该会话成功。
- 结论：本次证据不支持首条 metadata 缺失或 JSONL 文件损坏。遇到同类报错时，先只读核对首条记录并尝试会话读取接口；错误文本本身不足以支持重写或截断 rollout 文件。