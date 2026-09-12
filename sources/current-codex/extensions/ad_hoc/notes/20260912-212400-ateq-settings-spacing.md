# ATEQ 设置页模板与控件间距

2026-09-12，按用户反馈在远程 `D:\ATEQ` 调整设置页：打印模板 A/B 列固定为相同的 240 px；其他设置字段收拢到卡片左侧，标签右对齐、控件左对齐，标签与 ATEQ 下拉框间距为 10 px。未改变保存或设备逻辑。

验证：`tests/test_ui_theme_modern.py` 与 `tests/test_ui_replica_structure.py` 共 9 项通过；`tests/test_ui.py` 4 项通过，1 个既有数据断言用例单独排除；`compileall app tests` 通过。1366x768 SIMULATE 预览：`C:\Users\Administrator\.codex\opencode-executor\runs\20260912-194141-ateq-manual-win11\setup-spacing-after-1366.png`。未启动 LIVE 或重启现场程序。
