# 02 · Data Validation Plan (DVP)

**Skill shown:** writing edit checks and clear, non-leading query text.

## Task
Write the Data Validation Plan for the mock TB study: the checks that flag bad data, and the query a site receives when a check fires.

## Planned contents
- `DVP_TB_Mock_Study.xlsx`: 20 edit checks with these columns: Check ID, Form, Field, Check type, Logic, Query text

## Example checks

| Check ID | Form | Logic | Query text |
| --- | --- | --- | --- |
| DM-001 | Demographics | Consent date is missing | Informed consent date is missing. Please provide. |
| VS-003 | Vitals | Visit date is before consent date | Visit date is before the consent date. Please verify. |
| VS-007 | Vitals | Temperature outside 35-42 °C | Temperature is outside the expected range. Please verify. |
| AE-004 | Adverse Events | AE end date is before start date | AE end date is before the start date. Please correct. |

*Status: planned. All data is synthetic.*
