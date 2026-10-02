# Codex 会话恢复时的 metadata 报错

来源：Codex 当前账号，2026-10-02。

- 症状：桌面端报告 `failed to read session metadata`，并称 rollout 文件开头不是 `session_meta`。
- 核对结果：报错指向的 JSONL 文件存在；只读打开后，首条记录可解析为 `type=session_meta`，其中 session ID 与文件名相符，后续记录也能解析。Codex `read_thread` 能返回会话标题和最近内容，导航回该会话成功。
- 初步结论：本次证据不支持首条 metadata 缺失或 JSONL 文件损坏。遇到同类报错时，先只读核对首条记录并尝试会话读取接口；错误文本本身不足以支持重写或截断 rollout 文件。

## 复查

- 原始文件首字节为 `7B 22`（`{"`），当前文件没有 UTF-8 BOM；OpenAI issue #28139 描述的同文案 BOM 情形不符合本次文件的当前状态。
- 桌面日志记录旧会话在 2026-10-02 01:14 UTC 的 `thread/resume` 失败；文件当前修改时间晚于该日志，因此当前字节不能证明失败当时的文件内容。另一个当日会话也记录过相同错误，其当前文件同样以 `7B 22` 开始。
- `read_thread` 可读取旧会话，但状态为 `waitingOnApproval`；导航接口返回成功不等于桌面端历史恢复已成功。未改写原始 rollout，根因仍未确认。