# ATEQ 其他页面 Win11 风格统一

2026-09-12，按用户要求直接在远程 `D:\ATEQ` 修改测试、设置、查询页面，与手动页统一 Win11 风格；保留页面业务回调和设备动作。设置页增加登录门禁卡片，查询页增加页头与双工位筛选卡，并统一表格、输入框和按钮外观。

验证：`tests/test_ui_theme_modern.py` 与 `tests/test_ui_replica_structure.py` 共 9 项通过；`tests/test_ui.py` 4 项通过，排除既有的 `test_visible_scanner_calibration_and_settings_commit_flows` 数据断言问题；`compileall app tests` 通过。1366x768 的测试、设置、查询预览在 `C:\Users\Administrator\.codex\opencode-executor\runs\20260912-194141-ateq-manual-win11\`。未启动 LIVE、未重启现场程序。
