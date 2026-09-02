thread_id: 01a047bd-2b8e-7d63-a781-446f518accc7
updated_at: 2026-08-28T11:34:35+00:00
rollout_path: C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T17-39-35-01a047bd-2b8e-7d63-a781-446f518accc7.jsonl
cwd: \\?\C:\Users\Administrator\Documents\Codex\2026-08-28\referenced-chatgpt-conversation-this-is-an-2

# 修复 OpenCode 中 Token API 的 GLM-5.3-Flash 配置与多模态显示

Rollout context: Windows OpenCode Desktop 连接 Ubuntu 远程 OpenCode 服务，目标是同时使用 OpenCode Go、智谱 Token API 和智谱 Coding Plan 的同名模型，并让 Token API 正确显示和支持多模态。

## Task 1: 定位并修复 Token API Provider

Outcome: success

Preference signals:

- 用户多次指出“Token API 的这个模型没法用”“现在都看不见 Token API 的这个模型了”，说明仅验证命令行模型列表不足，必须同时验证桌面端实际配置、远程服务配置和 UI 可见性。
- 用户明确说明“Token API 与 Coding Plan 的 key 是一样的”，后续配置应允许两者共用同一把 key，但必须依靠不同 Provider ID 和 baseURL 区分计费路由。

Key steps:

- Windows OpenCode 1.18.23 实际使用配置目录 `C:\Users\Administrator\.config\opencode`；`OPENCODE_DISABLE_PROJECT_CONFIG=1` 生效。
- 发现 `opencode.json` 与 `opencode.jsonc` 同时存在，且两者曾分别注册 `zhipuai` 和错误的 `zhipuai-token`，导致桌面端显示与命令行结果不一致。
- 最终 Windows 两份配置统一注册 `zhipuai-token`（Token API）和 `zhipuai-coding-plan`，并删除/避免错误冲突配置。
- Token API 使用 `https://open.bigmodel.cn/api/paas/v4`，Coding Plan 使用 `https://open.bigmodel.cn/api/coding/paas/v4`。
- 远程 Ubuntu 配置同步更新：`/home/huaweixiong/.config/opencode/opencode.jsonc`；凭据保存到 `/home/huaweixiong/.local/share/opencode/auth.json`。
- 远程服务运行于 `100.117.1.6:4096`，多次重启后保持监听；最终桌面版也被完全重启。

Failures and how to do differently:

- 最初使用自定义 `zhipuai-token` 时曾误认为原生 `zhipuai` 足以满足桌面显示；实际 UI 需要显式自定义 Provider 才显示 Token API 名称。
- 曾只更新远程服务，忽略 Windows 本机旧配置，导致用户桌面端“没区别”；类似问题必须同时检查本机配置、远程配置和桌面进程缓存。
- 曾为服务加载 `server.env` 后启用密码保护，导致桌面端无法连接；恢复为无认证监听后连接恢复。以后重启远程服务必须保持原有认证模式，除非同步更新客户端认证。
- 多次 Bash/Python heredoc 和 PowerShell 引号解析失败；应优先使用 Base64/标准输入传输脚本，并将每次脚本执行结果单独验证。
- Coding Plan 调用失败原因为智谱“5 小时使用上限已达”（HTTP 429），不是 Provider 或 key 配置错误；应区分路由成功、认证成功和套餐额度限制。

Reusable knowledge:

- OpenCode 自定义模型的完整能力元数据需要使用 `attachment`、`reasoning`、`tool_call`、`interleaved`、`limit` 和 `modalities` 等字段；仅写 `name` 和 baseURL 会被 UI 默认显示为仅文本或能力为 0。
- 最终 Token API 模型元数据：输入 `text,image,video,pdf`，输出 `text`；上下文 `1000000`，输出上限 `131072`，支持 reasoning、tool call、attachment，`interleaved.field=reasoning_content`。
- 三个最终模型标识：`opencode-go/glm-5.3-flash`、`zhipuai-token/glm-5.3-flash`、`zhipuai-coding-plan/glm-5.3-flash`。
- Windows 本机对 `zhipuai-token/glm-5.3-flash` 的最小调用返回 `OK`；带 PNG 图片的真实调用返回 `IMAGE_OK`，证明图片确实传入模型而非仅修改 UI 标签。
- 远程 Provider 清单最终确认三条模型均 connected/present，Token API 的能力为图片、视频、PDF 输入支持，且远程服务监听正常。

References:

- Windows 配置：`C:\Users\Administrator\.config\opencode\opencode.json`
- Windows 配置：`C:\Users\Administrator\.config\opencode\opencode.jsonc`
- Ubuntu 配置：`/home/huaweixiong/.config/opencode/opencode.jsonc`
- Ubuntu 凭据：`/home/huaweixiong/.local/share/opencode/auth.json`
- Ubuntu 服务：`/home/huaweixiong/.opencode/bin/opencode serve --hostname 100.117.1.6 --port 4096`
- 关键验证：`opencode models zhipuai-token`、`opencode run --pure --model zhipuai-token/glm-5.3-flash --format json ...`
- 关键结果：`response_contains=OK`、`response=IMAGE_OK`、`http_status=200`。
- 备份示例：`opencode.jsonc.bak-20260828-111638`、`auth.json.bak-20260828-105811`。
