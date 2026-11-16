# Co-STORM protocol — turn policy, moderator, mind map

Read before running Co-STORM mode. The turn policy is what distinguishes this from a chat with
several personas.

## What Co-STORM is for

STORM assumes the user knows what article they want. Co-STORM is for the case where they don't: the
topic is unfamiliar, the interesting question hasn't been identified yet, or they want to steer as
they learn. The design goal is to reduce the user's effort to *reacting* — they don't have to know
what to ask, because the room asks, and they interject when something matters to them.

## Participants

| Role | Job |
|---|---|
| **Experts** (2 active by default) | Answer the current focus, grounded in fresh search, cited. Re-cast for each new focus. |
| **General knowledge provider** | Answers a question that was just asked, without a specialist framing. |
| **Moderator** | Takes the floor when the room stops asking questions; introduces an unexplored angle grounded in search it ran itself. See `../agents/moderator.md`. |
| **Mind map curator** | Files every turn's findings into a hierarchy. Silent. See `../agents/mind_map_curator.md`. |
| **The user** | May interject at any turn — a question, a redirection, a challenge. |

Experts are generated per focus, not fixed for the session: when the focus changes, generate a fresh
pair suited to it. Upstream deliberately invites speakers with opposing stands and different interests
where the topic warrants it. A roundtable of people who agree produces one turn's worth of
information spread over six turns.

## Warm start

Don't open a cold conversation — a roundtable that begins knowing nothing spends its first turns on
definitions the user could have got from a search box.

Run a compressed STORM knowledge-curation pass first: 3 perspectives, 2 turns each (upstream's
`warmstart_max_num_experts=3`, `warmstart_max_turn_per_experts=2`). Seed the mind map from it and
present a short summary of what's already established. The conversation then starts at the edge of
what's known rather than the middle.

## Turn policy

Each turn, decide who speaks, in this order:

1. **User interjection pending?** → the user's turn. Always wins.
2. **Moderator override flagged** (user asked for a change of direction, or you set it last turn) →
   moderator.
3. **Three consecutive turns without a genuine question** → moderator, *and* reorganise the mind map
   first. This is `moderator_override_N_consecutive_answering_turn=3`.
4. **Last turn was a question** → an expert answers it. Re-cast the expert list to suit the new focus.
5. **Otherwise** → next expert in rotation offers a grounded contribution, and the following turn
   should move towards a question.

The counter in rule 3 is the load-bearing part. Left alone, a roundtable drifts into answering ever
finer sub-questions inside a frame nobody chose; the moderator is a scheduled interruption of that
drift, and scheduling it beats waiting for someone to notice.

Every expert turn is grounded: search, then speak from what was retrieved, with `[n]` citations into
the shared source table. Ungrounded turns are what turn a roundtable into a group hallucination —
several confident voices agreeing is more convincing and no more true.

## Conversational register

Utterances are speech. Conversational, engaging, following naturally from the previous speaker. No
welcoming or concluding formulas — the conversation is ongoing. Citations stay in the utterance
exactly as retrieved; conversational polish must never move or drop an `[n]`.

Speakers address each other, not the reader. "That procurement figure cuts against the modelling
Sarah cited" is a roundtable; "It is important to consider procurement" is a memo.

## Pacing and the human

Don't run twenty turns unattended and present a transcript. Pause every 3–5 turns and offer the user
the floor with a one-line summary of where the conversation has got to and what the map now shows.
The collaboration is the feature; a Co-STORM run the user didn't participate in is a slower STORM run
with a worse output format.

Watch for the user going quiet mid-run — treat several silent pauses as a signal to wrap up and
render, rather than pressing on.

## Ending

The user says stop, the map stops growing, or the moderator can't find an unexplored angle worth a
turn.

Then render: the mind map hierarchy becomes the outline, its snippets become the evidence, and
`../agents/article_polisher.md` writes the lead and runs the full citation audit. Co-STORM output is
held to the same citation standard as STORM output.

Include a short "how this was produced" note listing the experts convened, the number of turns, and
what the map shows as thin or contested. A reader of a roundtable-derived report needs to know which
parts had one voice behind them.

## Parameters, for reference

Upstream `RunnerArgument` defaults, useful as sane starting points:

| Parameter | Default | Meaning |
|---|---|---|
| `max_num_round_table_experts` | 2 | active experts per focus |
| `moderator_override_N_consecutive_answering_turn` | 3 | answering turns before the moderator cuts in |
| `node_expansion_trigger_count` | 10 | snippets in a node before it splits |
| `warmstart_max_num_experts` | 3 | perspectives in the warm-start pass |
| `warmstart_max_turn_per_experts` | 2 | turns per warm-start perspective |
| `max_search_queries_per_turn` | 3 | queries behind each grounded utterance |
