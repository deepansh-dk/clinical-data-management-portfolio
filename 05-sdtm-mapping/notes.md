# Mapping notes and decisions

1. **Reference start date (RFSTDTC).** This is a diagnostic study with no study drug, so "first exposure" does not exist. RFSTDTC is set to the date of the first study procedure, the screening specimen collection (Form 04 BEDTC). Study days are calculated from this date.

2. **Arm variables.** All participants receive the same index test, so ARMCD = RMT and ARM = Rapid Molecular Test. ACTARMCD/ACTARM equal the planned arm because every enrolled participant was tested.

3. **AEACN vs AEACNOTH.** AEACN describes action taken with *study treatment*. There is none here, so AEACN = "NOT APPLICABLE". The action collected on the CRF (medication given, hospitalisation, etc.) goes to AEACNOTH.

4. **AEREL.** The CRF asks about relationship to a *study procedure* (e.g. sputum induction), not a drug. Y/N is mapped to RELATED / NOT RELATED.

5. **Ongoing events.** When an AE is ongoing at end of study, AEENDTC stays empty, AEENRTPT = "ONGOING" and AEENTPT = "END OF STUDY".

6. **Removed AE.** One event (subject 01-079, vomiting) started before informed consent. After query resolution in project 03 it was moved to medical history, so it does not appear in AE. AE has 30 records, compared with 31 in the raw data.

7. **Coding.** Verbatim terms were coded to a MedDRA Preferred Term and primary System Organ Class for illustration. In a real study this is done with the licensed MedDRA dictionary by a medical coder, and the MedDRA version is documented.

8. **Not mapped.** RACE and ETHNIC (expected in DM) were not collected on this CRF, so they are not included. A real study would either collect them or document the omission in the Reviewer's Guide.

9. **Next steps (not done here).** Other domains (VS, MB, MH, CM, DS, IE), SUPPQUAL for non-standard variables, a define.xml and a Pinnacle 21 validation run.
