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

## 2026-09-25（五）YOLO 实际训练配置盘点
- 实际训练项目在 `D:\ultralytics-main`（脚本 `Yolo train GPU.py`），数据集 `D:\Hengchuang00601.v47i.yolo26`（715 张 train 图，Roboflow 导出），跑在 conda `pytorch` 环境（用户确认训练确实走 GPU）。实际参数：yolo26s @ imgsz=1024、batch=16、**workers=0**、multi_scale=True、mosaic=1.0、amp=True，100 epochs 已完整跑过（输出 `D:\Hengchuang00601.v47i.yolo26_v2`）。
- 关键判断：**workers=0 使数据准备与 GPU 计算完全串行**（1024px+mosaic+multi_scale 的 CPU 管线很重，GPU 大概率在批间挨饿），是当前训练速度最大疑似瓶颈；设 0 的原因几乎肯定是 16GB 内存开不了 worker（桌面仅余 0.6GB，且有 `Yolo train GPU - test mem.py`（768+batch8）调内存的痕迹）。加内存条到 32GB 的核心收益 = 有资格把 workers 提到 4~8，预估 epoch 时间降至 1/2~1/3，待 A/B 实测验证（方法：同参数跑 2-3 epoch 对比 workers=0 vs 2~4，看 nvidia-smi GPU-Util 锯齿变化）。
- 按用户要求关闭 OpenCode 的权限询问（2026-09-25）：`~/.config/opencode/opencode.json` 与 `opencode.jsonc`（两份并存，避免不确定哪份生效）均加入全局 `permission` 块，read/edit/glob/grep/list/bash/task/external_directory/lsp/skill/webfetch/websearch 全部 allow；`agents/engineer.md` 与 `agents/reviewer.md` frontmatter 中原 ask 项（git push、rm、del、format、diskpart 及 reviewer 的 bash "*"）改为 allow。reviewer 保持 edit/task/webfetch deny（deny 是静默拒绝不弹窗）。配置生效需重启桌面端 sidecar；改后 `opencode models` 验证加载正常。schema 来源 opencode.ai/config.json：PermissionRuleConfig 支持 action 字符串或模式映射，仅 todowrite/question/webfetch/websearch/doom_loop 只收字符串。

## 2026-09-26
- 南美代理掉线事件：Pluto 所选「韩国」（及此前「越南1」）节点死掉、流量 0KB/s，批量测 25 节点死 18（仅新加坡隧道 361ms / 香港1 / 香港活）——疑似到期（9-27）前机场批量撤线。已切「新加坡隧道」恢复（出口 SIN）。后续若继续成片掉线即为撤线征兆，直接换机场/更新西游云订阅，别逐个排查节点。

## 2026-09-26（二）
- 西游云复活：入口 bzd.11151115.xyz 换 IP（52.68.82.112→54.250.110.88 AWS 东京）后 34/44 节点延迟健康（日本 67ms、新加坡 120ms、美国 227ms），旧 9-7 配置无需更新订阅即能用。**但 ip-api 实锤所有节点共用同一出口 IP 141.147.185.43（Oracle 云日本）**——"台湾家宽/美国AI通用/香港"等全是挂名假标签，带宽 ~115KB/s 偏慢，chatgpt.com 该出口 403 challenge。定位：日常翻墙可用（备用），ChatGPT 无节点多样性可言；南美（用户已续费）仍为主力。
- 排查技巧升级：判断机场"单一落地池"= GLOBAL 逐节点 PUT 后出口不变；测真实出口用 ip-api.com/json（cf-trace 的 loc 对云厂商 IP geo 常误标，本次 Oracle 日本 IP 被 CF 标为 SG）。

## 2026-09-26（三）
- 南美 vs 西游云 ChatGPT 访问 A/B（用户要求快的用哪个）：西游云 TTFB 快 2.7 倍（trace 156ms vs 430ms，应用流量也能过），但 1MB 下载 3 次断流 2 次（IncompleteRead 中途断）；南美 3/3 稳定、同量级带宽（0.33-0.37MB/s）。ChatGPT 是 SSE 流式输出，稳定>单次延迟 → **判南美赢，保持系统代理 17890 不变**。西游云定位：TTFB 快但单落地 Oracle IP 断流+可用性风险，仅作备用。A/B 方法：临时实例 17891 + 系统代理切换后看 /connections 应用流量 + 双方各复测带宽 2 次。

