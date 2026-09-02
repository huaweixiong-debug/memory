# OpenCode Memory

本目录保存 OpenCode 的共享记忆摘要。

- [`MEMORY.md`](MEMORY.md)：OpenCode 统一记忆主文件，包含用户画像、环境、活跃项目、最近会话。
- `threads/`：按会话归档的摘要卡片（目前为空，后续可逐步补充）。

使用方式：每次 OpenCode 会话开始前读取 `MEMORY.md` 和上级 `UNIFIED_MEMORY.md`，使 OpenCode 与 Codex 两个账号共享同一用户记忆。
