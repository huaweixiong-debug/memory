# 2026-09-28 LG Industrial Core serial transcript pilot

- LG Industrial Core now has a local JSONL serial byte recorder and deterministic replay factory. It preserves exact request bytes, requested read size, short/empty observed responses, and fails closed on mismatch, malformed data, or exhaustion.
- The isolated ATEQ and Morocco pilot copies received one integration test each; those tests use synthetic Modbus frames and in-memory serial fakes. Independent offline reruns passed: ATEQ 27 tests, Morocco 45 tests. Core verification passed 129 tests, template checks passed 5, and the GPT-6 Luna maximum-effort acceptance returned PASS with no issues.
- These results do not establish physical-device or production acceptance. No pilot application source was migrated, and no commit, merge, or release was made.
- ZCode QA automation can return ZCODE_NO_WORK when its gate finds no IMPLEMENTED/ZCODE task. The local CLI also failed to start a new or resumed prompt because no model was selected; its TUI entry reported the @zcode/tui package missing. Do not treat that run as QA evidence.
- Model routing update: do not use GPT-6 Terra. Codex final acceptance uses GPT-6 Luna at maximum reasoning effort. OpenCode pilot implementation used DeepSeek V4.1 Flash at max, per the current task instruction.