## 2026-09-26（四）
- **NAS 网关链路修复（手机走 exit node 的目标打通）**：绿联 NAS（lulian 100.82.136.106）上本就跑着 mihomo v1.19.30（TUN+auto-route，双订阅：南美+西游云 72 节点，控制 API 100.82.136.106:9090 **无 secret**、tailnet 内可直访，SSH 22 开但本机公钥未授权 root）。exit node 客户端流量裸奔的根因 = tun.auto-redirect 未开（TUN 只抓 NAS 自身流量，不抓转发流量）。已运行时 PATCH /configs {"tun":{...,"auto-redirect":true}} 热修复，端到端验证：PC 开 exit node 后绕开本地代理直连，出口=日本 161.248.63.7（NAS mihomo 选中链路的真实出口），chatgpt.com trace 200，NAS 连接表可见 51 条来自 PC tailscale IP 的被代理连接。
- **未持久化警告**：PATCH 仅运行时生效，NAS 重启/mihomo 重启后 auto-redirect 回落 false，需改配置文件（SSH 需用户授权）在 tun 块加 "auto-redirect": true。
- 手机侧用法：iOS Tailscale → Exit Node 选 lulian 即可，无需其他 app；注意手机流量将全量经家里宽带+NAS mihomo（中国应用 GEOIP 直连不受影响），NAS 离线时手机会断外网。

## 2026-09-27
- **NAS auto-redirect 已持久化**：SSH 登录绿联 NAS（18913391330@100.82.136.106，DXP4800 PLUS/UGOS，本机公钥已装入其 authorized_keys 可免密；密码不入库）。mihomo 是 Docker 容器（host 网络），配置 /volume1/docker/mihomo/config.yaml（bind 挂载），已在 tun 块加 "auto-redirect: true"（备份 config.yaml.bak-20260926）并 docker restart 验证重启后仍生效；tailnet 其他设备（100.100.83.52/100.67.124.5）流量已被网关正常分流（国外走南美·越南1、国内直连）。
- NAS 上还有既有的 mihomo-openai-failover.sh（crontab 每 2 分钟探测 chatgpt.com 自动切 "OpenAI" 组、每日 03:00 复位；纯 API 操作不碰配置文件，与本次修改无冲突；当前配置里无 OpenAI 组，脚本疑似休眠）。目录有大量 9-25/26 的配置实验备份（bak-before-no-autoredirect 等）说明 auto-redirect 之前是被人为去掉的。
- **手机用法最终态**：iOS Tailscale → Exit Node 选 lulian 即可上 ChatGPT；NAS 离线则手机断外网。

## 2026-09-27（二）
- **NAS ChatGPT 自动切换已修活**：mihomo-openai-failover.sh 失效根因 = 配置里无 OpenAI 组。已加 OpenAI select 组（美国2 主力 + 67 个真实节点为候选池）+ 既有 5 条 chatgpt/openai 分流规则（chatgpt.com/openai.com/oaistatic.com/oaiusercontent.com/chatgpt.livekit.cloud，原指向南美）改指向 OpenAI 组；脚本 test_url 从 chatgpt.com/（curl 指纹 403 误报）改为 chatgpt.com/cdn-cgi/trace（稳定 200）。切换逻辑本就符合"候选不指定+切换前实测"：失败计 2 次 → 遍历候选组员逐个 mihomo delay API 实测 trace → 首个通过者才切；每日 03:00 复位回美国2。
- 演练验证：MIHOMO_FAILOVER_FORCE_CURRENT_FAILURE=1 强制故障 → 日志 "automatic failover: 美国2 -> 乌克兰"（切换前实测乌克兰 trace 通过）；reset 复位回美国2 正常；非强制 monitor 探测通过。
- **坑**：NAS mihomo config.yaml 的 proxy-groups 是顶格 `- name:`（0 缩进），插组时用 1 空格缩进导致 YAML 解析炸、容器 crash loop（fatal: did not find expected key line 1040），回滚备份后用 0 缩进重做成功。NAS 家目录和 /tmp 对 SSH 用户不可写，传文件用 `ssh "cat > /volume1/docker/mihomo/xx" < local`。

