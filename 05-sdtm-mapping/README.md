# 05 · SDTM Mapping

**Skill shown:** mapping collected CRF data to CDISC SDTM domains.

## Task
Map the cleaned mock study data (from [project 03](../03-data-cleaning-excel)) to two SDTM domains: DM (Demographics) and AE (Adverse Events).

## Planned contents
- `mapping_spec.xlsx`: source field → SDTM variable, with derivation rules
- `DM.csv` and `AE.csv`: mapped output
- `notes.md`: decisions made, e.g. ISO 8601 date conversion and USUBJID derivation

## Key SDTM variables

| Domain | Variables |
| --- | --- |
| DM | STUDYID, DOMAIN, USUBJID, SUBJID, RFICDTC, BRTHDTC, SEX, COUNTRY |
| AE | STUDYID, DOMAIN, USUBJID, AESEQ, AETERM, AEDECOD, AESTDTC, AEENDTC, AESEV, AESER, AEREL |

*Status: planned. All data is synthetic.*
