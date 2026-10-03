# 恒创 v48i 数据集完整性核验

- 日期：2026-10-03
- 来源：Codex 当前账号；现场核验 `D:\Hengchuang00601.v48i.yolo26`
- `data.yaml` 的 `train/valid/test: ../.../images` 相对于数据集根目录会落到 `D:\train`、`D:\valid`、`D:\test`，当前均不存在；需使用修正后的独立 YAML。
- `train` 与 `valid` 各有 777 张图，文件名、图像字节及 777 个标签文件均完全相同；`test` 只有 2 张。README 声明总图数 779，与 777 张唯一 train/valid 图加 2 张 test 一致。
- `train/valid` 各有 15,442 个 flat_plate、15,003 个 convex_plate、294 个 ignore 框；重复导致计数被双算。test 两张共 98 个框，只有前两类。
- 既有 `D:\Hengchuang00601.v47i.yolo26_clean` 有无重叠的 572 train / 143 valid；这 715 张图像均以相同字节出现在 v48i 的 train/valid 副本中。v48i 另有 62 张新增训练候选和 2 张 test 图。
- v47/v48 对应标签坐标差异最大约 5e-7；有 2 张旧 train 图片在 v48 增加了各 1 个标注框。已有 `train_hengchuang_keep_ignore_1536_auto` checkpoint 的 args 指向 v47_clean、1536 px、batch 4。
- 候选恢复方案：沿用旧 572/143 图像划分，把 62 张新增图放 train，保留 2 张 test，生成独立副本和修正 YAML；这样不随机重切旧图，但仍须说明 test 数量过少，验证结论以 143 张 valid 为主。
