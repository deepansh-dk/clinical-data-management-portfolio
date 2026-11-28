# Query results on the raw data

Output of every query in [checks.sql](./checks.sql), run on `tb_mock_raw.db` (SQLite). Each non-empty result is a query to raise with the site; they match the queries in [project 03's query log](../03-data-cleaning-excel/query_log.xlsx).

### A1. How many records are in each table?

| tbl | n |
|---|---|
| demographics | 100 |
| vitals | 297 |
| microbiology | 100 |
| adverse_events | 31 |
| con_meds | 64 |
| end_of_study | 100 |

6 row(s)

### A2. Distribution of rapid molecular test results

| mborres | n |
|---|---|
| MTB not detected | 66 |
| MTB detected | 33 |
| Invalid / Error | 1 |

3 row(s)

### IC-002: consent = Yes but consent date missing

| subjid | consent | rficdtc |
|---|---|---|
| 01-007 | Yes |  |

1 row(s)

### DM-003: cough = Yes but duration missing

| subjid | cough | coughdur |
|---|---|---|
| 01-044 | Yes |  |

1 row(s)

### VS-002: vital signs collected but every value is missing

| subjid | visit | vsdtc |
|---|---|---|
| 01-093 | Month 2 | 2026-04-11 |

1 row(s)

### VS-003 / VS-004 / VS-007: values outside expected ranges (one query, labelled with CASE)

| subjid | visit | temp | pulse | oxysat | failed_check |
|---|---|---|---|---|---|
| 01-061 | Day 7 | 99.1 | 85 | 98 | VS-003 temperature |
| 01-066 | Screening | 38.2 | 820 | 93 | VS-004 pulse |
| 01-077 | Screening | 37.2 | 73 | 102 | VS-007 SpO2 |

3 row(s)

### VS-006: diastolic BP equal to or higher than systolic (values probably swapped)

| subjid | visit | sysbp | diabp |
|---|---|---|---|
| 01-072 | Screening | 78 | 124 |

1 row(s)

### MB-003: MTB not detected but a rifampicin resistance result is reported

| subjid | mborres | rif |
|---|---|---|
| 01-027 | MTB not detected | Not detected |

1 row(s)

### MB-007: NTM species recorded but organism is not NTM

| subjid | org | ntmspec |
|---|---|---|
| 01-057 | MTB complex | M. kansasii |

1 row(s)

### MB-002: test date before specimen collection date

| subjid | bedtc | mbdtc |
|---|---|---|
| 01-015 | 2026-02-15 | 2026-02-13 |

1 row(s)

### AE-002: adverse event end date before start date

| subjid | aeseq | aeterm | aestdtc | aeendtc |
|---|---|---|---|---|
| 01-078 | 1 | HEADACHE | 2026-05-10 | 2026-05-06 |

1 row(s)

### VS-009: Day 7 visit outside the window (5-9 days after screening)

| subjid | screening_date | day7_date | days_after_screening |
|---|---|---|---|
| 01-088 | 2026-04-21 | 2026-05-05 | 14 |

1 row(s)

### IC-004: specimen collected before informed consent

| subjid | consent_date | collection_date |
|---|---|---|
| 01-012 | 2026-06-21 | 2026-06-18 |

1 row(s)

### VS-001: any visit dated before informed consent

| subjid | visit | vsdtc | rficdtc |
|---|---|---|---|
| 01-055 | Screening | 2026-06-01 | 2026-06-02 |

1 row(s)

### AE-003: adverse event started before informed consent

| subjid | aeterm | aestdtc | rficdtc |
|---|---|---|---|
| 01-079 | VOMITING | 2026-03-31 | 2026-04-10 |

1 row(s)

### IE-002: age at consent under 18 although inclusion IN1 (age >= 18) = Yes

| subjid | brthdtc | rficdtc | age_at_consent |
|---|---|---|---|
| 01-023 | 2010-02-20 | 2026-03-28 | 16 |
| 01-038 | 2026-05-28 | 2026-05-05 | 0 |

2 row(s)

### MB-008: final diagnosis 'Not TB' although lab detected M. tuberculosis

| subjid | finaldx | mborres | org |
|---|---|---|---|
| 01-058 | Not TB | MTB detected | MTB complex |

1 row(s)

### AE-001: AE question = Yes but no rows in the adverse events table

| subjid | aeyn |
|---|---|
| 01-063 | Yes |

1 row(s)

### CM-002: anti-TB treatment started, but no rifampicin-containing drug in con meds

| subjid | attstart |
|---|---|
| 01-092 | Yes |

1 row(s)

### EOS-002: discontinued because of an adverse event, but no AE recorded

| subjid | eosreas |
|---|---|
| 01-099 | Adverse event |

1 row(s)

### Duplicate visits: same subject and visit recorded more than once

| subjid | visit | n_records |
|---|---|---|
| 01-060 | Day 7 | 2 |

1 row(s)

### Code-list check: values outside the allowed list for SEX

| subjid | sex |
|---|---|
| 01-046 | M |

1 row(s)

### Number of AEs per subject, with the worst severity, for subjects with any AE

| subjid | n_aes | worst_severity | n_serious |
|---|---|---|---|
| 01-004 | 2 | 2 | 0 |
| 01-008 | 2 | 2 | 0 |
| 01-011 | 2 | 1 | 0 |
| 01-014 | 2 | 2 | 0 |
| 01-055 | 2 | 1 | 0 |
| 01-059 | 2 | 2 | 0 |
| 01-079 | 2 | 1 | 0 |
| 01-081 | 2 | 1 | 0 |
| 01-098 | 2 | 2 | 0 |
| 01-005 | 1 | 1 | 0 |
| 01-006 | 1 | 2 | 0 |
| 01-017 | 1 | 2 | 0 |
| 01-019 | 1 | 1 | 0 |
| 01-032 | 1 | 2 | 0 |
| 01-036 | 1 | 1 | 0 |
| 01-053 | 1 | 1 | 0 |
| 01-078 | 1 | 2 | 0 |
| 01-084 | 1 | 3 | 1 |
| 01-087 | 1 | 1 | 0 |
| 01-092 | 1 | 1 | 0 |
| 01-093 | 1 | 1 | 0 |
| 01-094 | 1 | 1 | 0 |

22 row(s)
