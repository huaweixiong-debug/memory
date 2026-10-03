# YiDa F/U Faster R-CNN and Cascade R-CNN comparison

- Date/source: 2026-10-03, Codex current account. Experiment: `D:\ultralytics-main\inference_results\yida_faster_cascade_compare_20261003`; dataset `D:\YiDa002.v17i.yolo26`.
- Trained Faster R-CNN R50-FPN and Cascade R-CNN R50-FPN for 20 epochs in isolated MMDetection env (`torch 2.1.0`, CUDA 12.1, `mmcv 2.1.0`, `mmengine 0.10.7`, `mmdet 3.3.0`, RTX 4070 SUPER). Best checkpoints: Faster epoch 14; Cascade epoch 20.
- Test used 66 images once, only after class score thresholds were selected on valid. YOLO baseline mAP@[.50:.95] 0.7025; Faster 0.5815; Cascade 0.6430. Neither R-CNN improved overall detection mAP.
- Cascade improved F exact-count accuracy (63/66, 95.5%, count MAE 0.045) versus YOLO (42/66, 63.6%, MAE 0.439), while U regressed (30/66, 45.5%, MAE 0.879) versus YOLO (51/66, 77.3%, MAE 0.348). Both F and U counts simultaneously exact: Cascade 28/66 (42.4%), equal to YOLO; Faster 15/66 (22.7%). Cascade mean latency 52.2 ms/image vs YOLO 21.4 ms.
- Conclusion: do not replace the current YOLO baseline with these R-CNNs based on this experiment. Cascade may be useful only for the F-specific count behavior, but it did not improve joint F/U exact counts and was slower. The 66-image test comes from the same v17 collection context; do not generalize to new dates/lines or claim end-to-end installation accuracy.
- Checkpoint-discovery fix: `_find_mmengine_best_checkpoint` now searches recursively (`rglob`) because MMEngine nests best weights under `<work_dir>/<model>/`. Stable copies were hash-verified. No retraining was done for that fix.
- Report: `report/report_zh.md`; detailed frozen test metrics: `metrics/frozen_test_results.json`; joint count result: `metrics/joint_count_exact_test.json`.
