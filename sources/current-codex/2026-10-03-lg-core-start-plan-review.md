# ZCode Start Plan review route confirmation

Date: 2026-10-03
Source: current Codex

- User's review routing: OpenCode CLI / DeepSeek V4.1 Flash / max implements; ZCode CLI / GLM-5.3-Flash / high reviews; Codex GPT-6 Luna coordinates and performs final acceptance.
- For ZCode reviews, prefer Start Plan when quota is available; use BigModel Coding Plan with the same model and reasoning level if Start Plan cannot run.
- Verified in the LG Industrial Core PR #2 local overlay follow-up: ZCode CLI successfully ran Start Plan / GLM-5.3-Flash / high in plan mode and returned PASS. Start Plan was usable at that time, so the Coding Plan fallback was not used.
- The reviewed overlay added a ReplaySerial non-owner write regression test and clarified RecordingSerial.close() behavior for a blocked inner write. The packet reported 74 focused serial tests passing; ZCode reviewed the evidence read-only and did not rerun tests. This private review is not a GitHub review or approval, and the local overlay remained uncommitted.