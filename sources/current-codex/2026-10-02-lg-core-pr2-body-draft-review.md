# 2026-10-02 LG Core PR #2 正文更新草稿独立复核（PASS）

- 复核对象：`C:\Users\Administrator\.codex\opencode-executor\runs\20261002-roadmap-ci-evidence-correction\pr-body-update\PR_BODY_DRAFT.md`（拟替换 PR_BODY_BEFORE.md，旧正文基于旧 head `a822e5a`）。
- 结论：**PASS，草稿每一条可核查声明均属实**，可提交为 PR #2 公开描述；两条非阻塞小建议（见下）。

## 实测关闭了 REVIEW_PACKET §7.4 的证据溯源缺口

- 此前执行轮与 ZCode 复审都未查询 GitHub（计划禁止远端动作），run ID 只来自计划「verified source facts」。本次以只读 `gh` 实测确认：
  - PR #2：OPEN / MERGEABLE，head `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7`，base `be0ab16f32c174dd2803c0742931947badfc7432`。
  - CI run `36803886601`：success、pull_request、head `6f2591f`。
  - Release run `36803886868`：success、pull_request、head `6f2591f`（run 名 "Release"）。

## Summary 六条逐项对照提交树（checkout `Documents\Codex\2026-10-01-core-output-receipt-boolean-fix`，HEAD 即 6f2591f）核实

- 更名：pyproject `name = "lg-industrial-core"`，包 `src/lg_industrial_core/`。
- JSONL 事件 record/replay/compare（`recording.py`）+ 串口字节 transcript 录制/回放（`serial_recording.py`）。
- 有界传输无关分隔符组帧：`framing.py` `DelimitedByteFramer`；`FrameTooLargeError.completed_frames` 保留同次 feed 中超长帧之前的完整帧。
- 模板 ATEQ PASS/NG 与打印机 accept/reject 可配置（template README+fakes.py）；Fake-only `SimulatedStation`（Mode.SIMULATE）+ 独立 `demonstrate_live_gate()` LIVE 门演示；CI 矩阵 3.10/3.11/3.12；release.yml 的 Publish job 仅在 v* tag push 触发（PR 场景必 skipped）；`is_bound_to()` 公开适配器身份检查。
- `accepted` 必须 True bool，否则 TypeError（a822e5a 移除了 `bool()` 强转，`"false"` 之类 truthy 串改为 fail-closed）。

## 计数与其他对照

- PR-head 离线计数（Core 170 / 模板 7 / Morocco 根 169+1 skip / python_app 60+1 skip / ATEQ 102）与 2026-10-01 交叉复验文档完全一致；两个 skip 均为缺打包 EXE 的包布局检查，草稿的 skip 解释成立。
- 三个更正后路线图文档磁盘 SHA-256 与 verification-summary 完全一致。
- 草稿比旧正文更准确：旧正文把 170/7 说成「on each of Python 3.10/3.11/3.12」（实为本地 3.10.11 离线计数），并把旧 head 的 Morocco 168 / ATEQ 93 当作现值。

## 非阻塞小建议

1. PR 最新提交 `6f2591f`（template/.gitignore 独立 ignore 规则，+7 行）在 Summary 中未提及——它是旧正文之后唯一新增提交，可加一句。
2. 旧正文的 Traceability 试点 27 tests、15 focused tests、兼容性 checker 等行被删除属收紧范围的取舍，非错误，提交前请确认是有意为之。

## 运维提示

- 本机 `gh run view <id>` 会先解析 workflow 再发第二个请求，该请求易复现文档中记载的 unexpected EOF；改用 `gh api repos/<owner>/<repo>/actions/runs/<id>` 直接查询更稳。
