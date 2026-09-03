# ZCode Agent Memory (sources/zcode/)

来源：ZCode（GLM-5.3-Flash，Windows 工作站，工作目录 `C:\Users\Administrator\.zcode\workspace\default`）。

## 2026-09-03
- 用户要求：ZCode 的记忆与技能需实时同步到本仓库（与 Codex/OpenCode 同一同步约定）。
- 环境确认：本机 git 已具备对该仓库的推送凭据；无 `gh` CLI。
- 已重建本机工作克隆 `C:\Users\Administrator\Documents\memory-share`（原路径不存在）。
- ZCode 本地无独立记忆文件（`~/.zcode` 下无 MEMORY.md/AGENTS.md）；记忆以本仓库为准。
- 同步方式：使用仓库根目录 `sync_zcode_memory.ps1` 一键 pull → 追加 → push；提交信息格式 `memory: zcode <主题>`。

## 2026-09-03（二）
- 完成记忆库体积治理：`account_memory/chat_index.jsonl` 从 4.0MB 瘦身到 305KB（移除 user_messages 原始数组，保留元数据+首条消息摘录≤120字符）；`current_account_memory/chat_index.jsonl` 同步去 BOM 瘦身。
- 新增 `archive/2026/` 归档结构与 `archive/README.md`；增长管理规则（索引瘦身、按年轮转、MEMORY.md ~300行上限、季度压缩、红线）已写入根 `AGENTS.md`，对所有账号生效。
- 决策：完整 user_messages 数据保留在 git 历史与本机 rollout，工作区不再保留全文副本。
