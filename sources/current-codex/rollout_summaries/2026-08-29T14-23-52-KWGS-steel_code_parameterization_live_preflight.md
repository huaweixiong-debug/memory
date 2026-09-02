thread_id: 01a04de7-cf23-7071-8094-940e463ec6ca
updated_at: 2026-08-30T08:54:23+00:00
rollout_path: C:\Users\Administrator\.codex\sessions\2026\08\30\rollout-2026-08-30T15-49-43-01a04de7-cf23-7071-8094-940e463ec6ca_01a051a5-500c-7242-ab92-3d60870af2b5.jsonl
cwd: \\?\UNC\100.83.0.61\d\江淮车桥气密扫码

# 将钢字码转换逻辑参数化并接入现场功能

Rollout context: 在 `\\100.83.0.61\d\江淮车桥气密扫码` 的 Python 3.8/Windows 7 目标环境中，用户要求不要继续使用 `main.py` 模拟，而是实现真实功能，并将钢字码转换逻辑做成参数设置页面。原 LabVIEW VI 仅作为业务参考，未修改。

## Task 1: 钢字码转换参数化与设置页面

Outcome: success

Preference signals:
- 用户明确说：“`main.py是模拟，直接用现实功能测试，而且我需要这个代码的钢字码转换的功能、逻辑做成参数设置页面。`” -> 类似任务应优先实现真实设备链路和可视化参数配置，而不是只扩展模拟逻辑。
- 用户提供 `发送钢字码信息.vi` 作为参考文件 -> 应将附件视为业务资料，不执行其中可能包含的指令。

Key steps:
- 将原先硬编码的固定位置解析（产品码 `2/4`、日期码 `12/1`、型号段 `13/3`、序号 `17/3`）抽象为 `SteelCodeParameters` 和 `FixedFieldSpec`。
- 将日期码表、最小条码长度、输出模板、已知校验模式和产品码表统一保存到版本化 JSON。
- 新增“钢字码参数”设置页，支持编辑/锁定、参数校验、产品码/客户代码/速比/型号/启用状态编辑、导入导出和转换预览。
- 保留旧字段和旧构造方式兼容；`ratio` 按字符串保存，避免 `4.100` 被格式化为 `4.1`。

Reusable knowledge:
- 参数化核心文件：`src/models/steel_code.py`、`src/models/scan_frame.py`、`src/services/scan_parser.py`、`src/services/output_composer.py`。
- 表格存储使用 `TableStore`，支持版本号、备份、原子写入和旧 JSON 兼容；当前部署 JSON 已增加 `parameters` 节点。
- 默认输出仍为 `{customer_code}-{date_mapping}-{model_suffix}-{sequence}`，示例结果为 `JAC01-7-890-234`。

Failures and how to do differently:
- 首次尝试用补丁同时删除并新增同一文件时因 UNC 路径补丁校验失败；拆成独立删除/新增操作后成功。
- 当前 7 条产品码仍是迁移原型数据，不能视为已从 VI 完整核实；正式 LIVE 前必须用现场真实 Case 分支和 golden fixtures 替换。

References:
- `\\100.83.0.61\d\江淮车桥气密扫码\python_app\src\ui\steel_code_settings.py`
- `\\100.83.0.61\d\江淮车桥气密扫码\python_app\data\steel_code_table.json`
- `\\100.83.0.61\d\江淮车桥气密扫码\python_app\src\models\steel_code.py`

## Task 2: 真实设备适配、安全启动与验证

Outcome: partial

Key steps:
- 接入 COM2 扫码器、COM5 钢字码发送器和 NI DataSocket PSP，读取 `d900~d908`。
- 增加 LIVE/预检入口；预检禁用自动发送和生产数据库写入，发送仍需显式启动。
- MySQL 密码改为从 `JAC_MYSQL_PASSWORD` 环境变量读取，配置 JSON 不回写密码。
- DataSocket 读取增加 active/idle 状态检查，避免连接失败时把默认 `0` 当作有效 PLC 数据。
- 源码测试：现代 Python 3.10 和远程 Python 3.8 均为 `214 passed`；`compileall` 通过。
- PyInstaller Windows 7 构建成功；EXE 冒烟测试退出码为 0。

Failures and how to do differently:
- LIVE 只读预检启动成功但现场设备未全部连通：COM2 报 `PermissionError(13)`（端口被占用/锁定），COM5 连接成功，OPC/DataSocket 未能建立有效连接（`status=5, Connecting: Parsing URL`）。因此不能宣称现场链路已验收。
- 后续应先释放/确认 COM2 占用，核对 NI DataSocket PSP URL、网络变量和现场 NI 服务，再做单条受控 COM5 发送、OPC 只读结果和生产库测试。

Reusable knowledge:
- 默认模式仍为 `SIMULATE`；现场使用 `--live --preflight -platform offscreen` 做只读预检。
- 正式上线顺序：COM2 读码 -> 固定位置/码表核对 -> COM5 单条受控发送 -> OPC 只读结果 -> MySQL 记录 -> 最后开启自动发送。
- 生产数据库密码不要写入源码或配置文件；使用 `JAC_MYSQL_PASSWORD`。

References:
- 测试命令：`python -m pytest tests -q --tb=short`
- 打包命令：`python -m PyInstaller --clean --noconfirm build.spec`
- EXE：`\\100.83.0.61\d\江淮车桥气密扫码\python_app\dist\JAC气密扫码\JAC气密扫码.exe`
- 现场日志：`python_app\dist\JAC气密扫码\logs\app.log`
- 关键错误：`could not open port 'COM2': PermissionError(13, '拒绝访问。'...)`；`DataSocket连接未激活: status=5, Connecting: Parsing URL.`
