# S0-S10 投影弱证据探索对比（2026-09-24）

- 在 `D:\ultralytics-main` 新增隔离实验插件 `mvp_inference/plugins/projection_slot_assignment.py` 与基准脚本 `mvp_inference/tools/benchmark_s0s10_projection.py`；生产配置、模型、权重未修改。
- 将垂直投影峰作为 S2 槽位匹配弱证据（同峰、中心均在 12 px 内，成本折扣上限 0.035），不生成/删除检测，不强行凑数；S11 仍关闭。
- 对 `D:\YiDa002-Uploaded on 07-31-26 at 10-45 pm.coco` 的 14 张 test 图和 `D:\YiDa002.v17i.yolo26\weightm_260419\weights\best.pt` 做基线/实验组对照：640 个投影峰、516 个候选匹配获支持，但 14 张图的 S2 指派均未变化；最终 TP/FP/FN 均为 92/451/449，两组相同。F/U数量与标注一致 12/14 张。
- 按同类 IoU >= 0.50 严格框匹配的整体 Precision/Recall 仅 16.94%/17.01%；数量一致不能视为定位正确或 99% 验收。测试切分此前已查看，结果只属探索性回顾，不是盲测；现场 ONNX 需另行验证。
- 报告和预测产物位于 `D:\ultralytics-main\inference_results\s0s10_projection_fusion_260924`，中文报告为 `S0-S10_projection_experiment_zh.md`。本结果不支持将投影弱证据启用到生产流程。
