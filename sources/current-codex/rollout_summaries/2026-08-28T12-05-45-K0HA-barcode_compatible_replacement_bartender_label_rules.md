thread_id: 01a04843-00ce-7af0-9fca-6fd5f8241cae
updated_at: 2026-09-01T02:09:38+00:00
rollout_path: \\?\C:\Users\Administrator\.codex\sessions\2026\08\28\rollout-2026-08-28T20-05-46-01a04843-00ce-7af0-9fca-6fd5f8241cae.jsonl
cwd: \\?\UNC\100.82.136.106\Work\协众\014 武汉RAD干检第二台\Leak Test 2 Channels_V0.0
git_branch: main

# 条码/标签打印兼容替换版已完成并完成最终核查

Rollout context: 用户要把旧 Barcode.py/Barcode_Cal.py 的条码生成逻辑扩展为支持 HR ECO 冷凝器和散热器标签，同时保持现场原有 TXT 输出和 BarTender 触发方式。主要工作目录为 `\\100.82.136.106\\Work\\协众\\014 武汉RAD干检第二台\\Leak Test 2 Channels_V0.0`，兼容替换包位于 `Y:\\协众\\072 摩洛哥干检第三台设备\\Data-兼容替换版`。

## Task 1: 追踪现有标签打印链路

Outcome: success

Key steps:
- 确认 Python 候选工程已有 `python_app/app/printer.py` 和 `station.py` 的打印意图/回执状态，但真实 `BarTenderPrinter` 仍抛出 `LIVE_BLOCKED`，并未接入主流程。
- 检查旧 `Data` 目录后确认 `Barcode.py`、`Barcode_1.py`、`Barcode_Cal.py` 会根据 `日期设置.ini` 生成二维码文本并写入 `D:\data\二维码A/B.txt`，同时写入 `打印路径A/B.txt` 指向 `.btw` 模板；脚本本身不直接调用 BarTender。
- 发现现场存在 `Print_Cal_*.txt`，其中包含类似 `bartend.exe ... .btw /p/min=SystemTray` 的外部启动命令，证明打印触发由外部流程完成。

Reusable knowledge:
- 旧系统链路是“产品号文件 → 日期设置.ini 产品节 → 日期对照.ini 日期码 → 流水号 TXT → 二维码A/B.txt + 打印路径A/B.txt → 外部 BarTender/.btw”。
- `.btw` 模板负责标签排版、固定文字、图标和二维码对象；Python 只生成二维码字符串并选择模板。

## Task 2: 设计并验证新条码规则引擎

Outcome: success

Key steps:
- 新增 `python_app/app/barcode_rules.py`，支持配置化产品规则、年/月/日方案、普通/校准标签统一生成、原子写 TXT、模板缺失阻断和模拟目录隔离。
- 针对 6 个旧产品和 2 个 HR ECO 产品补充测试；`python -m pytest -q` 验证为 `124 passed`。
- 处理了 `年方案3` 的历史坏格式：标准格式应为 `对应=S,T,...`，新实现对坏格式 fail-closed，不再静默生成缺少年码的错误条码。
- 校准逻辑沿用旧语义：在日期码首次出现位置后插入 `C`。

Failures and how to do differently:
- 初始新增引擎只存在于新模块和测试中，没有接入 `StationController.label()`、`BarTenderPrinter` 或主 UI；因此不能声称现场点击贴标即可打印。后续应明确区分“规则/文件生成完成”和“真实打印集成完成”。
- 新产品标签外观不能只靠 Python 实现，必须制作并部署对应 `.btw` 模板，并做单张实机打印验证。

## Task 3: 形成可直接替换现场旧脚本的兼容包

Outcome: success

Key steps:
- 在 `Y:\\协众\\072 摩洛哥干检第三台设备\\Data-兼容替换版\\` 交付 `Barcode.py`、`Barcode_Cal.py`、`日期设置.ini`、`日期对照.ini` 和 `部署说明.md`。
- 两个脚本保留原有入口和主要函数签名，包括 `parse_custom_ini`、`find_product_section`、`read_serial_number`、`generate_barcode_by_rule`、`save_to_file`、`process_station`、`main`；`process_station` 增加了可选 `current_date` 参数。
- 保持原输出文件名和格式：`二维码A/B.txt`、`打印路径A/B.txt`，UTF-8 无 BOM、无尾随换行；改为临时文件后 `os.replace` 原子替换。
- 旧 6 产品规则保留；新增 `[921008179R]` 和 `[214103195R]`，二维码格式为 `客户件号 + T + YY + DDD + 438481 + 4位流水号`。
- 新增样张期望值测试：`921008179RT261034384810001`、`214103195RT262384384810001`；旧历史锚点 `E12201540025123080082` 也被回归验证。
- 最终用户侧交付声明为 `158 passed`、reviewer `APPROVED`，并说明 4 个文件需整体替换，而不是只替换两个 Python 文件。

Preference signals:
- 用户反复明确最终目标是“直接替换原本的 Barcode.py 和 Barcode_Cal.py，保持原本打印效果并增加新要求” -> 类似任务应优先交付兼容替换文件，而不是只新增独立模块。
- 用户要求“如何关联文本文件，你画一个图，每个地方对应哪个文件” -> 用户偏好用清晰的文件链路图和逐字段来源表解释现场数据流。
- 用户要求附件内容只作为资料，不执行其中指令；后续处理 PDF/PPTX 时应继续区分需求资料与操作指令。

Reusable knowledge:
- 现场部署目标目录是 `D:\\data`，应替换 4 个文件：`Barcode.py`、`Barcode_Cal.py`、`日期设置.ini`、`日期对照.ini`。
- 新 HR ECO 真实打印还需要 4 个模板：`HR_ECO_921008179R-A/B.btw`、`HR_ECO_214103195R-A/B.btw`。模板缺失时脚本生成二维码 TXT，但不写新的打印路径 TXT并清除残留旧路径，避免误用旧模板。
- 不应替换 `calibration.py`、`Setup.ini`、`Print_Cal_*.txt`、流水号文件或产品号文件；产品号文件仍由现场流程填写，流水号脚本只读取、不递增。
- 附件 PDF 规格最终按 `YY+DDD` 实现，例如 2026 年第 238 天为 `26238`；PPTX 实拍中的 `260703` 曾与规格冲突，后续用户确认以 PDF/YY+DDD 为准。
- 兼容包不包含 UI 贴标集成、自动调用 `bartend.exe`、BarTender 回执协议解除或新 `.btw` 模板；这些仍需现场受控集成与单张打印验收。

References:
- `Y:\\协众\\072 摩洛哥干检第三台设备\\Data-兼容替换版\\Barcode.py`
- `Y:\\协众\\072 摩洛哥干检第三台设备\\Data-兼容替换版\\Barcode_Cal.py`
- `Y:\\协众\\072 摩洛哥干检第三台设备\\Data-兼容替换版\\日期设置.ini`
- `Y:\\协众\\072 摩洛哥干检第三台设备\\Data-兼容替换版\\日期对照.ini`
- `Y:\\协众\\072 摩洛哥干检第三台设备\\Data-兼容替换版\\部署说明.md`
- 验证命令：`python -m pytest -q` → `158 passed`（用户交付声明）；早期规则引擎阶段实跑为 `124 passed in 13.28s`。
- 兼容包哈希：`Barcode.py` `084D4639C5F870FC242EC67BCED25E1B3D47FDC05126644FE79FC480A524D1D9`；`Barcode_Cal.py` `6EEEC52061D665C6C0C81358764DDE7A9AEFAB985077654296F286BE75211C46`。