## 2026-09-27（三）
- OpenAI 候选池精简：用 /group/OpenAI/delay?url=chatgpt.com/cdn-cgi/trace 一次性批量实测 67 成员，51 个 ChatGPT 可达，剔 5 个香港（unsupported_country）+ 16 个死节点（西游云全部"直连"系列/美国1｜AI通用/美国2｜高速/美国｜高速/伊拉克/哈萨克斯坦/意大利/菲律宾/阿塞拜疆/马来西亚）后重建组为 46 成员（美国2 主力在前、按 trace 延迟升序：俄罗斯 374ms 最快，南美-马来西亚 393ms、台湾 543ms 次之）。重建后 monitor 巡检通过。备份 config.yaml.bak-openai-v3-20260927。
- 附注：NAS mihomo 配置里同名单纯名（台湾/日本/德国等）= 南美原节点，"｜高速"等后缀名 = 西游云；延迟均为 NAS→节点→chatgpt trace 实测值。

## 2026-09-27（四）
- failover 脚本升级 v2（用户要求"故障时切最快的"）：切换逻辑从"按组内清单顺序切首个通过者"改为 `probe_group_ranked`——一次调用 `GET /group/OpenAI/delay?url=trace` 并发实测全部成员、按延迟升序、`jq map(select(.key != $old)) | first` 取最快者切换，日志格式 "automatic failover: A -> B (xxx ms, fastest of N verified)"。演练实证：强制故障后 42/46 存活、切俄罗斯 372ms（当次最快），reset 回美国2、monitor 通过。旧脚本备份 mihomo-openai-failover.sh.bak-v1。坑：sh 里 `${var%%<TAB>*}` 靠 jq 两段取值替代分隔符解析（节点名含 ASCII 竖线如 新加坡3|高速）。

## 2026-09-27（五）
- **"国内网站走了代理"修复（vipmro.com 案例）**：根因链 = ①本机 Nanmei clash v1.18.9 的 geoip.metadb 文件坏（GEOIP 查询全失败）；②换好库后仍漏——**fake-ip 模式下 HTTP 代理路径的 GEOIP 判定拿到的是 fake-ip（destIP=198.18.x）**，所有无专属域名规则的国内 .com 站（vipmro/jd 无规则时）全落 MATCH 走代理；③redir-host 已被 mihomo 移除（改了会静默回退 fake-ip），升级核心 v1.18.9→v1.19.30 也没用。**最终修复 = dns 块加 `respect-rules: true` + `proxy-server-nameserver`**（NAS 网关配置一直有所以 NAS 路径从来没这问题），GEOIP 判定改用真实解析。验证：vipmro→GeoIP DIRECT(183.134.18.40)，jd DIRECT，chatgpt→新加坡隧道，Pluto 恢复新加坡隧道。
- 附带变更：本机核心升级 v1.18.9→v1.19.30（clash.exe.bak-v1.18.9 留档），geoip.metadb 换为 NAS 容器同款（8.6MB），config 备份 config.yaml.bak-fakeip-20260927。诊断技巧：`curl -x 代理 https://IP/ -k` 纯 IP 连接可分离"GEOIP 库坏"vs"DNS 假 IP"两种故障；/dns/query 的应答受 respect-rules 影响。

## 2026-09-27（六）
- **ZCode 桌面版反复弹图片拖拽验证的根因与修复**：ZCode 的 API 走 open.bigmodel.cn（智谱），该域名 DNS 解析到阿里云日本 IP（47.245.63.126/47.74.41.78），GEOIP,CN 判不了 → 落 MATCH 走代理 → 智谱风控见境外机房 IP 强制人机验证。修复：Nanmei config rules: 顶部加 `DOMAIN-SUFFIX,bigmodel.cn/zhipuai.cn/chatglm.cn,DIRECT`（智谱全家直连）。验证：bigmodel→DIRECT、vipmro→GeoIP DIRECT（respect-rules 生效）、chatgpt→新加坡隧道。
- **YAML 坑（重要）**：Nanmei config.yaml 的 rules 块是 2 空格缩进 `  - DOMAIN,...`；插零缩进规则时，YAML 会把后续缩进行当"纯量续行"折叠进上一条规则，clash 报 "proxy [xxx - yyy] not found" 且整个 rules 被并成一行假象。插规则必须复制现有行的缩进。改坏时用 config.yaml.bak-fakeip-20260927 恢复后重插。

## 2026-09-27（七）
- **ZCode 验证码"手动拖对也失败"的根因**：验证码是第三方 geetest.com（api/captcha/static.geetest.com），不在智谱直连规则里 → 验证码组件走代理（境外 IP）加载/校验、主 API 走直连（家宽 IP）→ **两端 IP 不一致，服务端绑定校验必失败**，与拖拽是否正确无关。修复：rules 顶部再加 geetest.com/geetestcdn.com/zcode.ai/doubao.com 四条 DIRECT（现共 7 条国内服务直连规则在最顶部）。ZCode 实际域名清单（从 .zcode/AppData 提取）：api.zcode.ai、sso/open/dev/nopen/captcha.bigmodel.cn、api/cap/captcha/castatic/code.zhipuai.cn、api/captcha/static.geetest.com。顺带发现豆包（doubao.com，部分端点是腾讯/阿里海外 CDN 71.18.x/163.181.x）也在走代理，已加直连。ZCode 需完全退出重启才生效。

