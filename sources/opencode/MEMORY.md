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

### 2026-09-02（Windows opencode-go/glm-5.3-flash）：共享 Memory GitHub 仓库建立

- 用户要求把当前账号全部 memory push 到 https://github.com/huaweixiong-debug/memory，并确立规则：以后所有 AI 账号对话都必须更新该共享 memory。
- 已完成初始同步（commit 4060628）：sources/current-codex/（完整镜像 ~/.codex/memories，含 rollout_summaries）、sources/claude-code/CLAUDE.md（新增）、sources/shared-unified/AGENTS-global.md 与 CODEX-shared-memory-instructions.md（新增）。推送前扫描确认无敏感凭据。
- 本机工作克隆固定为 C:\Users\Administrator\Documents\memory-share（已从 Temp 移出，避免被清理）。
- 强制更新规则已写入四处本地全局规则文件（~/.claude/CLAUDE.md 第八节、~/AGENTS.md 第九节、~/.codex/AGENTS.md、~/.config/opencode/AGENTS.md 新建）及仓库 README"更新规则"节：每次对话产生稳定结论/决策/偏好时 git pull --rebase 后 commit + push，格式 memory: <账号> <一句话主题>，不写密码/token/API key。
- 待办：其他 Codex/ChatGPT 账号下次会话时应拉取本仓库并遵守 README 中的更新规则。

### 2026-09-06（Windows opencode）：南美代理故障速修手册 + Codex 桌面版本机化

- 复发规律：南美客户端每次重启会把系统代理 ProxyEnable 重置为 0（本轮 9/6 晚即因此全断）；clash-windows-amd64 核心还会僵死——端口能 TCP 连通但完全不转发（请求 5 秒失败、所有节点测速超时），唯一解法是重启南美客户端让核心重拉。
- 节点按端口失效：9/6 实测 nanmei13.hainiu56251454.com (43.198.71.139) 上韩国17049/香港17044/越南17048/德国17054 完全不通，美国1(17050)/美国2(17051)/马来西亚(17047)/台湾1(17046)/菲律宾(17056)/新加坡(17057) 约 210ms 可用；法国(17055) 1.2s 慢。服务商已从 nanmei12 轮换到 nanmei13，晚高峰国际线路 TCP 握手可达 15s。切节点用 API：PUT http://127.0.0.1:8765/proxies/Pluto body {"name":"美国1"}（中文 body 必须 UTF8.GetBytes）。
- 速修三步：① Set-ItemProperty HKCU:...\Internet Settings ProxyEnable=1 + wininet InternetSetOption(39/37) 广播；② 节点测速 API /proxies/{name}/delay?timeout=5000 并切到快节点；③ 全断且测速全超时 → 重启南美客户端（D:\南美\南美.exe，config 在 Roaming\南美\config.yaml 可直接写，非 9/1 记录的 Program Files 路径）。
- Codex 桌面版已于 8/30 改为本机执行：~/.ssh/config 的 ubuntu-codex 块已注释（备份 config.bak-20260830），.codex-global-state.json 已清全部 ubuntu-codex 绑定（备份 .bak-20260830，含 selected-remote-host-id/auto-connect 等根级键）。远程 openaiserver(100.117.1.6)/lulian(100.82.136.106) 两台 Tailscale 机器当时同掉线（Y盘=Y:\协众 映射自 lulian）。恢复远程：去掉 ssh 注释并在应用里重选主机。
- 仍生效的修复：hosts 里 ws.chatgpt.com→104.18.39.21/172.64.148.235、ab.chatgpt.com→104.18.32.47/172.64.155.209（桌面版本地解析被 DNS 污染，浏览器无此问题因走代理解析）；用户级环境变量 HTTP_PROXY/HTTPS_PROXY=http://127.0.0.1:17890、NO_PROXY 含 100.64.0.0/10（git/npm 等走代理依赖它，git pull GitHub 必须先设 HTTPS_PROXY）。
- 浏览器坑：系统代理变更后已运行的 Edge 不会感知（启动加速后台驻留），需彻底结束 msedge.exe 重开；360 浏览器当时新启动所以正常。ws.chatgpt.com 在 Clash connections 里 destinationIP 显示污染 IP 是本地规则匹配解析，实际转发域名由节点远程解析，以 TLS 证书 CN 为准判断真假。
- 潜在隐患：9/1 条目把 WLAN DNS 手动指向 198.18.0.2（Clash DNS），当前 TUN 关闭仅系统代理模式，DNS 依赖 clash 进程存活；clash 一停 DNS 即瘫。若彻底弃用南美需把 WLAN DNS 改回 DHCP。

