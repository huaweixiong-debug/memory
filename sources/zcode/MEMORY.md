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

## 2026-09-03（三）
- 按用户要求扫描 github.com/huaweixiong-debug 全部 20 个仓库，将仪器/设备/PLC 通讯类知识提炼为 8 个共享技能，置于仓库根 `skills/`（跨 agent 通用）：ATEQ 检漏仪 Modbus、S7-200 SMART snap7、同惠 TH9310/20 SCPI、奇力速螺丝刀 Modbus、扫码枪串口、BarTender 打印、LIN USB2XXX 加热、CAN PTC 加热。内容取自各仓库实际源码（ateq_modbus.py、th_scpi.py、snap7_plc.py、KILEWS_MODBUS_FIX_NOTE.md、serial_scanner.py、a050_protocol.py 等）。
- 关键现场参数：ATEQ COM3 9600/E/8/1 从站1（线圈 0x01 启动/0x00 复位，寄存器 0x30×13 实时状态）；TH 耐压 9600-8-N-1，FUNC:STAR/FETCh?；奇力速角度寄存器 0.1° 换算；扫码枪 9600-N-8-1 + 重复帧折叠。
- AGENTS.md 记忆文件清单已加入 skills/ 入口；skills/README.md 维护规则：内容必须现场验证过、标参考仓库、"读安全写危险"。

## 2026-09-20
- 修复 100.98.251.47（dell 账户，SSH/SMB 同一密码）SMB 共享资源管理器打不开的问题：根因是本机残留了以当前登录身份 `MS-VCFKEMTDOGYC\Administrator` 静默建立的 SMB 会话，Windows 因已有会话不弹凭据框，远端拒绝该身份访问共享。修复流程：`Get-SmbMapping` 过滤删除到该服务器的全部旧会话 → `cmdkey /add:100.98.251.47 /user:dell` 存凭据 → `net use` 重建连接，`e` 与 `240429箱体气密封` 共享均验证可列目录，且无显式凭据重连也成功（凭据管理器自动生效，重启后保持）。
- 踩坑记录：Git Bash 会把 UNC 路径的 `\\` 折叠成 `\`（net use 报 2250 找不到连接的假象），经 bash 传给 net/PowerShell 的 UNC 参数必须写成 `\\\\server\\share`；含 `$_` 的 PowerShell 命令行必须用单引号包裹。

## 2026-09-25
- 工作站硬件盘点（YOLO 训练加装显卡评估）：ASUS B760M-T R2.0（mATX，DDR5）+ i7-13790F（16C24T）+ RTX 4070 SUPER 12GB（驱动 591.86 / CUDA 13.1）+ 16GB DDR5-4800 单条单通道 + Acer N7000 1TB NVMe（M.2_2）。
- 结论：不能加装第二张训练卡——唯一 PCIe 4.0 x16 已被 4070 SUPER 占用，其余仅 2 条 x1（带宽/尺寸均不可用）；40 系无 NVLink。提升路线：①加一根 16GB DDR5 组双通道 32GB（优先）；②12GB VRAM 不够时换 16GB/24GB 单卡（换卡前查电源标签）；③真多卡需换平台或另配训练机/租云 GPU。
- 追加实测（同日）：①桌面常态内存 15.2/15.8GB（余 0.6GB），开训必进 swap，加内存条接近刚需。②**PATH 默认 python 是 CPU 版 torch（2.11.0+cpu）却装着 ultralytics——用它训 YOLO 会静默走 CPU**；正确环境为 `D:\miniconda3\envs\pytorch`（torch 2.4.1+cu121 + ultralytics 8.4.121，已验证识别 4070 SUPER）。mmdetection 环境 mmcv 1.7.2 与 mmdet 不兼容暂不可用；ultralytics-py311、mmdet-fresh 无 torch。
- OpenCode 桌面端项目"本地服务器"红色排查（18:0x 发现）：sidecar opencode server（127.0.0.1:51876）当日 18:02:07 崩溃，退出码 3221225477 = 0xC0000005 访问冲突，Electron 不自动重启，端口无监听而 UI 持续 SYN_SENT 重连， hence 项目里本地服务器显示红色。修复 = 重启 OpenCode 桌面端。日志定位：`~/AppData/Roaming/ai.opencode.desktop/logs/<会话目录>/utility.log`（sidecar exited）、`main.log`（spawning sidecar 端口）、服务端日志 `~/.local/share/opencode/log/opencode.log`；崩溃转储在 `Crashpad/reports/`（2026-09-04 还有两次 dmp，疑似复发性原生崩溃，复现时用 WinDbg/cdb 分析，本机暂无 cdb）。干扰项辨析：9/23 曾因 P: 网络盘不可达在 Server.listen 报 `lstat 'P:\'` 启动失败，但 P 盘（\100.117.1.6\projects）现已正常，与本次红色无关。

