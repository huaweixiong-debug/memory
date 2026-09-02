# OpenCode 共享记忆

生成时间：2026-08-20T17:30:00+08:00

## 说明

本文件是 OpenCode 的共享记忆入口，用于与 Codex 两个账号共享“统一大脑”。

### OpenCode 内置记忆

OpenCode 其实有内置记忆，存储在本地 SQLite 数据库：

- 主数据库：`/home/huaweixiong/.local/share/opencode/opencode.db`
- 关键表：`session`（会话）、`message`（消息）、`session_message`、`todo`、`workspace`、`project`
- 当前已记录 2 个 OpenCode 会话：
  - `ses_fe317394cffefyL8dPKCxmYZR8`：蒸发器装箱追溯系统迁移至 longol_mes 开发部署
  - `ses_fe17af6c0ffeHjcnxOwlkmWDl2`：共享记忆大脑设置（本会话）

同一 OpenCode 实例的后续会话可以读取这些历史会话。但 Codex 无法访问该数据库，因此仍需要本文件作为跨 AI 的共享记忆。

### 使用方式

- 每次 OpenCode 启动时，先读取本文件以及 `../UNIFIED_MEMORY.md`。
- 后续每次 OpenCode 会话结束后，可把关键结论、决策和待办追加或更新到这里。
- 完整原始上下文仍以各自原始 rollout / SQLite 记录为准。

### Codex 如何加入

- 已创建全局 `AGENTS.md`：`/home/huaweixiong/.codex/AGENTS.md`
- 已创建项目级 `AGENTS.md`：`/home/huaweixiong/projects/memory/AGENTS.md`
- 这样 Codex 每次启动时都会自动读取共享记忆规则，并参考 `opencode_memory/MEMORY.md`。

## 用户画像与偏好

- 身份：工业自动化/设备集成领域从业者，工作地点在中国南京。
- 主要工作：把 LabVIEW / 传统工控项目迁移到 Python/C#，开发上位机、气密检测、视觉检测、PLC 通讯等系统。
- 偏好工具链：
  - AI 代理：OpenCode、Codex、Claude Code、Hermes Agent
  - 语言：Python、C#、LabVIEW（迁移中）
  - 工业协议：Modbus-RTU/TCP、OPC、S7、LIN
  - 视觉：YOLO / Ultralytics
  - 远程：Tailscale、SSH、WSL、Docker（NAS）
- 工作方式：
  - 经常通过 Tailscale 远程操作 Windows 工控机。
  - 项目多放在映射盘（S:\、Y:\、X:\、U:\、V:\、W:\ 等）或 GitHub 仓库。
  - 习惯让多个 AI 协作：Codex/Claude 策划，OpenCode 执行，要求会话间可接力。
  - 对安全敏感：要求危险操作（分区、SSH 凭据、生产环境）需确认或白名单。

## 当前环境

- 本地工作目录：`/home/huaweixiong/projects/`
- 本文件位置：`/home/huaweixiong/projects/memory/opencode_memory/MEMORY.md`
- 共享记忆根目录：`/home/huaweixiong/projects/memory/`
- 其他 AI 记忆：
  - Codex 第二账号：`../account_memory/MEMORY.md`（149 个会话）
  - Codex 当前账号：`../current_account_memory/MEMORY.md`（135 个会话）

## 活跃项目

1. **蒸发器装箱追溯系统 / longol_mes**
   - 从 `Y:\协众\056 蒸发器装箱追溯系统\Brain` 同步到 `/home/huaweixiong/projects/longol_mes`。
   - 采用“每台工控电脑一个子目录”的总项目结构：
     - `PC-01_HELIUM-01/`：1 号氦检仪器 A/B 工位只读采集（当前实际开发子项目）
     - `00_CENTRAL-MES/`：中央 API/数据库迁移/看板（占位）
     - `PC-02_UNASSIGNED` ~ `PC-08_UNASSIGNED`：待现场盘点后命名
   - 技术栈：Node.js 20 LTS + Express 4 + CommonJS + npm + SQL Server
   - 开发/验证环境：Ubuntu Server（`100.117.1.6`，用户 `huaweixiong`）
   - 状态：已完成首次同步、环境搭建、数据库迁移、种子数据和集成测试（5 个测试全部通过）

