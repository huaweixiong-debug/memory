# 板片平凸检测 A/B/C 离线基准

- 日期：2026-09-24
- 来源：Codex 当前账号
- 在 `YiDa002-Uploaded on 07-31-26 at 10-45 pm.coco` 的 14 张 held-out test 图、541 个实例上，使用 v17 YOLO26m 权重比较整图 YOLO、固定中心 ROI YOLO、OpenCV 投影候选层 + 现有 ROI CNN。
- 本次 A/B 运行的是 PyTorch `.pt` + CUDA，并非现场方案里的 ONNX；只可比较本次 A/B 相对表现，不能外推现场 ONNX 性能。
- 当前参数下整图计数正确率均为 0/14。中心 ROI YOLO 相比整图基线小幅改善，但仍有大量误检；不应接入生产。
- C 的纵向中心匹配（容差 ±12 px）层候选召回 95.9%、精确率 81.1%，但现有 CNN 在匹配候选层上的 F/U 准确率仅 21.4%。分类器为整件 ROI 训练，不是逐层窄条 ROI 训练；需要单独准备并验证相符的逐层数据，不能把定位指标当作最终识别率。
- 测试结果与逐图可视化保存在 `D:\ultralytics-main\inference_results\flat_convex_abc_260419_test`。只新增离线实验脚本和报告，没有改变生产推理或模型权重。