## 2026-09-27（八）
- **PC 也挂上了 exit node（用户自行启用，lulian）**。新链路：PC clash 的 DIRECT 流量（ZCode/bigmodel/geetest 等）会经隧道到 NAS 被 NAS 规则二次处理——而 bigmodel.cn 解析到阿里云日本 IP，NAS 原本会把它丢进代理 → 验证码 IP 不一致会复发。**修复 = 把 8 条国内直连规则（bigmodel/zhipuai/chatglm/geetest/geetestcdn/zcode.ai/doubao/vipmro）同步加到 NAS config rules 顶部**（备份 config.yaml.bak-cn-20260927），日志实证 `match DomainSuffix(bigmodel.cn) using DIRECT`。
- 当前 PC 双跳链路已验证：ChatGPT = PC clash(新加坡隧道) 经 NAS 隧道转发 → 出口 SG 200 正常（略慢的双层代理）；国内 = NAS 判 DIRECT 出家宽。注意：①PC 挂 exit node 后 NAS 成为全部流量的单点，NAS 关机=电脑断网；②NAS 的 OpenAI 自动切换只服务走 NAS OpenAI 组的设备（手机），PC 的 ChatGPT 仍走自己 clash 的 Pluto 组；③更省层的备选方案（未实施）：PC 关系统代理，全流量交给 NAS 网关单层处理。
- 诊断技巧：连接受时长影响抓不到时，用 `docker logs mihomo | grep 域名` 看 match 日志是最可靠的规则命中取证；`GET /rules` 可确认规则加载顺序。

## 2026-09-27（九）
- 手机 ChatGPT"远程控制电脑"报"非预期的SSL证书"：手机（5G 裸连，Tailscale 已离线1天没走 exit node）→ OpenAI 中继 → PC 端 ChatGPT 桌面应用，而 **PC 端应用在当天多轮代理变更后已僵死**（12 进程但中继连接全断，应用自退过一次）。修复 = 重启 ChatGPT 桌面应用（微软商店包 OpenAI.Codex_2p2nqsd0c76g0，启动命令 shell:AppsFolder\OpenAI.Codex_2p2nqsd0c76g0!App），重启后 15 条连接全走本机代理 127.0.0.1:17890、chatgpt 流量正常（经新加坡隧道）。坑：查应用连接时 Get-NetTCPConnection 过滤别排除回环（走系统代理的应用连接=127.0.0.1:17890），且 PID 过滤要用 -contains 精确匹配而非 -match 正则（会误匹配其他进程）。

## 2026-09-27（十）
- 手机配 SSL 证书报错的另一层原因：OpenAI 组主力「美国2」当晚会间歇性失联（nanmei13 入口 dial timeout，19:29/20:09 有失败记录），failover 的 2 分钟巡检窗口内用户会撞上。已手动触发切换到俄罗斯(388ms)。
- **重要事实核查**：用户说"手机用了 exit node"，但 tailnet 里两台 iPhone 都是离线状态（iphone-3 离线1天、iphone181 离线4小时）——iOS 会挂起后台 VPN，手机上 Tailscale 很可能根本没连上（或连了又断）。排查手机问题前先确认：手机 Tailscale App 显示 Connected + 状态栏 VPN 图标 + Exit Node=lulian 选中。手机 ChatGPT"能正常用"是因为走了手机上另一个代理 App 或裸 5G 的其他通道，与 exit node 无关。
- PC 端 ChatGPT 桌面应用（OpenAI.Codex 商店包）配对中继域名：ws.chatgpt.com / chat.openai.com / auth.openai.com / ab.chatgpt.com / *.oaiusercontent.com，全部被 NAS OpenAI 组的 DomainSuffix 规则覆盖。

