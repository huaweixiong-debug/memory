# LG Industrial Core pilot review and temporary ZCode route — 2026-09-28

Source: Codex current account. Project: LG Industrial Core Morocco/ATEQ isolated pilots.

- User authorized ZCode review for the next three days using the logged-in personal Coding Plan OAuth with GLM-5.3-Flash at the highest available reasoning level; do not consume manually supplied API-key tokens.
- In this review, ZCode CLI headless/app-server did not resolve the account model in this environment, so the authorized read-only review was completed in the already logged-in ZCode Desktop UI, visibly set to GLM-5.3-Flash / 最高. No API key was used. Do not claim CLI succeeded; retry its model registration separately if a future task specifically requires CLI.
- ZCode review found a skipped duplicate-label test, a mismatch risk between the approved SIMULATE repository and the Core repository adapter target, and test coupling to Core private internals. ATEQ review reported no code-level finding; its static-review limits remain.
- OpenCode, same existing Morocco session ses_f1a2de891ffepKPhI3v0KnOLhw, used deepseek-official/deepseek-flash / high (highest supported variant) for one bounded repair. Only the staged Morocco python_app/app/core_adapter.py and python_app/tests/test_core_adapter.py changed. The bridge now rejects a Core adapter whose private _target is not the exact approved underlying repository, failing closed if Core changes that internal attribute; tests exercise a true second station label attempt and remove adapter-private inspection.
- Independent final verification with Python 3.10 and the staged LG Industrial Core source: focused 14 passed; full active Morocco Python app 108 passed. No hardware, production DB, LIVE path, merge, release, or deployment was used.
- Evidence packet and pre-fix backups: C:\Users\Administrator\.codex\opencode-executor\runs\20260928-102154-lg-core-pilots\morocco-fix-1\.
- Core remains private; pilot directories are isolated staging copies without Git metadata. Offline tests do not approve production use.
