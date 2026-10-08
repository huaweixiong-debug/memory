# 统一账号 Memory 规则

本目录中的 Codex 两个账号与 OpenCode memory 视为同一用户的连续记忆，后续整理、检索和回答时应联合参考：

- Codex 第二账号：`account_memory/MEMORY.md`，149 个已整理会话。
- Codex 当前账号：`current_account_memory/MEMORY.md`，本机当前账号的会话归档。
- OpenCode：`opencode_memory/MEMORY.md`，OpenCode 共享记忆与项目上下文。

## 使用规则

1. 三个来源内容互相补充，不把账号/Agent 边界当作用户身份边界。
2. 发生重复内容时，以较新的记录和更具体的记录为准。
3. 需要追溯时保留来源（Codex 账号 1 / Codex 账号 2 / OpenCode）和原始会话 ID。
4. 不把脱敏后的 memory 当作完整原文；完整上下文仍以各自原始 rollout 为准。

## 跨 Agent 执行与审核路由（2026-10-02）

- 用户指定：OpenCode CLI 使用 DeepSeek v4.1 Flash / max 执行；ZCode CLI 使用 GLM-5.3-Flash Coding Plan / high 审核；Codex 使用 GPT-6 Luna / 极高推理负责总协调与终审。
- 用户偏好：对已经明确授权的操作，不重复要求用户点击确认。

## 2026-10-03 OpenCode - YiDa detector comparison helper

- Implemented optional Faster R-CNN / Cascade R-CNN offline comparison helper for YiDa F/U without editing existing pipelines.
- Stable conclusion: R-CNN candidates must stay isolated from existing conda envs; train/eval later in `yida-mmdet-ab-20261003`.
- Limitations encoded in report helper: small shared-context test split; detection/count metrics are not end-to-end slot accuracy.

## 2026-10-03 OpenCode - YiDa detector helper fix pass

- Valid-threshold persistence must precede any test inference; report consumes a single frozen-threshold test result.
- Official detection metrics must use pycocotools COCOeval; custom AP approximations are rejected.
- Isolated MMDetection env still required (Py3.8 + torch2.1 cu121 + mmcv2.1 Windows wheel + mmdet3.3); existing mmdetection env remains incompatible.

## 2026-10-03 ZCode - 本机蓝牙音箱断续排查

- 硬件拓扑：蓝牙 BARROT USB 加密狗与 Realtek 8832CU USB WiFi 6 网卡同挂在唯一一个 USB 3.0 根集线器（无独立 USB 2.0 控制器）；USB 3.0 高速传输辐射 2.4GHz 干扰蓝牙，是音箱（猫王·小王子）断断续续的主因。
- 已做改动：USB 3.0 根集线器 MSPower_DeviceEnable 置为 False（关闭"允许计算机关闭此设备以节省电源"，可逆）；USB 选择性暂停原本已禁用；蓝牙服务 bthserv/BthAvctpSvc 正常，驱动无崩溃日志。
- 待办：用带屏蔽的 USB 延长线把蓝牙狗挪离 WiFi 网卡再验证；若仍断续，考虑重配对音箱或更新 BARROT 驱动。

## 2026-10-03 Codex 当前账号路由更新

- 来源：Codex 当前账号；用户在当前会话直接明确。
- 最新偏好：GPT-6 Luna 为最高指挥官，负责协调、审查裁定和最终验收；不再使用 GPT-5.6 Terra。
- 该明确指令优先于旧路由记录中涉及 Terra 的安排。代码执行者仍按任务提供的 AGENTS.md 和明确授权决定；本次项目由 OpenCode 实施、GPT-6 Luna 最终验收。

## 2026-10-03 Codex - YiDa F/U R-CNN comparison result

- On the 66-image frozen test for YiDa F/U, Faster R-CNN R50-FPN and Cascade R-CNN R50-FPN did not beat the YOLO baseline in mAP@[.50:.95] (0.5815 / 0.6430 vs 0.7025). Cascade's F exact-count result improved but U worsened; joint F/U exact-count accuracy tied YOLO at 42.4%, with slower inference. Keep the current YOLO baseline; treat the result as specific to this dataset split, not unseen production conditions.

## 2026-10-03 Codex - YiDa three-detector WBF ensemble follow-up

- A fixed score-normalized WBF of YOLO/Faster/Cascade on YiDa v17 improved F/U joint exact counting on the 66-image test from 28/66 to 54/66, with thresholds selected on valid first. mAP@[.50:.95] fell from 0.7025 to 0.6566; serial latency is about 5.5x YOLO by summing measured model means. Treat as count-focused candidate only, not production evidence; a separate-date test is still needed.

## 2026-10-08 OpenCode - ChatGPT/Codex Windows 桌面版崩溃修复

- 现象：商店版 OpenAI.Codex（ChatGPT.exe）使用中反复弹 "ChatGPT has stopped working / Error launching CrashSender.exe"，确定后退出；事件查看器/可靠性监视器无 ChatGPT 记录（崩溃被腾讯微信输入法 WeType 的 CrashRpt1500.dll 进程内处理器截获，其 CrashSender.exe 缺失，因此绕过 Windows WER）。
- 根因：windows-updater.node +0x1a789 空指针读 0xC0000005（openai/codex#51824，58+ 重复报告）；本机 10-07 更新到 26.1002.7124.0 后开始崩。
- 已在本机实施并验证的修复：退出应用后 Add-AppxPackage 安装已下载的官方运行时 `...LocalCache\codex-windows-runtime-framework-1cQY45\OpenAI.CodexPrimaryRuntime.v26-1007-641-0.msix`（签名 Valid）；重开后主进程稳定运行 4 分钟以上（此前 10~60 秒必崩）。
- 注意：勿卸载商店版应用（有人卸载后 ~/.codex 历史被清）；LocalCache 遗留 13 份运行时 msix（约 6.4GB）暂未清理；未来运行时更新可能复发。
