# 2026-10-01 — ZCode CLI reasoning level and failover smoke check

Source: Codex current account.

- The current ZCode CLI selection exposes `options.reasoningLevel = max` for Start Plan / `GLM-5.3-Flash`. The wrapper's `--mode plan` controls permissions; it does not lower reasoning. Its provider switch changes the provider ID while retaining the model selection options.
- A fixed-text request through the wrapper completed successfully from the UNC task directory despite CMD's UNC-CWD warning. This verifies a short call only; longer review prompts/large attachments have separate timeout reports. No quota exhaustion was forced and automatic fallback/retry remains unverified.
