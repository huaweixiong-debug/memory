thread_id: 019fa632-d326-7283-9a74-b008ba6f6368
updated_at: 2026-08-19T09:26:50+00:00
rollout_path: \\?\C:\Users\Administrator\.codex\sessions\2026\07\28\rollout-2026-07-28T08-49-36-019fa632-d326-7283-9a74-b008ba6f6368.jsonl
cwd: \\?\D:\ultralytics-main

# Built and validated a configurable multi-stage YOLO inspection pipeline, then fairly compared a candidate model

Rollout context: Work was performed in `D:\ultralytics-main` on Windows PowerShell. The user first requested a minimal plugin architecture, then repeatedly asked to make it genuinely multi-stage, produce annotated images, support configurable rules, and compare replacement models against the existing production solution without blindly switching.

## Task 1: Minimal plugin-based MVP

Outcome: success

Preference signals:
- The user explicitly asked for a minimal version first: image reading, YOLO detection, an anomaly-module placeholder, unified output, model files in a designated folder, and paths controlled by configuration -> future implementations should prioritize a narrow runnable vertical slice before adding advanced models.

Key steps:
- Added `mvp_inference` with YAML configuration, dynamic plugin loading, image I/O, YOLO plugin, anomaly placeholder, and unified JSON output.
- Added `models/yolo/yolo11n.pt`; direct script and module execution were both validated.
- Fixed direct-entry import failure (`ModuleNotFoundError: No module named 'mvp_inference'`) by adding the project root to `sys.path` and replacing newer type syntax with Python 3.8-compatible annotations.

Reusable knowledge:
- The pipeline is configuration-driven: plugins declare `name`, `module`, `class`, `enabled`, and model/settings fields in YAML. New models should generally be added as plugins rather than modifying Ultralytics core.

References:
- `mvp_inference/config.yaml`, `mvp_inference/run.py`, `mvp_inference/plugin_loader.py`
- Command: `python .\\mvp_inference\\run.py`
- Initial output: `inference_results/mvp_result.json`

## Task 2: YiDa dataset multi-stage pipeline

Outcome: success

Preference signals:
- When the assistant initially used only YOLO plus a placeholder, the user corrected: “你做个多阶段的，验证下，不要只是yolo” -> future agents should ensure later stages consume earlier-stage evidence and are validated with meaningful outputs, not merely empty fields.
- The user asked for annotated output images to verify visually -> similar computer-vision runs should proactively generate annotated examples and inspect representative OK/NG images.

Key steps:
- Added real stages: `image_quality -> yolo_detector -> rule_anomaly -> result_fusion`.
- Image quality computes brightness/sharpness with `ok/warning/critical` severity.
- Rule anomaly consumes YOLO detections and quality results, supports filename-glob rule sets, and records the selected rule.
- Result fusion emits `OK`, `RECHECK`, or `NG`.
- Added CLI overrides for input, output, limit, and annotated-image directory.
- Added `annotated_image` plugin that draws F/U boxes, confidence, status, quality, rule, and reasons.
- Ran the YiDa directory (`D:\YiDa002.yolo26\train\images`, 317 images) through the full pipeline.

Validation:
- 317-image quality-severity run: `OK=258`, `RECHECK=58`, `NG=1`; detection range 36–111, average 69.65.
- Annotated sample run processed 20 images and generated files under `inference_results/annotated_sample`; representative NG and OK images were opened and visually checked.

Reusable knowledge:
- Filename-based rule routing reduced the earlier overly strict result from `301 NG / 16 OK` to `258 OK / 59 NG`, then severity routing converted ordinary quality warnings into `RECHECK` rather than `NG`.
- The pipeline’s stages share a mutable per-image context, allowing downstream plugins to use `quality`, `detections`, `anomaly`, and `final_result`.

References:
- `mvp_inference/plugins/image_quality.py`
- `mvp_inference/plugins/rule_anomaly.py`
- `mvp_inference/plugins/result_fusion.py`
- `mvp_inference/plugins/annotated_image.py`
- Full result: `inference_results/yida002_quality3_full_result.json`
- Example command: `python .\\mvp_inference\\run.py --input 'D:\\YiDa002.yolo26\\train\\images' --output 'inference_results\\yida002_quality3_full_result.json'`

## Task 3: Candidate model comparison

Outcome: success

Preference signals:
- The user asked to test specific candidate weights, but accepted the conclusion that a model should not replace production unless it improves on the same benchmark -> future model changes should use identical data, cascade, thresholds, and metrics, and default to conservative non-replacement when gains are mixed.

Key steps:
- Used `mvp_inference/tools/benchmark_coco_s1s5.py` with the reference cascade configuration and same 125-image COCO benchmark.
- Compared production model `D:\YiDa002.v17i.yolo26\weightm\\weights\\best.pt` with candidate `D:\YiDa002.v17i.yolo26\weightm_260419\\weights\\best.pt`.
- Candidate run completed successfully with annotated and comparison images.

Validation:
- Production: exact count `117/125`, F TP/FP/FN `2421/5/4`, U `2315/1/3`, RECHECK `55`.
- Candidate 260419: exact count `115/125`, F TP/FP/FN `2422/6/3`, U `2315/3/3`, RECHECK `56`.
- Candidate reduced F misses by one but increased false positives and reduced exact-count images by two; therefore it was retained as a candidate and not promoted.

Failures and how to do differently:
- Several exploratory summary commands failed due to Windows quoting and unsupported PowerShell `??`; use PowerShell-native JSON parsing and syntax compatible with the installed shell.
- A candidate-specific S6 CNN-to-F override was tested, but it increased U errors and was removed from the default candidate path. Do not promote heuristic overrides based only on a small apparent recall gain.

References:
- Benchmark output: `inference_results/v17_s1s10_candidate_260419_conf005/combined_comparison.json`
- Annotated images: `inference_results/v17_s1s10_candidate_260419_conf005/predicted_annotated`
- Error comparisons: `inference_results/v17_s1s10_candidate_260419_conf005/comparison`
- Benchmark command used the candidate weight with `--s1-conf 0.05 --candidate-s1-adaptation`.

