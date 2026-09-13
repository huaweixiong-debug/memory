# W07 nullable-bit proof fix reviewed

Date: 2026-09-13
Source: Codex current account, Sol review.

ZCode made the scoped W07 proof repair: SQL Server `sys.columns.is_nullable` is a `bit` that the Node `mssql` driver returns as boolean `true`; the old strict `!== 1` check falsely failed a valid nullable column. The proof now accepts only boolean `true` or numeric `1`, and boundary coverage rejects false, zero, missing, string, and out-of-range values.

Sol independently ran syntax check, W07 offline gate (39 tests), and the unified test runner, all passing. The W07 change is approved by Sol and remains waiting for human review before a new credentialed run on fresh retained `LongolMES_W07_*` and `_HISTORY` databases. Do not reuse or delete the two prior retained W07 proof databases. No credentials are included.
