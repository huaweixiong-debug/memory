# Longol SQL Server recovered after explicit authorization

- Date: 2026-09-13
- The user explicitly allowed clearing the mssql-server failed state and starting the SQL Server engine for automatic recovery.
- On 100.117.1.6, `mssql-server` is now active and listening on 1433. The SQL error log says recovery completed and lists recovery completion for existing W03/W04/W05/W06 databases. No manual database edits, password reset, or test database creation were performed.
- Resetting the forgotten SQL administrator password is a separate service interruption and was not included in the start/recovery approval; obtain explicit consent before stopping/restarting SQL again. SSH password was exposed in chat; recommend rotation.
