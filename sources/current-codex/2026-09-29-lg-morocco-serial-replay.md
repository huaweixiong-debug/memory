# Morocco ATEQ 串口离线录放验证 — 2026-09-29

- Morocco 隔离试点加入 `SerialAteq.run()` 的完整周期录制与字节级回放覆盖，包含 StepCode 4→5→6→65525/65535、只读 FC03 写出断言、压力/泄漏解码、终帧、转录和回放耗尽。
- 该试点测试依赖未正式发布的 Core 串口录放 API。运行时须用 `LG_INDUSTRIAL_CORE_SOURCE` 显式指向含 `lg_industrial_core/serial_recording.py` 的已审查 Core `src`；仅设置 `PYTHONPATH` 不够。测试说明记录了该入口并在导入前检查 API 模块。
- Python 3.10 根套件在选定暂存 Core 后 173 项通过；ZCode Desktop 使用个人 Coding Plan GLM-5.3-Flash 最高档完成只读复核，无阻断。验证完全离线，不代表现场/生产验收。
