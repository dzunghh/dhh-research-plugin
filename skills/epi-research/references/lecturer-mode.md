# Lecturer mode and probing questions

Load for `mode: lecturer`, for "explain / teach / quiz me", or when choosing a probe.

## Interaction patterns

| Pattern | Trigger | Format |
|---------|---------|--------|
| **Teach** | "explain X", "what is X", "how does X work" | Concept → Example → Key misconception → *Check question* |
| **Quiz** | "test me on X", "quiz me", "give me questions on X" | 1 question (MCQ or case-based); wait for the answer before revealing the correct response |
| **Evaluate** | User answers a question | What was right → gap identified → corrected explanation → next concept |

**Check question**: end every Teach response with one question to confirm understanding, e.g.:
> *Quick check: A researcher adjusts for hospitalisation status in a study of ICU admission. What type of bias does this introduce?*

**Foundation role**: any mode that introduces a concept the user may not know switches to Teach format – concept → example → misconception – before continuing the task.

## Core topic ladder

| Level | Topics |
|-------|--------|
| 1 – Foundations | Measures of occurrence (incidence, prevalence, rates); measures of association (RR, OR, HR, RD, NNT) |
| 2 – Designs | Study design trade-offs; selection and information bias taxonomy; confounding |
| 3 – Causal inference | DAGs; backdoor criterion; collider/mediator/confounder; effect modification vs interaction |
| 4 – Analysis | Survival analysis concepts; competing risks; multiple imputation; propensity score logic; p-values, intervals, bootstrap, Bayes and likelihood ratios (`statistical-reasoning.md`) |
| 5 – Advanced | Meta-analysis and GRADE; Mendelian randomisation; target trial emulation; g-methods (IPW, g-formula, g-estimation); front-door and do-calculus; mediation (CDE vs natural effects) |

**Misconception banks** for Teach/Quiz: `g-methods-point-treatment.md`, `time-varying-g-methods.md`, `causal-graphs-pearl.md` and `statistical-reasoning.md` each end with a numbered misconceptions list – draw quiz items from there.

## Probing questions

Use **one** focused probe when the user's framing has a gap – never more than one.

**Formulating**: "What gap in current evidence would this fill?" · "Is this etiologic or prognostic?" · "What's the exact counterfactual?"

**Design**: "How are you handling time-varying exposure?" · "What's your source population?" · "What controls for [specific confounder]?"

**Causal**: "Have you drawn the DAG? What are the open backdoor paths?" · "Could [X] be a collider?" · "Is [M] a mediator you'd be blocking by adjusting?" · "Does any confounder also respond to earlier treatment?" (→ g-methods) · "If the confounder is unmeasured, is there a shielded mediator (front door) or an instrument?"

**Interpretation**: "What's the most plausible alternative explanation?" · "Does the CI width matter clinically?" · "Does this satisfy Bradford Hill temporality?" · "What is the absolute risk, not just the relative risk?" · "Could this be regression to the mean?"

**Appraisal**: "What's the biggest internal validity threat?" · "Could the null result be due to exposure misclassification?" · "Is this population representative of your target?"
