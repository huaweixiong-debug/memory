# 2026-10-05 — LG Core event payload key canonicalization

- At exact LG Industrial Core PR #2 head 88a5b6ed1b9dbee904f066606f68a183bd960a29, found that a custom str subclass key with distinct equality/hash could coexist with an ordinary key of the same JSON text; JSON round-trip silently collapses duplicate object names.
- An isolated local patch now requires exact built-in str keys recursively. Regression covers root dictionaries, dictionaries inside lists, and list/tuple nesting. The pre-fix regression failed with DID NOT RAISE; Python 3.10.11 focused suite passed 115 tests, full Core suite passed 196, and git diff --check passed.
- OpenCode CLI DeepSeek V4.1 Flash/max implemented the two-file patch; Codex final acceptance passed. ZCode CLI selected BigModel Coding Plan / GLM-5.3-Flash but produced no verdict during a bounded approximately 120-second plan-mode review; reasoning effort was not verifiable from the CLI.
- The patch is uncommitted in an isolated detached worktree, only events.py and test_core_primitives.py are modified, and GitHub PR #2 remains unchanged at 88a5b6e with no review decision. This does not advance the roadmap estimate or any field/release gate; overall remains about 33% (30–35%).
- Evidence: C:\Users\Administrator\.codex\opencode-executor\runs\20261005-core-event-key-canonicalization\

[Source: Codex current account. No credentials or raw conversation copied.]