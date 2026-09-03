---
name: purchase-contract
description: 基于 XZCX-SU03-JL07-2 一次性采购合同模板生成新合同（换产品、数量、价格，格式保持不变）。当用户提到"做个新合同"、"换个产品/价格再出一份合同"、"一次性采购合同"并附带 .docx 模板时使用。也适用于一般的"保持格式不变、只改内容"的 Word 合同套打任务。
---

# 一次性采购合同生成

以现有合同 .docx 为模板，只替换产品与价格信息，输出格式完全一致的新合同。

## 输入信息

通常用户会给出：模板文件路径、产品名称、数量、含税总价。需要自行推导或向用户确认：

- **未税价** = 含税价 ÷ 1.13，保留两位小数（模板口径：四舍五入，如 1200 → 1061.95）。
- **大写金额**：用 `scripts/rmb_upper.py` 换算，如 1200 → 壹仟贰佰元整。
- **数量词**：如"订购一套/二套"，中文数字需与数量一致。
- **协众件号**：新产品的件号通常未知，**清空留白**由用户后续补填，不要沿用旧件号。

## 生成流程

运行 `scripts/generate_contract.py`（一次完成：接受修订 → 替换 → 字体统一 → 导出 docx + PDF）：

```
python scripts/generate_contract.py \
  --template "D:\...\一次性采购合同XXX设备.docx" \
  --output   "D:\...\一次性采购合同YYY.docx" \
  --pdf      "work_dir\preview.pdf" \
  --old-product "储液器自动滴钎剂设备-朗国" \
  --new-product "蒸发器干检堵头" \
  --old-part-no "XZMG25286" \
  --old-qty-word "一套" --new-qty-word "二套" \
  --new-unit "套" --new-qty "2" \
  --old-untaxed "39823.01" --new-untaxed "1061.95" \
  --old-upper "肆万伍仟元整" --new-upper "壹仟贰佰元整" \
  --old-total "45000.00" --new-total "1200.00"
```

替换顺序有讲究：先替换带后缀的完整名称（如"XX设备-供应商"），再替换裸名称；先清空旧件号，避免短串误命中。

## 环境要点（Windows + 本机实际验证过）

- 本机**没有 MS Word**，`Word.Application` COM 注册是孤立的（报"服务器运行失败"）。用 **WPS：`KWPS.Application`**，接口与 Word COM 兼容。需 `pip install pywin32`。
- **WPS COM 的 `Find.Execute` 不支持命名参数**（`Replace=2` 会被静默忽略，只查不改！）。必须全位置传参：
  `f.Execute(find, True, False, False, False, False, True, 1, False, repl, 2)`
  位置依次为 FindText, MatchCase, MatchWholeWord, MatchWildcards, MatchSoundsLike, MatchAllWordForms, Forward, Wrap, Format, ReplaceWith, Replace(2=全部替换)。
- 模板可能带**修订记录（w:ins/w:del）**：打开后先 `AcceptAllRevisions()` 并关闭 TrackRevisions，否则查找替换结果不可靠。标题在文本框里，python-docx 读不到，但 COM 替换能覆盖到。
- 原模板表格把"数量"和"单位"填反了列，脚本会用单元格级替换纠正（单位列=套，数量列=数值）。

## 字体一致性（用户明确要求过）

COM 替换后的新文字**不会继承原 run 的字体**，会显示为默认字体。生成后必须统一：用 python-docx 给表格数据行、合计行、订购条款里被替换的 run 补上与相邻文字一致的 `w:rPr`（宋体、sz=24 即 12pt）。脚本已内置此步骤。

## 验收（必做）

1. 用 python-docx 重新打开输出文件，断言：新名称/新价格存在，旧名称/旧价格/旧件号**零残留**（注意 `w:t` 全量扫描，含表格）。
2. `pdftoppm -png -r 110 preview.pdf page` 渲染页面，派 judge 子代理视觉验收（表格数据、大写金额、页眉、无乱码/重叠/修订痕迹）。

## 输出位置

新合同保存到与模板同一目录，文件名保持模板编号前缀，如
`XZCX-SU03-JL07-2 一次性采购合同<产品名>.docx`。
