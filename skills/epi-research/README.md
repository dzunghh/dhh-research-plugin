# epi-research

Expert epidemiologist mentor for the full competency spectrum — from formulating research questions to policy translation. Vietnamese health context built in.

---

## Activation

The skill auto-triggers on epidemiology keywords: *cohort study, case-control, survival analysis, confounding, DAG, Mendelian randomization, odds ratio, STROBE, PRISMA, Vietnamese health data*, etc.

To invoke directly:
```
@epi-research [your question]
```

---

## Modes

Specify a mode or let the skill detect from context:

| Mode | Competency | Use for |
|------|-----------|---------|
| `formulate` | Research question | Sharpen RQ with PICO/PICOT, novelty check, counterfactual clarity |
| `design` | Study design | Match design to RQ, sample size, control selection, threat identification |
| `causal` | Causal inference & DAGs | Build DAGs, backdoor criterion, identify mediators/colliders |
| `analysis` | Statistical analysis (R/Stata) | Code templates, assumption checks, publication-ready output |
| `interpret` | Results interpretation | Effect size, CI, Bradford Hill, bias direction |
| `appraise` | Critical appraisal | Systematic validity assessment; TTE studies use the TARGET statement |
| `write` | Scientific communication | Methods/Results/Discussion/Abstract, oral presentation |
| `policy` | Ethics & policy | Ethical considerations, health policy implications, public framing |
| `mr` | Mendelian randomization | IV assumptions, full sensitivity analysis panel |
| `lecturer` | Epidemiology educator | Teach concepts (Teach/Quiz/Evaluate patterns), test knowledge, foundation for all modes |

Activate a mode:
```
mode: causal
Exposure: statin use. Outcome: colorectal cancer.
Draw the DAG and tell me what I need to adjust for.
```

---

## What to Expect

**It will challenge you, not just help you.** Expect one pointed question back when your framing has a gap — e.g., *"Have you drawn the DAG?"*, *"What's the counterfactual?"*, *"What's the most plausible alternative explanation?"* This is intentional — to build your thinking, not replace it.

**Code comes with inline comments**, not a summary at the end.

**Responses are direct and concise.** No preamble. No filler.

---

## Skill Routing

For advanced tasks, the skill delegates to specialized skills rather than doing a worse job in-skill:

| Task | Routed to |
|------|-----------|
| Find sources & summarise (literature review) | **Primary**: `notebooklm` (when sources attached). Fallback: `literature-review` → `pubmed-database` → `perplexity-search` (Haiku, simple queries) |
| Write or revise a full academic paper | `academic-paper` |
| Peer review a manuscript | `academic-paper-reviewer` |
| Deep critical analysis of a paper | `scientific-critical-thinking` |
| Generate / stress-test hypotheses | `hypothesis-generation` |
| Research grant writing | `research-grants` |
| Advanced statistical modelling | `statistical-analysis` |
| EDA and visualization | `exploratory-data-analysis`, `scientific-visualization` |
| Advanced R workflows | `rlang-patterns`, `r-package-development` |

---

## Example Prompts

**Study design:**
```
I'm designing a case-control study on HBV and hepatocellular carcinoma
in Vietnam. What controls should I use and what are my main bias threats?
```

**Causal inference:**
```
mode: causal
Exposure: statin use. Outcome: colorectal cancer.
Draw the DAG and tell me what I need to adjust for.
```

**Statistical analysis:**
```
mode: analysis
Run a Cox regression in R with time-varying statin exposure.
Correct for immortal time bias.
```

**Results interpretation:**
```
mode: interpret
OR 1.8 (95% CI 1.2–2.7) for smoking → lung cancer in Vietnamese women.
Heterogeneity I²=62%. What do I conclude?
```

**Critical appraisal (general):**
```
mode: appraise
[paste abstract or methods section]
What are the critical validity threats in this study?
```

**Critical appraisal (TTE study):**
```
mode: appraise
[paste TTE study methods]
Appraise this using the TARGET statement.
```

**Target trial emulation design:**
```
mode: design
I want to emulate a trial of statin initiation vs no statin
on stroke risk using claims data. Help me specify the target trial.
```

---

## Vietnamese Context

Write in Vietnamese and the skill responds in Vietnamese automatically, applying local context: HBV/HCC burden, three-tier healthcare system, Ministry of Health regulations, Vietnam Cancer Registry, GSO data sources.

---

## Tips

- **Give context**: study design, population, exposure, outcome. The more specific, the sharper the response.
- **Push back** on the probing questions — the dialogue is where the learning happens.
- **Use modes explicitly** when you want focused help; omit them for general questions.
- **Don't ask it to write your paper** — use `academic-paper` for that. Use this skill to think through methods and framing first.

---

## File Structure

```
epi-research/
├── SKILL.md                          # Core skill definition
├── README.md                         # This file
├── evals/
│   └── evals.json                    # Evaluation test cases
└── references/
    ├── study-designs.md              # Detailed design guidance, DAG examples, GRADE, sample size
    ├── statistical-methods.md        # Full R/Stata code templates
    ├── writing-guidelines.md         # STROBE/PRISMA structure, null findings framework
    └── vietnamese-context.md         # Vietnamese healthcare context and terminology
```

---

## Packaged Skill

The compiled skill file is at `D:\AI\epi-research.skill` — this is what gets loaded by Claude Code.
