# 恒创 v47 三检测器 WBF 实测结论

日期：2026-10-03  
来源：Codex 当前账号

## 实验设置

- 原始图像/标注来自 `D:\Hengchuang00601.v47i.yolo26`，源目录未修改；按日期重新分组为 train=393（日期至 2026-01-06）、valid=146（2026-05-05）、test=178（2026-05-07/08/09/19）。
- 训练 YOLO26s、Faster R-CNN R50-FPN、Cascade R-CNN R50-FPN，各 20 epochs、seed=42、imgsz=1024；YOLO batch=8，MMDet batch=2，均从 COCO 预训练初始化。
- 未加载 `D:\Hengchuang00601.v47i.yolo26_v2\weights\best.pt`；原始划分存在 train/valid/test 图像重叠风险，不把已有权重用于干净对比。
- 三模型等权 WBF，IoU=0.55；各类置信度阈值只用 valid 选择并在测试前冻结。测试集 178 张只推理一次，指标用 pycocotools COCOeval。测试集 ignore 类仅 30 个框，相关类别结论不确定性较高。

## 测试集结果

| 模型 | AP50 | mAP50:95 | 三类计数逐图全对率 |
|---|---:|---:|---:|
| YOLO26s | 0.7137 | 0.3278 | 6.18% |
| Faster R-CNN | 0.8119 | 0.3741 | 7.87% |
| Cascade R-CNN | 0.8338 | 0.4007 | 37.08% |
| 三模型等权 WBF | 0.8392 | 0.3654 | 21.91% |

三模型融合相比 YOLO26s 有提升；相比最佳单模型 Cascade，AP50 仅高 0.0054，而 mAP50:95 低 0.0353、全类计数全对率低 15.17 个百分点。若重视跨 IoU 定位和逐图计数，当前优先保留 Cascade 单模型；融合只在 AP50 权重高且接受计数/定位退化时考虑。

验证集 batch=1 串行 YOLO→Faster→Cascade→WBF 实测 50 张：mean=213.48 ms、p95=244.40 ms（RTX 4070 SUPER，含 WBF，3 张 warmup 不计）。端到端大约 4.7 张/秒。

## 运行环境提示

Windows 上 MMEngine 0.10.7 的环境收集可能因 MSVC 输出被 GBK 解码而报 `UnicodeDecodeError`。本次仅给训练进程设 `PYTHONUTF8=1` 后恢复运行，没有安装或修改 Python 环境。

完整报告：`D:\ultralytics-main\inference_results\hengchuang_v47_grouped_wbf_20261003\report\report_zh.md`
