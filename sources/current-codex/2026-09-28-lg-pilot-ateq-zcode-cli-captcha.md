# 2026-09-28 — ATEQ synthetic replay acceptance and ZCode OAuth CAPTCHA

- Codex accepted the scoped ATEQ offline replay test after reviewing the test and saved evidence. Only `tests/test_core_serial_recording.py` was hand-edited; the recorded targeted and full-suite results are 2 passed and 92 passed. The test uses synthetic frames and is not hardware or production acceptance.
- ZCode CLI 0.16.9 was authorized for GLM-5.3-Flash at highest reasoning through the signed-in BigModel Start Plan OAuth account; manually entered Coding Plan API-key credentials were not read. The app-server account callback worked, but the gateway returned HTTP 400 `captcha verify failed` during the review, so ZCode produced no verdict. Do not count this as PASS; retry after the user completes the account CAPTCHA in ZCode.
- No merge, release, production database, or live-device action was performed.
