# LG Core Release 制品身份 preflight

日期：2026-10-04；来源：Codex 当前账号。

- 在 detached PR #2 head `88a5b6ed1b9dbee904f066606f68a183bd960a29` 的既有隔离候选中，仅新增 `.github/workflows/release.yml` 的无条件身份检查：wheel/sdist 元数据名按 PEP 503 规范化后必须为 `lg-industrial-core`，版本必须非空且一致。
- OpenCode CLI `opencode-go/deepseek-v4.1-flash` / max 实施；ZCode CLI Start Plan / GLM-5.3-Flash / high 返回 PASS，无额度回退；Codex 最终验收 PASS。
- 使用候选 wheel/sdist、真实 Bash run block、10 项元数据边界、27 项 YAML/发布结构断言和 `git diff --check` 验证通过。未安装 actionlint；没有针对本地增量运行 GitHub Actions。
- 项目代码仍仅为本地未提交/未推送候选；PR #2 远端 head 未改变，reviewDecision 为空，未产生正式审查/合并/发布。路线图门禁不推进，整体准备度估算仍约 33%（30–35%）；现场来源与真实成本门仍开放。
- 证据目录：`C:\Users\Administrator\.codex\opencode-executor\runs\20261004-lg-release-identity-guard\`。