2. **武汉 RAD 干检第二台 / Leak Test 2 Channels**
   - 把 LabVIEW 项目迁移到 Python。
   - 涉及 ATEQ 气密仪、S7-200 Smart PLC、斑马扫码枪/打印机。
   - 仓库：`huaweixiong-debug/ALW-Leak-Test`
   - 路径：远程 `100.126.165.53:D:\dispense flux` / 本地映射 `X:\dispense flux`

3. **ATEQ 气密检测上位机（多项目）**
   - 与 ATEQ 仪器通过 RS232/Modbus-RTU 通讯。
   - 需要实时曲线、数据库存储、多条件查询、条码绑定产品档案。
   - 常见远程地址：`100.89.253.4`、`100.91.248.9` 等。

4. **膨胀阀安装工作台 / 自动涂胶 / 冷凝器产线**
   - 涉及扫码、拧紧枪（Kilews）、PLC、标签打印、数据追溯。

5. **视觉检测（Camera Screw Project）**
   - YOLO 模型：`best.pt`，类别 `['NG', 'O_Ring_L', 'O_Ring_S', 'QR', 'TXV']`
   - 使用 Ultralytics 8.4.x，PyTorch，CUDA。

## 重要账号/地址（已脱敏）

- NAS / Docker / Mihomo：`100.82.136.106`
- Tailscale 虚拟局域网中的多台远程 Windows 工控机
- 常用映射盘：`S:\`、`Y:\`、`X:\`、`U:\`、`V:\`、`W:\`
- GitHub 组织/用户：`huaweixiong-debug`

## 记忆使用规则

1. 每次 OpenCode 启动时，先读取本文件以及 `../UNIFIED_MEMORY.md`。
2. 需要追溯时，保留来源标记（OpenCode / Codex 账号 1 / Codex 账号 2）。
3. 发生冲突时，以最新、最具体的记录为准。
4. 敏感信息需脱敏，完整凭据不写入本文件。

## 最近 OpenCode 会话

### 2026-08-20：共享记忆大脑设置

- 用户要求把 OpenCode 的记忆加入 `memory/`，实现 Codex 两个账号与 OpenCode 共享一个大脑。
- 已创建 `opencode_memory/`，更新 `README.md`、`UNIFIED_MEMORY.md`、`memory_summary.md`。
- 发现 OpenCode 内置 SQLite 记忆数据库，并提取了历史会话摘要。

### 2026-08-20：蒸发器装箱追溯系统迁移至 longol_mes 开发部署

- 源项目：`Y:\协众\056 蒸发器装箱追溯系统\Brain`
- 目标：`/home/huaweixiong/projects/longol_mes`
- 项目结构：
  - `PC-01_HELIUM-01/`：1 号氦检仪器 A/B 工位只读采集（当前实际开发子项目）
  - `00_CENTRAL-MES/`：中央 API/数据库迁移/看板（占位）
  - `PC-02_UNASSIGNED` ~ `PC-08_UNASSIGNED`：待现场盘点后命名
  - `_legacy_station_placeholders/`：旧工位占位目录，已废弃
- 技术栈：Node.js 20 LTS + Express 4 + CommonJS + npm + SQL Server
- 主要能力：旧氦检数据只读采集与回填、工艺路线与追溯、装箱闭环与标签打印、站点认证/CSRF/审计日志、Modbus 采集封装
- 环境搭建结果：
  - Node.js v20.20.2、npm v10.8.2 安装完成
  - `npm ci` 成功（253 个包）
  - 语法检查 `npm run check` 通过
  - Microsoft SQL Server 在 Ubuntu 26.04 上安装并启动（需从 Ubuntu 22.04 源安装 `libldap-2.5-0` 兼容库）
  - 数据库 `LongolMES_Dev` 创建成功
  - 迁移 `npm run migrate` 3 个迁移全部应用
  - 种子数据 `npm run seed:demo` 完成
  - 集成测试 `npm test` 5 个测试全部通过
- 代码改动：`src/config.js` 修复 `MES_SQL_INSTANCE` 空字符串无法覆盖默认值的问题
- `.env` 已配置（已 gitignore，不提交），包含本地开发账号密码、氦检站点密钥、旧氦检采集关闭、打印代理 dry-run
- 这台 Ubuntu Server 为开发和验证环境，最终项目会放到远程电脑。

### 2026-08-21：根据更新 Excel 形成整线开发蓝图

- 用户提供 `P:\longol_mes\蒸发器追溯系统.xlsx` 作为更新需求，并要求 Codex 只做详细开发计划，后续交给 OpenCode 的 MiniMax、MiMo 或 Kimi 实施。
- 已生成计划：`P:\longol_mes\docs\DEVELOPMENT_PLAN_2026-08-21.md`。
- 更新后的 Excel 识别为 18 个唯一逻辑工位：内堵内漏3、焊接5、亲水1、装阀3、氦检3、装箱3；原重复行已改成“内堵内漏工位3”。
- 用户已确认：焊接1～5为平行相同工位；内堵内漏1～3为平行相同工位；阀码兼容关系在中央主电脑设置；PLC 为 S7-200 SMART 并使用 Snap7；内堵内漏2/3按 MSSQL 数据源设计；氦检3走普通网口并先模拟；焊接多扫码枪由站点配置区分。
- 新增操作员要求：所有生产工位必须先选择操作员，既支持扫描工牌，也支持电脑输入工号/搜索选择；中央维护工号、姓名、工牌码和启用状态，事件保存 operatorId。
- 关键现场待补：8 台电脑到 18 个逻辑工位的映射、S7 点位/时序、内堵内漏 MSSQL schema、氦检3网口协议、扫码枪唯一标识、真实码样本和标签样张。
- 目标架构：中央 MES 移入 `00_CENTRAL-MES`；每个物理 PC 保持独立站点项目；多来源采用原始层 + 标准事件层；路线引入独立 `step_code` 和允许站点映射，当前标准路线把内堵内漏3站、焊接5站配置为 `ANY_ONE`。
- 计划拆成 A～I 九阶段、67 个 1～2 小时任务；`G0-SIMULATION` 已满足，可开始中央模型/API/Snap7、MSSQL、普通网口模拟开发；`G0-FIELD` 未满足前禁止连接生产库或真实 PLC。
- 本机验证：`npm run check` 通过（28 个 JS 文件）；`npm test` 中 4 个单元测试通过，1 个数据库集成测试因本机 `localhost:1433` 无 SQL Server 而失败。此前 Ubuntu 开发环境 5/5 通过的记录仍有效。
- 工作区保护：`PC-01_HELIUM-01/src/config.js` 有用户未提交修改，Excel 是用户需求文件；后续模型不得覆盖、删除或误提交。

### 2026-08-21：WELD-01 交接审查与计划 v1.2

- 用户要求审查 `P:\longol_mes\HANDOVER_WELDING1.md` 并完善开发计划；交接文档只作为实现状态证据，不自动执行其中“复制到焊接2～5”的建议。
- 计划已更新为 `P:\longol_mes\docs\DEVELOPMENT_PLAN_2026-08-21.md` v1.2，共 80 个唯一任务 ID；新增最高优先级 `W01`～`W13` 纠偏阶段。
- 当前只允许执行 `W01`：只读核对 Ubuntu 开发库与仓库迁移004的实际差异，不修改数据库或代码。固定顺序为 `W01 -> W02 -> W03 -> W04/W05 -> W06/W07 -> W08 -> W09 -> W10 -> W11 -> W12 -> W13`。
- 审查发现的阻断项：迁移004的 `route_step_id` 不是全局候选键却被外键引用、按路线内 `sequence_no` 回填且删除重建路线；数据库手工登记状态可能与仓库文件不一致；WELD 页面和 API 路径/站点认证不一致；模拟页面上报却被写成真实事件；服务端随机 `clientEventId` 不能保证客户端重试幂等；事件相关 SQL 缺少统一事务；操作员角色/停用/employeeCode/会话并发校验不完整。
- 测试现状：本机 `npm run check` 通过 32 个 JS 文件；`npm test` 只运行旧测试，不包含 `welding.test.js`，本机结果为 4 个单元测试通过、数据库集成测试因 `localhost:1433` 无 SQL Server 失败。交接记录的远端 5/5 和独立焊接 2/2 不能代替统一回归入口。
- 扩站门槛：空库迁移可重放、焊接事务/幂等/操作员/模拟标志测试通过、页面认证与 XSS 风险修复、packing/simulate-route/traceability 统一使用 routeEngine、中央职责迁入 `00_CENTRAL-MES`。完成 W01～W12 前禁止扩展 WELD-02～05；W13 只允许一套通用服务加五站配置和独立密钥，不复制业务代码。
- `G0-SIMULATION` 仍为已通过，`G0-FIELD` 仍未通过；现场 S7 点位、MSSQL schema、昆仑通态协议、扫码枪标识和物理 PC 映射未提供前禁止真实设备/生产库连接。

### 2026-08-21：逐任务人工确认门与 W01 待复核

- 用户明确要求：每完成一个功能/任务，必须先由用户人工复核并明确确认，之后才允许做下一个功能。
- `docs/DEVELOPMENT_PLAN_2026-08-21.md` 已升级为 v1.3。统一状态为 `NOT_STARTED -> IN_PROGRESS -> WAITING_FOR_HUMAN_REVIEW -> APPROVED`；用户要求修改时回到 `CHANGES_REQUESTED/IN_PROGRESS`。AI、测试通过或报告生成均不能代替用户批准。
- 唯一有效放行方式是用户明确指定任务 ID 和下一任务，例如“确认 W01，可以进入 W02”。批准仅限指定切片，不自动批准整个阶段，也不扩大生产设备/数据库权限。
- `docs/W01_AUDIT_REPORT.md` 当前状态为 `WAITING_FOR_HUMAN_REVIEW`，`W02 NOT_STARTED`。用户批准前只能补 W01 证据、回答复核问题或修订报告，不得开始 W02/修改迁移/开发新功能。
- W01 报告复核发现：缺少可重复执行的只读 SQL、目标数据库身份和关键原始结果摘要；“17站 vs 18工位”应聚焦 `HELIUM-01-A/B` 与氦检1～3的建模关系，不能猜 PACK-04/INNER-04；`attempt_no NOT NULL` 来自001，不是004差异；004仅在开发库登记不能自动证明已发布，因此修004还是加005留待W02并需用户决定。

### 2026-08-21：W02方案提前提交，暂不批准

- `docs/W02_MIGRATION_STRATEGY.md` 在用户尚未明确批准W01时被提交，违反逐任务人工确认门；只做了只读审查，W01仍为待复核，W02不得视为已授权或已完成。
- W02当前主要问题：把 `DROP DATABASE LongolMES_Dev` 和 `CREATE LOGIN` 写入重建流程；没有冻结 route_step_id 的最终键方案；拟把WELD密钥和猜测的第18站写进004；未处理004删除重建标准路线的历史破坏风险；声称开发库可重建但没有给出复核证据，且当前004本身无法从空库成功建立FK。
- 建议人工结论为 `CHANGES_REQUESTED`：先补齐并批准W01，再重做W02；W03必须使用独立可丢弃测试库，禁止删除LongolMES_Dev，凭据拆到W04，氦检1～3先冻结工位/通道/数据源模型。

### 2026-08-21：GPT-5.6 Luna 修订W02，Codex主审通过

- 用户明确要求由GPT-5.6 Luna处理、Codex随后检查。Luna仅修订 `docs/W02_MIGRATION_STRATEGY.md`，未执行W03、未改SQL/JS/specs/public、未连接数据库或设备。
- Codex主审两轮并要求返修：最终冻结 `route_step_id` 为 `int IDENTITY(1,1) NOT NULL PRIMARY KEY`；原 `(route_id, sequence_no)` 改为UNIQUE，保留 `(route_id, step_code)` UNIQUE。
- 迁移编号仍为条件决策：只有证据证明004仅用于可重建开发环境且未发布时才修004，否则新增005。W03使用独立可丢弃测试库，禁止删除LongolMES_Dev或创建服务器登录。
- 004/005不得删除重建路线历史；W03只保护现有路线/products/process_events不丢失和不孤立，产品路线绑定留W07/C04。WELD密钥移到W04安全配置；不猜第18站，等待确认HELIUM-01-A/B与氦检1～3的语义。
- 文档主审已通过，但流程状态仍为W01待用户确认、W02草案待人工复核、W03未开始。只有用户先确认W01，再明确“确认W02，可以进入W03”，才允许实际迁移开发。

### 2026-08-22：Z:\Weixin Monitor 微信单会话采集测试版

- 工作区原为空，已建立 Node.js 18+ / Express 4 CommonJS 服务与 Python Windows helper；当前切片只采集指定一个微信会话的昨天消息，不访问或解密微信数据库。
- 采集链路冻结为：微信可见窗口 -> UI Automation（主通道）-> 截图 -> Windows.Media.Ocr（兜底）-> 原始视口证据 + 标准化 JSON/TXT。发送人无法可靠识别时必须为 null，不猜测。
- 已验证：Node 语法检查、Python 编译、微信窗口 dry-run、Windows OCR 中文识别、API health 均通过。当前微信 Qt 窗口 UIA 未暴露聊天文本，OCR 兜底实际可读。
- 文件入口：`Z:\Weixin Monitor\README.md`、`docs\BLUEPRINT.md`、`server.js`、`wechatCollector.js`、`python\wechat_collector.py`。真实单群端到端采集需用户指定测试群名后人工复核；在复核前不扩展多群、文件扫描或 AI 总结。

### 2026-08-25：Chiller Line 2 客户码重码审计与原子取号替代切片

- 项目在 `T:\Chiller Line 2`，T 盘映射远程 `D:\Chiller Line 2`；源项目为 LabVIEW 2024，生产数据是 MySQL 5.7 `test.information`。
- 已只读解析 `Heating.vi`：现有客户码为产品前缀14位 + `YYMMDD` + 当天合格记录数量补零6位；返工重扫不增加记录数、并发读取相同计数，因此会重码。
- 数据库审计时 `information` 有 81,676 行、无任何索引/唯一约束；流水码存在重复，客户码历史重码明显。未自动清理历史数据。
- 已新增 `T:\Chiller Line 2\customer_code_fix`：Python ODBC 原子取号 CLI、MySQL 迁移/只读预检、单元测试和接入说明。规则为数据库日序列表原子递增、同一流水码幂等返回、分配表双唯一约束、历史冲突拒绝自动覆盖。
- 验证：8 个 Python 单元测试通过；两个产品映射 dry-run 通过；生产 MySQL 5.7 `ONLY_FULL_GROUP_BY` 下三段核心查询只读 `EXPLAIN` 通过。
- 安全门：未执行生产迁移、未改任何 `.vi`、未部署 Python。上线前必须停旧计数生成路径、备份数据库、人工处理/确认历史重码，再执行迁移并把 LabVIEW System Exec 切到新 CLI；远程当前只有 32 位 MySQL ODBC DSN，因此 Python 与 pyodbc 也必须用 32 位。

### 2026-08-25：Chiller Line 2 客户码防重 UI 门完成

- `T:\Chiller Line 2\customer_code_fix` 已按切片完成原子分码核心、MySQL 5.7 影子验证、中文 Tkinter HMI、x86 便携打包与远程复核；当前测试总数为 38，全部通过。
- 影子 schema 使用同一份生产迁移 SQL 验证通过：74,716 条安全一对一历史映射回填，双唯一约束、冲突跳过和日序列初始化均通过；生产迁移仍未执行。
- 32 位便携包已放到远程 `D:\Chiller Line 2\customer_code_fix\release\CustomerCodeHMI_x86`，远程 Windows PowerShell 5.1 返回 `RELEASE_VERIFIED`；实际 HMI 截图为该目录的 `remote_ui_review.png`。
- 14 个原生产 VI 与基线 SHA-256 全部一致，未切换旧 LabVIEW 生成路径；HMI 当前明确为模拟/影子模式且不连接生产库。
- 当前门禁为 `APPROVED_UI` 待用户确认界面。用户确认前禁止生产迁移和 VI 接入；确认后才按单工位试运行、全工位扩展、异常停止分码且不回退旧计数算法的预案执行。

### 2026-08-26：Windows Codex/OpenCode 执行器安装

- 当前用户已安装 OpenCode CLI `1.18.23`（npm `opencode-ai@latest`），`opencode models --verbose` 可用；默认 `opencode-go/deepseek-v4-flash` 支持 `high`。
- 已创建用户级技能 `C:\Users\Administrator\.codex\skills\opencode-executor`、执行器配置和 Python 标准库测试；技能校验 1/1、unittest 4/4 通过。
- 已在 `C:\Users\Administrator\.codex\opencode-executor\smoke-repo` 完成无害 Git 冒烟，OpenCode session 已捕获、exit code 0、只生成 `smoke_result.txt`，证据目录为 `C:\Users\Administrator\.codex\opencode-executor\runs\2026-08-26-smoke`。
- 已将默认 Codex/OpenCode 路由幂等追加到 `C:\Users\Administrator\.codex\AGENTS.md`；未复制或修改任何认证凭据。

### 2026-08-26：中间审核模型调整

- 用户要求将 OpenCode 执行完成后的中间审核固定为 `gpt-5.6-terra`、`high`。
- 已在 `C:\Users\Administrator\.codex\opencode-executor\config.json` 增加 `review_model` 和 `review_variant`；规划模型与 OpenCode 执行模型保持独立。
- `opencode-executor/SKILL.md` 已要求审核阶段读取并使用该配置，修改后技能校验和 4 项自动测试全部通过。

### 2026-08-26：OpenCode 执行模型调整

- 用户要求将 OpenCode 执行模型改为 `opencode-go/mimo-v2.5`。
- 当前模型清单显示 MiMo V2.5 存在但 `variants` 为空，因此执行配置同步改为 `default_variant: none`；Codex 中间审核仍为 `gpt-5.6-terra` + `high`。

### 2026-08-26：审核模型按复杂度分层

- 用户确认：复杂任务中间审核使用 `gpt-5.6-terra` + `high`；简单任务中间审核使用 `gpt-5.6-luna` + `high`。
- 已更新 `opencode-executor` 配置和技能说明；OpenCode 执行仍为 `opencode-go/mimo-v2.5` + `none`。

### 2026-08-26：审核配置按复杂度拆分

- 用户确认：复杂任务和简单任务的 Codex 中间审核均使用 `gpt-5.6-terra` + `high`。
- 配置已增加 `review_complex_model`、`review_complex_variant`、`review_simple_model`、`review_simple_variant` 四个显式字段；OpenCode 执行保持 `opencode-go/mimo-v2.5` + `none`。

### 2026-08-27：opencode-executor 完整审核链路实现

- 用户确认完整实现不能停留在模型配置：已补齐 `REVIEW_PACKET.md` 模板/强制验收、OpenCode session 与流式证据、独立 stdin-only Terra/Luna 审核器、只读 sandbox、30 分钟/5 分钟超时、单次同 session 返工约束及阶段标记。
- 当前固定路由：OpenCode `opencode-go/mimo-v2.5` + `none`；simple `gpt-5.6-luna` + `high`；complex `gpt-5.6-terra` + `high`。
- `opencode-executor` 测试结果：pytest 11 passed；simple/complex 分层测试分别通过。

### 2026-08-27 GLM-Terra V1 文件优先工作流落地

- 已实现 plan.md（2026-08-27-glm-terra-v1）：执行者默认 opencode-go/glm-5.3-flash + high；Terra 计划/终审默认 medium，仅 L 或高风险升 high（--task-size/--high-risk）；Sol 默认关闭且需用户批准，每任务最多 1 次。
- 新增：
eferences/v1_workflow.json（路由/状态/标记契约）、10 个 .ai-workflow 模板、5 个固定 prompts、alidate_state.py（进程成功+必需工件+完成标记三重校验）。
- 注意：实施期间有并发会话同时编辑同一 skill 目录（config.json、test_v1_workflow.py 多次被对方改写），最终以 pytest 29 passed 收敛。Sol 网关键名存在 sol_enabled 与 sol_escalation_enabled 并存历史，文档/prompts 统一用 sol_escalation_enabled。


### 2026-08-29 Chiller Line 2：Heating.vi 的 Python 替代——现场架构勘察与真实适配器

- 项目：`\\100.74.196.22\d\Chiller Line 2`（现场机 `100.74.196.22` = `192.168.3.179` = `DESKTOP-47FN6P3`，Tailscale 名 `xiezhong-heating`；SSH 账号见本机 `C:\Users\Administrator\.codex\.codex-global-state.json`，凭据不写入本记忆）。
- 通信架构勘察结论（全部来自现场实读）：
  - NI OPC Servers 2016（Kepware 内核，server_runtime.exe）加载的工程是 `C:\ProgramData\National Instruments\NI OPC Servers\V2016\default.opf`。
  - `Channel1` = Mitsubishi FX 驱动（FX3U，烘干主 PLC）；`Channel4` = Modbus Ethernet → `<192.168.3.32>.0`，1-8温度 = 保持寄存器 40001-40008。
  - 四处反直觉映射（勿"修复"回直觉值）：**m105→M0205、m107→M0907、m108→M0908、正吹时间→T013**（T051 是未绑定的"反吹时间"，勿混淆）；报警→M0129。
  - UA 端点 `opc.tcp://127.0.0.1:49350`（仅本机回环）；运行时还监听 0.0.0.0:502（Modbus unsolicited 服务端模式）。
