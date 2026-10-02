# Codex 与 ChatGPT 无需逐项确认设置

- 日期：2026-10-02
- 来源：Codex 当前账号，用户明确要求
- Codex 本机默认策略设为 `approval_policy = "never"` 与 `sandbox_mode = "danger-full-access"`，因此 shell 命令和本地文件访问无需逐项审批；Windows 原生沙盒仍为 `elevated`。重启 Codex 后读取新默认值。
- ChatGPT 的 GitHub、Gmail、Google Calendar、Google Contacts、Google Drive 已分别设为应用级 `full_access`。全局 `full_access` 不可用；全局默认仍为“允许低风险操作”。
- 边界：ChatGPT 的其他连接应用、Windows 系统提示及组织管理限制未由这些设置覆盖。