## 2026-09-11 - ���� DeepSeek V4.1 Flash ģ��
- opencode.json �� opencode.jsonc ������ deepseek provider��@ai-sdk/openai-compatible��baseURL https://api.deepseek.com/v1��apiKey �� env:DEEPSEEK_API_KEY��
- ģ�� ID��deepseek-v4.1-flash����Ϊ��ѡ�Ĭ�� model δ�Ķ�
- ע�⣺opencode.json �� "model" �ֶ�������δ����� provider opencode-go��opencode-go/deepseek-v4-flash��
- �����û������� DEEPSEEK_API_KEY ����ʹ��

- �������� Key ʵ�ʿ���ģ�� ID Ϊ deepseek-flash �� deepseek-v4-pro���� deepseek-v4.1-flash���������Ѹ�Ϊ deepseek-flash
- DEEPSEEK_API_KEY ����Ϊ�û���������������֤ API ��ͨ�ɹ�

- Ĭ�� model �� opencode-go/deepseek-v4-flash ��Ϊ deepseek/deepseek-flash��opencode.jsonc Ĭ����Ϊ glm-5.3-flash����OpenCode Go ����������Ȼָ����ֶ�ѡ��

- �޸�ģ���б�����ʾ���Զ��� provider ID "deepseek" �� opencode ���� deepseek provider ��ͻ�����ǣ�����Ϊ "deepseek-official"��ģ�� deepseek-flash ���ɳ����� DeepSeek Official �����£���Ĭ�� model ͬ������

## 2026-09-21 NAS mihomo 双订阅融合（西游云 + 南美）

- **NAS Docker mihomo（100.82.136.106）配置彻底重建**：合并两套订阅 73 个节点（西游云 47 + 南美 26，4 个重名节点南美侧加"南美-"前缀）
- 分组结构：`节点选择`（主入口，select）→ `西游云-自动选择` / `南美-自动选择` / `西游云` / `南美` / DIRECT；自动选择组只含真实节点（信息占位节点如"剩余流量：xx GB"被过滤，仅在手动组可见）
- 规则：沿用西游云 522 条规则，全部指向 `节点选择` 主入口
- **API 端口从 8765 改为 9090**：8765 被 NAS 上 `fio --server`（磁盘测试守护进程，开机自启）占用，mihomo 无法绑定。9090 未被占用
- **配置写入方法**：Synology SFTP 报 No such file（chroot 限制），改用 SSH `cat > 文件` stdin 管道写入（paramiko stdin.write + shutdown_write），MD5 校验一致
- **关键教训**：NAS config 是 bind mount（/volume1/docker/mihomo/config.yaml），`docker cp` 改不到；且禁止用 sed/PowerShell 管道处理中文配置（编码损坏导致解析失败）。正确做法：本地 Python utf-8 构建 → mihomo -t 本地校验 → stdin 管道上传
- 容器重启后配置生效；日志 `External controller listen error` 消失
- 切换验证全部通过：API PUT /proxies/{组}，两个提供商流量测试 github/opencode 200
- 切换助手脚本：`C:\Users\Administrator\mihomo\nas-switch.py`（status / list / nodes / use）
- 配置副本：`C:\Users\Administrator\mihomo\nas-merged-config.yaml`
- 状态（2026-09-21 晚）：主入口=西游云-自动选择，西游云自动选香港3｜高速，南美自动选香港；两路 github/opencode 均 200

### 2026-09-21 追加：自动选择限定德/日/韩（ChatGPT 不支持香港）

