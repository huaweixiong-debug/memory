# ATEQ 远端 WebUI 故障记录（2026-09-01）

- 远端主机为 Windows，项目目录为 `D:\ATEQ`，WebUI 使用 `D:\Python312\python.exe` 运行 `webui_server.py`，监听 `0.0.0.0:8001`。
- 正式入口是 `D:\ATEQ\start_github_webui.bat`，该入口设置 COM3、站号 1、9600/E/8-1 等 ATEQ 通信参数。
- 计划任务名为 `\ATEQNodeServer`，执行 `D:\ATEQ\start_github_webui.bat`；本次通过计划任务重新启动后，HTTP GET `/` 返回 200。
- 已将 `D:\ATEQ\start_ateq_webui.bat` 补上 `D:\Python312` 和 COM3 参数；已创建登录启动快捷方式 `C:\Users\dell\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ATEQ WebUI.lnk`，用于静默启动/打开网页。
- `\ATEQNodeServer` 已重新注册为登录触发，并设置失败后最多重启 10 次、间隔 1 分钟。
- 不要将 `reset_ateq.py` 或 `start_ateq.py` 与 WebUI 启动混淆；它们会执行 Modbus 线圈写操作，涉及实际设备状态。
