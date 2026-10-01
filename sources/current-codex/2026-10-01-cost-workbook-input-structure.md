# Cost workbook input structure verification

Source: Codex current account. Date: 2026-10-01.

- Read-only inspection of workbook V9 confirmed dedicated actual BOM quantity/unit-price inputs and actual normal-hours/rework-hours/rate inputs. The corresponding 200-row input ranges are all empty. The instructions distinguish blank as unrecorded from explicit zero as confirmed no cost/hours.
- The workbook remains an initial manual capture template, not evidence of an actual-cost cycle. Of 4,200 formulas, only 10 have cached values; 4,190 remain uncached. No spreadsheet engine was used to save it.
- openpyxl emitted warnings for unsupported workbook/conditional-format extensions, so it was used only for read-only inspection; the original V9 hash was unchanged.
