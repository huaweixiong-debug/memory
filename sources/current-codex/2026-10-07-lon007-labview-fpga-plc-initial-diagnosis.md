# 2026-10-07 LON007 BMW LabVIEW 启动故障初诊

- 用户提供的截图显示 NI Vision Development Module 2018 SP1 Runtime 因电脑硬件变化处于 Backup 许可，剩余 7 天；需用合法许可重新激活，和 FPGA/PLC 通信故障分开处理。
- 截图初诊记录 `Get PLC Live.vi` 错误 -1、`PLC is NOT Live`，另有 `FPGA Init Error`；后续远程只读复核见下节。
- `Application2.ini` 同时含旧备份路径 `I:\test` 与项目内 C 盘备份路径，截图记录两处备份失败；项目备份目录里已有今日和历史快照，未修改任何配置或数据。
- 初查阶段尚无远程会话，随后用户提供 SSH 连接信息并完成只读核验；具体结果和未完成项见下节。全程未写 PLC、未下载 FPGA、未改配置、未重启程序。

## 2026-10-07 远程只读复核

- 用户确认 PLC 地址为 192.168.1.11，与 `System Setup\DRHost.ini` 中的 Snap7 配置一致。远程 PC Ethernet 4 (PLC) 为 192.168.1.2/24；PLC ping 与 TCP 102 均可达。
- 使用部署目录自带 x86 `snap7.dll` 做只读查询：Rack 0 / Slot 1 连接成功；`Cli_GetPlcStatus` 返回 0、CPU 状态 0x08 (RUN)；读取 DB110 成功。
- `IO Interface.ini` 将 PLC Live 配置为 DB110 偏移 2、长度 1。五次间隔读取中偏移 2 始终为 0，而偏移 0 曾由 0 变为 1，符合电脑侧 heartbeat 在更新、PLC Live 标志未置位的现象。事件日志错误 `PLC is NOT Live` 与该证据吻合。需检查 PLC 工程的 DB110 heartbeat/映射逻辑；不得用临时写 DB 或切 RUN 作为诊断。
- 部署目录扫描未发现 `.lvproj` / VI 源文件或 Siemens PLC 工程文件；当前仅有已编译应用和配置，无法在此处安全修改 PLC 心跳逻辑。尚未证明 PLC 逻辑为什么未置位。
- FPGA RIO 目标配置为 192.168.2.207，目标 ping、NI-RIO dumpinfo 和其公布的动态 RPC 端口可达，NI-RIO 18.5 已安装；这些仅证明基础可达，未验证 FPGA VI/bitfile 初始化。`FPGA Init Error` 原因仍未完全隔离。
- NI Vision Runtime 仍显示硬件变化后 Backup 许可剩 7 天，需通过 NI/供应商正式激活；它与 DB110 PLC Live 标志是两个独立待处理项。
- 本轮未写 PLC、未切换 CPU 状态、未重启应用、未修改业务配置或设备状态。