- 关键约束（实测）：
  - 192.168.3.32:502 只接受 1 个 Modbus TCP 会话，Kepware 常驻占用；Python 直连会握手成功但请求全部超时。
  - UA 客户端证书被无条件拒绝（无信任配置面，settings.ini 仅 EndPoint0-7）；asyncua 2.0.1 自签证书生成器有 bug（硬编码 BasicConstraints ca=True），需用 cryptography 自建终端实体证书并让客户端 application_uri 与证书 SAN 一致。
  - Kepware DA（COM）对所有身份（dell/SYSTEM）返回 CLASS_E_NOTLICENSED(0x80040112)——只有 NI 生态客户端（SVE/LabVIEW）能连。**生产等价通路 = SVE 共享变量**（DA 服务器 `National Instruments.Variable Engine.1`，需 LabVIEW 工程运行部署共享变量后命名空间才非空）。
  - 现场硬件状态：事件日志显示 Channel1（FX3U）not responding、M0205/M0907/M0908 写入失败（串口链路疑似断开）。
- 代码交付（已部署远程 `D:\Chiller Line 2\heating_python`，原版备份 `heating_python_backup_20260829`；本地+远程 unittest 104 全绿）：
  - `address_map.py`（已验证地址表）、`live_opc.py`（OpcUaAdapter，asyncua 同步门面+可注入传输层）、`live_modbus.py`（零依赖原始 Modbus/TCP，按操作短连接）、`cli.py` 新增只读 `probe` 子命令、`tools/field_probe_modbus.py` 与 `tools/field_probe_opcua.py`、`ADDRESS_MAP.md` 证据链文档。
  - 修掉的真 bug：Modbus MBAP 解析偏移（`>HHH` 6 字节却喂 7 字节 header）、FC03/FC01 数量交叉验证缺失、地址范围未校验、持久连接模式死代码、build_write_coil_request struct 格式错。
