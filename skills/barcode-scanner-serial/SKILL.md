---
name: barcode-scanner-serial
description: Handle production barcode scanners — serial-port listening with frame splitting, dedup of repeated scans, and keyboard-wedge dual mode. Use when wiring scan-triggered test workflows or debugging missed/duplicated scans.
allowed-tools: Read, Grep, Bash
---

# 产线扫码枪接入（串口 + 键盘模拟双模式）

## 适用场景

扫码触发测试流程（扫码 → 匹配产品 → 启动仪器）。参考实现：`hc-leak-test-print/serial_scanner.py`（串口模式，含 pytest）、`dexin-hi-pot-test/server/drivers/scanner.py`（串码枪 COM 监听/键盘模拟双模式）。

## 串口模式参数（现场默认）

- 默认 `COM4，9600-8-N-1`，全部可用环境变量覆盖（`SCAN_SERIAL_PORT` 等）。
- 帧分隔符：`\n \r \t`；剥离字节：`\x00 \x02 \x03 \r \n \t 空格`（去 NUL/STX/ETX）。
- 帧切分：空闲 **0.45 秒**（`SCAN_IDLE_SECONDS`）判定一帧结束。
- 断线自动重连间隔 2 秒。

## 关键逻辑

- **重复帧折叠**：部分扫码枪会把同一码连续发多遍。`_collapse_repeated_scan()` 探测"整串 = 某长度单元 × N 次重复"并折叠为一次，重复次数保留在状态里。最短重复单元 4 字节。
- 扫描状态含 `seq/code/raw_hex/timestamp/port/connected/error`，供上层 UI 与测试记录关联。
- 键盘模拟模式（keyboard wedge）：扫码枪当 HID 键盘，适合不能占串口的场景；与串口模式二选一配置。

## 操作顺序

1. `target_serial_scan_test.bat` / `scan_serial_test.py` 先验证枪到串口的原始字节流。
2. 接入 `serial_scanner` 常驻监听，确认日志里码值、时间戳正确。
3. 再对接测试工作流（扫码匹配 → 允许启动），不要跳过第 1 步直接上产线。

## 坑与红线

- 扫码枪串口是 **9600-N-8-1**，ATEQ 是 9600-E-8-1——同一线体多串口时容易配反。
- 同码连扫若未折叠，会造成"同一件测两次"或 FIFO 混乱，上线前必须验证折叠逻辑。
- 扫码枪偶尔发乱码帧：保留 raw_hex 便于事后排查，不要只存清洗后的码值。

## 验证清单

- 连续扫同一码 5 次，日志与状态机只推进 1 帧（含重复计数）。
- 扫不同码间隔 <1 秒，两帧不粘连。
- 拔枪重插后 2 秒内自动恢复监听。
