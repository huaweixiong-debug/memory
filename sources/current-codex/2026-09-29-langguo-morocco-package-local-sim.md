# 2026-09-29 LG roadmap: Morocco staged package local simulation

Source: Codex current account. Scope was the isolated Langguo_AI pilot copies only.

- The LG Industrial Core rename audit found active package metadata/import identity as `lg-industrial-core` / `lg_industrial_core`; old XZ names remain only in historical migration notes and task reports, with no active code or package metadata residue found.
- The Morocco `package_staging/TASK-1007` bundle was copied without edits to a local temporary directory. EXE and default config hashes matched the shared-copy originals. From the local copy, `--diagnose --mode simulate` passed with fake/no-side-effect checks for PLC, ATEQ, scanner, database, and printer; `--smoke-cycle --mode simulate` passed with two stations, records, and fake labels.
- This isolates the prior startup failure to execution from the shared path for the tested bundle. It does not clear the original shared-path `Access Denied` gate. Morocco TASK-1004/1005 remain `REPAIR_REQUIRED`; no ACL, staged source, field devices, production services, or release state changed.
- Evidence: `P:\Langguo_AI\company\outputs\01a0dc5b-a613-7a30-9675-6be7a44f5ddd\Morocco_TASK-1007_本机暂存包模拟运行核验_2026-09-29.md`; roadmap ledger updated in the same output folder.
