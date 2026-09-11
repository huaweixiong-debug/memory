# Shared scanner test-page controls

- The ATEQ test page now shows one shared scanner state/status and one `开启扫码/关闭扫码` input-gate button; toggling it does not start, stop, or change any A/B test program.
- Per-station scanner indicators and watchdog controls were removed from the A/B cards. Reprint remains separate as `标签重打 A` and `标签重打 B`.
- Verification after the UI change: `71 passed`, compileall passed. The scanner remains configured as the single TCP client at `192.168.2.10:9004` with automatic A/B QR routing.
