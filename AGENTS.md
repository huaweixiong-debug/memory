# AGENTS.md — 共享记忆库

<INSTRUCTIONS>

本目录是 Codex 与 OpenCode 的共享记忆库。当你在这个目录或相关项目中工作时，必须联合参考以下记忆文件：

1. `UNIFIED_MEMORY.md` — 统一记忆规则
2. `opencode_memory/MEMORY.md` — OpenCode 共享记忆
3. `account_memory/MEMORY.md` — Codex 第二账号记忆
4. `current_account_memory/MEMORY.md` — Codex 当前账号记忆
5. `skills/` — 跨账号设备/仪器技能库（ATEQ 检漏仪、S7-200 SMART PLC、SCPI 耐压仪、奇力速螺丝刀、扫码枪、BarTender 打印、LIN/CAN 总线）；涉及对应设备通讯时先读 `skills/README.md` 索引与对应 SKILL.md

把以上来源视为同一用户的连续记忆。需要追溯时保留来源标记，冲突时以最新最具体的记录为准。敏感信息已脱敏，完整上下文以原始 rollout 为准。

## 持续同步规则

每次对话结束或形成阶段性结论时，将具有长期价值的决策、环境变化、项目状态、用户偏好和待办更新到对应记忆文件，并同步到 GitHub 共享仓库。无长期价值的闲聊不必记录；绝不写入密码、token、cookies、私钥或其他敏感凭据。

## 体积与增长管理规则（2026-09-03 起）

本库是纯文本 git 仓库，容量本身不设限；管理目标是**上下文可加载性**与**检索效率**，不是磁盘。

1. **索引瘦身**：`*/chat_index.jsonl` 只保留元数据（id、title、topic、时间戳、message_count、source_rollout 路径）和至多一条首条消息摘录（≤120 字符）。禁止写入 `user_messages` 等原始消息数组——完整内容以本机 rollout 为准。
2. **按年轮转**：每年年初把上一年的索引快照固化到 `archive/<年份>/`，活跃 jsonl 只保留当年条目。归档结构见 `archive/README.md`。
3. **入口文件上限**：各来源 `MEMORY.md` 建议不超过 ~300 行。超出时把已完结、过时的条目沉降到 `archive/<年份>/`，入口只保留：用户画像、环境配置、进行中项目、活跃待办与长期偏好。
4. **沉降时机**：日常会话顺手沉降明显过时的条目；每季度由一次专门会话做集中压缩（合并重复、按主题重组索引）。
5. **红线**：原始 rollout/对话导出、认证文件、凭据永不入库；大文件迁移只靠 git mv + 提交，历史由 git 保留，不在工作区重复存放全文副本。

</INSTRUCTIONS>
