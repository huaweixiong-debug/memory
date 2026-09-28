# 2026-09-29 Morocco ZCode Desktop review follow-up

Source: Codex current account. Date: 2026-09-29.

- ZCode Desktop was operated through Computer Use with BigModel personal Coding Plan GLM-5.3-Flash at highest reasoning; no API-key tokens or ZCode CLI were used.
- TASK-1004: the Desktop reviewer’s first Bash inventory request was declined. Its report addendum records that hashes, binaries, TOC imports, and SIMULATE runs were not independently verified by ZCode; state remains REPAIR_REQUIRED / OPENCODE. The existing Codex evidence still records matching TOML hashes, both temporary SIMULATE commands exiting 0, OpenSSL 3 sourced from Miniconda, and an unresolved extra root-level EXE staging policy.
- TASK-1005: ZCode independently read project files and confirmed the current candidate lacks _internal/config/points.toml, while the source map exists and leak_test.spec requires it. The candidate default.toml matched the source text. ZCode’s read tool rejects .exe/.dll by extension and cannot enumerate directories; an absent-file control returned the same binary-file rejection, so EXE/DLL inventory was not inferred. The prior --help Access Denied was not retried; neither simulator command was run by ZCode. State remains REPAIR_REQUIRED / OPENCODE.
- package_staging/TASK-1007 already exists with staged point-map evidence. The recorded staged EXE launch failed with Windows WinError 5; no ACL change or external fallback is allowed by that task. Static QA passed with binary/runtime limitations recorded.
- Next gate: resolve the shared-path execution limitation within the authorized project boundary before any staged runtime acceptance. Do not treat static review or Codex-only SIMULATE evidence as ZCode independent verification or release approval.
