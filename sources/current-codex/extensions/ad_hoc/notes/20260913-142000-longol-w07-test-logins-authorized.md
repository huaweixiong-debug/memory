# Longol MES W07 dedicated test login authorization

- Date: 2026-09-13
- The user authorized creation of two dedicated SQL Server logins for W07 validation rather than weakening the harness: longol_w07_admin and longol_w07_app.
- Scope: do not change existing root/root credentials or any existing database. The provisioning must fail if either target login already exists, use strong user-entered hidden passwords, and grant only dbcreator to the W07 admin login.
