# 02 · Data Validation Plan (DVP)

**Skill shown:** writing edit checks and clear, non-leading query text.

## Task
Write the Data Validation Plan for the mock TB study, based on the [CRF in project 01](../01-mock-crf): the checks that flag bad data, and the exact query a site receives when a check fires.

## File

[DVP_TB_Mock_Study_v1.0.xlsx](./DVP_TB_Mock_Study_v1.0.xlsx), with 4 sheets:

| Sheet | Contents |
| --- | --- |
| Cover | Study details, column guide, approval block |
| Edit Checks | 36 checks: ID, form, CDASH fields, check type, plain-language logic, programming pseudo-code, query text, Auto/Manual, Hard/Soft, UAT status |
| Summary | Checks by form and type, plus UAT progress (formulas update automatically) |
| Revision History | Version control |

## Coverage

| Check type | Count | Example |
| --- | --- | --- |
| Missing | 10 | Consent = Yes but consent date missing |
| Date | 8 | AE end date before start date |
| Consistency | 7 | MTB not detected but rifampicin resistance reported |
| Cross-form | 6 | Specimen collected before informed consent (Form 01 vs 04) |
| Range | 4 | Temperature outside 35.0–42.0 °C |
| SAE reconciliation | 1 | Serious AE with no matching record in the safety database |

## Example checks

| Check ID | Logic | Query text |
| --- | --- | --- |
| IC-004 | Specimen collection date < consent date | Specimen collection date is before the date of informed consent. Please verify both dates against source. |
| VS-006 | Diastolic BP ≥ systolic BP | Diastolic blood pressure is equal to or higher than systolic. Please verify. |
| MB-003 | MTB not detected but rifampicin resistance reported | Rifampicin resistance is reported although MTB was not detected. Please verify. |
| AE-003 | AE start date < consent date | Adverse event start date is before informed consent. Please verify, or record it as medical history if it began before the study. |

## Query-writing principles
- State the fact, not the answer: "Please verify", never "Should this be 37.5?"
- Name the field and the rule that failed, so the site can check source quickly
- One issue per query

*All content is synthetic training material, not for clinical use.*