- 现场环境增补：远程 32 位 Python `C:\Users\dell\py311w32`（python-3.11.9-embed-win32 + pywin32/comtypes，为 OPCDAAuto COM 准备）；`SysWOW64\OPCDAAuto.dll` 已 regsvr32 注册（回滚：`regsvr32 /u` + 删除 64 位视图 surrogate 键）；UA 探测证书留在服务端 `RejectedCertificates`（1b3c/500caafb/c5e5 三个 .der，可删）。
- 下一步（等现场配合）：用户启动 LabVIEW 工程部署共享变量 → Python 经 SVE DA 影子读取全部标签（与 Heating.vi 同路同权）；维护窗口内做 m105(M0205)/D202(D0202) 写入验证；激光协议仍未知；结果库为 MySQL（DSN `mysql57` / 库 `test`，见 database.udl）。

### 2026-08-29 Chiller Line 2 补充：Kepware XML 导出对齐修正

- 用户提供 Kepware 项目 XML 导出（Simulation Driver Demo.xml），对 default.opf 二进制读数做出修正：
  - **正吹时间→T013**（此前误读为 T051；T051 是未绑定的"反吹时间"，两名仅一字之差，二进制里不可分）。
  - **数据类型**：D202/D212/D222 = **Float（32 位，raw Modbus 占 2 寄存器，字序需现场核对后再写）**；D225-D233 + 正吹时间 = Short；1-8温度 = Word；m 线圈 = Boolean。
  - Channel1 = **COM6 串口**，9600，7 数据位，Even，1 停止位，RTS Always（FX3U）；配置中另有 255.255.255.255:2101 Ethernet Encapsulation 字段，以 COM6 为准。
  - Channel4 `ZeroBasedAddressing=true`（与已实现的 0 基协议地址一致）。
  - 扫描枪1 通道：192.168.3.61，端口 **8889**（非 502），无标签；三个设备 Simulated=false，"Simulation" 文件名不代表模拟状态。
