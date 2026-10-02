# Neurobot 切图推理在 YiDa F/U 上的本地实验

日期：2026-10-02（Codex 当前账号）

- 用户要求使用 Neurobot 官网上的大图切小图思路推理 YiDa F/U 并比较效果。官方说明要求模型训练时先切图，部署推理保持相同切图；当前实验为保护数据在本机运行，没有上传图像、标签或权重，也未使用需要厂商导出模型与许可的 SDK。
- 在相同 29 张标注图、S0-S10 流程、产品配置及 `D:\YiDa002.v17i.yolo26\weightm_260419\weights\best.pt` 上比较整图与推理期 4x4/320px 切片（带重叠，global NMS IoU 0.50）。图像最小标注目标面积比约 5526-9709，切片后最大约 948，符合官网建议阈值。
- 结果：整图 18/29 数量正确且非 RECHECK、RECHECK 10；切图 0/29、RECHECK 29。S1 F TP/FP/FN 从 573/174/0 变为 0/9/573，U 从 632/10/4 变为 7/107/629。切图 S1 仅 123 个框，整图 1389 个。模板配准缺少锚点；主检测耗时约 10.2s vs 5.2s。
- 解释边界：这是现有整图训练权重的切片推理敏感性试验，不等同官方完整的切图训练/测试/SDK导出流程。结果说明当前权重不能直接切图使用；若要验证完整方法，应独立生成裁剪数据/标签、重新训练候选权重，并在留出批次上完整对照。该实验未改变产品代码和任何权重。
- 本地报告与数据：`D:\ultralytics-main\inference_results\neurobot_crop_trial_20261002\summary.md`；机器结果、S1配对指标及一次性runner同目录。
- 来源：<https://neurobot.readthedocs.io/en/latest/ModelDevelopment/AdvancedApplications/DetectSmallTargetsInBigPicture/>；<https://neurobot.readthedocs.io/en/latest/privateCloud/model_export/>。