- 用户用途：ChatGPT、opencode、GitHub —— **香港节点不可用**（OpenAI 不支持 HK），只能用德国/日本/韩国
- 自动选择组重命名为 `西游云-德日韩` / `南美-德日韩`，各含 5 个节点：
  - 西游云：日本1｜高速、日本2｜高速、日本｜备份、韩国1｜高速、德国
  - 南美：日本、日本1、韩国、韩国1、南美-德国
- 两个死节点（新加坡｜直连、日本｜直连2，trojan b.1181181.xyz:2096 i/o timeout）已从所有组剔除
- 手动组 `西游云`/`南美` 中德/日/韩排最前，其余节点保留在下方备选
- 验证（2026-09-21）：西游云-德日韩（日本1｜高速）github/chatgpt/opencode 全 200；南美-德日韩（韩国1）github/opencode 200（chatgpt 403 为 curl 被 Cloudflare 拦截，非节点问题）
- 注意：chatgpt 对 curl 时而 200 时而 403，判断节点可用性以 github/opencode/浏览器实测为准
- 默认状态：节点选择 = 西游云-德日韩 → 自动选日本1｜高速

### 2026-09-21 追加：全节点×3网站矩阵实测结果

- 方法：mihomo `/proxies/{node}/delay` API 直测每节点（不切主线路），4 地址 × 2 次重试；校准发现 **mihomo 延迟测试把非 2xx（如 404）也计为成功**，故"有毫秒数"仅证明 HTTP 层可达，ChatGPT 区域封锁需另判
- 结果落盘：`C:\Users\Administrator\mihomo\node-matrix-20260921.md`（完整矩阵）+ Temp\node_matrix.json（原始数据）
- 德日韩 9 节点全通（西游云：日本1/日本2/韩国1/德国；南美：日本/日本1/韩国/韩国1/南美-德国）
- ChatGPT 往返最快：西游云 韩国1｜高速=846ms；南美 新加坡隧道=751ms、南美-德国=848ms、日本1=831ms
- 新增死节点 4 个（已从配置组剔除）：日本｜备份、台湾｜直连-家宽、哈萨克斯坦、伊拉克（此前已有 新加坡｜直连、日本｜直连2）
- 西游云-德日韩组已改为 4 节点（去掉死的日本｜备份）
- 重要认知：HK/俄罗斯节点对 ChatGPT 区域封锁（HTTP 可达但账号不可用）；除德日韩外，西游云 美国1｜AI通用、新加坡3|高速、台湾｜高速-家宽、法国、英国、意大利、土耳其、西班牙、印尼、菲律宾、沙特、墨西哥、智利、尼日利亚、阿塞拜疆 也三站全通（备选）
- 南美 新加坡隧道/台湾/台湾1/南美-马来西亚/马来西亚A/美国3/菲律宾一/南美-法国 等亦三站全通