## 2026-09-27（十一）
- **failover v3：加地区校验**。用户实测"俄罗斯节点连不了 ChatGPT"——俄罗斯=OpenAI 制裁区，trace 探活只能测到 CF 边缘、测不出地区支持（与香港同类盲区）。修复：①巡检改用 `ios.chat.openai.com` 的响应体判断（含 unsupported_country=地区封锁→计失败；403 type:dc/200=可用——curl 指纹 403 不是拒绝信号）；②切换时遍历按延迟排序的候选，逐个"切换+地区校验"，首个通过者才落定，日志记 "region verified" / "candidate rejected: X (region blocked)"。演练实证：俄罗斯被拒→落加拿大(462ms)。
- v3 引入过笔误（jq `{name: $node_name}` 应为 `{name: $name}`，变量名不一致导致全部 PUT 400），已修复重验。教训：sh 里 jq --arg 定义的变量名和 filter 引用必须一致；改完必须实跑演练不能只看语法。
- OpenAI 组当前：加拿大(462ms, 地区校验通过)，主力仍为美国2（每日 03:00 复位，复位后若地区/连通失败会自动再切）。

## 2026-09-27（十二）
- **手机配对"无法连接到你的电脑"的根因 = PC 双层代理掐断长连接**：PC 同时开 exit node + 本机 clash 形成嵌套隧道，DF 大包测试 1472 字节丢 50%（有效 MTU 压到 ~1430），ChatGPT/Codex 桌面应用的 ws.chatgpt.com 中继 WebSocket 90 秒重连 1287 次（重试风暴），手机配对永远失败。修复 = PC 关 exit node 回归单层，ws 连接立刻长稳（60/60 采样持续在线）。结论固化：**PC 挂 NAS exit node 的双层架构对长连接（WS/SSH/SSE）有害，PC 用单层 clash、手机用 NAS exit node，各走各的**。诊断法：`curl --limit-rate` 抓 + /connections 按 start 时间统计重连频率；`ping -f -l` 分层测 MTU。
- 错误演进对照（排查手机配对问题）：非预期SSL证书 → （修 geetest 直连）→ 配对失败无法连接电脑 → （关 PC exit node 单层化）→ 待用户确认。

## 2026-09-27（十三）
- 用户新增机场「魔戒」（NAS mihomo 的 proxy-provider `mojie`，订阅 21 节点，多个标"GPT"优化，url-test 组「魔戒-灾备」自动选优，当前新加坡-优化-GPT），并把 5 条 ChatGPT 规则改指向新 fallback 组「AI自动」。审查结论：**配置正确无需修改**——AI自动成员顺序 [OpenAI, 南美, 魔戒-灾备]（现有节点主力、魔戒最后兜底），日志实证 `chatgpt.com match DomainSuffix using AI自动[新加坡隧道]`。
- 当前完整高可用链路（三层）：规则→AI自动(fallback, 120s 健康检查)→ ①OpenAI 组(46池, v3 failover: 最快+地区校验+2min巡检, 当前新加坡隧道) → ②南美组 → ③魔戒-灾备(21节点)。任一层故障自动降级到下一层，恢复后自动回切。
- mojie 订阅源: https://74.82.196.10:5000/api/v1/client/subscribe?token=... (providers/mojie.yaml, exclude-filter 已滤香港/流量信息)。

## 2026-09-27（十四）
- **PC 代理升级为三机场架构（与 NAS 同构）**：NAS 的合并配置（南美+西游云内联节点 + mojie provider + OpenAI 46池 + AI自动 fallback + 国内直连规则 + respect-rules）移植到 PC（C:/Users/Public/nanmei/config.yaml，备份 config.yaml.bak-sanjie-20260927）。适配项：TUN enable:false（PC 用系统代理模式）、external-controller 127.0.0.1:8765、allow-lan:false、GeoSite.dat 从西游云目录复制、providers/mojie.yaml 用 docker exec 从 NAS 容器卷取（宿主机路径在 /var/lib/docker/volumes/...，须 exec 进容器 cat）。
- PC failover 脚本 = NAS v3 的 Python 移植（C:/Users/Public/nanmei/openai_failover.py，monitor|reset|--force；地区校验经 127.0.0.1:17890 代理端口测试当前组选择；俄罗斯被正确拒绝）。计划任务 NanmeiOpenAIFailover（/SC MINUTE /MO 2 /RU SYSTEM，python 全路径 C:\Program Files\Python310\python.exe）。演练：俄拒→墨西哥(412ms)→复位美国2→巡检通过。
- 实测三链全通：chatgpt.com 200（走 AI自动，fallback 层在 OpenAI(美国2)/南美(越南1) 间按健康自动挑）、open.bigmodel.cn 200 直连、models.opencode.ai 200（opencode 畅通）。PC 无 jq——failover 脚本用 Python 移植而非 bash+jq。

