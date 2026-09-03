---
name: bartender-label-print
description: Print production labels via BarTender (bartend.exe command line) — template selection, variable substitution, copies, printer routing, and print-result verification in the data chain. Use when integrating label printing into test workflows.
allowed-tools: Read, Grep, Bash
---

# BarTender 标签打印集成

## 适用场景

测试 OK 后自动打标签/合格证（条码、参数、生产日期、班次等）。参考实现：`hc-leak-test-print/bartender_print.py`；`xiezhong-Morocco-2-stations`（绑定打印机出滴铆剂时间标签）与 `Yida-Marking-Printing`（打码机联动）是同类扩展。

## 调用方式（bartend.exe 命令行）

- 可执行文件：`C:\Program Files\Seagull\BarTender Suite\bartend.exe`。
- 参数：`/F <template.btw>` 模板、`/C <n>` 份数、`/P <printer>` 指定打印机、`/X` 打完关闭 BarTender 进程。
- 模板默认目录 `templates/`，固定数据目录 `D:\data`（现场固定模板 `D:\data\label.btw`）。
- 变量内容（条码、件号、测量值）经模板命名数据源替换；打印进程用 `subprocess` 调起，后台模式 `Popen` + DEVNULL。

## 操作顺序

1. 先在 BarTender 里设计模板并绑定数据源命名，导出 `.btw` 到约定目录。
2. 代码侧按产品型号选模板（`_get_template_path` 自动补 `.btw` 扩展名）。
3. 组装变量 → 调 `print_label(template, copies, variables, printer)` → 记日志。
4. **保存链路校验**：打印对应的测试记录 UPDATE 必须检查受影响行数，0 行显式报错（防"打标了但没记录"或反之）。

## 坑与红线

- `bartend.exe` 是 GUI 程序：不加 `/X` 会残留后台进程，连续打印后内存与句柄堆积；服务化部署时务必加。
- 打印机名必须与 Windows 打印机名完全一致（含空格），用 `/P` 显式指定，不要依赖默认打印机。
- 模板文件路径改动是常见故障源：路径集中在一处配置，不要散落硬编码。
- 打印成功 ≠ 记录成功：以数据库受影响行数为准，二者都要校验。

## 验证清单

- 实际打印一张，条码可扫、字段与测试记录一致。
- 打印后 BarTender 进程退出（`/X` 生效）。
- 人为制造一次打印失败，确认记录侧报错且可重打。
