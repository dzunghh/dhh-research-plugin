---
name: critical-appraisal
description: Use when appraising the quality or risk of bias of a published study or a set of papers – in a literature review, journal club, evidence table, or "is this paper any good?" – with JBI, AXIS, AMSTAR 2 or PRESS, or when checking reporting against STROBE, CONSORT, PRISMA-ScR or TRIPOD. Not for risk of bias inside a formal systematic review (use srma).
---

# Critical Appraisal

One design-matched tool per paper. Every judgement carries a quote. The appraisal ends in the main bias and its direction, not in a score.

## Steps

1. **Identify the design from the Methods**, not from the title or the authors' label (a "cohort" analysed at one time point is cross-sectional; a nested case-control is a case-control).
2. **Pick the tool** from the table and load only that reference file – in `jbi.md`, only the section for the design.
3. **Judge each item** Yes / No / Unclear / NA with an evidence line. Nothing reported → **Unclear – "not reported"**. Never infer Yes from silence.
4. **Summarise**: main threat, its likely direction, and how the paper should be used.

Only the abstract available? Say so on the first line and mark every item that needs the full text as Unclear.

## Tool selection

| Design | Tool | Reference |
|---|---|---|
| Cohort, case-control, analytical cross-sectional, prevalence, case series, case report, quasi-experimental, RCT, diagnostic accuracy, economic evaluation, qualitative, text and opinion | JBI checklist for that design | `references/jbi.md` |
| Cross-sectional, only when the user or the review protocol names AXIS (otherwise: prevalence survey → JBI prevalence; association at one time point → JBI analytical cross-sectional) | AXIS | `references/axis.md` |
| Systematic review of interventions (RCTs, non-randomised studies or both) | AMSTAR 2 | `references/amstar2.md` |
| Other reviews (prevalence, diagnostic accuracy, qualitative, scoping) | JBI systematic review checklist | `references/jbi.md` |
| A search strategy | PRESS | `references/reporting-checklists.md` |
| Completeness of reporting only | STROBE, CONSORT, PRISMA-ScR, TRIPOD | `references/reporting-checklists.md` |

**Reporting is not quality.** STROBE, CONSORT, PRISMA-ScR and TRIPOD say whether a study was described fully, not whether it was done well. Use them only when asked about reporting, and label the output "reporting completeness".

**Boundary.** RoB 2, ROBINS-I, ROBINS-E, Newcastle–Ottawa, GRADE, and any appraisal that feeds a pooled estimate belong to the `srma` skill. Target trial emulations, Mendelian randomisation and prediction-model studies have no tool here: return to `epi-research` (TARGET statement, STROBE-MR; PROBAST is not bundled). Unpublished manuscripts and protocols go to `academic-paper-reviewer`. For a deeper look at one causal threat (confounding structure, time zero, positivity), use the `epi-research` skill (its causal-identification reference).

## Output – one paper

```
**Author Year** – design – tool (n items)

| # | Item | Judgement | Evidence |
|---|------|-----------|----------|
| 4 | Confounders identified | Yes | "adjusted for age, parity and smoking" (Methods, Statistical analysis) |
| 9 | Follow-up complete | Unclear | not reported |

**Failed or unclear:** items 5, 9
**Main threat:** <bias> → likely direction (towards / away from the null / unpredictable) → would it change the conclusion?
**Use in the review:** include | include with caveat | exclude – one sentence why
```

The table plus at most five lines. No introduction, no recap.

## Output – a set of papers

One row per paper; give full item tables only when asked.

| Study | Design | Tool | Yes / applicable | Failed or unclear items | Main bias and direction | Weight in synthesis |
|---|---|---|---|---|---|---|

## Rules

- **No quality score as a verdict.** Report "Yes / applicable" as a count and name the failed items. Apply a cut-off only when the user set one before appraisal. AMSTAR 2 has its own rating rule – use it.
- **Quote, then judge.** The evidence cell holds a verbatim phrase and its location. A judgement with no quote is Unclear.
- **Adequate, not mentioned.** An item is Yes only if what was done is adequate for the paper's main claim. A key confounder named but never measured fails the "strategies" item; follow-up that is long on average but sparse where the headline claim sits fails the follow-up item.
- **Missing pieces.** If figures or supplements were not retrieved, mark the items that depend on them Unclear and say what was not seen.
- **Direction over labels.** "Risk of selection bias" is incomplete; say which way it pushes the estimate and why.
- **Same tool for the same design** across a review, so rows are comparable.

## Common mistakes

| Mistake | Fix |
|---|---|
| Using STROBE to call a study "high quality" | STROBE is reporting; use JBI or AXIS |
| Trusting the authors' design label | Re-derive the design from sampling and timing |
| "Yes" because the paper is in a good journal | Yes needs a quote |
| Appraising a systematic review with a primary-study tool | AMSTAR 2 |
| Summing AMSTAR 2 items into a score | Rate by critical domains |
