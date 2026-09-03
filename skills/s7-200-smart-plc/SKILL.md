---
name: s7-200-smart-plc
description: Communicate with Siemens S7-200 SMART PLCs via python-snap7 — connect with correct rack/slot/TSAP, read/write V/M/Q/I areas as bit/word/real, avoid snap7 3.x connection pitfalls. Use when wiring a new station or debugging PLC data exchange.
allowed-tools: Read, Grep, Bash
---

# S7-200 SMART PLC 通讯（python-snap7）

## 适用场景

上位机（Python/C#）与 S7-200 SMART 交换数据：拍照/启动/完成等握手位，温度、压力等 Real 参数，配方号等 Int 值。参考实现：`dexin-hi-pot-test`（`server/drivers/snap7_plc.py`）、`hc-leak-test-print`（`s7_communication.py`、`S7-200 Smart Com.py`）、`xiezhong-Morocco-2-stations`。

## 连接参数

- 默认 `rack=0, slot=1`，TCP 端口 102；IP 以现场为准（例：192.168.2.1）。
- **snap7 ≥3.x 的坑**：`Client.connect()` 会按 rack/slot 重算 remote_tsap 并覆盖自定义连接参数。需要自定义 TSAP 时（如走 CP243-1 或经典 S7-200），必须先 `set_connection_params(ip, local_tsap, remote_tsap)` 再走自定义 ISOTCP 连接（见 `dexin-hi-pot-test/server/drivers/snap7_plc.py`）。
- 经典 S7-200 的 V 区经 CP243-1 映射为 **DB1**。

## 地址读写约定

- 位引用：`Q0.2 / I0.0 / M10.1 / V50.3`（区 + 字节.位）。
- 字/双字：`VW100`（16位）、`MD40` / `VD100`（32位 Real）。
- M 区 Real（MDx）：`mb_read(md, 4)` 读 4 字节，`struct.unpack('!f')` 大端转浮点；写用 `struct.pack('!f', value)` 后 `mb_write`。
- M 区位写：**先读回整字节、改位、再写回**（避免覆盖同字节其他位），参考 `s7_communication.py:write_bool_m`。
- Int（MW）：2 字节，大端有符号。

## 操作顺序

1. 连接后先 `get_connected()` 确认，再注册轮询/握手逻辑。
2. 上线前与电气确认地址表（哪个 M 点是拍照、哪个 MD 是参数），写清注释；**Modbus 地址习惯从 1 开始，S7 字节地址从 0 开始**，注释里写清换算。
3. 写 Real 前先读回验证一次（值匹配再进入自动流程）。
4. 通讯日志写文件（`s7_plc.log`），连接异常要带 IP 和异常文本。

## 坑与红线

- 干跑模式（`dry_run` 或 IP 为空）下驱动必须走模拟分支，绝不真写 PLC——dexin 驱动自带此开关，新项目沿用。
- 位写覆盖同字节其他位是最常见事故，必须读改写。
- 仪器测试周期内不要频繁写 PLC 握手位，等测试流程节点。

## 验证清单

- `get_connected()` 为 True，读写各一次成功且值匹配。
- 实际设备验证：上位机改一个 MD 值，PLC 侧（编程软件/触摸屏）能看到同步变化。
