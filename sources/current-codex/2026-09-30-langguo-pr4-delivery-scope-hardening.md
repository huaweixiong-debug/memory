# Langguo Agent Factory PR #4 delivery safety hardening

Source: Codex current account, 2026-09-30.

- PR #4 (`huaweixiong-debug/Langguo-Agent-Factory`, `codex/repo-delivery-scope`) now validates every effective fetch and push URL from the task worktree before remote preflight, immediately before push, before timeout reconciliation, and before each GitHub PR API call.
- Both `ls-remote` checks run from the task worktree. The timeout-reconciliation path revalidates scope before reading remote state.
- GitHub URL parsing accepts HTTPS, SSH URI with a valid port, and canonical scp form; malformed ports and slash-only scp lookalikes fail closed.
- Delivery test runners replace `origin` with a temporary bare path for `push`, `fetch`, and `ls-remote`, and fail before Git starts when a local remote is missing. The includeIf sibling-pushurl regression remains offline even if the production guard is bypassed.
- Local verification passed: 46 repository-scope tests, 73 delivery tests, 207 total tests. Both Windows GitHub Actions checks passed.
- ZCode performed a read-only review with the account Start Plan GLM-5.3-Flash path and found no blocking issues; quota fallback was not triggered, and no API-key plan was used.
- Commit `589f0b4` is on PR #4. PR remains OPEN and unmerged.
