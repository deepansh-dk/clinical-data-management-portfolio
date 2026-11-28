-- =====================================================================
-- Project 04 · SQL data review · TB-RMT-MOCK-01 (synthetic data)
-- Database: tb_mock_raw.db (SQLite) · tables built from data/*.csv
-- Each query implements one check from the Data Validation Plan (project 02)
-- and returns the records that FAIL the check (= queries to raise).
-- Dates are stored as ISO 8601 text (YYYY-MM-DD), so they compare correctly.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART A · Getting to know the data
-- ---------------------------------------------------------------------

-- A1. How many records are in each table?
SELECT 'demographics' AS tbl, COUNT(*) AS n FROM demographics
UNION ALL SELECT 'vitals', COUNT(*) FROM vitals
UNION ALL SELECT 'microbiology', COUNT(*) FROM microbiology
UNION ALL SELECT 'adverse_events', COUNT(*) FROM adverse_events
UNION ALL SELECT 'con_meds', COUNT(*) FROM con_meds
UNION ALL SELECT 'end_of_study', COUNT(*) FROM end_of_study;

-- A2. Distribution of rapid molecular test results
SELECT mborres, COUNT(*) AS n
FROM microbiology
GROUP BY mborres
ORDER BY n DESC;


-- ---------------------------------------------------------------------
-- PART B · Missing data checks
-- ---------------------------------------------------------------------

-- IC-002: consent = Yes but consent date missing
SELECT subjid, consent, rficdtc
FROM demographics
WHERE consent = 'Yes' AND rficdtc IS NULL;

-- DM-003: cough = Yes but duration missing
SELECT subjid, cough, coughdur
FROM demographics
WHERE cough = 'Yes' AND coughdur IS NULL;

-- VS-002: vital signs collected but every value is missing
SELECT subjid, visit, vsdtc
FROM vitals
WHERE vsperf = 'Yes'
  AND weight IS NULL AND temp IS NULL AND pulse IS NULL AND resp IS NULL
  AND sysbp IS NULL AND diabp IS NULL AND oxysat IS NULL;


-- ---------------------------------------------------------------------
-- PART C · Range and consistency checks
-- ---------------------------------------------------------------------

-- VS-003 / VS-004 / VS-007: values outside expected ranges (one query, labelled with CASE)
SELECT subjid, visit, temp, pulse, oxysat,
       CASE
         WHEN temp   NOT BETWEEN 35 AND 42   THEN 'VS-003 temperature'
         WHEN pulse  NOT BETWEEN 40 AND 180  THEN 'VS-004 pulse'
         WHEN oxysat NOT BETWEEN 70 AND 100  THEN 'VS-007 SpO2'
       END AS failed_check
FROM vitals
WHERE temp NOT BETWEEN 35 AND 42
   OR pulse NOT BETWEEN 40 AND 180
   OR oxysat NOT BETWEEN 70 AND 100;

-- VS-006: diastolic BP equal to or higher than systolic (values probably swapped)
SELECT subjid, visit, sysbp, diabp
FROM vitals
WHERE diabp >= sysbp;

-- MB-003: MTB not detected but a rifampicin resistance result is reported
SELECT subjid, mborres, rif
FROM microbiology
WHERE mborres = 'MTB not detected' AND rif IN ('Detected', 'Not detected');

-- MB-007: NTM species recorded but organism is not NTM
SELECT subjid, org, ntmspec
FROM microbiology
WHERE ntmspec IS NOT NULL AND (org IS NULL OR org <> 'NTM');


-- ---------------------------------------------------------------------
-- PART D · Date checks
-- ---------------------------------------------------------------------

-- MB-002: test date before specimen collection date
SELECT subjid, bedtc, mbdtc
FROM microbiology
WHERE mbdtc < bedtc;

-- AE-002: adverse event end date before start date
SELECT subjid, aeseq, aeterm, aestdtc, aeendtc
FROM adverse_events
WHERE aeendtc < aestdtc;

-- VS-009: Day 7 visit outside the window (5-9 days after screening)
--         self-join: the vitals table is joined to itself to compare two visits
SELECT d7.subjid,
       scr.vsdtc AS screening_date,
       d7.vsdtc  AS day7_date,
       CAST(julianday(d7.vsdtc) - julianday(scr.vsdtc) AS INTEGER) AS days_after_screening
FROM vitals AS d7
JOIN vitals AS scr ON scr.subjid = d7.subjid AND scr.visit = 'Screening'
WHERE d7.visit = 'Day 7'
  AND julianday(d7.vsdtc) - julianday(scr.vsdtc) NOT BETWEEN 5 AND 9;


-- ---------------------------------------------------------------------
-- PART E · Cross-table checks (JOINs)
-- ---------------------------------------------------------------------

-- IC-004: specimen collected before informed consent
SELECT m.subjid, d.rficdtc AS consent_date, m.bedtc AS collection_date
FROM microbiology AS m
JOIN demographics AS d ON d.subjid = m.subjid
WHERE m.bedtc < d.rficdtc;

-- VS-001: any visit dated before informed consent
SELECT v.subjid, v.visit, v.vsdtc, d.rficdtc
FROM vitals AS v
JOIN demographics AS d ON d.subjid = v.subjid
WHERE v.vsdtc < d.rficdtc;

-- AE-003: adverse event started before informed consent
SELECT a.subjid, a.aeterm, a.aestdtc, d.rficdtc
FROM adverse_events AS a
JOIN demographics AS d ON d.subjid = a.subjid
WHERE a.aestdtc < d.rficdtc;

-- IE-002: age at consent under 18 although inclusion IN1 (age >= 18) = Yes
SELECT subjid, brthdtc, rficdtc,
       CAST((julianday(rficdtc) - julianday(brthdtc)) / 365.25 AS INTEGER) AS age_at_consent
FROM demographics
WHERE in1 = 'Yes'
  AND (julianday(rficdtc) - julianday(brthdtc)) / 365.25 < 18;

-- MB-008: final diagnosis 'Not TB' although lab detected M. tuberculosis
SELECT e.subjid, e.finaldx, m.mborres, m.org
FROM end_of_study AS e
JOIN microbiology AS m ON m.subjid = e.subjid
WHERE e.finaldx = 'Not TB'
  AND (m.mborres = 'MTB detected' OR m.org = 'MTB complex');


-- ---------------------------------------------------------------------
-- PART F · "Yes, but no records" checks (LEFT JOIN / NOT EXISTS)
-- ---------------------------------------------------------------------

-- AE-001: AE question = Yes but no rows in the adverse events table
SELECT e.subjid, e.aeyn
FROM end_of_study AS e
LEFT JOIN adverse_events AS a ON a.subjid = e.subjid
WHERE e.aeyn = 'Yes' AND a.subjid IS NULL;

-- CM-002: anti-TB treatment started, but no rifampicin-containing drug in con meds
SELECT e.subjid, e.attstart
FROM end_of_study AS e
WHERE e.attstart = 'Yes'
  AND NOT EXISTS (SELECT 1 FROM con_meds AS c
                  WHERE c.subjid = e.subjid AND c.cmtrt LIKE '%RIFAMPICIN%');

-- EOS-002: discontinued because of an adverse event, but no AE recorded
SELECT e.subjid, e.eosreas
FROM end_of_study AS e
WHERE e.eosreas = 'Adverse event'
  AND NOT EXISTS (SELECT 1 FROM adverse_events AS a WHERE a.subjid = e.subjid);


-- ---------------------------------------------------------------------
-- PART G · Checks the DVP does not cover
-- ---------------------------------------------------------------------

-- Duplicate visits: same subject and visit recorded more than once
SELECT subjid, visit, COUNT(*) AS n_records
FROM vitals
GROUP BY subjid, visit
HAVING COUNT(*) > 1;

-- Code-list check: values outside the allowed list for SEX
SELECT subjid, sex
FROM demographics
WHERE sex NOT IN ('Male', 'Female');


-- ---------------------------------------------------------------------
-- PART H · Summary listing for the data manager
-- ---------------------------------------------------------------------

-- Number of AEs per subject, with the worst severity, for subjects with any AE
SELECT subjid, COUNT(*) AS n_aes, MAX(aesev) AS worst_severity,
       SUM(CASE WHEN aeser = 'Y' THEN 1 ELSE 0 END) AS n_serious
FROM adverse_events
GROUP BY subjid
ORDER BY n_aes DESC, subjid;
