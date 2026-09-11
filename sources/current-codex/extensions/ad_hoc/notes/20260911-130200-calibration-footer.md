# Calibration footer layout

- The test-page footer now contains exactly four calibration items: calibration due, start validation, NG first piece, and OK second piece. The three non-start items are larger status lamps; start validation is a same-size button.
- The old visible `next_action`/scan prompt was removed from the footer while retaining a hidden compatibility label for non-visual callers. Verification: `71 passed`, compileall passed.
