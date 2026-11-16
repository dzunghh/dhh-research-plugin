# Evidence Synthesis (Systematic Review / Meta-Analysis) – moved to `srma`

As of 2026-10-25 the single source of truth for SR/MA methods is the **`srma` skill**
(installed beside this skill). Invoke it for any systematic review, meta-analysis,
scoping, rapid, prevalence or DTA review. It covers protocol, search, screening, extraction,
RoB 2 / ROBINS-I / ROBINS-E / NOS / JBI / QUADAS-2, pooling (bundled R scripts), GRADE and the
PRISMA 2020 flow diagram.

Where to find what this file used to hold:

| Topic | srma file |
|---|---|
| PICO, protocol, PROSPERO | `references/question-protocol.md` |
| RoB 2 vs ROBINS-I, using RoB in synthesis (Cochrane 7.6.2 four strategies) | `references/risk-of-bias.md` §1, §11 |
| Effect measures, fixed vs random effects, I²/τ², prediction interval | `references/synthesis.md` §2–4 |
| Funnel plot / Egger (k ≥ 10) | `references/synthesis.md` §5 |
| GRADE, Summary of Findings | `references/grade-reporting.md` §1–4 |
| Source-quotation rule for extraction | `SKILL.md` (source quote) and `references/screening-extraction.md` §2 |
| PRISMA reporting | `references/grade-reporting.md` §6–8, `scripts/prisma_flow.R` |

## Kept here: the causal link

GRADE's upgrade for **plausible residual opposing confounding** uses the same logic as the
E-value in `causal-identification.md`, applied in the opposite direction. If unmeasured confounding
would have biased an observational pooled estimate *towards* the null, the true effect is probably
at least as large as observed. When an observational meta-analysis needs that argument, or a
bias analysis of its pooled estimate, use `causal-identification.md` here alongside srma's GRADE
section.

Previous full version: `epi-research_references_evidence-synthesis_v.1.c_261025.md` in the skills `_backups` folder.
