# Longol MES W07 weak credential block

- Date: 2026-09-13
- The user reports every W07 input is root/root. This cannot pass the W07 secure harness: passwords and station keys require at least 12 characters, and five station keys must be distinct.
- Do not weaken the harness or substitute values. Changing SQL login passwords or station configuration is external state and needs a separate explicit authorization and rollback plan.