### 2026-09-23 ChatGPT 桌面版（OpenAI.Codex MSIX）启动卡死根治 + 本地 clash 节点坑
- **卡死根因（两层叠加）**：① 应用启动时 sidebar 对项目列表逐个做 stat + git rev-parse，项目里有死网络路径（\\\\100.99.20.28、\\\\100.87.176.32、U:\\、W:\\、X:\\ 等），每个 60s 超时，30 个目录扫 187 秒，窗口全程未响应；② T:/Y: 等 SMB 映射僵尸会话（net use 显示 OK 但实际访问挂死），TCP 445 通也没用
- **修复**：删 .codex-global-state.json 的 electron-saved-workspace-roots + local-projects 死条目；删 state_5.sqlite 的 projects/project_roots/project_idempotency_keys 死行（threads 先置 project_id=NULL 保历史，实测死项目 0 线程）；
et use T:/Y:/Z:/P: /delete /y 后重建映射重置 SMB 会话。备份均在原文件旁 .bak-20260923
- **存储位置**：项目列表双存储 = C:\Users\Administrator\\.codex\\.codex-global-state.json（Electron 层）+ state_5.sqlite（app-server 层，只改一处会被另一处回填，projectCount 日志可验证）
- **本地 clash（南美）重大坑**：德国节点对 chatgpt.com 完全连接失败（000 超时），对 auth/api.openai.com 也曾 SSL 失败；日本/日本1/韩国/韩国1 全通。ChatGPT 卡死别只查路径，先 curl -x 127.0.0.1:17890 https://chatgpt.com 测当前节点。切换工具：python C:\Users\Administrator\\mihomo\\clash-api.py status|list|use|test（Pluto 组）
- **诊断技巧**：主进程 Responding 忙等翻转（True↔False）+ CPU 不涨 = 同步阻塞；应用日志在 %LOCALAPPDATA%\\Packages\\OpenAI.Codex_2p2nqsd0c76g0\\LocalCache\\Local\\Codex\\Logs\\2026\\MM\\DD\\，t0=主进程 t1=git worker；[git] timed_out=true 即网络路径挂死实锤
- 重启应用：explorer.exe shell:AppsFolder\\OpenAI.Codex_2p2nqsd0c76g0!App；statsig.openai.com / oai-sentry.openai.com 经代理 000（不阻塞使用）
- PowerShell 5.1 坑：python -c 多行代码会报 NullReferenceException，必须写脚本文件执行

### 2026-09-26 Langguo Agent Factory TASK-0002 修复第 3 轮（GitHub 只读导入接入 Orchestrator）
- 仓库 `Langguo-Agent-Factory`，分支 `feature/github-issue-intake`；OpenCode = Builder，工作区 UNC `\\100.117.1.6\projects\Langguo_AI\repos\Langguo-Agent-Factory`
- 阻塞缺陷（最终评审 attempt 2）：`github_intake._label_names` 用 `record.get("labels") is None` 把「字段缺失」与「显式 JSON null」混为一谈 → 混合响应可部分导入
- 修复：改为 `if "labels" not in record: return set()`，显式 null 落为「非 list → ValueError → malformed」，使整份响应对导入 all-or-nothing
- 新增 3 个离线回归：Eligibility 显式 null 分类、Import 混合响应双顺序零写入、daemon 层 `GITHUB_INTAKE_FAILED` 零 task/state
- 验证：`python -m unittest discover -s tests -v` → **70 tests OK**（67+3，纯离线 mock gh，无网络）
- 状态机：`.agent/state/TASK-0002.json` 置 `IMPLEMENTED / ZCODE`，attempt=3 保留；下一棒 ZCode QA，再 Codex Reviewer
- 未 push、未改 `P:\Langguo_AI` 活动配置、未动 TASK-0001 历史；`.agent/state` 为 gitignore 不提交
- 流程约定：Builder 完成即更新 `.agent/reports/{task}-IMPLEMENTATION.md` 并改状态到 IMPLEMENTED/ZCODE（见 orchestrator `builder_prompt`）

### 2026-09-27 Langguo Agent Factory TASK-0003 修复（子进程字节码隔离，attempt 1）
- 仓库 `Langguo-Agent-Factory`（UNC `\\100.117.1.6\projects\Langguo_AI\repos\Langguo-Agent-Factory`）；OpenCode = Builder
- 最终评审 REPAIR_REQUIRED（attempt 1，owner OPENCODE）：`tests/test_orchestrator_daemon.py` 子进程集成测试未隔离 Python 字节码——`child_env()` 继承环境、`run_child()` 以 REPO_ROOT 为 cwd，Orchestrator 导入 `github_intake` 会在仓库 `runtime/orchestrator/__pycache__` 写 .pyc，违反 SPEC AC4「文件写入仅限临时根」
- 修复：`child_env()` 设 `PYTHONDONTWRITEBYTECODE=1` + `PYTHONPYCACHEPREFIX=<tmp>/pycache`；新增 `child_command()` 用 `python -B`；`run_child()` cwd 改为临时根；新增 `ChildIsolationTests`（2 例）与 `repo_pyc_snapshot()` 前后快照断言
- 验证：`py_compile` OK；focused 14 tests OK；full `python -m unittest discover -s tests -v` → **84 tests OK**；前后对照演示：无守护子进程重建 `__pycache__`=True，守护后=False
- 状态机：`.agent/state/TASK-0003.json` → `IMPLEMENTED / ZCODE`，attempt=1 保留；下一棒 ZCode QA，再 Codex Reviewer
- 未 push、未动 `P:\Langguo_AI` 活动配置、未改 TASK-0001/0002 历史；`.agent/state` 属 gitignore 不提交

