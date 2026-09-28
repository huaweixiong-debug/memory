# 2026-09-28 — ATEQ synthetic replay acceptance and ZCode OAuth CAPTCHA

- Codex accepted the scoped ATEQ offline replay test after reviewing the test and saved evidence. Only `tests/test_core_serial_recording.py` was hand-edited; the recorded targeted and full-suite results are 2 passed and 92 passed. The test uses synthetic frames and is not hardware or production acceptance.
- The user authorized ZCode CLI 0.16.9 for the next three days from 2026-09-28 to review with GLM-5.3-Flash at the highest reasoning level through the signed-in BigModel Start Plan OAuth account. Do not use or read Coding Plan API-key tokens. An app-server route check confirmed OAuth and no manually entered plan API key.
- ZCode's earlier review call received HTTP 400 `captcha verify failed`; a subsequent read-only CLI retry returned `Model creation failed` and produced no review. Neither call is a ZCode verdict. Continue only after the account verification is completed in ZCode; never count this as PASS.
- No merge, release, production database, or live-device action was performed.
