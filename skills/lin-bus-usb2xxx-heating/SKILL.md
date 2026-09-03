---
name: lin-bus-usb2xxx-heating
description: Control heating products (A045/A050 PTC heaters) over LIN bus with USB2XXX adapters — multi-device management, command/measurement/fault PIDs, 8-byte frames, power steps. Use when integrating or debugging LIN-based heating test stations.
allowed-tools: Read, Grep, Bash
---

# LIN 总线加热产品通讯（USB2XXX 适配器）

## 适用场景

通过 USB2LIN（USB2XXX 系列）适配器驱动 LIN 总线上的加热产品（A045/A050 协议）：吸合/断开、功率请求、状态与故障读取。参考实现：`Heating-LIN`（`lin_device_manager.py`、`lin_service.py`、`a045_protocol.py`、`a050_protocol.py`、`usb2lin_ex.py`，配套 pytest 全覆盖）。

## 协议要点（A050，源自 A050.xlsx）

- 帧 8 字节；PID：**0x36 命令、0x37 测量/状态、0x39 故障状态**。
- 命令态：0=断开（disengage）、1=吸合（engage）。
- 功率请求 raw：**1 raw = 50 W**（`POWER_STEP_W`），最大 raw 0xFF。
- 运行状态：0 正常、1 降级运行；电压故障：0 无、1 过压、2 欠压；IGBT 故障：0 无、1 短路、2 开路、3 电压驱动击穿。
- A045 与 A050 协议存在差异，按产品型号路由（`product_catalog.py`），不要共用编解码。

## 设备管理

- 多适配器按 **SN 序列号**管理：`USB_ScanDevice` 扫描 → `open_all_devices(sn_list)` → 每设备独立锁（`device_locks`），通道状态按 (SN, 通道) 记账。
- **设备已打开时跳过强制重扫描**，返回缓存目录（避免重扫导致句柄失效）。
- 电源输出控制用 `usb2lin_ex.LIN_EX_CtrlPowerOut`。
- 异常分层：`DeviceNotFoundError / NativeDriverError / LinCommunicationError / LinServiceError`，上层按类型决定重试或跳过。

## 操作顺序

1. 扫描设备、按 SN 打开、确认通道状态。
2. 按产品型号选协议（A045/A050），编码命令帧发 0x36。
3. 轮询 0x37 读测量/状态、0x39 读故障位，异常态先断开功率再报警。
4. 结束时按通道逐一断开释放。

## 坑与红线

- native 库调用统一走 `_call_native` 包装（错误码检查），不要裸调 ctypes。
- 功率写入前确认当前产品协议的最大功率档，50 W 步进意味着小数功率不可表达，取舍要记录。
- 故障态（过压/欠压/IGBT）下继续发功率请求可能损坏硬件，必须先断开。

## 验证清单

- `test_a050_protocol.py`、`test_lin_device_manager.py` 等全绿后再上真机。
- 真机：吸合→测量值上升→断开→功率归零；故障注入路径（如拔适配器）能触发 `DeviceNotFoundError` 并恢复。