### 2026-09-27 Langguo Agent Factory TASK-0004 修复第 3 轮（QA 绑定到可发布 worktree 的执行证据）
- 仓库 `Langguo-Agent-Factory`，分支 `feature/github-issue-intake`（UNC `\\100.117.1.6\projects\Langguo_AI\repos\Langguo-Agent-Factory`）；OpenCode = Builder
- 最终评审 REPAIR_REQUIRED（attempt 3，owner OPENCODE）：交付启用时 `IMPLEMENTED/ZCODE` 只写 handoff + `WAIT_ZCODE`，不把 ZCode 派发进任务 worktree；`write_qa_attestation` 只写身份字段 + verified，无测试执行证据 → 无法证明 QA 真在 worktree 跑过
- 修复三块：① Orchestrator 新增 `qa_prompt()`+`run_zcode()`，`process_task` 在 `IMPLEMENTED/ZCODE` 且交付启用时把 QA worker 派发进 handoff 记录的 worktree（禁用时保持原 `WAIT_ZCODE` 共享检出等待），派发后 `verify_task_qa_binding` 必须通过；② 证据合约：attestation 必须含 `tested_worktree`、`report_path`（精确 `.agent/reports/<task>-TEST.md`）、`report_sha256`、非空 `commands`（每项 `{argv:[...], exit_code:0}`），`verify_qa_attestation` 重新哈希报告并逐字段校验，新增 `record_qa_evidence()` + CLI `--record-qa`（按 handoff 重算身份）；③ 新增 `docs/qa-worktree-attestation.md` 定义协议，集成测试 `test_qa_dispatch_routes_worker_to_worktree_and_gates_delivery` 经 `process_task` 派发假 QA、断言 worktree 路由与 work-order 身份、在 worktree 真跑子进程并记录证据，再验证 Reviewer 路由与交付路径集一致；另加无证据 fail-closed 与禁用保持 `WAIT_ZCODE` 两例
- 验证：`py_compile` OK；focused delivery 56 tests OK；full `python -m unittest discover -s tests -v` → **141 tests OK**（纯离线、mock gh）
- 状态机：`.agent/state/TASK-0004.json` → `IMPLEMENTED / ZCODE`，attempt=3 保留；下一棒 ZCode QA（须在 handoff 的 worktree 跑测试并把 argv/exit_code 写进报告与 attestation），再 Codex Reviewer
- 本地提交 `340616b fix: bind task QA to executed worktree evidence`（5 文件）；**未 push**、未建真实 PR、未 merge/deploy、未改 `P:\Langguo_AI` 活动配置；`.agent/state` 属 gitignore 不提交
- 并发提醒：本会话发现同一仓库有另一进程并发编辑（docs/README/implementation report 在会话中途出现），最终工作树与 HEAD 一致且 141 测试通过

