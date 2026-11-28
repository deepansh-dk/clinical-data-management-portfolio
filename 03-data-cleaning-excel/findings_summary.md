# Findings summary: data cleaning of TB-RMT-MOCK-01

## 1. Queries by form

| Form | Queries | Main issue types |
| --- | --- | --- |
| DM (consent, eligibility, demographics) | 9 | Missing dates, wrong birth year, eligibility inconsistency, off-list value |
| VS (vital signs) | 9 | Out-of-range values (unit error, typos), swapped BP, visit window, duplicate row |
| MB (specimen and results) | 8 | Date order, results inconsistent with each other, missing level/organism |
| EOS (end of study) | 4 | Final diagnosis vs lab results, wrong or missing discontinuation reason |
| AE (adverse events) | 3 | End before start, AE before consent, wrong outcome code |
| CM (concomitant medications) | 2 | Stop before start, anti-TB drug missing from log |
| **Total** | **35** | |

## 2. Queries by type

| Type | Count | Example |
| --- | --- | --- |
| Missing data | 9 | Consent date blank although consent = Yes |
| Cross-form | 7 | Specimen collected before consent date (MB vs DM) |
| Date logic | 7 | Test date before specimen collection date |
| Consistency within a form | 7 | MTB not detected but rifampicin resistance reported |
| Range | 3 | Temperature 99.1 (entered in °F instead of °C) |
| Found outside the DVP | 2 | Duplicate Day 7 record; sex entered as "M" |

## 3. Root causes seen
1. **Transcription typos** (extra digit, transposed digits, wrong year): most common.
2. **Unit errors**: temperature in °F.
3. **Wrong box ticked** on tick-box questions (final diagnosis, outcome code, discontinuation reason).
4. **Pages missed during data entry**: blank vital signs, missing anti-TB medication.
5. **One error, two checks**: a birth year typed as 2026 triggered both DM-002 (birth after consent) and IE-002 (age under 18).

## 4. Lessons learned
- **Cross-form checks need a lookup first.** Most date checks compare against the consent date on another sheet, so INDEX/MATCH comes before any comparison.
- **The DVP does not catch everything.** A duplicate row and an off-list value were found only by scanning filter drop-downs and counting rows per visit. A manual listing review is still needed.
- **Not every query ends in a correction.** A late Day 7 visit was confirmed as true; the data stays as entered and the issue becomes a protocol deviation.
- **Neutral query wording** ("Please verify") lets the site check the source without being led to an answer.

## 5. Suggested DVP updates (version 1.1)
- Add a duplicate-record check (same subject and visit appearing twice).
- Add code-list checks on all tick-box fields (e.g. SEX must be Male or Female).
- Add a check that Month 2 vital signs exist for every participant marked as completed.
