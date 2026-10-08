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

### 2026-09-28 Morocco 试点：Core 串口录制/回放集成测试（OpenCode executor）
- 目标仓库（非 git）`\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-morocco-20260927`；Core 只读注入 `C:\Users\Administrator\Documents\Codex\2026-09-27-lg-industrial-phase1\lg-industrial-core\src`（经 PYTHONPATH，导入路径已确认命中该 src 而非 site-packages）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260928-morocco-serial-replay-integration`
- 新增唯一文件 `tests/test_core_serial_recording.py`（131 行，SHA256 `5c8816b1…`）：真实 `app.ateq.SerialAteq` 用 Core `RecordingSerialFactory` + 内存假串口记录一条 `read_registers(0x0030, 13)` 事务（13 个合成寄存器，独立 CRC-16 参考实现生成合法 Modbus RTU 帧，经 pilot 自身 CRC 校验交叉验证），再用 `ReplaySerialFactory` 注入第二个 SerialAteq 回放；断言寄存器/原始帧逐字节一致、transcript JSONL 单行字段正确、`consumed=1 / remaining=0 / exhausted` 且再次读取抛 `SerialTranscriptExhausted`
- 验证（Python 3.10.11，同一 PYTHONPATH）：计划命令 `pytest -q tests/test_core_serial_recording.py` → 1 passed（exit 0）；既有 focused Core adapter 套件 `tests/test_core_adapter.py` → 44 passed（exit 0；改前基线同为 44 passed）
- 边界合规：未改应用源码/其他文件；未开 COM/硬件/网络/数据库；非 git 未 push；运行仅刷新 `.pytest_cache` 与 `__pycache__` 非源码产物；REVIEW_PACKET.md 内嵌 diff 已用脚本与目标文件逐行比对一致
- 遗留：无；审查焦点（CRC 独立性、假串口表面贴合度、异常透传、范围保证）已写入 packet §8


### 2026-09-28 lg-industrial-core stage 仓库对账（OpenCode executor）
- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-industrial-core-stage-20260928`（分支 `codex/lg-industrial-core-reconcile-20260928`，基线 `be0ab16f`）；只读快照 `P:\Langguo_AI\repos\lg-industrial-core`；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\lg-core-20260928-081401`（REVIEW_PACKET.md 2401 行，含完整 26 文件 diff）
- 变更：21 个文件从快照字节级复制（SHA-256 全部一致）；删除 `src/xz_core`（5 文件）；新增 `src/lg_industrial_core`（含 recording.py）、`tests/test_recording.py`、`template/**`、`.github/workflows/{ci,release}.yml`；`.gitignore` 无需改（已覆盖生成物）
- 文档修正：`docs/pilot-compatibility.md` 重写（日期 2026-09-28；明确改名非 name-only——同时引入 JSONL record/replay/compare 与 SIMULATE-first 模板；旧提交 pin 与旧套件数字删除；证据按当前 staging 路径+日期固定并写明非全周期/非生产结论）；README 证据指针同步
- CI/发布：ci.yml 覆盖 Python 3.10–3.12 且 `workflow_call`；release.yml 由 `v*` tag 触发，release job `needs: ci`；本会话未创建 tag/release/合并/push，改动留工作区待 QA
- 验证（隔离 Python 3.10.11 venv，`C:\Users\Administrator\AppData\Local\Temp\opencode\lg-core-venv310`）：core tests 50 passed；template 5 passed；`python -m build` 成功（wheel sha256 e0e3fce8…，sdist 8314d3fa…）；wheel 临时目录安装后 `import lg_industrial_core` OK、`import xz_core` ModuleNotFoundError；offline checker 对 `lg-pilot-morocco-20260927` 与 `lg-pilot-ateq-20260927` 均 PASS（ATEQ/PLC/repository/journal + label/mark adapter）
- 试点保全：前后 manifest（路径+大小+mtime）完全一致；无硬件/数据库/网络副作用；生成物 build/dist/egg-info/cache 已在验证后清理
- 遗留（未决）：当前 Morocco staging 的 `tests/test_core_serial_recording.py` 期望更新版 Core API（SERIAL_TRANSCRIPT_SCHEMA_VERSION / RecordingSerialFactory / ReplaySerialFactory / SerialTranscriptExhausted），不在本快照内——该 staging 超前于本快照；完整试点套件本轮未重跑（计划仅要求 checker）；等待 ZCode QA + Codex 终审后再由 orchestrator 推送/PR




### 2026-09-28 lg-industrial-core 串口字节转录补齐（OpenCode executor，follow-up）
- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-industrial-core-stage-20260928`（分支 `codex/lg-industrial-core-reconcile-20260928`，基线 `be0ab16f`）；只读源项目 `C:\Users\Administrator\Documents\Codex\2026-09-27-lg-industrial-phase1\lg-industrial-core` 修订 `eea4d2087f630f46a18541ec2aafb8362eff56ed`；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\lg-core-serial-20260928-084652`（REVIEW_PACKET.md 3996 行，含自 be0ab16 的完整 28 文件 diff）
- 补齐内容：从源修订复制 `src/lg_industrial_core/serial_recording.py`（529 行）、`tests/test_serial_recording.py`（793 行）、`__init__.py` 串口导出（8 个）、`release.yml` 发布预检（tag/version 守卫）与 README 串口章节；同时更新 `tests/test_core_primitives.py`/`tests/test_recording.py` 到源修订版；保留首轮全部有效改动
- 文档：README 明确区分通用 JSONL 事件录制与串口字节转录，写明 synthetic-only 边界；`docs/pilot-compatibility.md` 重写为本次目标检出+两个试点副本的新证据（不再引用旧修订/旧计数）
- 验证（隔离 Python 3.10.11 venv）：core 129 passed（含串口测试）；template 5 passed；build wheel/sdist 成功（wheel sha256 dea061eb…）；wheel 临时目录安装后串口导出齐全、`import xz_core` ModuleNotFoundError；checker `PASS Morocco` + `PASS ATEQ-F620-Laser`；两个试点各自 `tests/test_core_serial_recording.py` 在 PYTHONPATH 目标 src 优先下均 1 passed（导入路径已确认命中目标 src）
- 保全：试点副本与源项目 before/after manifest（路径+大小+mtime）一致；合成内存串口，无 COM/硬件/网络/数据库；生成物已清理；工作区未提交
- 遗留：完整试点套件本轮未重跑（只跑计划要求的 checker+串口测试）；等待 ZCode QA + Codex 终审后再推送/PR

### 2026-09-28 lg-industrial-core 公共身份契约 is_bound_to（OpenCode executor）
- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-industrial-core-stage-20260928`（分支 codex/lg-industrial-core-reconcile-20260928）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260928-lg-core-target-identity`（REVIEW_PACKET.md）
- 变更仅 2 文件、纯新增 39 行：`src/lg_industrial_core/adapters.py` 新增 `ProductRepositoryAdapter.is_bound_to(target)->bool`，仅以 `is` 比较私有 `_target`（身份而非相等），docstring 声明为受支持的身份检查；`tests/test_core_primitives.py` 新增 2 测试（相同/不同目标；相等但不同一目标，验证 fail-closed，且断言不触发完成方法）
- 验证（Python 3.10.11，PYTHONPATH 前置仓库 src+template，导入解析命中仓库 src 而非 site-packages 陈旧 0.1.0 构建）：focused `tests/test_core_primitives.py` 28 passed；全量 `tests template/tests` 136 passed（含模板测试），均 exit 0
- 边界：未改其他文件；`.agent/` 既有未跟踪状态保持不动；无硬件/数据库/LIVE/发布/合并/ATEQ/Morocco 改动；工作区未提交
- 经验：UNC 工作区 PowerShell 中 `\Microsoft.PowerShell.Core\FileSystem::\\100.117.1.6\projects\Langguo_AI\repos\lg-industrial-core-stage-20260928` 含 provider 前缀 `Microsoft.PowerShell.Core\FileSystem::` 会使 PYTHONPATH 失效，须用 `(Get-Location).ProviderPath`
- 遗留：无功能遗留；Morocco 试点改用该公共接口属后续独立交接

### 2026-09-28 Morocco 试点改用 Core 公共身份契约 is_bound_to（OpenCode executor，is_bound_to 交接）
- 目标仓库（非 git）`\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-morocco-20260927`；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260928-lg-morocco-public-api`（REVIEW_PACKET.md + verification.log；基线两份备份在 `...\baseline\`）
- 变更仅两文件：`python_app/app/core_adapter.py`（`CoreRepositoryPort` 增加 `is_bound_to(target)->bool`；`CoreRepositoryBridge.__init__` 改为 `getattr(core_adapter,"is_bound_to",None)` 存在+可调用+返回真 才通过，否则 `PermissionError`；不再读 `_target`）；`python_app/tests/test_core_adapter.py`（`_RecordingCoreAdapter` 删除 `_target` 镜像，新增 `is_bound_to` 委派给 `self.inner`；新增 focused `test_core_repository_bridge_rejects_adapter_without_public_identity_api`；保留 mismatched-target 测试）
- 验证（Python 3.10.11，`PYTHONPATH=P:\Langguo_AI\repos\lg-industrial-core-stage-20260928\src`，`lg_industrial_core.__file__` 确认命中 staged src 而非 site-packages）：focused `tests/test_core_adapter.py` 15 passed（基线 14）；全量 `pytest tests -q -p no:cacheprovider` 109 passed（基线 108），均 exit 0
- 边界合规：未改 Core 源/`.agent/`/ATEQ/硬件/生产 DB/LIVE；未动普通 service 构造或离线 builder；非 git 未 push；SIMULATE/Fake/capability/exact-type 门控与委派行为不变
- 备注：两文件中唯一 `_target` 子串现仅出现在保留测试的函数名 `..._mismatched_adapter_target`（非属性访问）；若 `is_bound_to` 抛异常会原样透传而非转 `PermissionError`，已列入 packet §8 审查焦点

### 2026-09-28 ATEQ 试点全周期合成串口录制/回放（OpenCode executor）
- 目标仓库（非 git）`\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-ateq-20260927`（`P:\Langguo_AI` 同源）；Core 只读注入 staged `P:\Langguo_AI\repos\lg-industrial-core-stage-20260928\src`（PYTHONPATH）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260928-ateq-full-cycle-replay`
- 唯一变更文件 `tests/test_core_serial_recording.py`（3917→9093B，sha256 `681326a9…`→`f3a41d03…`；+136/−7）：新增 `test_serial_ateq_records_and_replays_full_cycle`——四个合成 CRC 帧（StepCode 4/5/6/65525，终帧 status=0x0001 OK）驱动真实 `SerialAteq.run()`（恰好 4 次 0x0030/13 轮询），经 `RecordingSerialFactory` 写入同一 JSONL，再 `ReplaySerialFactory` 回放；断言 AteqResponse/Measurement 相等（pressure 84.0 kPa 取 StepCode=6 快照、leakage 0.025 mL/min 取终帧、Result.OK）、recorded/consumed=4、请求帧地址数量与四帧逐行存在、耗尽后再 run 抛 `SerialTranscriptExhausted`；`_MemorySerial` 扩展为帧队列（单帧 bytes 构造兼容），既有单读测试函数体未动
- 验证（Python 3.10.11 + staged Core src）：目标 `pytest -q tests/test_core_serial_recording.py` → **2 passed**（exit 0）；全量 `pytest -q` → **92 passed**（exit 0）；补充 collect-only 证明新测试真实收集；证据 `verification-{targeted,full,collect}.txt`、`session-diff.patch`、`REVIEW_PACKET.md`
- 边界：未改生产代码/Core/配置/其他文件；纯内存假串口，无 COM/硬件/网络/数据库；非 git 未 push；pytest 仅刷新 `tests/__pycache__` 缓存产物；合成帧在 docstring/注释中明确标注非现场证据
- 待办：plan 的 Review 段（ZCode CLI GLM-5.3-Flash 只读评审）由 executor 流程后置执行，本会话未跑

### 2026-09-28 Morocco README_CN 打包预检章节中文澄清（OpenCode executor，utf8 复核）
- 目标仓库（非 git）`\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-morocco-20260927`；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260928-morocco-readme-zh-clarification-utf8`（REVIEW_PACKET.md、encoding_verification.txt、diff_lines.txt、README_CN.md.baseline/final）
- 变更（由并行 `...-direct` 流水线于 19:15:37 落盘，本 utf8 会话只验证、未改写）：`README_CN.md` 第 19 行——"校验嵌套 exe、…与源文件逐字节一致" 改为 "检查嵌套 exe 存在且非空，校验 config/default.toml、config/points.toml 与各自源文件逐字节一致"；基线 sha256 `d700b5ab…`（1633B）→ `ef78cb08…`（1662B），24 行仅此行不同（LF）
- 验证：严格 UTF-8 解码通过、无 BOM/无 U+FFFD；与并行 final 快照逐字节相等；修正措辞与 `python_app/tools/package_preflight.py` 实现一致（exe：`is_file`+`st_size==0` 判空 @226-229；TOML：`files_identical` 大小+SHA256 @189-195/245-248，各自源文件映射 @31-32；ICU 门禁 @535-539；OpenSSL 来源 @541-581；`PREFLIGHT_PASS` 仅全过 @602-620）
- 经验：本机 PowerShell 宿主缺 `Get-FileHash`/`Format-Hex`，用 `certutil -hashfile` + .NET/Python 替代；同一文件出现并行 executor 运行时（-clarification/-direct/-utf8 三个 run 目录），后启动方应核对 hash 后只做验证、不重复写入
- 边界：未跑构建/预检/pytest；未动英文 README、代码、package、Git；非 git 未 push

### 2026-09-28 南美第二晚整组故障 + 自动故障转移实战验证（魔戒兜底成功）
- 9/28 晚：南美入口 hainiu56251454.com→dismt.zziot.life→123.253.227.51 全端口拒连（服务商侧，非DNS污染：Windows直连也被拒；日志 connection refused）→ NAS 南美20节点全灭、MATCH/节点选择路径 502
- 「AI自动」fallback 实战生效：OpenAI组(南美)死→南美死→自动落到魔戒-灾备（日本节点），chatgpt 实测 200×3 稳定（0.5-4s）；魔戒按量卡价值验证
- 西游域 hao1.11151115.xyz 仍存活但 IP 高频轮换（16.106.12.118→18.182.51.250→129.146.172.74），部分节点可连（日本1｜高速2310ms/韩国1｜高速2278ms/香港2｜高速446ms）；本机 Clash 混装西游(42 anytls)+南美(26)，一直用西游英国节点所以本地无感
- 修复动作：节点选择组 南美-德日韩(死)→西游云；西游云选中→日本1｜高速；一般流量恢复 204。AI 路径维持魔戒（南美恢复前不切回）
- 早前一次断连诱因：OpenAI组被切到「土耳其」节点（TR 非 OpenAI 支持地区），已切回新加坡隧道→后南美死自动转魔戒
- 结论：fallback 链路设计经受实战；南美（10-07到期）不建议续；西游=轮换IP不稳定；魔戒=当前最可靠兜底

### 2026-09-28 ZCode 独立评审状态纠正（OpenCode executor，文档-only）
- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-industrial-core-stage-20260928`（branch `codex/lg-industrial-core-reconcile-20260928`，基线 HEAD `8f2a0c2`）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260928-lg-zcode-cli-review-status`（plan.md + REVIEW_PACKET.md）
- 唯一变更：`docs/pilot-compatibility.md` 的 `## Independent review state`（+5/−1）。纠正要点：①ZCode Desktop（GLM-5.3-Flash，reasoning `max`，BigModel OAuth）已于 2026-09-28 完成独立评审，范围 Core 源码 `8cf4aa0` + Morocco bridge，结论 PASS、无新代码缺陷，展示 Morocco 测试后撤回初始缺测疑虑；该评审未跑测试/未改文件/未评审后续文档-only 提交/未批准 merge/release。②CLI 0.16.9 无 `--model`，fresh headless（含 `--surface desktop`）与 resumed OAuth/max session 均在推理前失败：`Model creation failed`、cause `Select a model before continuing`；Desktop 默认 `account:bigmodel-start-plan/GLM-5.3-Flash`/max，属模型选择/运行时问题，明确不建议改用 API-key provider；未使用任何 API-key/token，CLI 无评审结论；物理设备/生产 DB/merge/release 边界保留
- 验证：`git diff --check` exit 0（仅 LF→CRLF advisory，非空白错误）；`git status --short` 仅 ` M docs/pilot-compatibility.md` + 既有未跟踪 `.agent/`；按 plan 未跑测试；未动 PR/branch/config
- 经验：memory-share 出现与 origin 完全相同的未跟踪并行产物 `sources/current-codex/2026-09-28-lg-final-core-acceptance-model-routing.md`（blob `bbbb3de9…`），核对一致后删除本地副本再 pull；本机 PowerShell 无 `Get-FileHash`，比对文件用 `git hash-object` vs `git rev-parse origin/main:<path>` 更可靠

### 2026-09-29 ATEQ LIVE UI preflight 绑定 + FIX-1 完整报告校验（OpenCode executor）

- 目标仓库（非 git）`\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-ateq-20260927`；两个证据目录：实现会话 `C:\Users\Administrator\.codex\opencode-executor\runs\20260929-ateq-live-ui-preflight-binding-202022`（原始 baseline 7 文件 + REVIEW_PACKET），FIX-1 会话 `C:\Users\Administrator\.codex\opencode-executor\runs\20260929-ateq-preflight-report-fix1-204651`（baseline_fix1 快照 + 会话/累计双 diff + REVIEW_PACKET）
- 实现（7 文件 allowlist）：`app/composition.py` 新增共享 LIVE 门 `require_live_preconditions`（mode→preflight→ports_confirmed/points_confirmed→load_points→拒绝 sim），`build_services` 六元组与 SIMULATE/SHADOW 分支不变；`app/main.py` 保留 run_preflight 报告并随已加载 Settings 传入 `launch_ui`（仅 --live-ui）；`app/ui_replica.py` 的 `MainWindow(live=True)` 要求精确 Settings 实例 + 通过报告，LIVE 路径不再 `Settings.from_toml` 重读 config；`app/ui.py` 透传两个新参数
- FIX-1 根因：`PreflightReport(())` 的 `passed == all(()) == True`，空报告能过 UI 门并到达 SerialAteq 构造。修复：`composition.expected_live_preflight_checks(settings)` 给出默认 run_preflight 路由的完整 7 项（PLC 点位表/PLC/PLC 点位读回/ATEQ <station>/激光打码目录/日期/型号配置/MySQL），`require_complete_live_preflight_report` 在 MainWindow 中对 缺失/空/不完整/重复/额外/他站/失败 报告一律 `LIVE_BLOCKED`，且调用先于共享门与所有 LIVE 资源构造
- 验证（Python 3.10.11；PYTHONPATH=staged `lg-industrial-core-stage-20260928\src`）：focused 3 文件 40 passed（exit 0，日志 `focused_tests.log`）；全量 `pytest -q` 126 passed（exit 0，日志 `full_suite.log`）；FIX-1 会话 diff 仅 5 文件（main.py/ui.py 与 pre-edit 快照逐字节一致，diff exit 0）；累计 diff 对原始 baseline：composition +86/-10、main +10/-4、ui +11/-2、ui_replica +31/-5、3 个测试 +147/+72/+168
- 关键经验：检查集合类报告（`all([])==True`）必须做完整性/重复/集合相等校验，不能用 truthiness 或 `.passed` 放行；无 git 项目用 `git diff --no-index` 对 baseline（exit 1 = 有差异，exit 0 = 相同）；PowerShell 拼 Markdown 时数组字面量里 `'```' + 'diff'` 会被逗号拆分，先赋值再入数组
- 边界：未启动 LIVE、未接触硬件/DB/凭据/生产文件/网络；测试全为离线 mock/bomb；未动任务状态、凭据、部署、live 配置或 staged Core；未在 LIVE 模式运行 app/main.py

### 2026-09-29 本机 GitHub 登录不上 -> 本机Clash github精准直连修复
- 根因：浏览器走系统代理 127.0.0.1:17890 -> 本地mihomo规则 DOMAIN-KEYWORD,github->节点选择->西游云，西游系节点IP高频轮换期间歇秒断（000/3s），登录页+assets加载失败；直连本身可达（200 x 9/9）
- 修复：C:\Users\Public\nanmei\config.yaml 插入3条 DOMAIN github.com / api.github.com / github.githubassets.com -> DIRECT（githubusercontent及其余github资源留代理防raw被墙），API热重载 PUT /configs?force=true，body必须 --data-binary @file 传递（PS5.1直接传JSON会被引号转义弄坏报 Body invalid）
- 验证：代理路径 login 4/4=200、api=200、git ls-remote正常、chatgpt 200未受影响；备份 config.yaml.bak-github-direct-20260929-223700
- 遗留：google/youtube/gstatic 仍走 节点选择->西游（不稳）；本地AI自动=OpenAI->菲律宾一（南美死）但chatgpt实测200；如github直连被墙删3条规则重载即回代理

### 2026-09-30 lg-industrial-core 数值比较精度/溢出修复（OpenCode executor）

- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-industrial-core-stage-20260928`（branch `codex/lg-industrial-core-reconcile-20260928`，基线 HEAD `a5617740`）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260930-core-numeric-comparison`（plan.md + REVIEW_PACKET.md）
- 根因：`recording.py::_deep_compare` 数值分支用 `abs(float(a)-float(b)) > tol`。① 两个 int 先转 float，`2**54+1` 与 `2**54+2` 都塌缩为同一 float，零容差下被误判相等；② 超 float 范围的巨大 int（如 `10**400`）转换抛 `OverflowError`
- 修复（仅 `src/lg_industrial_core/recording.py`）：新增 `_numbers_exceed_tolerance(a,b,tol)`；int/int 走精确 `abs(a-b) > tol`；float/float 保持原式；int/float 混合仍用原 float 语义，仅在 `OverflowError` 时退回 `fractions.Fraction` 精确有理比较。bool 分支与 mismatch 结构不变
- 测试：`tests/test_recording.py` 新增 5 个回归测试（2**54 相邻整数、容差收纳、10**400 相等/相邻、10**400 vs 1.0），基线复现 5 failed（含 OverflowError），修复后全绿
- 验证：Python 3.10（CI 版本，pytest 9.1.1）`PYTHONPATH=src` 下 focused `tests/test_recording.py` 48 passed、Core `pytest -q tests` 137 passed；Python 3.14 focused 48 passed。注意：plan 写的项目根 `pytest -q` 会收集 `template/tests/test_template.py` 报 `No module named 'app'`，该失败在基线即存在且与本次无关；CI 实际是根 `pytest -q tests/` + template 目录内单独跑
- 经验：本机默认 `python`（miniconda）无 pytest，须显式用 `C:\Program Files\Python310\python.exe`/`C:\Python314\python.exe`；`2**53` ULP=2，验证精度塌缩要用 `2**54`（ULP=4）才可靠
- 边界：仅离线单测改动，未触碰硬件/DB/网络/打包/发布/GitHub；保留用户既有改动 `docs/pilot-compatibility.md`(M) 与未跟踪 `.agent/`；未 commit/push，未改 PR 状态

### 2026-09-30 同上 FIX-1 轮（OpenCode executor，Terra + Codex 追加发现）

- 证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20260930-core-numeric-comparison-fix1`（plan.md + fix.md + REVIEW_PACKET.md）；同一工作树、两文件、未 commit
- Terra 问题（major）：中间版 helper 的 OverflowError 兜底无条件 `Fraction(other_value)`，混合 int 与 `+inf/-inf` 抛 OverflowError，与 `NaN` 抛 ValueError → 巨大 int vs 非有限 float 不安全
- Codex 追加：混合 int/float 先转 float 再兜底，大整数能装进 float 仍丢精度（`2**54+1` vs `float(2**54+1)` 被判相等）
- 修复：混合路径改为对有限值一律用精确有理比较 `abs(Fraction(int) - Fraction(float)) > Fraction(tol)`，不再转 float；非有限 float 前置处理——`math.isnan` → False（IEEE 差值不超容差），`math.isinf` → `math.inf > tol`（有限容差报告超出）。float/float 与 int/int 分支不变
- 测试：新增公开 `compare()` 混合精度塌缩 1 例 + 直接 helper 非有限 6 例（±inf/NaN/NaN 顺序无关/inf 容差/有限塌缩）；Python3.10 focused 55 passed、Core 144 passed，Python3.14 focused 55 passed
- 方法经验：同一工作树多轮未提交时，会话级 diff 需重建 pre 映像：复制当前文件到临时目录、用 edit 反做本轮改动，再 `git diff --no-index`；用 blob 哈希核对（pre `recording.py`=5c3be72、`test_recording.py`=13ca1a5 与上轮 post 一致）证明基线精确
- 边界：同前，仅两文件、离线，保留用户改动；未 commit/push

### 2026-10-01 ATEQ Core 串口录制/回放集成测试（OpenCode executor）

- 目标仓库 `C:\Users\Administrator\Documents\Codex\2026-09-27-lg-industrial-phase1\ATEQ`（branch `codex/ateq-core-pilot`，HEAD `c22accd`）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-ateq-core-serial-replay`（plan.md + REVIEW_PACKET.md）
- 仅新增 `tests/test_core_serial_replay.py`：测试内合成 Modbus RTU fn-03 从站（内存端点、独立本地 `_crc16`，严格校验 8 字节帧/CRC/从站/功能码/地址/数量），用 Core PR#2 的 `RecordingSerialFactory` 把一次真实 `SerialAteq.read_registers(0x0030,4)` 录制到 pytest tmp 下的 JSONL，再用 `ReplaySerialFactory` 回放同一适配器调用，断言寄存器值、原始响应字节一致、恰好 1 笔事务、transcript 全部消费（consumed=total=1、exhausted）
- 保持公开仓库无私有依赖：模块级 `pytest.importorskip("lg_industrial_core")`（与既有 test_core_adapters.py 同一模式）；验证用 `PYTHONPATH=%LOCALAPPDATA%\Temp\lgcore_pr2_414c93d\src` + `C:\Program Files\Python310\python.exe`（3.10.11 / pytest 9.1.1）：compileall 0、focused 1 passed 0.06s、全量 `pytest -q tests/` 93 passed 2.82s
- 边界：合成 Replay 证据仅证明离线字节级回放，不等价于物理仪器/点表/端口/产线验收；保留用户既有改动（`app/composition.py`、`app/main.py`、`app/station.py` 已修改，`tests/__init__.py`、`tests/test_core_adapters.py` 未跟踪）；未 commit/push

### 2026-10-01 lg-industrial-core 输出回执 accepted 严格布尔校验（OpenCode executor）

- 目标仓库 `C:\Users\Administrator\Documents\Codex\2026-10-01-core-output-receipt-boolean-fix`（隔离 worktree，branch `codex/core-output-receipt-boolean-fix`，HEAD `414c93d008a5fed86635ca66541f842e80e036b2` = PR `huaweixiong-debug/lg-industrial-core#2` 精确 head；原脏用户 worktree 未触碰）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-core-output-receipt-boolean-acceptance`（plan.md + 4 个验证日志 + session.diff + REVIEW_PACKET.md）
- 根因/修复（仅 `src/lg_industrial_core/adapters.py`、`tests/test_core_primitives.py` 两文件）：`ProductOutputAdapter.submit` 里 `accepted=bool(value.accepted)` 把 `"false"` 强转成 `True`，可错误放行标签/打码完成。改为先在同一 try 内取 `accepted/job_id/receipt`（保留缺失属性 → `TypeError("output result must expose accepted, job_id, and receipt")` 契约），再 `isinstance(accepted, bool)`，非 bool 抛 `TypeError("output result accepted must be a bool, got <type>")`；`job_id`/`receipt` 仍 `str()` 归一，`accepted` 原样返回
- 测试：`_AcceptanceTarget`（同时实现 print_label/mark）× output_kind label/mark 参数化——`True/False` 保真（`receipt.accepted is accepted`）、`"false"/"true"/0/1/None` 全部拒绝（10 例）；focused `-k output_adapter` 15 passed
- 环境坑：本机 site-packages 有旧的非 editable `lg-industrial-core 0.1.0`，会遮蔽 worktree `src`，plan 原命令在 collect 阶段 `ImportError: AteqStartPort`（与改动无关）；因 CI 用 `pip install -e ".[test]"`，验证统一用 `$env:PYTHONPATH=<worktree>\src`（含 template 目录内跑测试），未改全局环境。全量根 170 passed、template 7 passed（Python 3.10.11 / pytest 9.1.1）；本机无 3.11/3.12，CI 矩阵仍待外部；`git diff --check` 干净，仅两文件改动
- 经验：接受类结果（gate 完成）禁止 truthiness 强转，必须类型严格（`isinstance(x, bool)`，int 0/1 也拒绝）；隔离 worktree 用 PYTHONPATH 覆盖旧 site-packages 比动全局 editable install 更安全
- 边界：纯离线单测，未 commit/push/merge，未触碰硬件/DB/网络/凭据；等 Codex 终审 + 外部 CI（3.10/3.11/3.12 + 打包 preflight）后才算验收

### 2026-10-01 Morocco ATEQ Core 串口录制/回放集成测试（OpenCode executor）

- 目标仓库 `C:\Users\Administrator\Documents\Codex\2026-09-27-lg-industrial-phase1\Morocco`（branch `codex/morocco-core-pilot`，HEAD `b54c4eb12f7271a60b4a1cc7ad67a87088dfe2f7`）；Core 源 `C:\Users\Administrator\Documents\Codex\2026-10-01-core-output-receipt-boolean-fix\src` commit `a822e5a2fa24d2a5a7cec3d0c2457a8b7312515f`；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-morocco-core-serial-replay`（plan.md + REVIEW_PACKET.md + 3 个验证日志 + implementation.diff）
- 仅新增 `tests/test_core_serial_replay.py`（231 行）：与 ATEQ 仓库同类思路，但覆盖 Morocco 完整 `SerialAteq.run()` 周期——合成 fn-03 从站严格校验 `FF 03 00 30 00 0D`+CRC，返回 13 寄存器两帧（StepCode 6 活动帧压力 50.000 kPa；终止帧 65525 status=0x0001 PASS、泄漏 3.000 mL/min），CRC 用独立表驱动 `_crc16`；Recording 一次 run（恰 2 笔事务）写 JSONL 到 pytest tmp_path，逐行断言 request_hex/read_size=31/response_hex，再用 ReplaySerialFactory 跑同一 request，断言 measurement/raw_frame 与录制一致、consumed=2/remaining=0/exhausted
- 验证（`PYTHONPATH` 与 `LG_INDUSTRIAL_CORE_SOURCE` 均指向 Core src；py -3.10.11 / pytest 9.1.1）：focused 1 passed、全量 `tests/` 169 passed 1 skipped（skip 为 test_ui_sol_round2.py 打包产物缺失的既有跳过）、`git diff --check` 干净；`git status` 仅新增本文件 + 基线脏文件集（app/composition.py、app/main.py、tests/test_ui_sol_round2.py、tests/test_ui_theme_modern.py 已改；app/core_adapter.py、tests/test_core_adapter.py 未跟踪）
- 经验：Morocco 的 run() 断言需注意 pressure 取 StepCode=6 快照帧、leakage 取终止帧；合成 endpoint 的 read 只服务队列内帧并按请求长度切片；不经 `start_test()`/任何写方法，传 serial_factory 时 `connect()` 不会触发 `import serial`；未跟踪文件用 `git diff --no-index /dev/null <file>` 生成完整 diff
- 修复轮（同会话同文件）：ZCode wrapper `plan` 模式 PASS，两条 low 建议已改——两个 SerialAteq 实例改用 try/finally 关闭（run 抛错也关）；`_SyntheticReadOnlyEndpoint.read` 对响应长度 != 请求长度直接抛 ValueError（不再静默切片），两帧 transcript 断言不变
- 修复轮验证：仅重跑 focused `tests/test_core_serial_replay.py` 1 passed（0.27s），按指示未重跑全量（此前全量 169 passed 1 skipped 属修复前版本）；`git diff --check` 干净；REVIEW_PACKET.md 与 implementation.diff 已按最终文件（239 行）刷新
- 边界：仅离线字节级传输回放证明，非物理仪器/产线验收；Codex focused 复验与终审留给外层；未 commit/push 项目改动

### 2026-10-01 lg-traceability-pilot README Core pin 刷新（OpenCode executor）

- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-traceability-pilot-20260927`（branch `main`，HEAD `14aebaf8`）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-traceability-core-pin-update`（plan.md + README.before/after + patch.diff + REVIEW_PACKET.md）
- 仅改 `README.md` 两个区域：① 引言删除 "Core PR #2 remains Draft"，改为基于 Core PR #2 精确修订 `a822e5a2fa24d2a5a7cec3d0c2457a8b7312515f`；② Setup 的 PYTHONPATH 与说明从共享 stage `P:\...\lg-industrial-core-stage-20260928\src`（`b2c40bb...`）改为已验证 Core 源 `C:\Users\Administrator\Documents\Codex\2026-10-01-core-output-receipt-boolean-fix\src`（同修订），保留"源码方式、非安装包"表述与全部 SIMULATE-only/synthetic 边界
- 验证：改前 SHA256 `14a28315…` = plan 基线（改前副本一致）；改后 `1d558c57…`；`git diff --check` exit 0；旧令牌 `b2c40bb`/`Draft`/`lg-industrial-core-stage` 在 README 中已无匹配，新修订与新路径各出现 2 次；git status 前后与基线完全一致（既有脏文件与未跟踪项保留未动）；session diff 仅 2 hunk（+9/−7），用改前字节副本 `git diff --no-index` 隔离
- 边界：文档-only，未跑测试（源码/测试未变；该 Core 修订 Python 3.10/3.14 各 43 passed 与合成 CLI 冒烟在 plan 基线中刚验证）；未 commit/push 项目；未触碰 app/configs/`.agent`
- 经验：会话前文件已脏时，先复制 pre 映像到证据目录再编辑，用 `git diff --no-index` 可得纯净 session diff；本机 PowerShell 仍无 `Get-FileHash`（用 certutil）；PS5.1 `>` 重定向 diff 输出为 UTF-16 会被判 binary，须 `Out-File -Encoding ascii`

### 2026-10-01 Morocco 单/双测模式压力输出写保护（OpenCode executor）

- 目标仓库 `C:\Users\Administrator\Documents\Codex\2026-10-01-morocco-mode-pressure-write-guard`（隔离 worktree，branch `codex/morocco-mode-pressure-write-guard-20261001`，HEAD `b54c4eb12f7271a60b4a1cc7ad67a87088dfe2f7`）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-morocco-mode-pressure-write-guard`（plan.md + REVIEW_PACKET.md）
- 变更仅 3 个允许文件：`app/plc.py` 删除未获点表/OPC 支持的 `POINTS["test_mode"]` 别名（M0.5/M0.4，实为 A/B 正负压开启）；`app/ui_replica.py` 删除 `_sync_test_mode_signal` 方法、`_test_mode_signal_value` 缓存及所有自动写调用（startup、mode_changed、production_scan×2、restore_validation、validation_started），保留本地模式状态、冻结拒绝、按钮文本与 `CAL_MODE_FROZEN` 日志；`tests/test_ui_replica_structure.py` 旧“模式位写入”测试替换为 `_WriteSpyPlc` 写监视测试 `test_single_dual_selection_does_not_write_pressure_points`（monkeypatch `ui_replica.FakePlc`，覆盖构造启动与 A/B 单双测切换，断言压力点位零写入且位值不变）
- 验证（须显式用 `C:\Program Files\Python310\python.exe`；本机默认 python 无 pytest/PySide6）：focused 2 passed；全量 `pytest -q` 122 passed 2 failed；两失败为既存基线问题（`package_dist_final` exe 缺失、中文界面既有 `Mx.x` 标签含 `M` token），用 `git stash` 在纯净 HEAD 复跑同样 2 failed，与本次无关；`git diff --check` 干净；`rg` 对 `POINTS["test_mode"]`、`_sync_test_mode_signal`、`TEST_MODE_PLC_SIGNAL`、`_test_mode_signal_value` 在 app/tests 全部 NO_MATCHES；`POINTS["pressure"]` 仍为 A(0,5)/B(0,4)
- 边界：全部离线 SIMULATE/Fake 路径；未跑 LIVE/preflight/--live-ui，未接 PLC/串口/DB/硬件；项目未 commit/push，终审交外层
### 2026-10-01 Morocco 单/双测模式标签在重启恢复后误显示单测（OpenCode executor）

- 目标仓库 `C:\Users\Administrator\Documents\Codex\2026-10-01-morocco-mode-pressure-write-guard`，branch `codex/morocco-mode-pressure-write-guard-20261001`，HEAD `b54c4eb`，验证目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-morocco-mode-label-restore`（plan.md + REVIEW_PACKET.md）
- 修复：`MainWindow._apply_language` 此前对每张卡硬编码单测标签，导致重启恢复进行中的双测校准时按钮 checked=True 但文字仍为单测；改为按 `card.mode_button.isChecked()` 选择每语言词汇 `("单测","双测")/("Single Test","Dual Test")/("Test simple","Test double")` 加站号后缀。不改选中态、校准状态、PLC 或扫描逻辑
- 测试：扩展 `test_restart_restores_in_progress_dual_validation_without_pressure_writes`，断言启动中文“双测 A/B”，并依次 `language_changed` 中文→English→Français→中文 断言 `Dual Test`/`Test double`，每次断言 checked、validation_started、test_mode=dual、phase=WAIT_NG、locked 不变；保留 `_WriteSpyPlc` 对 M0.5/M0.4 无写、读为 False 的断言。先红后绿（红：`assert '单测 A' == '双测 A'`）
- 验证（Python 3.10，离线 FakePlc）：focused 1 passed；`tests/test_ui_replica_structure.py` 全量 21 passed；`git diff --check` exit 0；本会话仅动 `app/ui_replica.py` 与 `tests/test_ui_replica_structure.py` 两个允许文件（`app/plc.py` 既有护栏改动未动）
- 边界：未 commit/push/merge/部署；未接 LIVE PLC/ATEQ/DB/串口/打印

### 2026-10-02 lg-industrial-core HEAD `1ef62df` 离线重验（OpenCode executor）

- 目标：在精确本地 Core HEAD 上刷新 pilot-compatibility 证据，不发布、不改 phase gate
- 执行边界：OpenCode 仅编辑 disposable snapshot `C:\Windows\Temp\LGCoreRevalidate20261002`；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-lg-core-head-revalidation`；canonical `\\100.117.1.6\projects\Langguo_AI\repos\lg-industrial-core-stage-20260928` branch `codex/lg-industrial-core-reconcile-20260928` HEAD `1ef62df17919c41dd04ced7d35eb9e6878554438`
- 源状态：本地 `origin/pr-2` 仍为 `6f2591f…`，canonical 领先 3 commits；PR 仍在旧 head；未 push/未跑该 HEAD 的远端 CI
- 会话唯一项目文件改动：snapshot `docs/pilot-compatibility.md` 仅追加 `## 2026-10-02 offline revalidation at Core HEAD 1ef62df`；pre-run SHA256 `129C00A8…`（22798 bytes）验证通过后才 copy-back 到 canonical；post SHA256 `608A3791…`
- 离线结果（Python 3.10.11，`PYTHONPATH`/`LG_INDUSTRIAL_CORE_SOURCE` 均指 snapshot `src`，import `samefile=True`）：Core 149 passed；template 5 passed；Morocco root 179 passed；Morocco `python_app` 141 passed；ATEQ 129 passed；compatibility checker 对 module-only `pilot-inputs` PASS；canonical `git diff --check` exit 0；`python -m build` 产出 sdist/wheel 到 evidence dist；`pip --no-deps --target installed` 后 isolated import 成功且无 `xz_core`
- 关键经验：Morocco `app/plc.py` 在 import 时 `POINTS = _legacy_points(load_points())`，module-only pilot-inputs 必须带上 `config/points.toml`（路径为 `parents[2]/config/points.toml`，对应 `pilot-inputs\config\points.toml`）；source/copy SHA-256 与 manifest 一致后 checker 才 PASS；映射盘路径只用于 pytest suite，checker 用本地 copies 规避 UNC cwd 子进程问题
- 边界：仅离线/Fake/Replay；未动硬件/COM/生产 DB/PR/merge/tag/release；V9 estimate-to-actual workbook 未改（搜索范围内无该文件）；canonical 仍保留 pre-existing `M docs/pilot-compatibility.md` 与 `?? .agent/`
- REVIEW_PACKET：`C:\Users\Administrator\.codex\opencode-executor\runs\20261002-lg-core-head-revalidation\REVIEW_PACKET.md`

### 2026-10-02 Claude Desktop 第三方网关切原生 1P 模式（OpenCode）

- 目标：本机 Claude Desktop（MSIX v1.37937）从 MiMo/DeepSeek 第三方网关切回 Anthropic 原生（用户有 Pro/Max 订阅）
- 机制（逆向 app.asar 得出）：`%LOCALAPPDATA%\Claude-3p\configLibrary\` 每个 profile JSON 的 `inferenceProvider`（gateway/anthropic/bedrock/vertex/foundry）；`_meta.json.appliedId` 决定生效 profile；`claude_desktop_config.json.deploymentMode`（1p/3p）为总开关——设 inferenceProvider 即激活 3p。官方一键切换 IPC `applyAnthropicApiShortcut`：写 `{"inferenceProvider":"anthropic"}` profile → appliedId 指它 → mode 3p；anthropic 凭据自动解析为 interactive（登录流）
- 实操：新建 profile（`5495133b...`）+ appliedId 指向 + 重启 → 日志 `3P mode active {provider:'anthropic'}`、`inference apiHost=https://api.anthropic.com`；UI 弹 "Use your Claude API account" → 点 "Or sign in with Claude.ai" → 写 `deploymentMode:1p` + 清会话凭据 + 自动重启 → 停在 Sign In 页（邮箱/Google 登录需用户亲自完成）
- 回滚：`Claude-3p\configLibrary.bak-20261002-140324` 全量备份；appliedId 改回 1994d39d（mimo）+ deploymentMode 改回 3p
- 坑与经验：①应用"自行退出"真相=auto-updater 每次启动 ~30s 发现 Claude 2.19675 并下载（staged 未装上，循环）或模式切换/登录触发的 relaunch，均走正常 beforeQuit 非崩溃；②UI 自动化点击必须真前台：minimize/restore + ALT keybd_event + SetForegroundWindow 并验证 GetForegroundWindow==目标，否则点击落上层窗口；PrintWindow(flag=2) 截图不依赖前台；mouse_event 前必设 Cursor.Position；③PS5.1：方法调用作实参须括号包裹，日志被占用用 FileStream(FileShare=ReadWrite)
- 关联：本机 Clash 已加 claude.ai/claude.com/anthropic.com → AI自动 三规则（bak-claude-20261002-132809）；DeepSeek 中转 ~/.claude/settings.json 备份 bak-deepseek-20261002-133029
- 状态：deploymentMode=1p 已落地，待用户完成 claude.ai 登录即为原生订阅模式
### 2026-10-02 Morocco 全树 package-layout 复检（OpenCode executor）

- 目标仓库 `P:\Langguo_AI\repos\lg-pilot-morocco-20260927`（UNC `\\100.117.1.6\projects\...`，非 git；完整树含 `package_dist_final`）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-morocco-full-tree-package-layout-recheck`（plan.md + evidence\* + REVIEW_PACKET.md）
- Core 源：`C:\Users\Administrator\Documents\Codex\2026-10-01-core-output-receipt-boolean-fix` HEAD `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7`，`src` tree `9d592b5f958dafa6ebeb39e38f919166e4fdb1c3`，`src` 前后均 clean；仓库其余 `template/`、README 等脏文件为既存未动
- 执行：Python 3.10.11（`C:\Program Files\Python310\python.exe`，pytest 9.1.1，PySide6 6.11.1）；`PYTHONPATH`/`LG_INDUSTRIAL_CORE_SOURCE` 指向精确 Core `src`，`PYTHONDONTWRITEBYTECODE=1`，`QT_QPA_PLATFORM=offscreen`（另加 `PYTHONIOENCODING=utf-8` 仅为日志可读）；根套件 `179 passed`、`python_app` `141 passed`，均 exit 0、stderr 0 字节、零跳过
- package-layout：两处 `test_ui_sol_round2.py::test_table_header_geometry_and_canonical_package_layout` 用 `-v` 单测复证 PASS（补充验证，非重跑套件）；`package_dist_final\LeakTest2Channels\LeakTest2Channels.exe` 存在（61,178,180 B，2026-09-28，SHA256 `428dfe7e…`），根下裸 exe 不存在的断言成立
- 状态不变：前后 manifest 逐项一致（根 1009、`python_app` 340 文件）、6 个保护文件 SHA-256 全同；import 探针 `app` 分别解析到根/`python_app`，`lg_industrial_core` 两处均解析到精确 Core `src`
- 边界：纯离线验证，无编辑/构建/复制/EXE 执行；旧 EXE 不代表当前源码、非新建包；不推进 LIVE/现场门禁（`config/live.toml` `ports_confirmed=false` 未变）

### 2026-10-02 溯源试点 README/QA 报告证据纠正（OpenCode executor）

- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-traceability-pilot-20260927`（映射盘 `P:\Langguo_AI\repos\lg-traceability-pilot-20260927`；git HEAD `14aebaf` 未变，未 commit/push）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-traceability-evidence-correction`（plan.md + REVIEW_PACKET.md + 会话 diff/日志/baseline）
- 仅改 2 个允许文件：`README.md` 删除固定 SHA `a822e5a…` 与用户绝对路径，Setup 改为调用方占位符 `<pilot-root>;<core-src>`、要求源导出 `AteqStartPort`、要求记录 Core HEAD+dirty；`.agent/reports/TASK-0001-TEST.md` 顶部纯插入 `## Superseding revalidation — 2026-10-02`（34 行），记录：安装包缺 `AteqStartPort` 收集失败、本地源码 43 passed（Python 3.10.11）、Core HEAD `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7` + 5 个脏路径、任务态实为 APPROVED/ORCHESTRATOR、范围无设备/客户网/生产库/LIVE；旧报告作为历史证据原样保留
- 验证：无 PYTHONPATH 时安装包收集失败 exit 2；本地源码 `py -3.10 -B -m pytest -q -p no:cacheprovider --tb=short tests/` 43 passed exit 0；`git diff --check` exit 0；项目 status 前后 13 项完全一致（仅 README 内容变化）；Core HEAD/脏路径前后不变
- 边界：纯文档修正，未 commit/push/publish；不据此宣称 QA_PASS 或生产就绪；未动 app/tests/pyproject/任务状态/路线门禁

### 2026-10-02 溯源试点复审修正 fix1（OpenCode executor）

- 目标仓库 `\\100.117.1.6\projects\Langguo_AI\repos\lg-traceability-pilot-20260927`（HEAD `14aebaf` 未变，未 commit/push）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-traceability-evidence-correction-fix1`；承接上一轮 run `20261002-traceability-evidence-correction` 的 plan/packet
- 两项精确修正：`README.md` 将 "expected to be dirty during review" 改为 "Each verification record should include the Core HEAD and working-tree status, because uncommitted changes affect the tested source"（2+/2-）；`.agent/reports/TASK-0001-TEST.md` superseding 节新增 `.agent` inventory 条目（4+），更正旧说法 ".agent 仅含 state/TASK-0001.json"，明确报告自身位于 `.agent/reports/TASK-0001-TEST.md` 且除此之外无任务定义/SPEC/实现报告文件；历史正文原样保留
- 验证：Python 3.10.11 本地 Core 源 43 passed exit 0；`git diff --check` exit 0；项目 status 前后 13 项一致；Core HEAD `6f2591f…` + 5 脏路径不变；fix 基线哈希与上轮验收后哈希一致（无漂移）
- 注意：本轮要求记录的 ZCode GLM-5.3-Flash/high 复审在限时等待内无输出，其先前模型设置已恢复；本轮无 ZCode 结论
- 边界：纯文档修正，未 commit/push/publish；不据此宣称 QA_PASS 或生产就绪

### 2026-10-02 lg-industrial-core 当前工作树 Phase 1 发布基线验证（OpenCode executor）

- 目标仓库 `C:\Users\Administrator\Documents\Codex\2026-10-01-core-output-receipt-boolean-fix`（branch `codex/core-output-receipt-boolean-fix`，HEAD `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7`，等于 PR #2 head 分支 `codex/lg-industrial-core-reconcile-20260928`）；证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-roadmap-core-fresh-validation`（plan.md + REVIEW_PACKET.md + 全部日志）
- 保留 5 文件既存脏 diff（36+/21−：ci.yml `permissions: contents: read`、README 模板段落、template/README、template/app/composition.py 去掉 `SimulatedStation.policy`、template/tests/test_template.py 新增 fake-only 断言）；本会话零项目改动；`git apply --check --reverse baseline.patch` exit 0 证明工作树与基线完全一致；项目 diff 对象 SHA `2b21609…` 前后不变，status 快照一致
- 预录测试（按 plan 未重跑）：Core 170 passed、template 8 passed；`git diff --check` exit 0（plan 引用的 diff-check.log 实际缺失，本会话重建）
- 构建（Python 3.10.11，`C:\Program Files\Python310\python.exe`；仅在 disposable copy `build-src`）：`python -m build --sdist --wheel` exit 0，隔离环境 setuptools 84.0.0；产物 `lg_industrial_core-0.1.0-py3-none-any.whl`（sha256 `020750d4…`）/ `.tar.gz`（`af9cbcc9…`）；wheel 仅含 `lg_industrial_core` 包，METADATA Name/Version 0.1.0/Requires-Python >=3.10 正确
- 安装验证：`pip install --no-deps --target install-target` + `python -I` 导入解析到 target（非全局），`importlib.metadata` version 0.1.0，35 个 `__all__` 符号全可解析；无 `__version__` 属性（仅元数据版本，非缺陷）
- 名称审计：`xz-industrial-core`/`xz_core` 仅剩 `docs/pilot-compatibility.md:63` 历史说明，无别名/导入；同行为 allowlist 外文档仍写 "SIMULATE-first template"，与改后 Fake-only 模板不符 → 未改，建议后续单独修
- 远端边界：PR #2 head 6f2591f 的 CI（3.10/3.11/3.12 + Package preflight）2026-10-01 全绿；5 文件未提交 diff 未 push、无远端 CI 覆盖；本会话未 commit/push/merge
- 经验：`Tee-Object` 对无输出命令不创建文件（`git diff --check`/`git apply --check` 成功时无 stdout），日志需显式写命令+exit code；本机构建/导入验证统一用 py310，不用默认 miniconda py3.13

### 2026-10-02 同上 fix1：pilot-compatibility 模板术语修正（OpenCode executor）

- 证据目录 `C:\Users\Administrator\.codex\opencode-executor\runs\20261002-roadmap-core-fix1`（plan.md + REVIEW_PACKET.md + pre/post 副本 + SHA/字节级校验 + diff/日志）；同一会话续作
- 唯一改动 `docs/pilot-compatibility.md:63`：`the SIMULATE-first template` → `the Fake-only template with a separately demonstrated fail-closed RuntimePolicy gate`；xz 历史名称说明与 no-aliases 声明原样保留；其余 5 个既存改动逐字节不变（五文件 diff 哈希 `2b21609…` 前后一致）
- 验证：pre-edit 副本 SHA256 `BA046DF9…`（16820 B）与改前原文件逐字节相同；post SHA256 `0BB03344…`（16877 B）；单一 hunk 1+/1−；`git diff --check` exit 0；无尾随空白；无 BOM 变化、CRLF=108 不变；`SIMULATE-first` 全树 0 匹配
- 边界：Markdown-only，未重跑测试/构建（Core 170/template 8 与 run1 wheel/sdist 仍适用；`docs/` 不参与打包）；未 commit/push；远端 CI 仍只覆盖已提交 head `6f2591f`
- REVIEW_PACKET：`C:\Users\Administrator\.codex\opencode-executor\runs\20261002-roadmap-core-fix1\REVIEW_PACKET.md`

### 2026-10-03 矩视智能/NeuroBot（nb-ai.com）目标检测技术调研（OpenCode 问答）

- 对象：`nb-ai.com`（北京矩视智能，工业 AI 视觉低代码平台）+ `github.com/neurobot-ai/neurobot_sdk_demo`（闭源 SDK 调用示例：C++/C#，链接 `opencv_world454.lib` + `neuro_det_sdk.lib`，模型由平台下载，Virbox 授权；无算法源码）
- 结论：检测为深度学习单阶段检测器（SDK 输出 `x0,y0,x1,y1 + score + label`，通用检测格式）；同组织开源仓库 `neurobot-ai/neurobot-vision` 自述 "Optimized YOLO series models" 且路线图规划开源 YOLO 检测/分割/分类 → 检测方法属 YOLO 系（具体版本官方未公开，此为公开材料推断）
- 配套：OCR=文本检测+识别，像素分割=语义/实例分割，3D=点云处理/配准，跟踪=轨迹关联算法；标注端宣传"视觉大模型"辅助（疑似 SAM 类，未证实）；整体是商用化封装而非开源工具简单拼装，但组件方法论均为公开常规技术
- 可复刻性：单一检测任务数天可复刻（Ultralytics YOLO + Label Studio + ONNX/TensorRT）；商用平台难点在工程（旋转框、大图切分、多模型多线程调度、C++/C# SDK 封装、加密授权、低代码 GUI、IO/PLC 集成），均有开源替代件
- 证据：nb-ai.com 产品页、neurobot.readthedocs.io `Deployment/HowToUseSDK`、`github.com/neurobot-ai/neurobot-vision` README、`neurobot_sdk_demo` README


### 2026-10-03 补：矩视"二阶段检测比 YOLO 更精准"说法核查（OpenCode 问答）

- 核查方式：抓取 neurobot.readthedocs.io 全站英文文档搜索索引（search_index.json，248 KB，覆盖全部页面）全文检索：0 处 "two-stage"、0 处 "YOLO"、仅 1 处 "faster"（FAQ 描述新框架模型"推理更快"）、4 处 "algorithm"
- 公开可证事实：平台有模型分级"标准版/高精度版"（FAQ/lowcodedep，替代旧"普通模型/快速模型"）；私有云训练模块支持 "manually switch the algorithm, adjust the hyper-parameter"（算法可切换，未公开算法名）；标注指南提到 anchor box 定位（属 anchor-based 检测器）
- 同组织 `neurobot-vision` 仓库自述 "Optimized YOLO series models"；无任何公开基准（mAP/速度）对比 vs YOLO
- 结论："有二阶段检测"无公开证据；"二阶段一定比 YOLO 准"技术上已过时（现代 YOLO 已追平/反超常见 Faster R-CNN 实现；工业精度更取决于数据/标注/分辨率/阈值）。验证动作：要其给出具体架构名 + 本数据 A/B 指标，或自行同数据对比高精度版 vs 标准版 vs YOLOv8x/11x
- 另一可能口径：其 SDK demo README 第 7 条"目标定位 + OCR"是真两段流水线（先检测 ROI 再 OCR），可能被销售表述为"两阶段"


## 2026-10-03 opencode - YiDa Faster/Cascade R-CNN experiment helper

- Project: `D:\ultralytics-main` (non-Git). Evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-yida-rcnn-ab`.
- Implemented only 5 allowed new files from plan.md: `mvp_inference/plugins/mmdet_detector.py` plus experiment helpers under `inference_results/yida_faster_cascade_compare_20261003/` (prepare_data.py, benchmark.py, environment.yml, README.md).
- Data path fixed: `D:\YiDa002.v17i.yolo26` (YOLO 0=F 1=U; train 470/valid 132/test 66). YOLO baseline checkpoint: `weightm_260419\weights\best.pt` (evaluate as-is).
- prepare_data.py COCO conversion validated clean on all three splits (no label errors).
- Training was intentionally NOT launched this pass. Isolated env still required: Python 3.8 + torch 2.1.0+cu121 + mmcv 2.1.0 Windows wheel + mmengine 0.10.7 + mmdet 3.3.0. Existing conda `mmdetection` env is incompatible (mmcv 1.7.2).
- REVIEW_PACKET.md written to the evidence run directory (not the project root). Project root and evidence path must not be confused.
- Follow-up: create isolated env, run `benchmark.py --stage check-env`, then `--stage train --allow-train`, then eval/select/report. Do not substitute another detector if R-CNN cannot fit; record blocker.

## 2026-10-03 opencode - YiDa R-CNN helper fix pass (ses_f00a15108ffeVZVYmimGqIQway)

- Applied fix.md exactly for session ses_f00a15108ffeVZVYmimGqIQway on project `D:\ultralytics-main`.
- Evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-yida-rcnn-ab` (fresh REVIEW_PACKET.md).
- Fixed 4 terra issues: (1) valid threshold persist before single test pass; (2) official pycocotools COCOeval only, no custom AP fallback; (3) check-env requires CUDA + MMCV NMS on selected CUDA device; (4) mmdet_detector passes runtime Config to init_detector.
- Changed only: mmdet_detector.py, benchmark.py, README.md. Unchanged: prepare_data.py, environment.yml. Training not launched.
- Unresolved: isolated env creation, CUDA check-env runtime, full valid/test eval, metric-filled Chinese report.

## 2026-10-03 opencode - YiDa best-checkpoint metric key fix (executor)

- Target project root exactly `D:\ultralytics-main`; evidence run directory exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-yida-checkpoint-keyfix`. Do not confuse these paths.
- Implemented plan exactly. Intentional source edits limited to two allowed files: `inference_results/yida_faster_cascade_compare_20261003/benchmark.py` and `README.md`.
- Metric key fixed: generated CheckpointHook now uses `save_best='coco/bbox_mAP'` (was `bbox_mAP`). Constants: `BEST_COCO_METRIC_KEY`, `STABLE_BEST_CHECKPOINT_NAME='best_valid_bbox_map.pth'`.
- MMEngine handoff: after successful train only, `stage_train` discovers `best_coco_bbox_mAP_epoch_<N>.pth` (MMEngine replaces `/` with `_` in metric key), preserves original via copy-not-move, copies stable path to both `experiments/<model>/` and `checkpoints/<model>/best_valid_bbox_map.pth`. Missing best checkpoint => clear failure, no substitute.
- Verification without training: syntax compile OK; `--stage gen-configs` regenerated configs with new key; focused temp-file checks 9/9 passed (`checkpoint_handoff_checks.json`); protected production hashes unchanged (prepare_data.py, environment.yml, YOLO best.pt, dataset, mvp_inference production files); no new project weights; train still refused without `--allow-train`.
- Verification side effects only: regenerated `generated_configs/*` + manifests + `metrics/gen_configs.json` (plan-required gen-configs step).
- REVIEW_PACKET: `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-yida-checkpoint-keyfix\REVIEW_PACKET.md`. Terra no longer used per user; Codex does final bounded review.
- Follow-up: real train in isolated env `yida-mmdet-ab-20261003` still pending; after train confirm `best_coco_bbox_mAP_epoch_*.pth` preserved and stable `best_valid_bbox_map.pth` created, then eval/select/report.


---

## 2026-10-03 OpenCode 会话结论：yida mmdet config 引用修正

- 工程根：`D:\ultralytics-main`；证据目录：`C:\Users\Administrator\.codex\opencode-executor\runs\20261003-yida-mmdet-config-ref-fix`
- 在 `benchmark.py` 中仅修正两条 `mmdet_config`：去掉多余 `configs/` 段，改为 `mmdet::faster_rcnn/...` 与 `mmdet::cascade_rcnn/...`（官方 MMEngine `{package}::` 写法）。
- 本 OpenCode 实现只做了 `py_compile` + 源字符串校验；未生成配置、未训练、未跑 check-env、未调用 Terra。
- 待办（Codex 侧）：审阅补丁后重新生成 `generated_configs/*`（现存 artifacts 仍带旧路径），再在隔离 GPU 环境跑非训练 `check-env` 验证实例化。
- 该目录不是 Git 仓库；diff 已写入 REVIEW_PACKET 的 before/after 文本。


## 2026-10-03 opencode - YiDa persistent_workers Windows init fix (executor)

- Target project root exactly `D:\ultralytics-main`; evidence run directory exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-yida-persistent-workers-fix`. Do not confuse these paths.
- Implemented saved plan only. Sole allowed source edit: `inference_results/yida_faster_cascade_compare_20261003/benchmark.py`.
- Change: added `persistent_workers=False` to generated `train_dataloader`, `val_dataloader`, and `test_dataloader` dicts. Preserved `num_workers=0` / `{args.workers}` (CLI default 0). Diff is exactly 3 added lines.
- Before hash matched baseline: `2c2424f10328fb0a750544e18f45a20e1bed779538d8e2ce575d10c67f2834de`. After hash: `11f9196c1530b9cb6430d4248c52e9d17cbef52b9586d8540e256886b81b31b7`.
- Verification without training: isolated env `D:\miniconda3\envs\yida-mmdet-ab-20261003\python.exe` (`mmengine 0.10.7`, `mmdet 3.3.0`); `py_compile` OK; `--stage gen-configs` OK; both generated configs load via `Config.fromfile` with train/val/test `num_workers=0` and `persistent_workers=false`.
- Self-correction: first edit briefly introduced f-string indent into generated-config content (unloadable configs); corrected to planned column-0 layout. Authoritative verification is post-fix.
- REVIEW_PACKET: `...\REVIEW_PACKET.md`. Terra not called. Training not started; real train still pending.

## 2026-10-03 opencode: yida 递归 best checkpoint 发现修复

- 项目：D:\ultralytics-main，实验目录 inference_results/yida_faster_cascade_compare_20261003
- 问题：Faster/Cascade 训练已完成，但 MMEngine best checkpoint 写在 xperiments/<model>/<model>/（嵌套一层）；enchmark.py 的 _find_mmengine_best_checkpoint 只搜 work_dir 顶层，导致 stage_train 标失败且未安装评测 handoff 副本
- 决策：只改 enchmark.py 中该函数的候选扫描 work_dir.glob → work_dir.rglob，保留 metric coco/bbox_mAP 匹配与最高 epoch 选择；不重训、不改其他源文件
- 验证（隔离环境 yida-mmdet-ab-20261003，未启动训练）：
  - Faster：源 est_coco_bbox_mAP_epoch_14.pth，SHA256 6eba68a7...
  - Cascade：源 est_coco_bbox_mAP_epoch_20.pth，SHA256 839276d8...
  - 稳定副本均已写入 xperiments/<model>/best_valid_bbox_map.pth 与 checkpoints/<model>/best_valid_bbox_map.pth，与源哈希一致
- 证据目录：C:\Users\Administrator\.codex\opencode-executor\runs\20261003-yida-recursive-best-checkpoint（含 REVIEW_PACKET.md、verification_report.json、verification_commands.json、benchmark.diff）
- 待办：中间复审配置为 simple-tier GPT-5.6 Luna；用户明确排除 Terra


## 2026-10-03 opencode: Hengchuang v47 grouped WBF experiment scaffolding

- Target project root exactly `D:\ultralytics-main\inference_results\hengchuang_v47_grouped_wbf_20261003`; evidence run directory exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-hengchuang-grouped-ensemble`. Do not confuse these paths.
- Source dataset (read-only): `D:\Hengchuang00601.v47i.yolo26`. Excluded contaminated checkpoint: `D:\Hengchuang00601.v47i.yolo26_v2\weights\best.pt`.
- Created 5 scripts: `prepare_data.py` (audit + 393/146/178 split materialization + COCO), `train_yolo.py` (YOLO26s smoke/train/predict), `train_mmdet.py` (Faster+Cascade R-CNN gen-configs/train/predict/smoke), `evaluate_fusion.py` (thresholds + WBF IoU 0.55 + COCOeval + protocol freeze + Chinese report), `README.md` (stage commands).
- Frozen class map from source data.yaml: `['convex_plate', 'flat_plate', 'ignore']` (nc=3), written to `class_map.json`, consumed by all scripts. COCO category_id = class_id + 1.
- Date-grouped split: train ≤ 2026-01-06 (393), valid = 2026-05-05 (146), test = 2026-05-07/08/09/19 (178); total 717 unique images. Source has 715 duplicated in train/valid + 717 in test (2 extra May-5 images only in test).
- Smoke checks passed (no training, no test inference): prepare_data ok=True with exact 393/146/178; YOLO26s COCO pretrained loaded (10M params, CUDA OK); FasterRCNN (41M) + CascadeRCNN (69M) instantiated on GPU with num_classes_head=3, CUDA NMS ok; check-env confirmed RTX 4070 SUPER + pycocotools + no test artifacts.
- Env: `yida-mmdet-ab-20261003` (mmcv 2.1.0, mmengine 0.10.7, mmdet 3.3.0, ultralytics 8.4.2, Python 3.8).
- Protocol: seed 42, epochs 20, imgsz 1024, YOLO batch 8, MMDet batch 2. WBF equal weights IoU 0.55. Threshold grid 0.05–0.95 step 0.05, max F1, ties → higher threshold. Protocol freeze before test enforced.
- Remaining to run: full training (3 models), valid predictions, threshold select + protocol freeze, test predictions + metrics, Chinese report. Commands in README.md.
- Known risks for reviewer: mmdet box rescale heuristic untested; `ignore` treated as detectable class (matching source data.yaml); WBF score uses weighted-average variant; Python 3.8 f-string backslash issue was found and fixed in evaluate_fusion.py.
- REVIEW_PACKET written to evidence run directory. Terra not called. Non-Git project; diff as before/after file inventory.

## 2026-10-03 opencode: core 模板 Fake-only 构造函数守卫

- 目标工程根：`C:\Users\Administrator\Documents\Codex\2026-10-01-core-output-receipt-boolean-fix`；证据目录：`C:\Users\Administrator\.codex\opencode-executor\runs\20261003-core-template-fake-only-constructor-guard`（两者不可混淆）。
- 仅改允许的两个文件：`template/app/composition.py`、`template/tests/test_template.py`；基线分支 `codex/core-output-receipt-boolean-fix` HEAD `6d278e8`。
- 实现：`SimulatedStation` 改 `@dataclass(frozen=True)`，ATEQ 字段注解改为 `FakeAteq`，新增 `__post_init__` 用 `type(value) is not fake_type` 精确校验三个端口（拒绝 Fake 子类与 real-like 适配器）；`create()`/`run_cycle()`/`demonstrate_live_gate()` 未动。
- 测试：新增 4 个回归测试（任意对象、real-like 端口、Fake 子类、冻结重赋值），最终 12 passed；负对照（仅 stash composition.py）4 个新测试全部失败，证明守卫有效。
- 环境偏差：计划原命令从仓库根运行时 `app` 不在 sys.path，基线同样失败（预先存在的问题）；验证用等价命令在 PYTHONPATH 追加 `template` 后通过。9 个无关已修改文件前后 hash 完全一致。
- REVIEW_PACKET 已写入证据目录；ZCode/Terra 未调用（按计划由 Codex 做最终 bounded review）。

## 2026-10-03 opencode: 路线图门禁总览当前态刷新（executor）

- Target project root exactly `C:\CodexScratch\20261003-roadmap-gate-overview-refresh\workspace`；evidence run directory exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261003-roadmap-gate-overview-refresh-isolated`（两者不可混淆）。
- 仅改快照 `10项能力路线图门禁总览_2026-10-01.md`：更新日期→2026-10-03；表行 1–5、8 刷新为 2026-10-03 证据（远端 PR #2 head `6d278e8…` 不变、本地 11 个未提交路径、wheel `076c49…` 18,657 字节、Traceability Fake-only guard 54/16、V14 工作簿 `D020986F…`）；首条基线 bullet 与输入第 1 条更新（显式发布授权门）；`对应证据` 增 2 条；行 6/7/9/10 与第二条 bullet 不变；`## 2026-10-01 Core 状态补充` 起始后缀逐字节保留（SHA-256 `85703be1…`）。
- Before SHA-256 `E1F7525D...C4AB64` → after `220f02bd...F0FFF93F`；替换 9 行 + 插入 2 行；CRLF 44 不变、LF 152→154；无 BOM。
- apply 脚本首跑因审计断言过严在写盘前中止（无副作用），修正后通过；certutil 与独立复核 PASS。未运行测试；Terra 未调用。
- REVIEW_PACKET：`...\REVIEW_PACKET.md`（含完整 diff、字节保留、行尾校验与事实来源披露）。

## 2026-10-04 opencode: Core PR #2 模板包 CI 门禁与 Replay 契约文档

- 目标工程根目录 exactly `C:\Users\Administrator\Documents\Codex\2026-10-01-core-output-receipt-boolean-fix`；证据运行目录 exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-core-template-package-gate`；两者不同，不可混淆。
- 分支 `codex/lg-industrial-core-reconcile-20260928` HEAD `dafb171`；仅修改计划授权的 3 个文件：`.github/workflows/ci.yml`、`README.md`、`src/lg_industrial_core/serial_recording.py`；工作树基线下干净，会话后 git status 恰为这 3 个文件。
- 关闭 ZCode 评审 finding #2：ci.yml 新增三步——template 目录内 `python -m build`（并校验恰一个 wheel + 一个 sdist）、`pip install --no-deps --target "$RUNNER_TEMP/template-install"`、在 `working-directory: ${{ runner.temp }}` 下以 PYTHONPATH 指向 target 导入 `app`（断言 `app.__file__` 位于 target 内）并执行 `SimulatedStation.create().run_cycle("ci-template-smoke")`（断言 passed 为 True、value=42.0）。权限保持 `contents: read`；release.yml 的 `ci` job 仍 `uses: ./.github/workflows/ci.yml`，自动继承新门禁。
- 关闭 finding #1（不改回放事务语义，仅文档）：serial_recording.py 模块 docstring 与 RecordingSerial/ReplaySerial/ReplaySerialFactory docstring、README 序列记录章节及限制列表明确：ReplaySerial 仅提供方法级兼容面（write/flush/read/close/is_open/上下文管理器/reset_input_buffer/consumed/remaining/total/exhausted）；transport 属性（port/baudrate/timeout/in_waiting）不记录不模拟，访问抛 AttributeError；RecordingSerial 仅因包装活传输而转发未知属性；Replay 工厂接受并忽略连接参数、永不打开端口。
- 静态验证：`git diff --check` 通过（无输出）；`ast.parse` serial_recording.py 通过；本地已有 PyYAML 结构校验 ci.yml 通过（三步存在、permissions=contents:read、heredoc 终结符收敛于列 0、env 与 working-directory 指向 runner.temp）并确认 release.yml 复用 CI。按计划未在本地运行 pytest/build/pip install；远端 CI 与 Release 校验待 Codex 提交推送后执行；ZCode/Terra 评审未在 OpenCode 会话内执行。
- REVIEW_PACKET：`C:\Users\Administrator\.codex\opencode-executor\runs\20261004-core-template-package-gate\REVIEW_PACKET.md`，同目录附 session.diff、diff-stat.txt、git-status.txt。

## 2026-10-04 opencode: Traceability 试点状态/存储加固（executor）

- 目标工程根 exactly `\\100.117.1.6\projects\Langguo_AI\repos\lg-traceability-pilot-20260927`；证据运行目录 exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-traceability-state-store-hardening`；两者不同且不可混淆。
- 按 Codex 计划加固本地 SIMULATE 追溯试点（仅 6 个允许文件）：F1 存储 event_json 按 Core JSONL 契约严格反序列化，统一 TraceStoreError 并带 cycle/event seq 上下文；F2 append_event 仅允许 in_progress 周期的非 cycle_state 事件；F3 event_id 唯一（打开时发现历史重复即 fail-closed，不删改行），重复 cycle/event ID 与不存在周期错误归一化；F4 tester/printer 异常终态化为 port_error（记录 failed_stage、completed=false、零标签、不落异常文本），scanner 异常在创建周期前不留部分行；F5/F6 CLI 边界捕获存储/Core 记录/文件系统错误返回 2（0/1 语义保留、无 traceback、全输出转义、query 缓冲防半截输出）；F7/F8 README 补全夹具/错误码/port_error 并追加 2026-10-04 Release wheel 记录（54/179/141/129），补 scanner 断言。
- 验证：Python 3.10.11 / pytest 9.1.1，仅用已装 exact PR#2 wheel（Release run 37146409416、head 88a5b6e、SHA-256 8C4548F16136B298CD998F316054A680FED94F9116A3224C2483770B65B15A87）；基线 54/54 → 加固后 80/80；CLI 冒烟 9 项 + 4 内容断言全过；`git diff --check` 通过；git status 与基线一致；`.agent/state/TASK-0001.json` 哈希未变；未构建/安装 wheel、未提交/推送 pilot。
- 证据：`C:\Users\Administrator\.codex\opencode-executor\runs\20261004-traceability-state-store-hardening\REVIEW_PACKET.md`（session diff +873/-50，另含 logs/、baseline/、smoke/）。

## 2026-10-04 opencode: Traceability 事件行-信封一致性修复（executor）

- 目标工程根 exactly `\\100.117.1.6\projects\Langguo_AI\repos\lg-traceability-pilot-20260927`；证据运行目录 exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-traceability-event-row-consistency-fix`；两者不同且不可混淆。
- 仅改 2 个允许文件：`app/trace_store.py` 新增 `_verify_event_row`，`events_for_cycle` 扩展 SELECT 后逐行校验解码信封与冗余列（cycle 归属、event_id 文本、kind、occurred_at 按 tz-aware 瞬时精确比较；等价偏移接受、1µs 差异拒绝；列时间戳非法/naive 也报错），任何不一致抛带 `cycle '…' event seq N` 上下文的 TraceStoreError，不产出/导出、不修复/变更行；`tests/test_trace_store.py` 新增 8 个聚焦测试（JSON cycle_id、三列篡改、naive/非法时间戳、等价偏移正例、export 拒绝且行不变）。
- 验证：Python 3.10.11 / pytest 9.1.1 + 已装 exact PR#2 wheel target；focused 37 passed；全量 88/88（上一轮 80）；`git diff --check` 通过；git status 与基线一致；六项未触碰文件哈希（含 `.agent/state/TASK-0001.json`）不变；未提交/推送 pilot。
- 证据：`...\20261004-traceability-event-row-consistency-fix\REVIEW_PACKET.md`（session diff +244/-12，另含 baseline/、logs/）。

## 2026-10-04 opencode: Morocco 压力/模式点分离成果集成到源树（executor）

- 目标工程根目录 exactly `\\100.117.1.6\projects\Langguo_AI\repos\lg-pilot-morocco-20260927`（即 `P:\Langguo_AI\repos\lg-pilot-morocco-20260927`）；证据运行目录 exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-morocco-pressure-mode-point-separation-source-integrate`；两者不同、不可混用。
- 按 Codex 计划将已独立评审（ZCode GLM-5.3-Flash/high PASS）的 7 个文件从 `D:\CodexIsolated\morocco-pilot` 字节级复制进规范非 Git 源树：README.md、app/plc.py、app/ui_replica.py、config/points.toml、tests/test_dual_station_live_rules.py、tests/test_ui_replica_structure.py、python_app/tests/test_point_map_config.py；合计 +61/-47。
- 变更语义：删除未溯源的 PLC test_mode 点（config `[points.test_mode]`、`REQUIRED_SIGNALS`），pressure 保持 A=M0.5/B=M0.4 且仅经管理员授权+二次确认的手动输出流程写入；移除 app/ui_replica.py 的 `_sync_test_mode_signal` 及全部 6 处调用（启动/模式切换/两处生产扫码/校准恢复/验证开始）；单测/双测保留于应用 StationSelection/周期/校准记录；手动输出安全路径未改动。
- 本会话不跑测试（计划要求，Codex 事后执行）。已完成验证：7/7 SHA-256 与参考一致且逐字节相同；867 条库存比对 missing=0、恰好 7 个白名单变更、越界 0；全会话仅这 7 个文件被写（touched-since 2026-10-04T00:00Z = 7）；142 个清单外路径均为 2026-09-27..30 预存缓存/agent 文件（原清单排除 .agent/.pytest_cache/__pycache__/部分 build pyc）；参考副本哈希未变；rg 静态审计无 test_mode PLC 残留（exit 1）。
- REVIEW_PACKET：`...\20261004-morocco-pressure-mode-point-separation-source-integrate\REVIEW_PACKET.md`（SHA-256 `5E8B6A5D44A125BAC034971DA27FE54AED5694F0B6CECA0550B7497AA37225CA`，含完整 diff 与前后哈希表）。
- 待办：Codex 以 PYTHONDONTWRITEBYTECODE=1、禁用 pytest cache，离线 Fake-only 运行聚焦 UI/点表测试、根套件与 python_app 套件；若应用字节与参考一致可沿用既有 ZCode PASS，否则对新的精确 packet 重跑 ZCode。

## 2026-10-04 opencode: LG Core 九文件合并覆盖层离线复核（executor）

- 目标工程根目录 exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-lg-core-consolidated-overlay\worktree`；证据运行目录 exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-lg-core-consolidated-overlay`；两者不同、不可混淆。基线 detached PR #2 head `88a5b6ed1b9dbee904f066606f68a183bd960a29`。
- 合并来源（均只读、未编辑）：`20261004-lg-core-review-hardening-fix1\worktree`（八文件覆盖层，diff SHA-256 `3520EB…`）与 `20261004-lg-core-serial-exclusive-create\worktree`（六文件，仅取 policy/schema 部分，diff SHA-256 `B2D07D…`）。
- 结果：恰好 9 个允许路径变更（+381/-22）：release.yml SHA pin、pilot-compatibility.md 追加记录、events.py/serial_recording.py/recording.py 递归加固、serial 独占创建、policy.py 严格 bool 门（5 字段非 bool 抛 TypeError）、recording.py `_deep_compare(exact_paths)` 仅对每信封顶层 `schema_version` 精确比较（嵌套 payload 中同名键仍享数值容差），及对应测试；serial 两文件与 prior 源逐字节相同（race 测试与递归测试保留，未复制 latest 的替代 race 测试）；policy.py 与 latest 源逐字节相同。
- 验证（Python 3.10.11；全部 `-B`/`-p no:cacheprovider`/`PYTHONDONTWRITEBYTECODE=1`）：Core 250 passed；template 12 passed；Morocco root 179、python_app 141、ATEQ 129、Traceability 88（`LG_INDUSTRIAL_CORE_SOURCE`/PYTHONPATH 指向目标 src，import 探针全部解析到目标 src）；三个试点树 before/after manifest 0 变更（1009/109/66 文件），Traceability git status 14 项不变。
- 本地包验证（构建依赖现成：Codex runtime bundled Python 3.12.14 + setuptools 84.0.0 + wheel 0.48.0，全程 `--no-index`/`--no-build-isolation`/`--no-deps`，未联网/未装包）：wheel 20,089 B SHA-256 `30F5A40A…`、sdist 35,275 B `EDAE7D06…`；载荷审计 8/8 模块与快照源一致；安装到 isolated target 后 import 解析到 target（wheel 与 sdist 均验证），wheel Core 250/template 12，sdist Core 250。
- `git diff --check` exit 0；工作树 status 恰为 9 个 M、无未跟踪；源工作树 status 与开始时一致；未 commit/push/PR/release/LIVE；无 phase gate 推进。
- REVIEW_PACKET：`...\20261004-lg-core-consolidated-overlay\REVIEW_PACKET.md`（含完整 634 行合并 diff，SHA-256 `048858E4…`），证据在 `verification\` 与 `artifact\`。

## 2026-10-05 opencode: Morocco/ATEQ 精确 Release wheel 修正命令离线复验同步（executor）

- 目标工程根目录 exactly `\\100.117.1.6\projects\Langguo_AI`；证据运行目录 exactly `C:\Users\Administrator\.codex\opencode-executor\runs\20261005-morocco-ateq-roadmap-revalidation`；两者不同、不可混淆。
- 仅向 `company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\10项能力路线图门禁总览_2026-10-01.md` 追加一个 2026-10-05 日期节：精确 PR #2 Release wheel 19,167 B、SHA-256 `8C4548F1…`、head `88a5b6e`；Python 3.10.11 下 Morocco 根 179、python_app 141、ATEQ 129 passed（0 failed/skipped，导入仅解析隔离安装目标）；首轮设置问题（Morocco 缺显式 `LG_INDUSTRIAL_CORE_SOURCE`、ATEQ 未以试点根为 cwd）已由修正命令取代，不得与产品失败混记；136 文件源清单前后一致；门禁不推进、总体估算仍约 33%。
- 字节校验：前映像 94,036 B / SHA-256 `BBD809FF…`；追加 +2,608 B（CRLF、UTF-8 无 BOM，含 1 空行分隔）；末文件 96,644 B / SHA-256 `E66CCD3F…`；前 94,036 字节前缀 SHA-256 与逐字节比较均等于前映像。
- 证据：`...\20261005-morocco-ateq-roadmap-revalidation\REVIEW_PACKET.md`、`verification-append.txt`；测试总结 `...\20261005-morocco-ateq-exact-release-wheel-revalidation\summary-final.json`（`ateq-pytest-corrected.txt` 为被取代的设置错误日志；最终 ATEQ 日志为 `ateq-pytest-corrected-cwd.txt`）。

## 2026-10-08 opencode: ChatGPT/Codex Windows 崩溃定位与修复（windows-updater.node 0xC0000005）

- 现象：商店版 OpenAI.Codex 26.1002.7124.0（主进程 ChatGPT.exe）使用中反复弹 "ChatGPT has stopped working / Error launching CrashSender.exe"，点确定后应用退出；事件查看器与可靠性监视器均无 ChatGPT 崩溃记录。
- 根因①（真崩溃）：app\resources\native\windows-updater.node 指令偏移 +0x1a789 空指针读（0xC0000005，读地址 0x0），发生在启动后后台执行 primary runtime 安装时；对应 GitHub openai/codex#51824（全站约 58 条同类报告，多机 WinDbg 验证同一模块/偏移/异常码）。
- 根因②（弹窗来源）：崩溃被注入 ChatGPT 进程的腾讯微信输入法 WeType 组件（wetype_tip_core.dll + CrashRpt1500.dll，CrashRpt 崩溃报告库）进程内截获；它要启动 CrashSender.exe 但该文件不存在（WeType 目录只有 CrashSender1500.exe），于是弹 "Error launching" 并终止进程，完全绕过 Windows WER——这就是日志查不到故障模块的原因。
- 取证要点：窗口枚举 PID=31988 PROC=ChatGPT CLASS=#32770 TITLE="ChatGPT has stopped working"（子控件文本读出）；PID 31988 模块扫描命中上述 WeType dll；10-07 21:00:47 AppX 部署日志显示 26.1002.6548.0 → 26.1002.7124.0 更新；10-08 应用启动会话 13 次；LocalCache 有 13 份 OpenAI.CodexPrimaryRuntime.v26-1007-641-0.msix（6.4GB）且运行时包未安装。
- 修复（本机已实施并验证）：退出 ChatGPT 后执行 Add-AppxPackage 安装已下载的官方运行时包（签名 Valid，OpenAI OpCo, LLC）：%LOCALAPPDATA%\Packages\OpenAI.Codex_2p2nqsd0c76g0\LocalCache\codex-windows-runtime-framework-1cQY45\OpenAI.CodexPrimaryRuntime.v26-1007-641-0.msix
- 验证：重开后主进程存活 236 秒以上（此前 10~60 秒必崩），无弹窗、无新崩溃产物；日志 primary_runtime_install_started → windows_primary_runtime_framework_ready bundleVersion=26.1007.11041；运行时包已注册（26.1007.641.0，Ok，IsFramework）。
- 风险/待办：仍是 workaround，未来运行时更新可能复发（复发时对新下载的 msix 重复同样操作）；勿卸载商店版应用（有人卸载后 ~/.codex 历史被清）；13 份 msix 缓存（6.4GB）暂未清理，可按需清理。
