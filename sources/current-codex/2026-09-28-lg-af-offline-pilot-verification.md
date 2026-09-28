# 2026-09-28 — LG-AF offline pilot re-verification

- Current staged `lg-industrial-core` HEAD `8f2a0c2` passes the combined Core/template suite (136 tests). The isolated Morocco copy passes 171 root tests and 109 Python-app tests; the isolated ATEQ copy passes 92 tests, including synthetic serial recording/replay. Runs explicitly loaded the current staged Core source before collection where required; default imports can resolve an older installed package.
- Morocco's `package_preflight.py` independently built a fresh one-folder bundle under OS temp with Python 3.10.11 / PyInstaller 6.22.0 and returned `PREFLIGHT_PASS`. Config files matched source hashes, no ICU DLLs were collected, OpenSSL provenance allowed only Python-runtime `libcrypto-1_1.dll`, and both fixed SIMULATE commands exited 0. Qt TLS runtime behavior was not tested.
- The canonical Morocco `package_dist_final` was not changed. It remains stale (no bundled `points.toml`, residual ICU DLLs, and an execute ACL that prevented in-place execution). TASK-1004/1005 remain `REPAIR_REQUIRED / OPENCODE`; the temporary preflight does not approve or replace the candidate.
- The Core PR #2 remains Open / Draft / unmerged. No live device, production database, or release action occurred.
- The estimate-to-actual workbook v3 exists but has no real project-cycle data; no later-phase productization is supported until a full cost cycle and genuine follow-on reuse evidence exist.
- The latest ZCode CLI ATEQ review retry returned `Model creation failed`, so it produced no ZCode verdict. The selected account route was personal Coding Plan OAuth; no API-key token was read.
- Full command output and before/after candidate evidence are in the Codex run directory `20260928-morocco-preflight-codex-independent`.
