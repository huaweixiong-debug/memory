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
- OpenCode 桌面端项目"本地服务器"红色排查（18:0x 发现）：sidecar opencode server（127.0.0.1:51876）当日 18:02:07 崩溃，退出码 3221225477 = 0xC0000005 访问冲突，Electron 不自动重启，端口无监听而 UI 持续 SYN_SENT 重连， hence 项目里本地服务器显示红色。修复 = 重启 OpenCode 桌面端。日志定位：`~/AppData/Roaming/ai.opencode.desktop/logs/<会话目录>/utility.log`（sidecar exited）、`main.log`（spawning sidecar 端口）、服务端日志 `~/.local/share/opencode/log/opencode.log`；崩溃转储在 `Crashpad/reports/`（2026-09-04 还有两次 dmp，疑似复发性原生崩溃，复现时用 WinDbg/cdb 分析，本机暂无 cdb）。干扰项辨析：9/23 曾因 P: 网络盘不可达在 Server.listen 报 `lstat 'P:\'` 启动失败，但 P 盘（\100.117.1.6\projects）现已正常，与本次红色无关。
