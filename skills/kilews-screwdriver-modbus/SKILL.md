---
name: kilews-screwdriver-modbus
description: Configure and drive Kilews (奇力速) electric screwdriver controllers (e.g. KL-NTCS-M7) over Modbus — torque/angle target registers with 0.1° scaling, job switching, parameter write flow. Use when integrating smart screwdriving stations.
allowed-tools: Read, Grep, Bash
---

# 奇力速电动螺丝刀 Modbus 参数与控制

## 适用场景

智能拧紧工位：设置拧紧方式（扭矩控制+角度监控）、目标扭矩、扭矩/角度上下限，Job 切换后补写参数。参考实现：`txv-vision-screw`（`app/hardware/kilews.py`，修复记录 `KILEWS_MODBUS_FIX_NOTE.md`）。

## 现场已验证配置（KL-NTCS-M7）

- 拧紧方式：**扭矩控制 + 角度监控**（target_type=2 扭矩；target_type=1 角度），不是纯角度控制。
- 目标扭矩 3 N·m，下限 2 N·m，上限 5 N·m。
- 角度监控下限 700°，上限 12000°。

## 寄存器约定

- 相关寄存器：`REG_TARGET_ANGLE`、`REG_ANGLE_HI`、`REG_ANGLE_LO`、目标扭矩与扭矩上下限寄存器。
- **角度寄存器按 0.1° 为单位写 raw 值**：700° → 7000，12000° → 120000（`ANGLE_SCALE=10`）。解码 `_decode_angle()` 同样按 0.1° 换算。
- 写入流程 `write_all_flow()`：**先统一把工程量换算成 raw 值，再逐个写寄存器**；不要直接写工程量。

## 操作顺序

1. 连接后读当前 Job 与参数，确认基线。
2. 按 raw 值写入目标类型、目标扭矩、上下限、角度上下限。
3. Job 切换后必须**补写角度监控上下限**（切换会重置）。
4. 写完读回核验，再放行自动拧紧流程。

## 坑与红线

- 历史事故：旧逻辑直接把工程量（如 700）写进 0.1° 单位寄存器，实际角度只有 70°——换算必须集中在一处做。
- 扭矩单位 N·m，注意与 cN·m/mN·m 型号手册的差异，以现场控制器实测为准。
- 拧紧参数属于质量关键参数，改动前必须获得用户/工艺确认，改动后留记录。

## 验证清单

- 读回的扭矩/角度参数与工艺要求一致（含 0.1° 换算后）。
- 实际拧紧验证：达标件 PASS、故意拧过头件触发角度超限报警。
