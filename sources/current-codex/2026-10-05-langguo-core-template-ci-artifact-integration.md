# Langguo Core/template CI artifact integration

Date: 2026-10-05
Source: Codex current account.

- On the detached local PR #2 candidate, OpenCode changed only .github/workflows/ci.yml for this task. Existing local EventEnvelope edits in events.py and test_core_primitives.py were preserved.
- The workflow now builds Core and template wheel/sdist outputs, checks exact artifact counts, installs both wheels together into an isolated target, and runs import-provenance, Fake-cycle, SIMULATE-denial, and installed Replay checks outside the repository.
- Python 3.10.11 local verification passed: joint installation and smoke passed; Replay matched three events; installed template suite passed 12 tests. Core wheel SHA-256: 368410E6D029C3BE8022164D916FBBEE691EBBB408875246757F4A84F1FF0B66. Template wheel SHA-256: 49A8ADD057FF88068313C8F0572562A04A3F8E40A77741E6E41A64B9A22A4958.
- ZCode CLI Start Plan / GLM-5.3-Flash / high returned independent read-only PASS on this review. The CLI main route was temporarily set to high for the request, then restored to max. This confirms that this CLI route worked for this invocation; it does not establish remaining quota.
- GitHub-hosted CI, Python 3.11/3.12, formal PR review, merge/release, field/LIVE, and actual-cost gates remain open. No phase advanced; overall ten-capability readiness remains roughly 33% (30–35%).
- Evidence: C:\Users\Administrator\.codex\opencode-executor\runs\20261005-core-wheel-template-ci-hardening-fix1.

## Additional verification and current PR checkpoint (2026-10-05)

- The isolated candidate Core wheel passed the complete Core suite: 196 passed on Python 3.10.11; a pytest startup plugin asserted import provenance from the wheel target. The joint Core/template workflow smoke also passed on Python 3.12.14.
- PR #2 remains OPEN/CLEAN at 88a5b6e with no formal review decision. Its existing 3.10/3.11/3.12 CI/Release and package-preflight checks passed on 2026-10-03, but do not cover the local workflow edit. GitHub main still declares xz-industrial-core; PR head declares lg-industrial-core.
- No project push/PR update/merge/release or roadmap gate advancement. Readiness stays about 33% (30–35%).