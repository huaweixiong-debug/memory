# ATEQ B 实时启动修复

- 2026-09-11：B 工位真实启动路径在 `PyMySQLRepository.query()` 从 `test.info_A/info_B` 恢复记录时引用 `StationId`，但 `app/repository.py` 漏导入，导致 UI 弹出 `NameError: name 'StationId' is not defined`。
- 已补齐 `StationId` 导入；本机 `pytest` 76 项全部通过，远程机 COM6 + MySQL 的 `MainWindow(b_live=True)` 构造验证通过。
