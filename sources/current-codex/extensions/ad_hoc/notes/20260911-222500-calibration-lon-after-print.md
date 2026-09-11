# 校准打印后自动开启扫码

- 2026-09-11：远程 B UI 日志在用户截图对应时段没有新的 `PLC_M16_1_RISE`、`ATEQ_START_REQUEST` 或 `TEST_RESULT`，因此“启动验证”只进入等待状态，不能代替 PLC 的 `M16.1` 测试启动沿。
- 已在校准标签和生产标签收到成功打印回执后统一调用共用扫码枪 `set_scan_enabled(True)`，发送 `LON`；TCP 断线时由 `TcpScanner` 排队并在重连后重放，打印失败不发送。
- 当前远程 UI 已重启并重新连上 PLC/COM6；现场扫码枪 `192.168.2.10:9004` 仍返回 TCP refused，需设备端开启 TCP Server。