- 代码同步：address_map.py 新增 PLC_DATA_TYPES 并修正正吹时间映射；测试 105/105 全绿（本地 Python 3.10 + 远程 3.12）。
# 2026-09-01：OpenCode 桌面端白屏恢复

- 症状：OpenCode Desktop 1.18.25 进入“新建会话”后只显示空白页；渲染日志出现 `Failed to load sessions: Unexpected server error`。
- 根因：窗口恢复状态中保存了已断开的网络目录会话（`\\100.121.217.117\d\Test`、`\\100.74.196.22\d\Chiller Line 2`）；新版桌面端启动时对这些路径 `lstat` 失败，未能隔离异常，导致整个会话页无法加载。另有历史默认远程服务器 `http://100.117.1.6:4096` 返回 502，已移除该默认连接，改回本机 sidecar。
- 修复：备份并重置桌面端窗口/全局标签缓存；将 16 条指向上述断开目录的会话临时重定向至 `C:/Users/Administrator/Documents/Default Project`，以保留会话消息并避免启动失败。数据库备份在 `C:\Users\Administrator\.local\share\opencode\backups\20260901-1335-before-directory-repair`；桌面状态备份保留在 `C:\Users\Administrator\AppData\Roaming\ai.opencode.desktop\*.backup-20260901-*`。
- 验证：OpenCode 已重启，界面正常显示提示词输入框、Build 智能体和 GLM-5.3-Flash 选择器，渲染日志未再出现 session-load 错误。
### 2026-09-01 Clash TUN 致 Edge 打不开工行网站：DNS 劫持修复（Windows 本机）

