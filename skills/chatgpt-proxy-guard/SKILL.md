---
name: chatgpt-proxy-guard
description: 在装有"南美"Clash 客户端的 Windows 机器上部署 ChatGPT 可用性守护：节点失效/被 ChatGPT 屏蔽(403)时自动切换到下一个能访问 chatgpt.com 的节点，永不放弃、无总超时。当用户提到"另一台电脑要配代理守护"、"ChatGPT 又连不上自动切节点"、"部署 chatgpt-proxy-guard skill"时使用。
---

# ChatGPT Proxy Guard（ChatGPT 代理可用性守护）

监控本机 Clash/mihomo（"南美"客户端）代理，当当前节点无法访问 ChatGPT 时，自动逐个切换节点直到找到能访问 chatgpt.com 的节点为止；所有节点都失败时无限重试（按需求不设总超时）。

## 文件

| 文件 | 用途 |
|------|------|
| `guard.ps1` | 守护脚本（可移植：自动从配置探测 mixed-port / external-controller / 出口分组） |
| `install.ps1` | 新机器一键安装：装文件 → 探测核心 → 修复 chatgpt 分流规则 → 写自启 → 启动守护 |

## 前置条件

1. Windows，已安装"南美"客户端并用**同一个账号**登录（订阅地址/token 只存在客户端里，**不要**写进本 skill 或记忆库）。
2. 客户端核心在运行（本skill默认其 external-controller 可访问、无 secret；本机实测为 `127.0.0.1:8765` + mixed-port `17890`，新机器以自动探测为准）。
3. PowerShell 5.1+（系统自带）。

## 安装（新机器）

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File install.ps1
```

安装器会自动完成：

1. 从 `%APPDATA%\南美\config.yaml`（兜底搜索 Program Files 下客户端目录）探测端口与分组；
2. 校验核心 API 可达；
3. 经代理口实测 `https://chatgpt.com/robots.txt`：
   - 若节点延迟测试能通但代理口不通 → 说明分流有问题（chatgpt.com 落入 GEOIP+DNS 污染），自动在 `rules:` 顶部注入 `chatgpt.com/openai.com/oaistatic.com/oaiusercontent.com` 域名规则并 `PUT /configs?force=true` 重载核心；
   - 若所有节点都连不上 chatgpt → 提示更新订阅（机场订阅挂了神仙也救不了）；
4. 复制 `guard.ps1` 到 `%USERPROFILE%\Tools\ChatGptProxyGuard\`；
5. 写启动文件夹 VBS（UTF-16LE，兼容中文用户名）实现登录自启；若 shell 已提权则额外注册计划任务（崩溃自动拉起）；
6. 立即启动守护并回显日志尾部。

## 守护逻辑（guard.ps1）

- 每 60s 经代理实测 chatgpt.com/robots.txt，**仅 HTTP 200 算可用**（403 = 出口 IP 被 ChatGPT 屏蔽，也算失效）；
- 连续 2 次失败 → 按节点延迟历史排序逐个切换分组节点实测，找到 200 为止；
- 全部失败 → 30s 后重新循环，**永不放弃**（单次请求 10s 网络超时仅用于判定，不是放弃机制）；
- 互斥锁防多开；日志在 `Tools\ChatGptProxyGuard\logs\guard.log`（UTF-8，5MB 轮转）。

## 手动运维

```powershell
# 看当前节点与状态
Get-Content "$env:USERPROFILE\Tools\ChatGptProxyGuard\logs\guard.log" -Tail 20 -Encoding UTF8

# 立即实测一轮切换
powershell -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\Tools\ChatGptProxyGuard\guard.ps1" -RunOnce

# 停止守护
Get-CimInstance Win32_Process -Filter "Name='powershell.exe'" |
  Where-Object { $_.CommandLine -match 'guard\.ps1' } |
  ForEach-Object { Stop-Process -Id $_.ProcessId }
```

## 已踩过的坑（都是实测教训，勿重蹈）

1. **PS 5.1 `Invoke-RestMethod` 会把 Clash API 响应按 Latin-1 解码**（mihomo 响应头无 charset），中文节点名全部变乱码，切节点 PUT 全部 400。必须用 `WebClient` + 显式 UTF-8 编解码。
2. **无 BOM 的 UTF-8 .ps1 含中文会被 PS5.1 按 GBK 误读**：脚本文件必须转成带 BOM 的 UTF-8（`install.ps1` 用 `[char]0x5357+[char]0x7F8E` 构造"南美"路径绕开此问题）。
3. **核心不会自动加载新配置**：改了 config.yaml 后必须 `PUT /configs?force=true` 重载，否则跑的还是核心启动那天的旧规则（本机曾因此 chatgpt.com 整体走不到节点）。
4. **节点名里混着信息节点**（"剩余流量：xx GB"等），切换时要按正则过滤，否则会切到假节点上。
5. **机场 IP 被 ChatGPT 风控是常态且会漂移**（香港 403、新加坡过会也 403），所以判定标准必须是"实时 200"，不能看节点是否"能用"。
6. 客户端更新订阅会**覆盖 config.yaml**，注入的域名规则和 dns-hijack 修复可能被冲掉；ChatGPT 若整体不通（所有节点都不通但延迟测试通），先重跑 install.ps1。

## 安全注意

- 订阅 URL / token / 节点凭据只存在于"南美"客户端内，**严禁**写入本 skill、日志或 P:\memory。
- 守护脚本无密钥、无敏感信息，仅调用本机 Clash API。
