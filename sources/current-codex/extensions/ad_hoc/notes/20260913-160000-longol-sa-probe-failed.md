# Longol SQL sa credential probe

- Date: 2026-09-13
- At the user's request, one read-only SQL authentication probe tested login `sa` with password `sa` against local SQL Server on 100.117.1.6 and ran only `SELECT 1` after authentication.
- Authentication failed. No database writes or password changes occurred. Do not repeat guesses; a password reset is the next route and requires stopping/restarting the SQL Server service.
