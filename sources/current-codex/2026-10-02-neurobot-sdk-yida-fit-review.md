# Neurobot SDK 对 YiDa F/U 项目的适配评估

日期：2026-10-02（Codex 当前账号）

- 审阅对象：`neurobot-ai/neurobot_sdk_demo`，用于当前 `D:\ultralytics-main` YiDa F/U 多阶段推理项目的技术适配判断；未克隆运行 SDK，也未做模型转换/性能测试。
- 仓库包含 C++/C# 推理、单/多模型多线程、切图、OCR、旋转检测、分割 mask 后处理、WinForms/Qt/HIK 相机示例。最后一次 push 为 2023-08-08；GitHub API 未返回仓库 license 元数据。
- Neurobot 官方 SDK 文档写明 Windows x64、NVIDIA GPU、Visual Studio、Virbox 激活；API 通过厂商模型目录调用 `load_model` / `predict_model` 并回传框/分类/mask 结构。当前没有证据表明它能直接加载本项目 `.pt` 权重或兼容 Ultralytics YOLO26。
- 结论：短期不迁移当前 Python F/U S1-S10、产品模板、槽位分配和结果融合；可借鉴 C++/C# 部署外壳及 OCR/切图/分割示例。仅当 Windows 原生部署或厂商模型平台是明确需求时，再以一款代表模型确认转换、授权、精度和端到端延迟后评估 SDK。
- 维护规则：多线程示例不证明同一 GPU 上会更快；每线程独立模型会增加显存。任何候选性能都需在独立留出图像上验证 F 缺件、U 缺件、错装和 RECHECK 回归，不据小样本/示例代码决定上线。
- 来源：<https://github.com/neurobot-ai/neurobot_sdk_demo>；<https://neurobot.readthedocs.io/en/latest/Deployment/HowToUseSDK/>；本地对照 `mvp_inference/plugins/yolo_detector.py`、`mvp_inference/run.py`、`mvp_inference/live_adapter.py`。
