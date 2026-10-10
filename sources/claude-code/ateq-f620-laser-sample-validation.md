# ATEQ-F620-Laser-2-stations：校准样件验证规则（Claude Code，2026-10-11）

仓库：https://github.com/huaweixiong-debug/ATEQ-F620-Laser-2-stations
分支：`feat/sample-validation`；PR https://github.com/huaweixiong-debug/ATEQ-F620-Laser-2-stations/pull/1 （base main，未合并）
设计 `docs/superpowers/specs/2026-10-10-sample-validation-design.md`，计划 `docs/superpowers/plans/2026-10-10-sample-validation.md`

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

## 现场部署（已完成 2026-10-11）
- 部署方式：**文件复制**，不是 git（`D:\ateq` 无 `.git`）。只覆盖 `app/{calibration,station,ui_replica,ui_theme}.py`、`tests/{test_calibration,test_station,test_ui}.py`、`README.md`；
  必须保留 `config/live.toml`、`calibration_state.json`、`journal/`、`.venv`、日志。
- 备份：两台机 `D:\ateq_backup_20261011\{app,config,tests,README.md}`。
- 停机安全条件：A `phase=空闲` 且无 pending journal；B journal 为已打码完成周期（phase COMPLETE / recovery_required False）。
- 重启方式：**只启动 B 的 `ATEQ_B_UI` 计划任务**，B 的 `run_live_ui.bat` 会经 SSH 触发 A 的 `ATEQ_A_UI`；
  两台都有 dell / Interactive 的 `ATEQ_?_UI` 任务跑 `run_live_ui.bat`。**不要单独启动 A 的任务**，否则 A 会出现第二个 UI 实例（`tools/start_a_ui.py` 不查重）。
- 验证：两台 `pytest -q` 各 **238 passed**（先 234，补齐 test_plc_* 后 238），UI 起来后 `live_trace.log` 有新启动记录、无 `ui_crash.log` 条目。
- 访问：A `ssh dell@100.75.116.118`、B `ssh dell@100.98.251.47`（Tailscale），密码 `0000`。**密钥登录未配置**，本机用 PuTTY plink/pscp 配 `-pw` + `-hostkey`。

## 待办
- 实机验证（spec 第 6 节）：OK 件两次 StepCode=4 同一 cycle_id、样件期间激光不动作、验证后首件产品数据与打码一致；A/B 当前 `due=True` 等操作员点“启动验证”。
- 测试文件差异（已解决）：现场 `tests/test_plc_fx.py`、`tests/test_plc_relay.py` 曾是 main 的**真子集**（main 多 4 个用例、无删改），app 代码两边一致。
  2026-10-11 用户确认后已把 main 版本推到现场两台，现场测试套件 234→**238 passed**。
  这 4 个用例守护的 2026-10-08 修复本就在现场 app 代码里（曾缺测试）。
