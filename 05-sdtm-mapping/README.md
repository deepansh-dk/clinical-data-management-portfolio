# 05 · SDTM Mapping

**Skill shown:** turning collected CRF data into CDISC SDTM datasets: writing a mapping specification, applying controlled terminology, converting dates to ISO 8601 and deriving variables such as USUBJID, AGE, AESEQ and study day.

## Task
Map the clean data from [project 03](../03-data-cleaning-excel) to two SDTM domains: **DM** (Demographics) and **AE** (Adverse Events).

## Files

| File | Contents |
| --- | --- |
| [mapping_spec.xlsx](./mapping_spec.xlsx) | Mapping specification: for every SDTM variable, its label, type, core status, CRF source and derivation rule |
| [DM.csv](./DM.csv) | Demographics domain: 100 records, 18 variables, one row per participant |
| [AE.csv](./AE.csv) | Adverse Events domain: 30 records, 19 variables, one row per event |
| [notes.md](./notes.md) | Mapping decisions and the reasons for them |

## From CRF to SDTM: an example

| CRF (Form 05) | SDTM AE |
| --- | --- |
| Subject 01-004, "ARTHRALGIA" | USUBJID = TB-RMT-MOCK-01-01-004, AETERM = ARTHRALGIA |
| (coded) | AEDECOD = Arthralgia, AEBODSYS = Musculoskeletal and connective tissue disorders |
| Severity = 1 | AESEV = MILD |
| Start 23-FEB-2026 | AESTDTC = 2026-02-23, AESTDY = 47 |
| Outcome = 1 | AEOUT = RECOVERED/RESOLVED |

## Key derivations
- **USUBJID** = STUDYID + "-" + SUBJID, unique across all studies
- **AGE** = completed years between date of birth and date of informed consent
- **RFSTDTC** = date of the first study procedure (screening specimen collection)
- **AESTDY / AEENDY** = date − RFSTDTC + 1 on or after the reference date (SDTM has no day 0)
- **AESEQ** = running number of events within each subject, ordered by start date

## Quality checks done
- Every USUBJID in AE exists in DM
- No AGE under 18 (consistent with inclusion criterion IN1)
- No study day equal to 0; all dates in ISO 8601 format

*All data is synthetic. MedDRA coding is illustrative only (no MedDRA licence used).*
