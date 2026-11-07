# 恒创 MES 对接：视觉检测工位（Claude Code，2026-11-07）

项目：冷水机片数视觉检测 `Detection V21.py`，运行在远程 Windows 机 `D:\ultralytics-main`（SSH 22 端口 2026-11-07 连不上：kex connection reset）。
远程访问（2026-11-07）：Tailscale 名 `hengchuang-chiller`（100.111.94.83），445 端口通；共享 `\\hengchuang-chiller\ultralytics-main` 存在但需要 Windows 凭据（WinError 1326）。用户给的主机名 DESKTOP-17IPMUM 本机解析不到（WinError 53）。凭据由用户自己 `net use` 映射，助手不代输密码。Git Bash 会吞掉 UNC 开头的 `\\`，测试时在 Python 里用 chr(92) 拼路径。
远程核对（2026-11-07，经 `\\100.111.94.83\ultralytics-main` 用户 l 映射）：远程 `Detection V21.py` 与本地 Chiller-counting 版 MD5 一致；运行解释器为 Python 3.13（pyc 为 cpython-313），项目 .venv(3.12) 基本为空不是运行环境；`detection_debug.jsonl` 约 1.5 GB 持续增长需轮转。HTTP 决定用标准库 urllib，扫码枪需 pyserial。远程命令行 `python` 为 `D:\miniconda3`：有 requests 2.32.4，无 pyserial、pycryptodome（2026-11-07 用户 pip show）；是否即 PyCharm 的 Python 3.13 待确认。
方案草稿：`Y:\恒创\006 视觉识别\MES对接方案.md`（未实施，等用户确认）。

## 协议结论（来自《恒创MES项目系统接口集成规范V0.3》+ 字段说明 xls + Postman 脚本）
- 请求头 appKey / timestamp(ms) / nonce / sign / Content-Type: application/json。
- sign = HMAC-SHA256(key=appSecret, msg=appKey+timestamp+nonce+body+appSecret) 小写 hex；body 必须与发送字节一致。
- 可选 AES（加密方式=1）：key = SHA256(appSecret) hex 前 32 位按 hex 解析，AES-128-ECB PKCS7，Base64 密文作 body，签名基于密文。默认明文。
- 返回 {code, message, data}，200 成功。接口 URL「联调期间提供」→ 全部配置化。appSecret 只放配置，不入代码/仓库。
- 本工位需要：HC_01 心跳、HC_05 过站（进站 scantype=1、出站 scantype=2 各一次，result 1合格/2不合格）、HC_06 质量（overallresult + children[code,name,key]）。
- 默认值 factorycode=HC04、stationcode=04-QJ-03、type=1；ordernumber/sn 不填；barcode（客户外部条码）必填。
- 规范 2.1：断网续传不丢不重时序一致、离线导入、可视化报警、同 SN 不并发、失败留报文+明确重试策略、超限进待处理队列不得静默丢弃。

## 已定（2026-11-07）
- barcode 来源：工位新增扫码枪。必须用串口/USB-COM 模式，不能用 USB 键盘模式：程序有 pynput 全局键盘监听（Enter 触发检测、r 切 ROI、+/- 调曝光），键盘模式会误触发。
- 配对规则：先扫码后触发，触发时取走当前条码；重复扫码以最后一次为准；默认 120 s 过期。

## 待用户确认
- 扫码枪型号/波特率/结束符、缺条码时进待处理还是不上传、HC_06 children 参数编码（找甲方）、进出站时机、重试数值、time 时区、ERR/NOPROD 是否上传、远程运行版本是否即 V21。
