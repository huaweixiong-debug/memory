---
name: ateq-leak-tester-modbus
description: Operate ATEQ leak/seal testers (F5/F620 family) over Modbus — start/reset coils, read realtime status registers, parse pass/fail, units and pressure/leak values. Use when integrating or debugging ATEQ instruments on a production line.
allowed-tools: Read, Grep, Bash
---

# ATEQ 检漏仪 Modbus 通讯

## 适用场景

ATEQ 气密/泄漏测试仪（F5/F620 系列）通过 Modbus 串口接入产线上位机：启动/复位测试、读实时状态（程序号、判定、压力、泄漏率）、解析结果。不适用于：改仪器参数文件、校准（走仪器面板或专用软件）。

## 现场参数（来自本项目实际配置）

- 串口：**COM3，9600/E/8/1（偶校验）**，从站地址 1。
- 常用拓扑：串口经 serial-to-TCP 桥暴露为 Modbus TCP（端口 502），Python 侧用 socket 直发 RTU 帧（见 `ateq_modbus.py`）。
- 参考实现仓库：`hc-leak-test-print`、`ALW-Leak-Test`、`Leak-Test-Scan-C`（C# 版）、`ATJ-ATEQ-Seal-Test`、`D620`、`xiezhong-Morocco-2-stations`（F620 双工位）。

## 核心寄存器/线圈（F5 协议）

| 操作 | 地址 | 说明 |
|---|---|---|
| 写线圈 0x01 = FF00 | START | 启动测试 |
| 写线圈 0x00 = FF00 | RESET | 停止/复位仪器 |
| 读保持寄存器 0x30 ×13 | 实时状态 | Word0 程序号、Word1 FIFO、Word2 测试类型、Word3 状态位、Word4 步码 stepcode、Word5-6 压力、Word7-8 压力单位码、Word9-10 泄漏率、Word11-12 泄漏单位码 |
| 读保持寄存器 0x20 ×1 | stepcode | 当前测试阶段码 |

- 压力/泄漏率为 32 位值，跨两个寄存器且**字内字节交换**，原始值 ÷1000 得工程量；单位码为 24 位（kPa=12000、MPa=13000、Bar=11000、mBar=10000、Pa=6000、PSI=8000、mL/min=51000、inch³/min=47000 等，完整表见 `ateq_modbus.py:get_unit_name`）。
- 状态位（F5 协议，Word3）：bit0 合格、bit1 测试件不合格、bit2 参考件不合格、bit3 报警、bit4 压力错误、bit5 循环结束、bit15 键盘锁定。

## 操作顺序

1. 先读 0x30 实时状态确认仪器在线、无报警，再发控制命令。
2. 启动测试：写线圈 0x01。停止/复位：写线圈 0x00。
3. 测试期间轮询 0x30，等 bit5（循环结束）置位后读判定与测量值；期间可读 0x20 stepcode 跟踪阶段。
4. 结果必须以寄存器判定位为准，不要以"发送成功"为准。

## 坑与红线

- **`start_ateq.py` / `reset_ateq.py` 会执行线圈写操作，直接影响真实设备状态**；不要与 WebUI 启动脚本混淆（来自 2026-09-01 ATEQ 远端故障记录）。
- 压力/泄漏的 32 位解析顺序错一位，数值会差几个数量级——直接复用 `ateq_response_parser.py`，不要手写偏移。
- ATEQ 串口是**偶校验**，扫描枪和耐压仪是**无校验**，别复制粘贴串口配置。
- WebUI 服务（`webui_server.py`，0.0.0.0:8001，入口 `start_github_webui.bat`，计划任务 `\ATEQNodeServer`）只读不写；怀疑仪器状态异常时先读 0x30 而不是先复位。

## 验证清单

- 0x30 返回 13 字寄存器、CRC 校验通过。
- 启动后 stepcode 沿阶段推进，结束时判定位 bit0 或 bit1 置位。
- 压力/泄漏值带正确单位（对照仪器面板显示）。