## 2026-09-27（十五）
- 已产出《三机场自动切换代理部署指南.md》（C:/Users/Administrator/Desktop/），供办公室电脑复现 PC 三机场架构。内容：架构图、config 关键段（PC 适配项/respect-rules/fallback 链）、openai_failover.py 完整脚本、从零部署命令（schtasks 三件套：NanmeiProxy 自启/NanmeiOpenAIFailover 2min/NanmeiOpenAIReset 03:00）、验证清单与合格标准、8 条踩坑记录（双层代理 MTU、v1.18 fake-ip bug、YAML 缩进、curl 403 误报、俄罗斯地区盲区等）、OpenAI 46 节点清单与刷新方法。
- 办公室部署要点提醒：拷贝整个 nanmei 目录最省事（内核+数据文件+脚本），只需改 mojie 订阅 token；部署后按第六节验证清单跑。

## 2026-09-28
- PC 三机场运行次日：德国节点间歇抽风（当晚 5 次"1/2 探活失败后自恢复"，未触发连续 2 次切换），应用撞上失联窗口报 TLS 中断（自动重试自愈）。手动地区校验切换到英国(1351ms, 3/3 稳定)。存活池萎缩到 22/46（机场节点波动属常态，failover 体系正常工作）。经验：日志反复出现同节点 "1/2" 失败 = 该节点不稳的信号，看到就可手动换掉，不必等连续 2 次。

## 2026-09-28（二）
- **opencode 失联根因与修复**：①opencode.ai 域名原来不在容灾链里，流量挂在南美组的选择（越南1，当晚又死）上；②已加规则 `- DOMAIN-SUFFIX,opencode.ai,AI自动`（在 chatgpt 规则前），opencode 与 ChatGPT 同享三层容灾。验证：models.opencode.ai 经 英国→OpenAI→AI自动 返回 200。
- 当晚南美机场整体下线（入口 again，21 节点全探活失败 504）——容灾自动绕开（OpenAI 组用西游云的英国节点），机场恢复后自动回归。**Windows curl 测 HTTPS 报 CRYPT_E_REVOCATION_OFFLINE 是 schannel 吊销检查失败（OCSP 域名路由到死节点），加 `--ssl-no-revoke` 即可验证；Node/Electron 应用（opencode/OpenCode）用 OpenSSL 不做此检查，不受影响。**

## 2026-09-30
- PC ChatGPT 掉线事件复盘：加拿大节点 17:00-20:00 半残 3 小时（trace 通但 ios 端点超时，region_check 连续失败 92 次未触发切换——因组测速同时 504，脚本 bug 把错误码 {'__err__':504} 当成假候选 "__err__"，导致 "no region-supported node available (1 tried)" 无效切换）。20:00 后自愈（trace/ios 均恢复）。
- 脚本修复：ranked() 对 api() 错误返回（含 __err__ 键）必须返回空列表，并对候选名做 '__err__' 过滤。已修复并验证（巡检通过计数清零）。
- 运维经验：日志里 "probe failed: X (N/2)" 的 N 超过 2 还在涨 = 切换一直没成功，此时先手动跑一次组测速（/group/OpenAI/delay）看是真全灭还是脚本 bug；应用端 TLS 中断重试报错通常等自愈即可。

## 2026-10-01
- ChatGPT 掉线再排查：本次根因不是节点而是 **clash.exe 内核进程在 20:30 前后死亡**（17890/8765 全无监听，系统代理仍指向 17890 → 所有走代理的应用断网）；本机直连正常（bigmodel.cn 200、DNS 正常）证明非物理网络。崩溃前 failover 日志已连续 27 次 "no alive node"（机场链路整体不可达约 1 小时），20:30:11 后日志停更 = mihomo API 也不通 = 内核已死（脚本 api() 的 URLError 未捕获，静默崩溃不留日志）。
- 修复一条命令：`schtasks /run /TN NanmeiProxy`。恢复后"韩国"节点 region check 通过（Python urllib 指纹能过，curl 会 403 type=dc 误报）、chatgpt.com trace 200、api.openai.com 401（未带 key 的正常应答）。9-30 修的 ranked() 假候选 bug 未复发。
- 判别口诀：ChatGPT 掉线先 `netstat -ano | grep 17890` 看监听——**无监听 = 内核死了，直接 schtasks /run /TN NanmeiProxy 秒恢复；有监听才去查节点/机场**。注意 NanmeiProxy 是 ONSTART 任务：机器不重启就不会自动拉起中途死掉的进程；failover 巡检任务日志停更（尤其整点后无新行）本身就是"内核死了"的信号。