### 2026-09-27 LG Industrial 成本工作簿完整度修正（OpenCode executor，fix1b 恢复会话）
- 目标源：`C:\Users\Administrator\Documents\Codex\2026-09-27-lg-industrial-phase1\cost-workbook\build-cost-tracker.mjs`；产物：`\\100.117.1.6\projects\Langguo_AI\company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\项目成本估算与实际记录.xlsx`（104,576B，空白模板）
- 关键引擎事实（@oai/artifact-tool v2.8.59 公式求值，务必记住）：`0=""` 为 True（数值 0 与空串相等）；`COUNTIF(range,">=0")` 会把空单元格计入；`ISBLANK(0)=False`；公式返回空串时 `.values` 得 `""`；未使用单元格为 `null`；SUMIFS 文本条件可作用于公式结果列。结论：数值完整性一律用 ISNUMBER，禁止用 `=""`/`<>""` 判断数值单元格
- 实现：BOM采购 P/Q、工时返工 R/S 行级状态（待补齐/已完整/待录实际/已录实际）；项目汇总 U/V（缺类别确认/待补齐/估算已确认；待录实际/部分已录/实际已录齐）；估算合计按类别完整性门控；实际合计仅汇总已录实际行并标注“累计已录”；偏差/偏差率仅估算与实际均完整后显示，估算为 0 时偏差率留空；确认零成本类别必须显式 0 行
- QA：7 个可弃置场景（完整值、缺估算单价、缺实际单价、待录实际、部分实际+完整行、显式 0、无明细）+ 三次清空校验；`node build-cost-tracker.mjs` 退出码 0；demo/clean/saved 三次公式错误扫描均 0 命中；openpyxl 3.1.5 独立复核 4 表名、公式、条件格式、数据验证通过；保存文件无 TEST- 残留
- 证据目录：`C:\Users\Administrator\.codex\opencode-executor\runs\20260927-cost-workbook-fix1b`（REVIEW_PACKET.md、builder.diff、build-run.log、formula-probe.*）；基线计划与旧工作簿备份在 `...\runs\20260927-cost-workbook-fix1`
- 注意：四个 `*-preview.png` 是带 TEST-901/902/903 演示状态行的渲染图（导出前已清空），另生成 4 张 `*-clean-preview.png` 证明空模板；产物 xlsx 公式无缓存值，Excel/WPS 打开时自动重算


### 2026-09-27 LG 成本工作簿 fix2：行状态必须依赖项目编号（reviewer FIX major）
- 问题：BOM/工时明细行数值齐全但项目编号 A 为空时，行状态误报 已完整/已录实际，但该行无法归属任何项目、无法计入合计
- 修复：BOM P/Q、工时 R/S 状态公式在行已开始且 A 为空时一律 待补齐；空行仍留空；有编号行保持原数值/显式 0 语义；项目级公式未改（无编号行本就不参与项目汇总）
- QA：新增 S8（BOM 估算/实际缺编号行）与 S9（工时估算/实际缺编号行），断言四个状态为 待补齐 且 G/J/K/L/M 合计公式留空；S1–S7 全部保留通过；`node build-cost-tracker.mjs` 退出码 0，demo/clean/saved 三次公式错误扫描 0 命中，保存文件无 TEST- 残留；openpyxl 复核门控存在于 P5/Q5/R5/S5
- 产物：同路径 xlsx 重生成（105,466B，SHA256 4f75385e…）；构建器 93dfdb17…；证据 runs\20260927-cost-workbook-fix2（REVIEW_PACKET.md、builder.diff、build-run.log、verify-openpyxl.log）

### 2026-09-27 lg-pilot-ateq TASK-1002 DEF-2 修复（Core 离线冒烟 flag 边界，attempt 2）
- 仓库 `lg-pilot-ateq-20260927`（UNC `\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-ateq-20260927`，`P:\Langguo_AI` 同源）；OpenCode = Builder
- 接单 REPAIR_REQUIRED（attempt 2，owner OPENCODE）；DEF-2：`--core-smoke-cycle --mode simulate` 下 `--ateq-test`（可对串口写程序号）与 `--preflight`（访问 PLC/ATEQ/MySQL/激光目录）分支先于 Core 派发执行，违反离线验收边界（AC4）
- 修复：`app/main.py:119-123` 新增 guard——Core smoke 与 `--ateq-test`/`--preflight` 组合立即 exit 2 并输出 `CORE_SMOKE_BLOCKED`，位于配置加载、ateq、preflight 分支之前；`--live-ui` 仍由既有 mode guard 拦截；composition 层 `CORE_OFFLINE_ONLY` 与 6 元组 `build_services()` 契约未动
- 测试：`tests/test_core_adapters.py` 新增 4 个 CLI 回归——ateq-test 哨兵（含 `--program`）、preflight 哨兵、双 flag 组合、SIMULATE 正例（exit 0 `CORE SIMULATE OK` 且 preflight 哨兵零调用）；focused **26 passed**，full **90 passed**（首次运行，无 WinError 5 复现）
- CLI 手测：valid 0；`--ateq-test --program 2` → 2；`--preflight` → 2；`--mode live --config config/live.toml` → 2（DEF-1 守护保持）
- 状态：`.agent/state/TASK-1002.json` → `IMPLEMENTED / ZCODE`，attempt=2；报告 `.agent/reports/TASK-1002-IMPLEMENTATION.md`；下一棒 ZCode QA → Codex Reviewer
- 离线边界：未开物理 ATEQ/PLC/激光/数据库/网络；项目非 git 仓库，未 push、未部署；除实现文件、报告与 state 两字段外未改其他内容


