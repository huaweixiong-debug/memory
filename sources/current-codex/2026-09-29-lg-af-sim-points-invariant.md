# ATEQ SIM_POINTS and production point-map invariant

Date: 2026-09-29
Source: Codex current account; read-only ZCode Desktop review on the personal GLM-5.3-Flash plan.

- Do not keep `SIM_POINTS == config/points.toml` as a long-term invariant. `app/points.py:42` defines `SIM_POINTS` as a demo table with no physical meaning; `config/points.toml:4-6` identifies current addresses as Morocco-derived placeholders intended for replacement from ATEQ electrical data.
- Correct the routing description: `app/composition.py:52-53` makes LIVE load the configured production map without a simulation fallback. Non-LIVE modes first load the configured points file and use `sim_point_map()` only when that file is missing or invalid (`composition.py:54-57`). Do not claim SIMULATE always uses the simulation map.
- Durable checks should cover signal-key/schema consistency, LIVE source provenance and no simulation fallback, non-LIVE fallback provenance, and that `points_confirmed=false` blocks preflight/LIVE service construction. Avoid comparing physical address values across the independent sources.
- `PointMap.source` is not currently consumed elsewhere in `app/`; `ui_replica.py:149` can silently fall back to `sim_point_map()` when `point_map=None`. Treat source enforcement there as a hardening candidate, not as a completed guard.
- Neither the current SIM values nor the placeholder production addresses establish field correctness. Keep ATEQ points/ports confirmation false until the electrical point list and point-by-point review are available. This was a read-only review; no tests, files, devices, or production systems were changed.
