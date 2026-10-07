# Google Antigravity 登录资格排查

- 日期：2026-10-07（Codex 当前账号）
- Windows 上 Antigravity 2.21.0 的 `antigravity://` 用户级 URL scheme 已注册并指向已安装程序；触发 `antigravity://oauth-success/` 后，应用日志记录了 deep link 启动，证明 scheme 能交给应用处理。
- 登录失败页明确显示当前 Google 账号因当前所在地不可用而不具备 Antigravity 使用资格。该资格检查是本次登录受阻的直接证据；此前语言服务端反复报“未登录”是结果，没有发现 BigInt、连接超时或 token exchange 错误。
- `127.0.0.1:17890` 当前可连接；通过本机与 Tailscale 地址代理访问两个 Google API 基础域名均获得 HTTP 404 响应（TLS/HTTP 可达，不代表 OAuth 请求成功）。已重启应用并显式给进程设置本机代理环境变量，未卸载或改动账号/应用数据。
- Google 官方 Antigravity FAQ 表示只对批准地理区域中的个人 Google 账号开放；Workspace 账号可尝试个人 Gmail 账号。若 Google 账号的条款国家/地区记录错误，FAQ 建议通过 Google 正式渠道申请更正。不要把回调注册或重装当作当前资格错误的修复。
