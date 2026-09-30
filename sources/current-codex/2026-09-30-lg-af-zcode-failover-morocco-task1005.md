# Morocco TASK-1005 ZCode CLI re-audit (2026-09-30)

Source: Codex current account. Addendum to the LG-AF roadmap execution.

- The authorized zcode-failover.ps1 CLI route completed a scoped, read-only ZCode review using Start Plan OAuth GLM-5.3-Flash. It did not trigger the personal Coding Plan fallback and used no API-key tokens. ZCode self-reported 227,537 tokens for the call; that value is not independently verified billing.
- ZCode independently inventoried the Morocco candidate: one nested EXE, 61,178,180 bytes, SHA-256 prefix 428DFE7E and suffix CC8974; the package lacks the spec-required points.toml and retains ICU DLLs that the spec filters.
- Its single help-first --help launch was denied by Windows before process creation (shell status 126), with no application output. Per the gate it did not run SIMULATE, copy the package, change ACLs, or retry. The candidate remains REPAIR_REQUIRED / OPENCODE; runtime is unverified and external release is not ready.
- ZCode appended the audit to the existing TASK-1005 report. Codex checked the state JSON and confirmed it remained owner=OPENCODE, status=REPAIR_REQUIRED.
- This call confirms the wrapper can complete a Start Plan request. Actual quota exhaustion and automatic provider switching were not exercised.
