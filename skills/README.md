# skills/ — 跨账号设备/仪器技能库

面向产线自动化常用设备与通讯协议的共享技能（SKILL.md 格式，Codex / OpenCode / ZCode 通用）。内容从各项目仓库的**实际源码与现场配置**提炼，标注了参考实现仓库；改动参数时以仓库最新代码为准。

## 索引

| 技能 | 设备/协议 | 参考仓库 |
|---|---|---|
| `ateq-leak-tester-modbus` | ATEQ F5/F620 检漏仪，Modbus RTU（串口 9600/E/8/1，从站 1） | hc-leak-test-print, ALW-Leak-Test, Leak-Test-Scan-C, ATJ-ATEQ-Seal-Test, D620, xiezhong-Morocco-2-stations |
| `s7-200-smart-plc` | 西门子 S7-200 SMART，python-snap7（V/M/Q/I 区） | dexin-hi-pot-test, hc-leak-test-print, xiezhong-Morocco-2-stations |
| `th-scpi-hipot-serial` | 同惠 TH9310/20 耐压仪，RS232 SCPI 9600-8-N-1 | dexin-hi-pot-test |
| `kilews-screwdriver-modbus` | 奇力速 KL-NTCS-M7 电动螺丝刀，Modbus（0.1° 角度换算） | txv-vision-screw |
| `barcode-scanner-serial` | 扫码枪串口/键盘双模式（9600-N-8-1，重复帧折叠） | hc-leak-test-print, dexin-hi-pot-test |
| `bartender-label-print` | BarTender 标签打印（bartend.exe 命令行） | hc-leak-test-print, xiezhong-Morocco-2-stations, Yida-Marking-Printing |
| `lin-bus-usb2xxx-heating` | LIN 总线加热产品 A045/A050，USB2XXX 适配器 | Heating-LIN |
| `can-bus-ptc-heating` | CAN 总线 PTC 加热（BAIC ThermalBUS DBC），USB2CAN | heating-can |
| `chatgpt-proxy-guard` | "南美"Clash 客户端：ChatGPT 不可达时自动切换节点（PowerShell + mihomo API） | 无仓库（本机实测，Windows 环境部署类技能） |

## 维护规则

1. 新增技能放 `skills/<kebab-case-name>/SKILL.md`，frontmatter 至少含 `name` 与 `description`（描述写清"何时用"，供各 agent 触发判断）。
2. 技能内容必须是**现场验证过的事实**：注明参考仓库与关键文件；协议细节以仓库最新代码为准，技能只保留操作流程、参数与坑。
3. 现场参数（COM 口、IP、寄存器表）变动时同步更新对应技能与来源仓库。
4. 设备类技能默认"读安全、写危险"：任何写操作（线圈/寄存器/PLC 位）先确认目标设备真实在线，质量关键参数（扭矩、耐压、气密阈值）改动前需用户确认。

生成：2026-09-03，由 ZCode 从 huaweixiong-debug 名下 15 个自动化仓库提炼。
