---
name: th-scpi-hipot-serial
description: Drive Tonghui TH9310/20 hi-pot (withstand voltage) testers over RS232 SCPI — push test parameters with readback verify, start/stop tests, parse measurement frames (AC/IR). Use when integrating or debugging hipot stations.
allowed-tools: Read, Grep, Bash
---

# 同惠耐压测试仪 SCPI 串口驱动（TH9310/20）

## 适用场景

耐压绝缘测试工位：向仪器下发测试参数、启动测试、被动接收或主动查询测量结果（AC 耐压 + IR 绝缘电阻两步）。参考实现：`dexin-hi-pot-test/server/drivers/th_scpi.py`（有配套 pytest）。

## 串口参数

- **RS232，9600-8-N-1**（无校验；注意与 ATEQ 的偶校验区分）。
- 命令以 `\n` 结尾，ASCII；支持 RS-485 地址前缀（`addr_485` 参数拼在命令前）。

## 核心 SCPI 命令

| 命令 | 作用 |
|---|---|
| `FUNC:STAR` | 启动测试（实际发送形式，注意不是 FUNC:START） |
| `FUNC:STOP` | 停止/中止测试 |
| `FETCh?` | 查询测量帧 |

测量帧格式：`AC,<V>,<mA>,PASS;IR,<V>,<MOhm>,PASS(0x0A)`，由 `parse_fetch_line()` 解析。

## 参数下发（FUNC:SOUR:STEP，手册第5章）

7 项参数按序下发并**逐项读回核验**，任一项不符即拒绝启动：

```
STEP 1 (AC):  FUNC:SOUR:STEP 1:AC:VOLT <V>   / 1:AC:UPPC <mA上限> / 1:AC:TTIM <s>
STEP 2 (IR):  FUNC:SOUR:STEP 2:IR:VOLT <V>   / 2:IR:LOWC <电阻下限> / 2:IR:UPPC 0（上限清零）/ 2:IR:TTIM <s>
```

每条写命令后立即发对应 `?` 查询，`value_matches()` 比对（带容差），不匹配报显式错误。

## 操作顺序

1. 选型后先推参数并核验，再启动。
2. 启动方式可配：串口 `FUNC:STAR`、PLC 位脉冲、或 both；测试中轮询不干扰仪器。
3. 结果接收：仪器测试完自动上报帧（被动读）或主动 `FETCh?`；PLC 位双通道兜底。
4. 异常时先 `FUNC:STOP` 清状态再重新下发参数。

## 坑与红线

- 参数"下发成功"不等于"生效"——必须读回核验，这一步不能省（耐压参数错误是安全事故级风险）。
- 串口读帧必须有 deadline 超时（`read_line(deadline_s)`），仪器无响应时不能无限等。
- 结果保存链路必须校验数据库 UPDATE 受影响行数，0 行显式报错，杜绝"测完没保存"。

## 验证清单

- 7 项参数读回全部匹配。
- 启动后能收到 PASS/FAIL 判定帧及四项测量值。
- 与 PLC 联动时握手位时序正确（先到位才允许测试）。
