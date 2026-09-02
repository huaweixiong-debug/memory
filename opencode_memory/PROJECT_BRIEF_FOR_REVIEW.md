# Chiller Line 2 — Heating.vi → Python 替代项目技术简报（供 Codex 确认）

> 目的：请 Codex 核对以下全部理解、映射与替代逻辑是否正确、是否有遗漏风险。
> 本文档所有事实均标注证据来源；【已验证】= 现场实读/实测，【待确认】= 仍需现场或
> 影子验证。日期：2026-08-29。整理：OpenCode（GLM）。

---

## 1. 项目目标

将 Chiller Line 2 烘干工位的 LabVIEW 程序 `Heating.vi`（位于现场机
`D:\Chiller Line 2\`）替换为 Python 程序包 `heating_python`，功能与行为对齐：

- 扫描流水码 → 客户码分配（幂等）→ 激光打码 → 烘干计时 → 结果落库
- 与 PLC/温度采集的交互路径、时序、数值与 Heating.vi 完全一致
- 回滚路径随时可用（Heating.vi / 应用程序.exe 保留原样）

## 2. 现场拓扑与访问

| 项 | 值 | 证据 |
|---|---|---|
| 现场机 | `100.74.196.22`（Tailscale）= `192.168.3.179`（现场网段）= `DESKTOP-47FN6P3`（主机名）= `xiezhong-heating`（Tailscale 名）| 【已验证】SSH 实测 |
| SSH | 用户 `dell`（高完整性级，管理员组）| 【已验证】|
| 项目目录 | `D:\Chiller Line 2\` | 【已验证】|
| 远程 Python | 64 位：`C:\Users\dell\AppData\Local\Programs\Python\Python312\python.exe`；**32 位（生产运行用）**：`C:\Users\dell\py311w32\python.exe`（3.11.9 embed + pywin32 + pymysql + comtypes）| 【已验证】|
| MySQL | `192.168.3.140:3306`，root/root，库 `test`，表 `information`（81,882 行，全 varchar(255)，表字符集 latin1）| 【已验证】实连查询 |
| 上一版备份 | `D:\Chiller Line 2\heating_python_backup_20260829\` | 【已验证】|

## 3. 通讯架构（自上而下）

```
Heating.vi / heating_python
   │ ① 共享变量 \\192.168.3.179\OPC\<变量名>（PSP 协议）
   ▼
NI Variable Engine (SVE, NITaggerService)      ← LabVIEW 工程运行时部署变量
   │ ② OPC DA
NI OPC Servers 2016（Kepware 内核，server_runtime.exe，随服务自启）
   │ ③ 驱动
   ├─ Channel1「Mitsubishi FX」→ FX3U 主 PLC —— COM6 串口, 9600, 7E1, RTS Always
   ├─ Channel4「Modbus Ethernet」→ <192.168.3.32>, unit 0, TCP 502 —— 8 路温度
   └─ 扫描枪1「Modbus Ethernet」→ 192.168.3.61:8889（无标签）
```

- Python 替代后的等价通路：`heating_python` ──④ OPC DA──▶ **SVE**（与 ① 同源）
  - 已实测：SVE DA 可连（ServerState=1）；工程未运行时命名空间为空（fail closed）
- UA 端点 `opc.tcp://127.0.0.1:49350`（仅回环）存在但**不可用**：客户端证书被无条件
  拒绝，且无信任配置面（settings.ini 仅 EndPoint0-7）【已验证】
- Kepware DA（COM）激活对所有身份（dell/SYSTEM）返回 `CLASS_E_NOTLICENSED(0x80040112)`
  —— 直连 Kepware 不可行【已验证】
- 192.168.3.32:502 仅接受 **1 个 Modbus TCP 会话**，Kepware 常驻占用；第二个客户端
  TCP 握手成功但请求全部超时【已验证】
- Kepware 运行时同时监听本机 `0.0.0.0:502`（Modbus unsolicited 服务端模式，映射未知，未采用）
- 事件日志显示 Channel1（FX3U）曾 not responding、M0205/M0907/M0908 写入失败
  —— **串口链路健康状况是首要现场检查项**【已验证】

