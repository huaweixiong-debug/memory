# ATEQ-F620-Laser-2-stations：校准样件验证规则（Claude Code，2026-10-11）

仓库：https://github.com/huaweixiong-debug/ATEQ-F620-Laser-2-stations
分支：`feat/sample-validation`（未合并 main，PR 待用户确认）；设计 `docs/superpowers/specs/2026-10-10-sample-validation-design.md`

## 现场事实（用户 2026-10-10 确认）
- PLC 对 NG 首件 / OK 二件没有控制，也不改 PLC；样件与正常产品走同一硬件时序。
- 腔序：第一腔 = 负压、第二腔 = 正压，每腔一次 StepCode=4。
- NG 件负压 NG 时仪器终止（一次 StepCode=4）；OK 件负压 OK 后继续测正压（两次）。

## 已定规则
- 倒计时到期后保留“启动验证”按钮（不自动进入）；未点时 PLC 可测，但上位机不建周期、不写库、不出激光文本。
- 样件均不打码；单/双测在启动验证时冻结并持久化（旧快照缺字段按双测）。
- NG 首件：周期最终结果为 NG 即通过（负压 NG，或负压 OK 后正压 NG 都算）。
- OK 二件：双测须负压、正压都 OK。
- 压力高/低等仪器报警不算 NG 通过，按故障处理，复位后重测（与 Q:\ATEQ 打印版 10-09 规则不同）。
- 不符合预期：保留记录、不推进阶段，下一次 StepCode=4 自动同阶段重测；OK 件从负压重来。

## 待办
- 部署到 A/B 工位机 `D:\ateq` 前先备份并经用户确认；按 spec 第 6 节实机验证（OK 件两次 StepCode=4 同一 cycle_id、样件期间激光不动作）。
- R:\ATEQ 与仓库 main 的 `tests/test_plc_fx.py`、`tests/test_plc_relay.py` 不一致，以哪边为准待用户决定。
