# 03 · Data Cleaning in Excel

**Skill shown:** discrepancy management: finding data issues, raising queries, tracking them to closure and producing a clean dataset with a full audit trail.

## Task
A site entered data for 100 synthetic participants of the mock TB study. Using the 36 edit checks from the [Data Validation Plan](../02-data-validation-plan), find every discrepancy, raise a query for each one, record the site's response and produce a clean dataset.

## Files

| File | Contents |
| --- | --- |
| [raw_dataset.xlsx](./raw_dataset.xlsx) | Data as entered by the site (6 sheets: DM, VS, MB, AE, CM, EOS), a data dictionary and a blank query log template. **Try it yourself before opening the answers.** |
| [query_log.xlsx](./query_log.xlsx) | 35 queries: subject, field, DVP check, value found, query text, site response, dates, days open, plus a summary sheet |
| [clean_dataset.xlsx](./clean_dataset.xlsx) | Data after all queries were resolved; used for SDTM mapping in [project 05](../05-sdtm-mapping) |
| [findings_summary.md](./findings_summary.md) | What was found, by form and type, and lessons learned |

## Results at a glance

| Measure | Value |
| --- | --- |
| Participants | 100 |
| Records reviewed | 100 DM · 297 VS · 100 MB · 31 AE · 64 CM · 100 EOS |
| Queries raised | 35 (33 from DVP checks, 2 found by manual review) |
| Queries closed | 35 (average 4.1 days to close) |
| Data corrected | 33 queries |
| Data confirmed as correct | 1 (late Day 7 visit, reported as a protocol deviation) |
| Resolved by another correction | 1 (two checks triggered by the same wrong birth date) |

## Excel techniques used
- **Filters** for blanks and off-list values (missing-data checks, code-list checks)
- **IF / OR / AND** helper columns for range and date-order checks
- **INDEX + MATCH** to bring the consent date from DM into other sheets for cross-form checks
- **COUNTIF / COUNTIFS** for "Yes but no records" checks and duplicate detection
- **MINIFS** to calculate days since the screening visit for visit-window checks

*All data is synthetic training material, not for clinical use.*
