# 04 · SQL Data Review

**Skill shown:** using SQL to find data issues across clinical trial tables.

## Task
Load the mock study data into SQLite as separate tables (demographics, vitals, adverse_events, con_meds) and write SQL queries that find each type of discrepancy.

## Planned contents
- `data/`: CSV files for each table (synthetic)
- `checks.sql`: one query per data check, each with a comment explaining it
- `results/`: screenshots of query output

## Example query

```sql
-- Visits recorded before the subject's consent date
SELECT v.subject_id, v.visit_date, d.consent_date
FROM vitals v
JOIN demographics d ON v.subject_id = d.subject_id
WHERE v.visit_date < d.consent_date;
```

*Status: planned. All data is synthetic.*
