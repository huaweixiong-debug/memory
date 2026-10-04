# 2026-10-05 Morocco and ATEQ corrected offline revalidation

[Source: Codex current account]

- Freshly revalidated the Morocco and ATEQ snapshots against the exact Core PR #2 Release wheel at head 88a5b6ed1b9dbee904f066606f68a183bd960a29: Morocco root 179 passed, python_app 141 passed, and ATEQ 129 passed on Python 3.10.11. Wheel SHA-256: 8C4548F16136B298CD998F316054A680FED94F9116A3224C2483770B65B15A87.
- Initial collection/run errors were command setup issues: Morocco root requires LG_INDUSTRIAL_CORE_SOURCE pointing to the isolated install target; ATEQ tests with relative config paths require the ATEQ project root as current directory. Corrected commands passed. The 136-file source/test/config manifest was identical before and after.
- Appended the fresh results to the company roadmap, preserving its prior bytes as an exact prefix. Final roadmap SHA-256: E66CCD3F64A31B9440AC5084C7DCE157AF460B8A08D3EDA0C78D70B3ADB602CF.
- ZCode Start Plan / GLM-5.3-Flash / high returned Model creation failed; BigModel individual Coding Plan / GLM-5.3-Flash / high reviewed the corrected packet and returned PASS with no blocking findings. Global ZCode config stayed unchanged.
- This is offline Fake/SIMULATE evidence only. Field configuration, PLC point/port provenance, hardware/LIVE/production, and actual cost gates remain open. No roadmap phase advanced. PR #2 remains OPEN/MERGEABLE with empty reviewDecision.
