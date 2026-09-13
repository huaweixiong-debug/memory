# Longol MES W07 Sol review approval pending human gate

- Date: 2026-09-13
- The ZCode rework corrected the W07 history proof runtime blocker: createHistoryDatabase now derives the application login from config.mesSql.user and no longer reads env.W07_APP_USER, which is intentionally absent from the proof environment.
- The regression boundary test verifies the alias is absent and config.mesSql.user is used. Sol independently re-ran syntax validation, 18 boundary tests, 37 W07 offline tests, and the unified npm test entry; all passed.
- W07 is now WAITING_FOR_HUMAN_REVIEW. The next gated action needs explicit user confirmation and hidden credentials to run the disposable, retained LongolMES_W07_* credentialed harness. No production database, device, or W08 action is approved.
