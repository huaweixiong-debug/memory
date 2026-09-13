# Longol MES W07 root freshness guard approved

- Date: 2026-09-13
- ZCode corrected the W07 root createDatabase batch to reject an existing target with THROW 51701. The silent-reuse branch was removed, while no-DROP retention and the history database guard remain in place.
- Sol independently re-ran syntax validation, 19 boundary tests, 38 W07 offline tests, and the unified test entry; all passed. W07 is APPROVED_BY_SOL and WAITING_FOR_HUMAN_REVIEW.
- User has authorized only the next credentialed validation on new retained LongolMES_W07_* databases; no production database, equipment, PLC, or W08 action is approved before its evidence is reviewed.
