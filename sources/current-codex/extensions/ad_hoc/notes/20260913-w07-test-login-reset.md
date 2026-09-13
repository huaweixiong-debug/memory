# W07 dedicated test login reset and verification

Date: 2026-09-13
Source: Codex current account, explicit user authorization.

Only the two existing W07 dedicated SQL test logins were reset: `longol_w07_admin` and `longol_w07_app`. No `sa` change, database write, migration, device, PLC, or printer operation occurred. Separate read-only `SELECT 1` authentication probes for both logins passed. Their secrets are intentionally not stored here. W07 secure harness execution remains the next approved gate and must use a fresh retained W07 target database.
