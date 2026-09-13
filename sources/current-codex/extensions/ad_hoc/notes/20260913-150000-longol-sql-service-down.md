# Longol SQL Server host diagnostic

- Date: 2026-09-13
- User asked for help after forgetting the SQL administrator password. SSH to 100.117.1.6 succeeded as huaweixiong; the target is openaiserver and this host owns Tailscale IP 100.117.1.6.
- Read-only checks showed mssql-server failed since 2026-09-02, no sqlservr process, no listener on 1433, and adequate disk space. Journal showed an unclean start with orphaned sqlservr processes followed by service failure. SQL errorlog access required sudo; only filtered startup context was inspected.
- No SQL service restart, credential reset, database access or creation was performed. Restart could trigger automatic recovery/writes on existing W03/W04 and other databases; obtain explicit confirmation before this state change. The SSH password was disclosed in chat; recommend rotation without recording it.
