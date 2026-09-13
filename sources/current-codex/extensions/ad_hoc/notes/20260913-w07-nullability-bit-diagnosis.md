# W07 populated-upgrade proof: SQL bit nullability false failure

Date: 2026-09-13
Source: Codex current account, Longol MES W07 review.

The credentialed W07 run created and retained fresh root and `_HISTORY` test databases. Migrations 001–006 applied on the root database and the second pass skipped them; populated-history setup also completed through applying 006. Verification then failed at `source_tested_at not nullable`.

Sol performed a read-only query against the retained W07 history database. SQL Server returned `sys.columns.is_nullable` as SQL `bit`; the Node `mssql` driver decoded it as JavaScript boolean `true` (`typeof === "boolean"`), while `w07-populated-upgrade-proof.js` compares it with strict numeric `!== 1`. This is a proof-script type-comparison defect, not evidence that the migration made the column non-nullable. No database edits or rerun were performed after diagnosis. W07 remains incomplete until ZCode adds a regression test for boolean `true` and reruns the approved controlled proof on fresh uniquely named W07 databases.

No credentials are included in this note.
