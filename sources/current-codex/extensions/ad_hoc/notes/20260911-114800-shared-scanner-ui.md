# Shared online scanner UI

- The Main.vi-style test page now starts one TCP scanner client for `192.168.2.10:9004`, polls its queue on the Qt event loop, and routes each received code through the exact A/B QR matcher.
- Operator station-routing buttons remain hidden diagnostic hooks only; the visible input is read-only and the status bar reports online, reconnecting, or rejected scans.
- The UI scanner adapter exposes an idle-safe `connected()` state. Regression verification after the change: `71 passed`; the current network probe from this session did not establish a socket, so field online status still needs confirmation on the target runtime.
