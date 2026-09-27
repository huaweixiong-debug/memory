# XZ Industrial Core offline pilot — 2026-09-27

- Created private GitHub repository `huaweixiong-debug/xz-industrial-core`. Main commits: `c87752d` for v0.1 source and `be0ab16` for pilot evidence docs.
- Core now has fail-closed per-effect mode policy (SHADOW defaults offline; optional reads require explicit gates), event envelope, typed ATEQ/PLC/repository/journal ports, and label/laser output compatibility adapters.
- On Python 3.10: core checks 9 passed; fake/in-memory compatibility checks pass for Morocco `b54c4eb` and ATEQ-F620-Laser `c22accd`. No product repository was changed or made dependent on the core.
- Existing pilot suite baselines: Morocco 122 passed / 2 failed (packaged EXE absent from source clone; visible UI text includes an unapproved standalone `M`); ATEQ-F620-Laser 64 passed after an in-memory test-package shim for missing `tests/__init__.py`.
- The repos' SHADOW compositions use Fake/Replay services rather than physical reads; keep core SHADOW offline by default. Production device behavior remains unverified; next phase is application-layer integration in reviewable isolated branches.