## 2026-10-02
- ChatGPT 断联第三次排查：内核活着（昨日 PID 43188 未死，17890/8765 正常监听），**根因是节点抖 + 应用卡死**——"韩国"节点夜间 4 次单次探活失败（21:40/22:14/00:54/02:12，均自愈），ChatGPT 桌面端的 WebSocket 被掐后自己不重连，界面显示断联而链路实际健康。用户重启 ChatGPT 应用即可恢复。
- 节点换血：组测速 /group/OpenAI/delay 再次 504（大量死节点拖垮批量测试，与 9-30 相同）；改用逐节点 /proxies/{名}/delay 3 次连测选稳。结果：主力"美国2"和"英国"已死；"台湾"延迟最低（259-372ms）但 ios 端点地区校验不过（延迟好≠能用）；最终选"韩国"（346-382ms、3/3 稳定、region 通过），"菲律宾一"为备选（462ms，实际出口也是 KR）。**再次验证：低延迟节点必须过 ios.chat.openai.com 地区校验才能用。**
- 当晨机场整体拥堵：节点抖动频繁（chatgpt trace 一次 000 一次 200 交替）、兜底组"西游云-德日韩"死、github 时通时断（走 MATCH→节点选择，非 AI 链）。mihomo API 被多组 URLTest 测速挤到间歇超时，openai_failover.py 的 api() 遇 API 超时会抛异常裸崩（exit 1，下轮巡检自愈但会漏记日志）——后续可给 api() 加 try/except 返回 {'__err__': ...}。
- 排查工具坑：Windows curl 对 chatgpt.com 的 000 需先加 --ssl-no-revoke 排除 schannel 吊销误报（本次又误判一次）；排除后仍 000 才是真断。

## 2026-10-02（二）
- conda create 报 repo.anaconda.com ReadTimeout 的真相：.condarc 里 TUNA 镜像早已配好，但 **conda 25.x 的 ToS 检查无视镜像配置、硬编码访问 repo.anaconda.com/pkgs/{main,r}/terms.json**；而 conda 继承全局 HTTPS_PROXY=127.0.0.1:17890 → 撞上抖动的代理。实测 repo.anaconda.com **直连是通的**（200 但 ~10s），TUNA/USTC/阿里云直连反而全超时，BFSU 北外镜像直连最快（0.12s）。
- 修复三件套：①.condarc 渠道全部切 BFSU（备份 .condarc.bak-20261002）；②用户 NO_PROXY 追加 repo.anaconda.com,mirrors.bfsu.edu.cn（setx，新终端生效）让 conda 流量绕开代理；③pip.ini 的 TUNA pypi 源同因不可达切 BFSU（https://mirrors.bfsu.edu.cn/pypi/web/simple）。验证：conda create -n stepai python=3.12 成功（D:\miniconda3\envs\stepai，Python 3.12.15），pip 下载 smoke test 通过。
- 经验：**镜像配置好了≠流量真走镜像**——工具还会继承全局代理环境变量；国内镜像/CDN 域名进 NO_PROXY 是通用修法。今晨该机直连网络本身也对部分国内目标（TUNA/USTC/aliyun）劣化，BFSU 独活，属运营商侧抖动。

