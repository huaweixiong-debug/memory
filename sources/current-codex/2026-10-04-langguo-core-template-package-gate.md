# Langguo Core PR #2 template package gate and roadmap estimate

Date: 2026-10-04

- PR #2 head `88a5b6ed1b9dbee904f066606f68a183bd960a29` adds a CI build for the template wheel and sdist, installs the wheel under `RUNNER_TEMP`, and runs the installed composition outside the repository. Replay documentation now states the method-level compatibility boundary; no runtime transaction behavior changed.
- ZCode CLI / GLM-5.3-Flash read-only review returned PASS with no blocking findings. One Low non-blocking limitation remains: the smoke uses the already-installed editable Core package, so it does not test the built Core wheel and template wheel together. This matches the plan scope.
- CI run `37146409172` passed on Python 3.10, 3.11, and 3.12, including all template build/install/composition steps. Release run `37146409416` passed the same matrix and Package preflight; Publish was skipped for the PR event.
- PR remains OPEN, non-Draft, MERGEABLE, with no formal GitHub review decision. No merge, tag, release, physical I/O, LIVE/field acceptance, actual-cost acceptance, or roadmap phase-gate advancement occurred.
- Planning estimate is roughly 33% (range 30–35%) across ten equally weighted roadmap capabilities. This is a rough capability-count proxy; no official workload weighting exists. Cost evidence, field point/port confirmation, and later capabilities remain open or deferred.
- Evidence: PR commit `88a5b6e`; ZCode report and implementation packet under `C:\Users\Administrator\.codex\opencode-executor\runs\20261004-core-template-package-gate\`.