## 4. 已验证地址映射（32 个绑定变量）

来源：NI OPC Servers 工程 `default.opf`（二进制实读）⊕ Kepware 项目 XML 导出
`Simulation Driver Demo.xml`（用户提供，权威）。两者一致，XML 补齐了二进制中不可分
辨的部分。

### 4.1 Channel1 → Mitsubishi FX3U（24 点，路径前缀 `Channel1.Device1.*`）

| OPC 变量名 | PLC 软元件 | 类型 | 备注 |
|---|---|---|---|
| m100-m104 | M0100-M0104 | Boolean | 控制位 |
| **m105开始读取（烘干）** | **M0205** ⚠️ | Boolean | 不是 M0105 |
| m106缓存数据信号 | M0106 | Boolean | |
| **m107激光1，3启动** | **M0907** ⚠️ | Boolean | 不是 M0107 |
| **m108激光2，4启动** | **M0908** ⚠️ | Boolean | 不是 M0108 |
| m159 | M0159 | Boolean | 用途待确认 |
| 报警 | M0129 | Boolean | |
| D202当前流量（烘干） | D0202 | **Float** ⚠️ 32 位 | raw Modbus 占 2 寄存器 |
| D212温度1#缓存 | D0212 | **Float** ⚠️ | 同上 |
| D222温度2#缓存 | D0222 | **Float** ⚠️ | 同上 |
| D225温度3#缓存 | D0225 | Short | |
| D226时间设定（烘干—） | D0226 | Short | 工艺时间 |
| D227-D231温度4#-8#缓存 | D0227-D0231 | Short | |
| D232流量缓存 | D0232 | Short | |
| D233时间缓存 | D0233 | Short | |
| 正吹时间 | **T013** ⚠️ | Short | T051 是"反吹时间"（未绑定），勿混淆 |

未绑定（Kepware 有、OPC.lvlib 无）：d10→D0010、d40→D0040、反吹时间→T051。

### 4.2 Channel4 → 192.168.3.32（8 点）

| OPC 变量名 | Kepware 引用 | 协议地址 | 类型 |
|---|---|---|---|
| 1温度 … 8温度 | 40001 … 40008 | 0 … 7 | Word |

`ZeroBasedAddressing=true`（与协议地址 0 基一致）。类型 Word（U16）。

## 5. 状态机逻辑（heating_python 的行为规范）

状态：`IDLE → WAIT_SCAN → VALIDATE → ALLOCATE_CODE → LASER_READY → HEATING → COMPLETE → WAIT_SCAN`（任一步可 → FAULT/STOPPED，操作员恢复）。

关键语义：

1. **扫描闩锁**：扫描是显式外部事件（操作员/HMI 提交）。串码与当时的配方在扫描时刻
   闩锁，之后不被 PLC 快照或第二次扫描覆盖。
2. **m105 握手**：`submit_scan` 时经 OPC 写 m105=TRUE；状态机在 WAIT_SCAN tick 中观察到
   快照 start_signal=TRUE 后写回 FALSE（应答）并推进。【⚠️ 待确认】m105 的真实驱动方向
   （PLC 发起还是上位机发起）—— 将用影子录制（monitor）核对，可能需要调整时序。
3. **激光**：`laser.mode='plc_bits'` 时 `mark(code)` = m107&m108 同时写 TRUE → 保持 1s →
   写 FALSE；客户码本身经数据库 `information.激光码信息` 传递【已验证：生产数据形状】。
   【⚠️ 待确认】激光控制器如何取得码内容（TCP？读库？）—— TCP Client.vi 为通用封装，
   无协议载荷；需要一次真实打码的影子录制或协议文档。
4. **烘干计时**：以配置配方 `default_recipe.time_setting`（当前=100s，与生产
   `烘干时间='100.000000'` 一致）为权威，注入时钟计时；超时（600s）熔断。PLC D0226 为
   显示对照，切换前必须与配置一致（核对清单项）。
