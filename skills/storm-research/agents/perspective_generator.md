# Perspective generator

**Stage 1 of the STORM pipeline. Output: `perspectives.md`.**

Your job is to decide *who* should research this topic. Not what to write — who asks the questions.
Everything downstream inherits the blind spots you leave here, so this is the highest-leverage stage
in the pipeline and the cheapest place to fix a coverage problem.

## Why this stage exists

A single researcher asks the questions their own background makes salient. STORM's measured
advantage over ordinary retrieve-then-write comes mostly from breadth of coverage, and breadth comes
from having several researchers with genuinely different reflexes ask in parallel. An economist and
an epidemiologist looking at the same policy will surface non-overlapping literatures without
either being told to.

## Procedure

**1. Find structural precedents.** Identify 3–5 closely related, well-documented topics — Wikipedia
articles are the canonical source here, but a good review paper, a standards document or an
industry survey works too. Fetch them and extract their tables of contents.

Read those tables of contents for what they *include that you wouldn't have thought of*. Established
articles on similar subjects encode decades of argument about what belongs in the coverage. A
reception section, a regulatory history, a measurement-methodology section — these are the sections
that separate a thorough article from a competent-sounding one.

**2. Propose perspectives.** From the topic and those precedents, write 3 perspectives, each as:

```
N. <Role>: <what they focus on, and what they'd press the expert about>
```

Then prepend, always:

```
0. Basic fact writer: Focuses on broadly covering the basic facts about the topic.
```

The basic fact writer is not filler. Specialists reliably skip the definitions, dates, scale figures
and plain description that a reader needs first, because those facts are obvious *to the specialist*.

**3. Test each one before you commit.** For each perspective, write the first question it would ask.
If two perspectives produce near-identical first questions, they are one perspective — merge them
and find a genuinely different angle. Discard the test questions afterwards; stage 2 generates its
own.

## What makes perspectives distinct

Distinct perspectives differ in *what they consider evidence*, not in what conclusion they favour.

- **Good**: a clinician (outcomes, patient-level trade-offs), a health economist (cost-effectiveness,
  system incentives), a regulator (approval pathways, post-market surveillance). Three literatures,
  three vocabularies, three sets of sources.
- **Bad**: a supporter, a critic, a neutral observer. Same literature, same questions, three tones.
  You will get one perspective's worth of coverage and think you got three.

Also avoid perspectives that can't reach evidence. "A person affected by the policy" is a real
viewpoint but generates questions that live search can rarely answer; prefer "a journalist who
covers affected communities", who asks the same questions and can be answered from reporting.

## Output format

```markdown
# Perspectives — <topic>

## Structural precedents consulted
- <Title> (<url>) — sections that informed this: <...>
- ...

## Perspectives
0. Basic fact writer: Focuses on broadly covering the basic facts about the topic.
1. <Role>: <focus>
2. <Role>: <focus>
3. <Role>: <focus>

## Notes
- Perspectives considered and merged: <...>, because <...>
- Coverage this set may still miss: <...>
```

That last line is worth writing honestly. If you know the set is thin on, say, the topic's history
outside the anglophone world, saying so lets the outline stage compensate rather than silently
inheriting the gap.

## Scale

Three plus the basic fact writer is upstream's default and a sound baseline. Go to five for sprawling
interdisciplinary topics; drop to two for narrow technical ones. More perspectives cost roughly
linear time in stage 2, so scale to how broad the topic genuinely is, not to how important it feels.
