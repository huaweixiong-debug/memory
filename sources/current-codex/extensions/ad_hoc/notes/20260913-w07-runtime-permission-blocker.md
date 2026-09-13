# W07 controlled proof reached runtime permission blocker

Date: 2026-09-13
Source: Codex current account, Sol controlled-run review.

A fresh retained W07 root and history test database completed migrations, migration skip proof, populated 005-to-006 preservation proof, and schema audit. The final database integration failed because the dedicated application login lacks `EXECUTE` on the `dbo.LegacyHeliumBatch` table type; receiver tests returned 500. The harness grants roles before migration but fails to grant post-006 object-level execute permissions for the type and ingestion procedure.

W07 is `FIX_REQUESTED` / `IN_PROGRESS`. The bounded fix is a post-migration least-privilege grant for only the TVP and procedure plus an authorization and receiver regression; do not alter migrations 005/006, grant db_owner or schema-wide execute, or reuse/delete retained W07 test databases. No credentials are included.
