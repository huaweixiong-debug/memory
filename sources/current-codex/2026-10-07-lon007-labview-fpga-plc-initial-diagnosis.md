# 2026-10-07 LON007 BMW LabVIEW 启动故障初诊

- 用户提供的截图显示 NI Vision Development Module 2018 SP1 Runtime 因电脑硬件变化处于 Backup 许可，剩余 7 天；需用合法许可重新激活，和 FPGA/PLC 通信故障分开处理。
- 项目只读配置显示 FPGA RIO 目标与 Snap7 PLC 分属不同配置端点；事件详情为 `Get PLC Live.vi` 错误 -1、`PLC is NOT Live`，另有 `FPGA Init Error`。当前证据更指向替换电脑后的网卡/设备可达性、NI-RIO 安装/枚举或 PLC Live 信号，尚未确认具体根因。
- `Application2.ini` 同时含旧备份路径 `I:\test` 与项目内 C 盘备份路径，截图记录两处备份失败；项目备份目录里已有今日和历史快照，未修改任何配置或数据。
- 当前只有远程项目文件共享权限；WinRM/WMI 与 DCOM 查询均不可用，无法从本端验证远程网卡 IP、NI MAX 设备状态或现场 PLC 状态。下一步应在远端只读核对 IPv4 地址、PLC TCP 102 可达性、NI MAX 中 RIO 目标及 NI-RIO 软件；确认后再决定最小修复。未写 PLC、未下载 FPGA、未改配置、未重启程序。
