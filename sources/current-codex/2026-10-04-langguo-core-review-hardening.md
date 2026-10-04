# 2026-10-04 Langguo Core review hardening

Source: Codex current account; isolated local follow-up to Core PR #2 on 2026-10-04.

- Based on detached PR-head snapshot `88a5b6ed1b9dbee904f066606f68a183bd960a29`, pinned `softprops/action-gh-release` to the immutable v3.0.3 commit and made default transcript creation exclusive, preserving explicit overwrite behavior. Added a deterministic race regression test. Only the workflow, `serial_recording.py`, and its focused test file changed.
- OpenCode packet reports 75 focused serial tests passed, six transcript-file tests passed, and a negative control failing against the pre-fix source as expected. Codex final static acceptance found no defect; no project commit, push, GitHub review, release, or deployment occurred.
- ZCode CLI Start Plan / GLM-5.3-Flash / high and the BigModel Coding Plan / GLM-5.3-Flash / high fallback both produced no review session or output within about 60 seconds. No ZCode PASS is claimed; prior model selections were restored.
- Overall ten-capability progress remains a rough 30–35% (central estimate about 33%) by capability/gate readiness, not labor hours or earned value. This small Core hardening does not materially change it. PLC/source confirmation, field/LIVE acceptance, actual-cost evidence, formal PR acceptance, and later capability gates remain open.