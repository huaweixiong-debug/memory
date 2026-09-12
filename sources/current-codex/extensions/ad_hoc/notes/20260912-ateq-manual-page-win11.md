# ATEQ 手动页 Win11 风格调整

- 日期：2026-09-12
- 来源：Codex 当前账号
- 项目：`\\100.87.176.32\d\ATEQ`

## 稳定结论

- 手动页适合用 A/B 两张独立卡片呈现六组动作、紧凑 PLC 回读标记和顶部扩展入口；保留控件对象名、授权、确认与 A/B 回读绑定，可只改呈现层。
- 此仓库的 Qt 离线截图/回归可通过 `MainWindow(b_live=False)` 在远程 Python 环境执行，不需要启动现场检测流程。
- 用户在本次任务明确要求 Codex 直接改代码、不要调用 OpenCode；这种明确的任务级指示优先于默认 OpenCode 执行路由。

## 本次验证与待办

- 1366x768 离线预览通过目视检查；`tests/test_ui_theme_modern.py` 为 5 passed，`tests/test_ui.py` 除下述用例外为 4 passed；目标模块 `compileall` 通过。
- `tests/test_ui.py::test_visible_scanner_calibration_and_settings_commit_flows` 单独执行时仍断言产品型号应为 `TEST-MODEL`，实际为 `E113015200`。该路径与手动页样式无关，后续单独查清产品选择/扫码数据来源。
- 本次没有改 PLC、扫码、数据库或测试业务逻辑，也未启动 LIVE 模式。
