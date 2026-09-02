# Windows Codex — 共享记忆指令

## 会话开始

如果共享盘 `P:\memory` 可访问，先读取以下文件：

1. `P:\memory\UNIFIED_MEMORY.md`
2. `P:\memory\opencode_memory\MEMORY.md`
3. `P:\memory\account_memory\MEMORY.md`（Codex 第二账号）
4. `P:\memory\current_account_memory\MEMORY.md`（本机当前账号）

将 OpenCode、Codex 当前账号和 Codex 第二账号视为同一用户的连续记忆，但保留来源标记和账号边界。内容冲突时，以最新、最具体且有明确来源的记录为准；需要精确历史时，再按对应索引和原始会话路径核对。

## 会话结束

只有用户明确要求保存记忆，或当前任务明确包含记忆更新时，才把稳定结论、用户偏好和待办写入对应共享 memory；不要复制完整聊天日志，不要写入密码、令牌或其他敏感凭据。

## 默认代码执行路由

对代码修改需求，默认使用用户级 `$opencode-executor`：当前 Codex（通常为 GPT-5.6 Sol）只负责首次详细规划和一次最终验收，OpenCode（默认 `opencode-go/mimo-v2.5`/`none`）负责实际编辑并生成 `REVIEW_PACKET.md`；简单任务由临时只读 GPT-5.6 Luna/high 中间审核，复杂任务由 GPT-5.6 Terra/high 中间审核；最多由同一 OpenCode session 返工一次。用户明确说“Codex 直接执行”时才绕过该路由；不要启动 AutoFlow 页面或让 Sol 反复扫描整个项目。

## GitHub 共享 Memory 更新规则（2026-09-02 起强制）

- 共享 memory 仓库：https://github.com/huaweixiong-debug/memory，本机工作克隆：`C:\Users\Administrator\Documents\memory-share`
- **YOU MUST** 每次对话产生稳定结论、决策、用户偏好或完成有价值工作时，更新该仓库并 push：会话开始 `git pull`，结束前 `git pull --rebase` 再 commit + push
- 写入位置：Codex 当前账号 → `sources/current-codex/`；跨账号通用结论 → `sources/shared-unified/UNIFIED_MEMORY.md`；保留来源标记和日期
- 只写稳定结论和待办，不复制聊天日志，不写入密码 / token / API key
- 提交信息格式：`memory: <账号> <一句话主题>`
