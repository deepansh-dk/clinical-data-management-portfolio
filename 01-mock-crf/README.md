# 01 · Mock CRF

**Skill shown:** Case Report Form (CRF) design and CRF completion guidelines.

## Task
Design the paper CRF for the mock TB diagnostic study (protocol TB-RMT-MOCK-01) so that sites collect clean, consistent data that maps easily to CDISC standards.

## Files

| File | Contents |
| --- | --- |
| [CRF_TB_Mock_Study_v1.0.pdf](./CRF_TB_Mock_Study_v1.0.pdf) | 8-page CRF: study overview and schedule of assessments, plus Forms 01–08 |
| [CRF_Completion_Guidelines_v1.0.pdf](./CRF_Completion_Guidelines_v1.0.pdf) | 2-page guide for site staff: general rules, date/number formats, missing-data codes, corrections, form-specific instructions, query handling |

## Forms in the CRF

| Form | Name | Visits |
| --- | --- | --- |
| 01 | Informed Consent & Eligibility | Screening |
| 02 | Demographics & Medical History | Screening |
| 03 | Vital Signs | Screening, Day 7, Month 2 |
| 04 | Specimen Collection & Test Results (rapid molecular test, smear, MGIT culture, NTM identification) | Screening, Day 7 |
| 05 | Adverse Events Log | Any time |
| 06 | Concomitant Medications Log | Any time |
| 07 | End of Study | Month 2 |
| 08 | Investigator Sign-off | Month 2 |

## Design principles followed
- Coded answers (tick boxes, code lists) instead of free text wherever possible
- One date format (DD/MMM/YYYY) and units printed beside every numeric field
- CDISC CDASH variable names shown under each field label (e.g. RFICDTC, AETERM, VSORRES), ready for SDTM mapping in [project 05](../05-sdtm-mapping)
- Expected ranges printed on the vital signs form; these become the edit checks in [project 02](../02-data-validation-plan)
- Subject identifiers (site, subject number, initials) on every page

*All content is synthetic training material, not for clinical use.*
