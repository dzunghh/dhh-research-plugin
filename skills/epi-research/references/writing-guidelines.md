# Academic Writing Guidelines for Epidemiology

## Writing Order

Write sections in this order (submit in IMRAD order):
**Results → Methods → Discussion → Introduction → Abstract**

---

## STROBE Methods Section (Observational Studies)

Required subsections:
1. Study design and setting (dates, location, rationale)
2. Participants (eligibility criteria, sources, matching if any)
3. Variables (exposure definition, outcome ascertainment, covariate measurement)
4. Bias (a priori discussion of likely biases and how addressed)
5. Study size (how determined — show sample size calculation)
6. Statistical methods (software, missing data approach, sensitivity analyses)

---

## PRISMA Methods Section (Systematic Reviews)

Required elements:
- Protocol and PROSPERO registration number
- Eligibility criteria (PICO, study designs, dates, languages)
- Search strategy — full strategy for ≥1 database in appendix
- Selection process (2 independent reviewers, disagreement resolution)
- Data extraction form and items
- Risk of bias tool (RoB 2.0 / ROBINS-I / NOS / QUADAS-2)
- Statistical synthesis (pooling method, heterogeneity, publication bias if ≥10 studies)
- GRADE assessment for each outcome

---

## Results Section

Pure reporting — no interpretation, no hedging.

- Lead with participant flow: "Of 5,240 eligible participants, 4,891 met inclusion criteria..."
- Table 1: characteristics by exposure group
- Report all prespecified analyses — do not selectively omit null results
- Use: "Among X participants, Y (Z%) developed [outcome] over N person-years (incidence: X per 1,000 PY)"
- Report effect + CI: not just p-values

---

## Discussion Structure

### Positive / Expected Finding
1. **Key finding** (1 sentence with point estimate)
2. **Prior evidence** (1–2 paragraphs): how this fits or conflicts
3. **Biological plausibility** (1 paragraph): mechanism, cautious language
4. **Alternative explanations** (1–2 paragraphs): confounding, bias — name each, assess direction
5. **Strengths** (brief, 3–4 points)
6. **Limitations** (1–2 paragraphs): specific, directional — "this bias would likely attenuate/inflate estimates"
7. **Implications** (1 paragraph): measured, not oversold
8. **Conclusion** (2–3 sentences): summarize without overstating

### Null / Unexpected Finding
Add between 2 and 4:
- **Power and precision**: Can CIs rule out a clinically meaningful effect? Minimum detectable effect?
- **Methodological explanations**: measurement error (attenuates toward null), confounding by indication, wrong exposure window, insufficient follow-up

Opening for null finding:
> "Coffee consumption showed no association with liver cancer in our cohort (HR=0.95, 95% CI: 0.75–1.21). While this conflicts with prior meta-analyses suggesting a 30% risk reduction, the wide CI is compatible with effects ranging from a 25% reduction to a 21% increase — either coffee has no effect, or our study lacked precision to detect a modest association."

---

## Writing Style Principles

**Quantify — never be vague:**
- ❌ "robust findings" → ✓ "consistent across all 5 sensitivity analyses"
- ❌ "significant impact" → ✓ "18% reduction in risk"
- ❌ "further research is needed" → ✓ "a community-based cohort in rural Vietnam could address this"

**Hedge proportionally:**
| Evidence level | Language |
|---------------|----------|
| Uncertain | "may suggest", "could indicate", "is consistent with" |
| Plausible | "suggest", "indicate", "appear to be associated" |
| Well-supported | "demonstrate", "provide evidence that" |

Never use "proves" or "confirms" for observational data.

**PEEL paragraph structure:**
- **P**oint: topic sentence stating the key idea
- **E**vidence: data, statistic, citation
- **E**xplanation: why this matters, mechanism
- **L**ink: connection to next point or implication

**Limitations: be specific and directional:**
> ❌ "Residual confounding may exist."
> ✓ "Residual confounding from unmeasured physical activity is possible — given that active individuals tend to have both lower BMI and lower cancer risk, this would likely attenuate our estimates toward the null."

---

## Common Mistakes

- Claiming causation from observational data without caveats
- Reporting p-values without effect sizes and CIs
- Vague limitations ("residual confounding may have occurred")
- Ending Discussion with "more research is needed" without specifying what kind
- Adjusting for mediators or colliders (DAG first!)
- OR ≈ RR when outcome prevalence >10% (mathematically incorrect)
- Starting every sentence with "The" or "There is/are"

---

## Submission Checklist

- [ ] STROBE/PRISMA/CONSORT checklist completed and attached
- [ ] All estimates reported as point estimate + 95% CI
- [ ] DAG in supplementary (if using structural causal approach)
- [ ] Missing data approach stated
- [ ] All prespecified sensitivity analyses reported
- [ ] Ethics approval and consent statement
- [ ] Data availability statement
- [ ] Conflict of interest statement