## 2026-09-25（二）
- ChatGPT 桌面客户端连不上排查结论：①绿联 NAS（lulian 100.82.136.106）的 Tailscale exit node 从未在本机启用（debug prefs 的 ExitNodeID 为空），且实测启用后出口=NAS 所在网络江苏电信家宽 180.109.26.176，直连 chatgpt.com 超时——exit node≠翻墙，NAS 不自己跑透明代理/TUN 就没用于访问被墙服务（测试后已关闭恢复原状）。②真正根因：NanmeiProxy 订阅全部 20 节点被 OpenAI 拦截（ios.chat.openai.com 403 "type":"dc" 数据中心 IP 封锁；香港×2=unsupported_country_region_territory；台湾×2 节点已死），推翻 9-21 "桌面客户端一般不受影响" 的旧结论。③待办：换有原生/家宽 IP 的机场节点，或让 NAS 自己跑翻墙后再用 exit node；南美套餐 2026-09-27 到期。
- 排查技巧：mihomo API `PUT /proxies/{组}` 切节点，Git Bash curl 传中文节点名会静默 400 "proxy not exist"，必须用 python urllib + `ensure_ascii=False`；切换后务必用 chatgpt.com/cdn-cgi/trace 的 loc 字段确认真切换了——节点挂名与实际出口常不符（德国/法国/菲律宾一实际都出口韩国 ICN）。

## 2026-09-25（三）
- 两套代理全节点体检：**西游云基本全灭**——本机 9-7 旧订阅 44 节点仅「马来西亚」活（38.47.189.86:21112，独立 IP，640ms，但也被 OpenAI 拦 403 dc），其余 35 个入口全部拒绝连接；主入口 bzd.11151115.xyz 整机下线（DoH 确认 52.68.82.112 为真实记录、非 DNS 污染），b.1181181.xyz:2096 / tw01.1100886.xyz:11027 / 36.141.116.50:37201 同死。套餐剩 120GB、2026-10-07 到期，**修复 = 去 www.xiyou.us 更新订阅**。**南美延迟全绿（20/20）但 ChatGPT 全军覆没**：dc 硬拦（美日韩新德法越马）+ 香港 unsupported_country + 台湾 cf-mitigated:challenge（桌面客户端过不了）。延迟榜：香港 145/台湾1 177/香港1 197/新加坡隧道 229/韩国1 349ms。
- 可复用测试方法：未运行的代理起临时实例（复制核心+配置+Country.mmdb，sed 改端口 17891/8766）；入口真伪用裸 TCP socket 测 + 1.1.1.1 DoH JSON 对比（区分机场挂了 vs DNS 污染）；`GET /proxies/{名}/delay` 并行测延迟不切组、不影响在线流量；OpenAI 判据 ios.chat.openai.com（403 JSON type=dc 硬拦 / 403 HTML cf-mitigated:challenge 软拦 / 200 放行）；urllib `[Errno 2]` 是 CONNECT 被断假象非节点死；Git Bash curl 切中文节点名必挂须 python urllib + ensure_ascii=False。

## 2026-09-25（四）勘误
- **勘误（三）中「南美全节点被 OpenAI 拦、ChatGPT 必挂」的结论**：用户实测 ChatGPT 桌面客户端正常。mihomo `/connections` 证实同一「越南1」节点上客户端 13 条活跃连接、MB 级收发；而 curl 测 `ios.chat.openai.com` 同时仍 403 `{"type":"dc"}`——**Cloudflare 拦的是 curl 的 TLS 指纹，不是应用**。规则固化：curl/urllib 的 OpenAI 端点响应（403 dc、cf challenge）不可作为「应用不可用」判据，唯一可信的硬封锁是香港式 `unsupported_country_region_territory`；判断 ChatGPT 真实可用性看 `/connections` 流量增长或重启应用实测。当天上午「连不上」为出口 IP 临时风控/应用状态问题，已自愈，与 9-21「间歇波动」记录一致。西游云入口全灭（待更新订阅）结论不变。
