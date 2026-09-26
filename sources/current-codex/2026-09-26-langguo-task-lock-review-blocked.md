# Langguo Agent Factory task-lock implementation review

日期：2026-09-26
来源：Codex 当前账号

- 按优先级开始了 Orchestrator task-scoped lock；代码路由使用 OpenCode executor，单一目标文件为 `P:\Langguo_AI\runtime\orchestrator\langguo-orchestrator.py`，未启动真实工厂或触碰 TASK-0003 状态。
- 第一轮实现曾将不同 OSError 都记录为 TASK_LOCKED，并用斜线替换形成可碰撞文件名；Terra FIX 后改为 task ID 的 SHA-256 前缀、区分 setup 错误和 winerror 33，并加入目录创建失败处理。
- 返修聚合测试称 9 项通过，但真实 Windows 多进程竞争日志显示 `[Errno 13] Permission denied` 被记录为 `TASK_LOCK_ERROR`，没有命中代码当前的 `winerror == 33` 分支；竞争日志分类仍未验证为正确，不能接受为完成。
- Terra 第二轮返回 BLOCKED：新 REVIEW_PACKET 只引用外部 `complete.cumulative.diff`，没有内嵌累计 diff，因其只读无工具审查规则而不能验证实现与原路由保持情况。该代码变更尚未做最终验收，现场保留在本机 OpenCode executor run 目录。
- OpenCode executor 执行器默认模型为 `opencode-go/mimo-v2.5` / `none`；Windows OpenCode CLI 的 `--file` 数组选项会吞掉后续 prompt，且通过 CMD shim 从 NAS UNC cwd 启动失败。本轮临时参数适配器解决了启动问题，但不是项目配置变更。