## 2026-10-02（三）
- Codex/ChatGPT 桌面端反复弹 "Command approval"（Approve / Approve for session / Decline）排查：本机配置其实已全开——~/.codex/config.toml 已是 `approval_policy="never"` + `sandbox_mode="danger-full-access"`（当日 14:50 改，bak-no-confirm-20261002-145021 备份在），App 内 composer 也是 full-access（.codex-global-state.json 的 permission-selection-by-host-id:local），53 个心跳线程里 49 个已是 never。仍弹窗两个原因：①个别会话按 on-request 创建（如 "Langguo Agent Factory 三 Agent 工作流" roadmap 会话），会话权限创建时固定，需在该会话输入框把模式切到 Full Access 或点一次 "Approve for session"；②Windows Codex App 已知 bug：Full Access 下仍对 read-only process check 类操作弹窗（openai/codex#24934、#28988、#18521，均 open 未修）。用户偏好明确：不要反复确认，能自动批准就自动批准。
- 追加修复：直接把 "配置 Langguo Agent Factory"（thread 01a0dc5b）改成 never——权威存储是 state_5.sqlite 的 threads 表（approval_mode='never' + sandbox_policy='{"type":"disabled"}'，全访问线程在 DB 里就是 disabled 沙箱），UPDATE 后已验证保留；.codex-global-state.json 的 heartbeat-thread-permissions 会被运行中 App 的内存态覆盖回 read-only，改了也白改，必须重启 App 才能刷新 UI 态。结论：改运行中会话的权限 = 改 threads 表 + 重启生效；composer 上的"完全访问"标签只是 host 默认选择，对 goal/roadmap 自动续跑的会话不生效（这就是一直弹 on-request 审批的根因）。
- 第二轮修复成功（根治）：改运行中会话权限**真正的源头是 rollout 文件的 turn_context**（sessions/2026/09/26/rollout-...01a0dc5b....jsonl，443MB，改前备份 .bak-never-20261002）——threads 表和 electron atom 都是镜像，App 启动时从 rollout 重推权限并回写两处，所以只改 DB/atom 必被打回。正确顺序：杀 ChatGPT.exe/codex.exe → 流式改写 rollout 里 payload 带 approval_policy 的记录（on-request→never、sandbox read-only→{"type":"danger-full-access"}、permission_profile→{"type":"disabled"}，本线程实际改了 10 条，其余历史记录本就是别的值）→ 重钉 DB+atom → 重启。验证：重启 45s 后 DB=never+{"type":"disabled"}、atom=never+dangerFullAccess 均未被回写，rollout 残留 on-request=0。格式参照：全访问线程 DB 沙箱={"type":"disabled"}、rollout permission_profile={"type":"disabled"}。

## 2026-10-02（四）
- ultralytics.com/agents 和 /pricing "打不开"排查：**站点完全正常**——本机双路径反复测均 HTTP 200（直连+代理 17890），DNS 正常（Vercel），依赖域 cdn.ul.run 也通（根 403 属正常）。真实原因是**链路严重劣化下的整页加载超时**：单个 HTML 文档直连 2.8-12.9s、走代理 1.4-8s（当晨机场拥堵），整页几十个 _next 资源累计必然超时；浏览器表现即转圈/错误页。ZCode 内置浏览器（IAB）不走系统代理=直连，复现到 chrome-error://chromewebdata/ 空错误页，连 example.com 都 10s 超时——再次验证本机直连国际线路当前不可用。判别经验：curl 单请求 200 ≠ 浏览器打得开，整页加载要看链路质量；测站点通不通要直连+代理各测一遍，再对比用户浏览器实际路径（注册表 ProxyServer=127.0.0.1:17890）。

## 2026-10-03
- ChatGPT 掉线第三天，已成规律：**每天凌晨机场都有全断窗口（今日 05:10-05:16，三层容灾全灭），恢复后 ChatGPT 桌面端卡在断线态**（应用连着代理但会话已死，重启应用即恢复）。当日 failover 自动切到"智利"（能通但 883-1726ms），手动优化到"菲律宾一"（338-348ms、region 通过）。**"台湾"节点连续两天延迟最低（~240ms）但 ios 端点地区校验不过=出口 IP 被 OpenAI 拉黑，OpenAI 组选节点时直接跳过它**。
- 晨间排查 SOP 已固化：①netstat 看 17890 监听（无=重启 NanmeiProxy）→ ②trace --ssl-no-revoke 测链路 → ③逐节点 3 连测选最稳+region 校验 → ④重启 ChatGPT 应用。根治要看上游：西游云 10-07 到期，机场侧夜间全断会持续；机器重启后 clash PID 会变属正常（ONSTART 任务拉起）。
- 矩视智能(nb-ai.com/NeuroBot)技术路线调研结论:工业视觉低代码SaaS,模式=**云端训练+本地封闭SDK推理**。SDK(github neurobot_sdk_demo)是Windows closed-source DLL,API仅 load_model/predict_model/destroy_model/get_batch,输入cv::Mat,输出bbox+score+label+mask(检测+实例分割+OCR),设备cuda/cpu,模型=文件夹(model.conf+私有格式权重,默认阈值0.7)。检测范式与YOLO同族(单阶段CNN检测器),具体架构与推理后端(疑ONNX Runtime/TensorRT)均未公开。核心壁垒是工作流整合而非算法;个人用 Ultralytics YOLO + PaddleOCR + X-AnyLabeling + ONNX/TensorRT + SAHI切片 即可复刻同等管线(其demo覆盖的OK/NG判定、多模型多线程、大图切片、旋转预测、mask过滤均为工程胶水代码)。
