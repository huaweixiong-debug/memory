# W07 receiver integration assertion uses wrong schema column

Date: 2026-09-13
Source: Codex current account, Sol controlled-run diagnosis.

The fresh W07 controlled run confirmed the post-migration EXECUTE grant fixed the prior TVP permission failure. It later failed only in the receiver integration test's persistence-count assertion because it queried `dbo.process_events.core_code`, a nonexistent column. `core_code` resides in `dbo.products`; `process_events` references it through `product_id`.

W07 is FIX_REQUESTED. The bounded ZCode repair is test-only: count HELIUM events by joining `process_events.product_id` to `products.product_id` and filtering `products.core_code`, plus an offline source guard against direct `process_events.core_code`. Do not alter application logic, migrations, permissions, or retained test databases. No secrets are included.
