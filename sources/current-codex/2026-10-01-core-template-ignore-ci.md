# 2026-10-01 Core template ignore rules and PR validation

Source: Codex current account.

- Added `template/.gitignore` to LG Industrial Core with the seven Python/build patterns already used at repository root, so a standalone project-template copy carries its own ignore rules. Commit `6f2591f12d5dcb8c0dcfa1c38b88300a6a6201b7` is on the existing Core PR #2 branch.
- Verified the rules in a separate scratch Git repo, imported Core from the exact `src`, and ran the Python 3.10 template tests (`7 passed`). Existing ignored test/bytecode caches were preserved unchanged.
- ZCode read-only review through the project failover wrapper returned PASS using Start Plan GLM-5.3-Flash / max; no fallback to the personal Coding Plan and no API-key tokens. Real quota-exhaustion fallback remains untested.
- PR #2 at this commit is OPEN and unmerged. Python 3.10/3.11/3.12 CI, reusable Release CI, and Package preflight succeeded; publishing the GitHub Release was skipped for the PR event. No hardware, production database, or customer network was accessed.
- Evidence: `C:\Users\Administrator\.codex\opencode-executor\runs\20261001-core-template-gitignore\REVIEW_PACKET.md`.
- After pushing that PR head, revalidated both isolated pilots with Core `src` pinned through `PYTHONPATH` and `LG_INDUSTRIAL_CORE_SOURCE`: Morocco Python 3.10 `169 passed, 1 skipped`; ATEQ `93 passed`. Their untracked-inclusive git status sets were unchanged. These are offline fake tests, not field acceptance.
