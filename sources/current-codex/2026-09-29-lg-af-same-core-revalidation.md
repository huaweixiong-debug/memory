# LG-AF 同版 Core 离线复验与模板复用证据

- 2026-09-29：Core 131 项、template 5 项、Morocco 根套件 171 项、Morocco Python 应用 139 项、ATEQ 92 项、Traceability 43 项（Python 3.10 与 3.14）通过。pytest 进程验证均从同一份 lg-industrial-core-stage-20260928/src 导入 Core。
- Morocco 根集成测试以前优先插入相邻旧 Core 副本。测试引导已增加可选 LG_INDUSTRIAL_CORE_SOURCE 覆盖，并检查目录有效；无效目录在收集时明确拒绝。目标路径设置后全量测试通过。
- Traceability 模板复用基线：app/__init__.py、app/composition.py、app/example_replay.py、tests/test_template.py 共 4/5 个代码/测试文件在统一换行后与 Core template 一致；app/fakes.py 增加项目专用的三类合成假设备。
- 私有仓库 huaweixiong-debug/lg-industrial-core 的 PR #2 head 8f2a0c2 仍 Open / Draft；Python 3.10/3.11/3.12 CI 与 Package preflight 成功，GitHub Release job skipped。未合并或发布。现场设备与生产数据库未连接。