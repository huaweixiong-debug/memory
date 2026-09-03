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