5. **完成落库**：HEATING 结束 → `save_result`（MySQL）→ 写 D202=1 → COMPLETE。两者任一
   未确认即 FAULT（fail closed）。同进程内同串码绝不二次落库；跨重启由 DB 侧幂等保护
   （见 §6）。
6. **失败模型**：任何适配器异常/串码非法/分配为空/激光失败/配方未设置/超时 → FAULT。

## 6. 数据库契约（生产 SQL 逐字复刻）

表 `test.information`（81,882 行，全 varchar(255)）。烘干工位实际有两站
（烘干工位='1'/'2'）。

烘干结果保存.vi 中的生产语句（GBK 原文解码）：

```sql
update information set 烘干日期='%s',烘干温度1='%s',烘干温度2='%s',烘干流量='%s',
烘干时间='%s',烘干工位='%s',激光码信息='%s' where 流水码编号='%s';
```

生产实值样例（2026-08-27）：

| 列 | 样例 | 说明 |
|---|---|---|
| 烘干日期 | `2026-08-27 16:15:44` | 完成时刻 |
| 烘干温度1 / 温度2 | `473` / `185`，或 `0`/`0` | 数值含义待影子核对（可能是 tag 实值）|
| 烘干流量 | `OK` | **实际存判定结果**（OK/NG），非流量 |
| 烘干时间 | `100.000000` | 配方时间（6 位小数格式）|
| 烘干工位 | `1` / `2` | 站号 |
| 激光码信息 | `10067001111109260827000152` | 26 位客户码 |
| where 流水码编号 | `EV80039100202608270002` | 流水码 |

Python 侧 `MysqlResultPersistence.save_result`：

- 复刻同一 UPDATE；`烘干流量` 写 'OK'/'NG'；`烘干时间` = `f"{time_setting:.6f}"`
- **跨重启幂等**：若该行 `烘干日期` 已非空 → 跳过重写（replay）并返回成功
- 行不存在（串码未在上游注册）→ fail closed 报错，不 INSERT
- 保存后回读校验，未落库即抛错

## 7. 客户码分配

- 复用既有 `customer_code_fix` 包（事务式、幂等分配；规则：产品前缀 14 位 + YYMMDD +
  6 位流水）
- 生产数据佐证：激光码 `10067001111109260827000152` = `1006700111110` + `9260827` + `000152`
- 数据库 `information` 表无唯一约束（81,676 行历史数据审计过），去重依赖应用层

## 8. Python 实现（heating_python 包）

| 文件 | 作用 | 状态 |
|---|---|---|
| `address_map.py` | 32 点已验证地址表 + `PLC_DATA_TYPES` 类型表 | 【已验证】|
| `live_da.py` | OpcDaSveAdapter：SVE OPC DA（OPCDAAuto/32 位），浏览发现 item ID（缓存 JSON），SyncRead/SyncWrite，快照填充语义与仿真一致（绝不写 serial_code/recipe）| 新增，单测覆盖（fake COM）|
| `live_opc.py` | OpcUaAdapter（UA 路线，当前被证书信任阻塞；保留备用）| 已实现 |
| `live_modbus.py` | 原始 Modbus/TCP（零依赖，按操作短连接）—— 温度 bank 直连仅在维护窗口可用 | 已实现 |
| `live_laser.py` | LaserPlcBitsAdapter（m107/m108 脉冲）| 新增，单测覆盖 |
| `live_persistence.py` | MysqlResultPersistence（§6 契约）| 新增，单测覆盖 |
| `state_machine.py` | 确定性状态机（注入时钟，无真实睡眠）| 原有 |
| `cli.py` | `simulate` / `live`（真实构建）/ `probe`（UA 只读）/ `monitor`（SVE 影子录制）/ `status` | 已扩展 |
| `tools/` | field_probe_modbus / field_probe_opcua 独立探测脚本 | |
| 测试 | 本地 Python3.10：**122/122**；远程 Python3.12：**122/122**；远程 32 位 py311w32 可导入 | 【已验证】|

启动器（现场机双击）：`RUN_SHADOW_MONITOR.cmd`（影子录制）、`RUN_PROBE.cmd`。