### 2026-09-27 西游云全灭定性 + 魔戒灾备接入 NAS mihomo（主力仍=南美越南1）
- 西游云订阅整体失效（1/44 可用）：全组共用域名 hao1.11151115.xyz 被针对性阻断——国内直连全端口(933/11027/20793/26297/41224)不通、经海外节点可达（服务端活着）、DNS 轮换 IP 16.106.12.118↔18.182.51.250 新旧均被拦；判定服务商侧/墙，NAS 无责，西游组弃用
- 教训：单域名承载全组=一墙全灭；delay 探测并发/晚高峰易假阴性（曾 0/44 与真流量 200 并存），可用性定论必须真流量状态码验证（chatgpt cdn-cgi/trace=200 且 api.openai.com/v1/models=401 为可用；403=被拦；44 覆盖网页+API 两个维度）
- 魔戒（按量不限时）接入：官网 mojie.uk 国内可直连（mojie.com/mojie.cfd 被墙）、现价 ¥19.9/130G（博客旧价 14.9 已过期）、测试档 ¥1/1G 不可续费；NAS mihomo 已配 proxy-provider(mojie, interval 86400)——订阅 URL 用 clash.meta 类 UA 才返回 Clash YAML（mihomo 下载 UA 恰为 clash.meta/…，返回 base64 则 provider 解析失败）+ exclude-filter 滤掉香港节点与"剩余流量/套餐到期/过滤掉"信息行
- 新组网：「魔戒-灾备」(url-test use mojie, 21 节点) ；「AI自动」fallback=OpenAI>南美>魔戒-灾备(interval 120)；5 条 OpenAI 域名规则(chatgpt/openai/oaistatic/oaiusercontent/livekit.cloud)→AI自动；MATCH,南美 不变
- 验证：主链路 chatgpt=200/api=401；魔戒真流量（临时把 openai.com 规则指魔戒）api=401（新加坡-优化2-GPT）通过后已恢复
- 备份：NAS config.yaml.bak-mojie-* / bak-wire-* / bak-t-* / bak-restore-*；南美订阅 10-07 到期（西游不续，魔戒作灾备）
### 2026-09-27 lg-industrial-core 发布 preflight（OpenCode executor，PR #1 draft）