- 现象：Edge 打开 www.icbc.com.cn / corporbank-simp.icbc.com.cn 报 ERR_CONNECTION_CLOSED，时好时坏；curl 直连/走代理均 HTTP 200 秒开。
- 环境：Windows + Clash Meta TUN 模式（"南美"客户端，内核 clash-windows-amd64）。配置 `C:\Program Files (x86)\南美\resources\static\clash\config.yaml`（写入需 UAC）；external-controller 127.0.0.1:8765（无 secret）；mixed-port 17890。
- 根因链：dns-hijack 仅 198.18.0.2:53 → 物理 DNS 查询未被劫持而泄漏，返回工行异常 AAAA（2a01:53c0:ffbf::31）→ Meta Tunnel 持有 IPv6 默认路由 ::/0 → gVisor TUN 本地模拟 TCP 握手"秒成功"，Edge 放弃 IPv4 回退 → Clash 送代理节点 → 工行风控掐断 → ERR_CONNECTION_CLOSED。"时好时坏" = 异常 AAAA 与节点状态波动。
- 修复三件套：① dns-hijack 改 any:53（核心；原配置备份 config.yaml.bak-dnshijack；PUT /configs?force=true 重载生效）；② netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 46 4（IPv4 优先，需 UAC）；③ WLAN 网卡禁用 ms_tcpip6 绑定。
- 关键教训：TUN 模式下系统代理例外列表（ProxyOverride）完全无效；浏览器"连接被关闭"≠ 对端真建立过连接（gVisor 假握手）；国内银行/政务站点必须直连，绝不能走代理节点。
- 诊断方法：nslookup 看解析是否 fake-ip(198.18.x) / 劫持 DNS(fdfe:dcba:9876::2)；Get-NetRoute 查 ::/0 归属；Edge 无头复现 msedge --headless=new --screenshot --virtual-time-budget=15000（错误页约 23953 字节）；--log-net-log 抓连接目标与 net_error（本例 -105/-348）。
- 坑：PS5.1 调 Clash API 传中文路径时 body 必须用 [Text.Encoding]::UTF8.GetBytes() 否则 400；无 BOM UTF-8 的 .ps1 含中文会被按 GBK 误读，提权脚本内容用纯 ASCII 或通配符绕开中文目录；HKCU\SOFTWARE\Policies 被 ACL 锁死无法写 Edge 策略。
- 维护提醒：客户端更新订阅/重置配置会覆盖 config.yaml，问题若复发先检查 dns-hijack 是否仍为 any:53。
- 同会话附：向日葵/UU远程剪贴板失效为常见问题——主因剪贴板同步开关未开、Clipboard User Service 异常、多远程软件/微信输入法抢占，重连远程+重启服务即可。
- 补充（同日后续）：主站修复后企业网银子域仍失败——其 AAAA 为电信真实记录 240e:604:204:900::5e（Chromium 内置解析器/Windows 多宿主并行查询采纳非空应答，any:53 劫持拦不住非 53 端口通道，Edge 策略 AsyncDns=0 也无效，已写入 HKLM Policies）。最终解法：① Set-DnsClientServerAddress WLAN DNS=198.18.0.2,223.5.5.5（切断电信应答源，立即生效，解析只剩 fake-ip）；② HKLM ...\Tcpip6\Parameters\DisabledComponents=0xFF（重启后系统级禁 AAAA，终极根治）。注意：WLAN DNS 已手动指向 Clash(198.18.0.2)，若日后卸载/长期关闭 Clash 需改回 DHCP 自动获取，否则无法解析域名。