## 9. 风险与开放问题（请 Codex 重点核对）

1. **m105 握手方向未定**：状态机假设"上位机写 m105=TRUE → 观察到后回 FALSE"。若实际
   是 PLC 侧驱动 m105，需要把 WAIT_SCAN 改为"等待 PLC 脉冲 + 上位机应答"。→ 用
   `monitor` 影子录制一个真实周期即可裁定。
2. **激光码到达路径未定**：打码机如何拿到 26 位码。 Heating.vi 里仅见 m107/m108 启动位；
   激光码信息写进 DB。若打码机软件读库，Python 替代无需额外实现；若走 TCP，
   需要协议（TCP Client.vi 无载荷，需抓包或文档）。
3. **FX3U 串口链路健康**：事件日志有 not responding 与 M0205 写失败记录。
4. **烘干温度1/温度2 列语义**：样例值 473/185/0，未确认对应哪两个 tag
   （当前映射 temperatures[0]/[1]，即 1温度/2温度；影子核对后可改
   `persistence.temp1_index/temp2_index`）。
5. **D202/D212/D222 为 Float**：经 OPC 读写无字序问题；若未来走 raw Modbus 写，
   必须先现场核对 2 寄存器字序。
6. **D0226 与配置配方的核对**：切换前需确认 PLC 内 D0226=100（或与配置一致）。
7. **扫描枪1（192.168.3.61:8889）**：无标签配置，扫描枪如何把串码交给系统
   （键盘口？HMI？）未在本次范围内验证。
8. **两站问题**：`information` 有烘干工位='1'/'2' 两站。当前 config_live.json
   station_id='1'。若两站共用一台上位机，并发/互斥需要明确。

## 10. 切换计划（维护窗口步骤）

1. 用户启动 LabVIEW 工程或应用程序.exe（部署共享变量）
2. `RUN_SHADOW_MONITOR.cmd` 影子录制 + Heating.vi 跑 1 个真实周期 → 停止录制
3. 核对录制：m105 方向、激光位时序、D202 时机、温度数值
4. （如需）按录制调整状态机握手
5. 维护窗口：停 Heating.vi →
   `py311w32\python.exe -m heating_python live --config heating_python\config_live.json --run-once --serial-code <真实流水码>`
   → 对照 DB 行与面板
6. 操作员验收 → 后续周期交 Python；Heating.vi/应用程序.exe 保留为回滚

## 11. 回滚

- 运行层：重新启动 `应用程序.exe`（Heating.vi）即回到原生产路径；heating_python 不改动
  任何 VI/数据库结构
- 代码备份：`heating_python_backup_20260829\`
- 现场机系统级变更（均可逆）：`SysWOW64\OPCDAAuto.dll` 注册（regsvr32 /u 回滚）；
  64 位视图 surrogate 注册表键（删除即可）；3 个 UA 探测证书留在
  `RejectedCertificates`；NI OPC Servers 服务重启 3 次（授权窗口内）
- py311w32 / ._pth 追加 `D:\Chiller Line 2` / RUN_*.cmd —— 纯增量，删除即回滚

## 12. 关键文件索引

| 文件 | 说明 |
|---|---|
| `heating_python\ADDRESS_MAP.md` | 地址映射证据链全文 |
| `heating_python\config_live.json` | 生产配置（现场机）|
| `heating_python\config_sample.json` | 脱敏样例（无凭据）|
| `heating_python\tests\` | 122 项测试 |
| `C:\ProgramData\...\NI OPC Servers\V2016\default.opf` | Kepware 活动工程（现场机）|
| `Simulation Driver Demo.xml` | Kepware 项目 XML 导出（用户提供）|
| `P:\memory\opencode_memory\MEMORY.md` | 跨会话记忆（2026-08-29 两条）|

---

**请 Codex 确认**：① 地址映射与类型表是否与 Kepware 配置一致；② 状态机时序与
m105/激光语义是否有误；③ MySQL 契约复刻是否完整；④ §9 风险清单是否有遗漏；
⑤ 切换步骤是否有安全隐患。
