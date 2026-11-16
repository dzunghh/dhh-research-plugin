# Fallback rules

Use only for the tool the script reported as `MISSING`. Label each row `Harper:<rule>` or `write-good:<check>` as if the tool had run.

## Harper half (errors)
Full rule list with defaults: `vendor/harper/default_config.json`. The groups that matter most:

| Rule | Look for |
|------|----------|
| SpellCheck | Word absent from `vendor/harper/dictionary.dict` (one entry per line, `word/FLAGS`) and from `user-dict.txt`; prefer British forms (colour, analyse, programme, centre) |
| RepeatedWords | Same word twice in a row ("the the") |
| AnA | "a" before a vowel sound, "an" before a consonant sound ("a apple", "an unique") |
| VeryUnique / absolute adjectives | "very/most/more unique", "completely unanimous" |
| Capitalisation | Sentence start lower-case; proper noun lower-case (`vendor/harper/proper_noun_rules.json`) |
| Irregular forms | Wrong plural or past form (`irregular_nouns.json`, `irregular_verbs.json`) |
| Spacing / punctuation | Double spaces, space before comma, missing space after full stop |
| LongSentences | Over ~40 words – advisory |

## write-good half (style – all advisory)
Word lists are under `vendor/write-good/<package>/`.

| Check | List / logic | Look for |
|-------|--------------|----------|
| passive | `passive-voice/passive.js` | form of *be* + past participle ("was recorded") |
| illusion | `lib/lexical-illusions.js` | repeated word, often across a line break |
| so | `lib/starts-with-so.js` | sentence starting "So" |
| thereIs | `lib/there-is.js` | sentence starting "There is/are" |
| weasel | `weasel-words/weasel.js` | many, very, extremely, fairly, few, significantly |
| adverb | `adverb-where/adverbs.js` | weakening adverbs (really, basically, quite) |
| tooWordy | `too-wordy/too-wordy.js` | phrases with shorter forms ("in order to", "a number of") |
| cliches | `no-cliches/cliches.js` | stock phrases |

Apply the academic calibration table in SKILL.md before reporting.
