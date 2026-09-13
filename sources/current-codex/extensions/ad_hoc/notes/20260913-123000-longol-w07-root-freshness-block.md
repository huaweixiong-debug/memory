# Longol MES W07 root database freshness blocker

- Date: 2026-09-13
- During the final pre-run check, the W07 root createDatabase batch was found to create only when absent and silently reuse an existing LongolMES_W07_* target. This conflicts with the user-approved boundary that every W07 test database must be new and an existing target must fail.
- Sol approval was withdrawn before any credentialed SQL action. W07 is FIX_REQUESTED / IN_PROGRESS until ZCode changes the root database batch to reject an existing name and adds an offline regression test. No secure harness, production database, or device action occurred.