- 仓库/分支：`huaweixiong-debug/lg-industrial-core`，PR #1（draft/open），branch `codex/lg-core-rename-foundation`；OpenCode 会话 `ses_f1c75548dffe3RelD1U2j6bP9X`
- 目标：给现有 Release workflow 加可验证、不发布的人工/PR rehearsal，同时保留严格的 tag-only GitHub Release 路径；仅允许改 `.github/workflows/release.yml` 与 `README.md`
- 实现：`release.yml` 拆为 `ci`（复用 ci.yml）→ `package`（构建 wheel/sdist、tag 守卫、`dist` artifact 7 天保留）→ `publish`（仅 `push` 且 `refs/tags/v*`，`contents: write` 只在此 job）；workflow 级与 package job 均为 `contents: read`；触发新增 `pull_request: [main]` 和 `workflow_dispatch`；守卫用 bash heredoc + Python zipfile 读取唯一 wheel 的 `.dist-info/METADATA` 的 `Version`，要求 `tag == "v"+Version`，缺失/多个 wheel、缺 METADATA、缺 Version、不匹配均 fail-closed；README 新增 `## Release process` 说明三触发、rehearsal 不发布、artifact、写权限范围、守卫、推 tag 即发布 Release
- 本地验证：PyYAML 结构 + 守卫 fixture 35/35 PASS（证据 local-verification.txt）；真实 wheel（临时副本 pip wheel，lg_industrial_core-0.1.0）跑工作流自带守卫 `v0.1.0`=exit 0、`v0.1.1`=exit 1；`git diff --check` exit 0
- 推送/托管：commit `9f400ff` 推送至 PR 分支；PR 触发 Release run 36331055663 `success`（ci 3.10/3.11/3.12 + Package preflight pass，Publish skipped，artifact `dist` 22,165B）；手动 workflow_dispatch run 36331152276 `success` 同样跳过 publish；`gh release list` 空、`git ls-remote --tags` 空、PR 仍 draft/open——未建 tag/release、未 merge/deploy
- 证据目录：`C:\Users\Administrator\.codex\opencode-executor\runs\20260927-lg-core-release-preflight`（REVIEW_PACKET.md、implementation.diff、session.txt、hosted-* 证据）
- 待办：plan 步骤 5/6 的 GPT-6 Luna high 中间评审与 max 终审由 Codex orchestrator 执行（不在 OpenCode 会话内）

### 2026-09-28 lg-industrial-core P: 源镜像与试点证据对齐（OpenCode executor）
- 目标仓库 `C:\Users\Administrator\Documents\Codex\2026-09-27-lg-industrial-phase1\lg-industrial-core`（branch `codex/lg-core-rename-foundation`，基线 `9f400ff5`）；P: 镜像 `P:\Langguo_AI\repos\lg-industrial-core`（无 .git）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260928-lg-core-mirror-doc-alignment`
- 镜像同步：`src/lg_industrial_core/events.py`、`recording.py` 原字节已备份到证据目录 `before-mirror\`（SHA256 `f4ef57…`/`e801d2…`，2909/12073B）；执行器在会话开始前已预同步（备份时间 00:51:36），本会话按计划再复制一次（幂等）；同步后 `git hash-object` == `HEAD:` blob `6bf8094e…`/`8fcf2bc…`，raw SHA256 == 规范检出文件
- 验证（统一 PYTHONPATH=镜像 `src`，Python 3.10.11，`PYTHONDONTWRITEBYTECODE=1`，导入路径经 `-c` 打印确认命中镜像而非 site-packages 副本）：Core 单测 69 passed；兼容性 `PASS Morocco` + `PASS ATEQ-F620-Laser`（用镜像内工具副本跑，保证 checker 解析到镜像 src）；Morocco 全量 166 passed / 2 failed（已知基线：缺打包 `LeakTest2Channels.exe`、中文 UI 独立字母 `M`）；ATEQ 全量 90 passed
- 文档（仅授权改这两份）：`README.md` 两处措辞改为区分离线试点副本与公共/上游产品仓库（后者未改、不依赖、无发布/生产批准）；`docs/pilot-compatibility.md` 新增 2026-09-28 复验章节（修订号、试点 ID、命令/结果表、两项已知失败、离线限制），并标注首轮旧计数已被取代
- 审计：新增 `audit-records\TASK-1001-morocco-revalidation-audit.md` 与 `TASK-1002-ateq-revalidation-audit.md`（实际命令、修订/路径、结果、已知失败、试点原始产物哈希与保全声明）；未改试点 `.agent` 任何文件与状态（全部 mtime 早于会话开始；TASK-1002.md 哈希与既有评审记录一致）
- 边界：无硬件/客户数据库/网络/部署/tag/发布/合并；未 push、未动 PR；PR 更新留给双评审通过后由 Codex 执行。遗留：镜像的 README/release.yml/tests 仍较旧——计划仅授权同步两个 src 文件，已在 packet 中标注为超出范围
