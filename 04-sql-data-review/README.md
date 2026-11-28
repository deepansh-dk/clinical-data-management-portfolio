# 04 · SQL Data Review

**Skill shown:** using SQL to find data issues across clinical trial tables: filters, ranges, date logic, JOINs between tables, self-joins, LEFT JOIN / NOT EXISTS, GROUP BY / HAVING.

## Task
Load the raw data from [project 03](../03-data-cleaning-excel) into a SQLite database and write one SQL query per Data Validation Plan check, so the review can be repeated automatically every time new data arrives.

## Files

| File | Contents |
| --- | --- |
| [checks.sql](./checks.sql) | 23 queries in 8 parts: data overview, missing, range/consistency, dates, cross-table JOINs, "Yes but no records", checks outside the DVP, AE summary |
| [results.md](./results.md) | Output of every query on the raw data |
| [tb_mock_raw.db](./tb_mock_raw.db) | SQLite database with 6 tables (open it in DB Browser for SQLite) |
| [data/](./data) | The same 6 tables as CSV files |

## Tables

| Table | Rows | One row per |
| --- | --- | --- |
| demographics | 100 | participant |
| vitals | 297 | participant per visit |
| microbiology | 100 | participant (screening specimen) |
| adverse_events | 31 | adverse event |
| con_meds | 64 | medication |
| end_of_study | 100 | participant |

## Example: a cross-table check

```sql
-- IC-004: specimen collected before informed consent
SELECT m.subjid, d.rficdtc AS consent_date, m.bedtc AS collection_date
FROM microbiology AS m
JOIN demographics AS d ON d.subjid = m.subjid
WHERE m.bedtc < d.rficdtc;
```

## How to run it yourself
1. Install **DB Browser for SQLite** (free).
2. Open `tb_mock_raw.db`, or create a new database and use File → Import → Table from CSV file for each file in `data/`.
3. Go to the **Execute SQL** tab, paste a query from `checks.sql` and press **F5**.

## Result
The SQL checks cover 20 of the 36 DVP checks plus 2 checks outside the DVP, and they flag exactly the same records as the matching Excel checks in project 03, which confirms both methods. The remaining DVP checks follow the same patterns and are left as practice. SQL has one advantage: the checks can be saved and re-run on every new data transfer in seconds.

*All data is synthetic training material, not for clinical use.*
