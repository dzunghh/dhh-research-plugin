# Lessons – things that went wrong once

Method and tooling lessons only. Load before running R, building a deck, or finalising a document.

## Running R on Windows
- `Rscript` may not be on PATH. Call it by full path, e.g. `"C:\Program Files\R\R-4.5.1\bin\Rscript.exe"`, and check the version folder first.
- Packages live in the user library (`R_LIBS_USER`). An old `rlang` in the system library can block newer packages – update dependencies before blaming the package.
- Run file-moving scripts (copy, delete, sync) from PowerShell, not Git Bash; MSYS path translation has silently broken `copytree`. Count files afterwards.

## Analysis
- **Read the user's existing code first.** Match their pooling model, filters and formulas before proposing changes; a "better" default that disagrees with their pipeline is a bug.
- Percentage change from a log-scale coefficient is `exp(β) − 1`, not `β`.
- `meta` GLMM proportions need ML τ² and no ad hoc Hartung–Knapp; Egger's test is not valid on GLMM proportions or SMDs. Detail: `srma`.

## Instruments and proposals
- Check the **fielded** questionnaire or dataset, not the proposal. Constructs promised in a protocol are often missing from the instrument – a DAG node with no variable is unmeasured confounding.

## Writing
- British English; en-dash (–), never em-dash.
- Narrative literature reviews: APA 7. Analysis plans and clinical manuscripts: Vancouver. Confirm when the target journal is known.
- Vietnamese output: full diacritics; keep established English terms (hazard ratio, DAG) in English on first use with a Vietnamese gloss.
- Finish prose with the `grammer` skill before handing back.

## Decks
- Reading rendered slide images is the largest token cost. Tile all slides into one contact sheet, review once at the end, and fix with targeted edits, not rewrites.

## Citations
- A DOI that resolves proves nothing about the title attached to it. Verify title against the resolved record before citing.
