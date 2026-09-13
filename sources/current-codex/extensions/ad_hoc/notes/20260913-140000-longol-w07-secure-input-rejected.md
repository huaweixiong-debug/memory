# Longol MES W07 secure validation input rejection

- Date: 2026-09-13
- The first human-run W07 secure command stopped in local input validation because W07_ADMIN_PASSWORD was shorter than the required 12 characters.
- The harness failed before any SQL Server connection or database creation. The printed W07 target was only a planned name; no cleanup action is needed.
- A later retry must use the real distinct SQL administrator, MES application, and bootstrap usernames as applicable, with every password and station key at least 12 characters. Do not retry until the correct values are available.
