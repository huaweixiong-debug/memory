# 恒创 v48 三检测器组合验证集复测

日期：2026-10-04  
来源：Codex 当前账号

## 实验与环境

- 使用 D:\Hengchuang00601.v48i.yolo26 的隔离副本，train=634、valid=143、test=2；原始数据未修改。模型训练和指标选择只使用 train/valid，2 张 test 未用于本次结论。
- 现有 D:\miniconda3\envs\pytorch 环境的 Ultralytics 从 8.4.171 更新到 8.4.172；Python 3.8.20 和原 Torch 2.4.1+cu121 未改动。Faster/Cascade 在隔离 MMDetection 环境训练。
- 重新训练 YOLO26s、Faster R-CNN R50-FPN、Cascade R-CNN R50-FPN，均 20 epochs、seed=42、1024 输入；在相同 143 张 valid 上用 pycocotools COCOeval 评 AP，并测试两两及三模型等权 WBF。

## 主要结果

| 模型/组合 | AP50 | AP50:95 | 逐图各类计数全对率 |
|---|---:|---:|---:|
| 现用 YOLO26s 1536（旧权重参考） | 0.9738 | 0.6361 | 85.3% |
| 新训 YOLO26s 1024 | 0.9550 | 0.5816 | 68.5% |
| Faster R-CNN | 0.8580 | 0.5243 | 18.9% |
| Cascade R-CNN | 0.9566 | 0.6149 | 41.3% |
| YOLO26s + Cascade | 0.9732 | 0.6249 | 70.6% |
| 三模型 WBF | 0.9738 | 0.6217 | 65.7% |

现用 YOLO26s 1536 在同一验证集的 COCO AP50:95 仍比三模型高约 1.44 个百分点，计数全对率也高 19.6 个百分点；三模型推理耗时估算约 107.18 ms/图，组合时延为各成员独立均值相加，未计 WBF，不是端到端测量。YOLO+Cascade 是本次新训模型中最好的组合，但仍落后现用模型。Faster R-CNN 加入第三路没有改善组合结果；当前不建议替换现用 1536 YOLO26s。

阈值及计数指标由同一验证集选取，属于探索性验证结果；test 仅 2 张，不能据此声称独立泛化已确认。需要新增足量独立测试图后再做最终部署判定。

完整报告：D:\ultralytics-main\inference_results\hengchuang_v48_triplet_20261004\report\valid_comparison_zh.md
