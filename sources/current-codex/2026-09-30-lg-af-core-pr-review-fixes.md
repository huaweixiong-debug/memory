# Core PR #2 review fixes (2026-09-30)

Source: Codex current account. Addendum to the LG-AF roadmap.

- Addressed two PR #2 findings in commit 1ef62df17919c41dd04ced7d35eb9e6878554438: per-handle replay transaction ownership lets close release its own pending exchange without advancing the shared cursor; event comparison mismatch paths now include events[index].
- Added close/retry, cross-handle read/close, idempotent close, and multi-event mismatch-path regressions. Python 3.10.11 focused tests: 120 passed; full Core tests: 149 passed. Tests used PYTHONPATH pointing to the current src tree and disabled bytecode/pytest cache. No global dependency was installed or changed.
- OpenCode used opencode-go/deepseek-v4.1-flash/high. GPT-6 Luna/high intermediate review and ZCode read-only review both passed. ZCode used Start Plan OAuth GLM-5.3-Flash/max without API-key tokens or plan fallback; it self-reported 49,645 tokens. A larger attachment review timed out after 900 seconds; the compact diff/test-summary review completed.
- PR #2 is open, Ready for review, and not merged. Python 3.10/3.11/3.12 CI and package preflight passed for the new head; release publishing was skipped. Pre-existing docs/pilot-compatibility.md and .agent/ changes were preserved.