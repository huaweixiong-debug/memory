---
name: can-bus-ptc-heating
description: Work with CAN-bus PTC heater testing (BAIC ECC-ThermalBUS) using USB2CAN adapters and DBC files — DBC-driven frame encode/decode, environment notes. Use when integrating CAN-based thermal product test stations.
allowed-tools: Read, Grep, Bash
---

# CAN 总线 PTC 加热测试（USB2CAN + DBC）

## 适用场景

BAIC 3.0 平台 ECC-ThermalBUS PTC 加热器的 CAN 总线测试工位。仓库：`heating-can`（DBC 与协议资料齐全，Python 侧 `python_wrapper.py`、`USB2CAN/`、`LGV2/`、`OPCOPC.xml`）。

## 关键资产

- **DBC 文件**：`BAIC_3.0 ECC-ThemalBUS_PTC_CAN_V1.10_20250927.dbc`（配套 xlsx 为可读版本）——报文/信号定义以 DBC 为准，编解码用 cantools 或厂商 DLL 加载，不要手写位偏移。
- **适配器**：USB2CAN（USB2XXX 同厂商驱动体系，与 LIN 技能中的 SN 管理方式一致）。
- `OPCOPC.xml`：OPC 侧节点配置；`config.json`：通道与产品配置。
- 环境注意：现场 Python 解释器是 `D:\miniconda3\python.exe`，`python_wrapper.py` 负责解释器选择，直接用系统 python 可能缺依赖。

## 操作顺序

1. 从 DBC 生成/核对信号表，确认 PTC 报文的周期信号与控制信号（使能、目标温度/功率）。
2. 打开 USB2CAN 通道，配置波特率与终端（与整车/台架一致）。
3. 发控制报文前先监听验证总线上有周期报文且信号解析正常。
4. 测试中记录原始帧 + 解析信号双份，便于与客户（主机厂）对帧。

## 坑与红线

- 主机厂 DBC 版本会迭代（文件名带日期版本 V1.10）：换版必须 diff 信号布局，不能假设兼容。
- 报文含 multiplexed 信号时，解析前先读多路复用位，cantools decode 需允许 `decode_choices`/`allow_truncated` 按需设置。
- 保密：DBC/xlsx 属客户协议资料，只在私有仓库，不得外传。

## 验证清单

- DBC 加载无警告，关键信号（电压、电流、温度、使能）解析值与台架显示一致。
- 使能/关断指令在总线上可见且设备响应正确。
