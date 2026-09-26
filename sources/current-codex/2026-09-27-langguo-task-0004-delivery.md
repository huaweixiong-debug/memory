# Langguo Agent Factory — TASK-0004 opt-in delivery complete

Date: 2026-09-27. Source: current Codex account.

- TASK-0004 adds opt-in, task-isolated Git branch and pull-request delivery. Defaults remain disabled; issue intake alone cannot enable writes; no merge/deployment path is provided.
- Final review found and resolved three safety defects across attempts 1–2: QA was not bound to the publishable worktree identity; invalid publication settings could fall back to the shared checkout; and incomplete QA attestations could omit worktree/baseline/path fields. The Orchestrator now blocks those paths, and QA attestation verification requires exact identity fields.
- ZCode independent QA passed the final attempt: 137 total offline tests, 52 delivery tests, plus intake and compilation checks. GitHub Actions passed both push and pull_request Windows CI runs.
- Commit `02faea5` was pushed to `huaweixiong-debug/Langguo-Agent-Factory` branch `feature/github-issue-intake`, updating existing PR #1. PR #1 remains open against `main`; it was not merged. The example config keeps all publication switches off and `base_branch` unset.
- Task workflow state is `APPROVED / ORCHESTRATOR`, attempt 2. No live task delivery, merge, deployment, or industrial write was performed.