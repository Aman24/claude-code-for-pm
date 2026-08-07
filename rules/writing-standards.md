# Writing Standards

Always on. It applies to everything the agent drafts for a human reader — status updates, exec briefs, specs, announcements, product copy, docs.

It exists because the other rules govern *structure* and this one governs *sentences*. A brief can have a perfect shape and still be unreadable, and the failure is always the same: prose that sounds finished and says nothing.

**Never apply these to text the human wrote or edited themselves.** Their wording is final. Editing someone's own sentences into house style is how you lose the one voice in the document that was real.

---

## The three that carry the most weight

1. **Protect the specific fact.** Never smooth a useful detail into generic importance. "The integration improved efficiency" becomes "The integration cut deploy time from 40 minutes to 4." Names, numbers, dates, mechanisms.

2. **State the fact and let the reader judge.** Executives decide what is significant. Writing that tells them what to think reads as advocacy and gets discounted at exactly the moment you needed it believed.

3. **Say it once.** If the clear word is right, repeat it. Rotating synonyms for variety makes the reader wonder whether you meant something different the second time.

## Patterns to cut

| Pattern | Avoid | Fix |
|---|---|---|
| **Binary contrast** | "It's not X. It's Y." / "The question isn't X, it's Y." | State Y directly |
| **Throat-clearing** | "Here's the thing," "Let me be clear," "I'll be honest" | Cut it, state the point |
| **Faux-insight setup** | "What nobody tells you," "The part everyone misses" | Let the claim stand alone |
| **Colon reveal** | "The best part: it learns." | Write it as a plain sentence |
| **Superficial analysis** | "…highlighting the team's commitment to innovation" | Replace with the actual consequence |
| **Importance puffery** | "marks a pivotal moment," "a testament to," "plays a vital role" | State what it is |
| **Interpretive metadiscourse** | "That matters more than it sounds," "As you can see," "The key point is" | Delete, or replace with support |
| **Weasel attribution** | "experts agree," "studies show," "widely regarded as" | Name the source or cut the claim |
| **Fake-strong verbs** | "serves as a centralized hub for" | "is," "has," "tracks" |
| **Synonym cycling** | "The agent reviews. The assistant scores. The tool suggests." | One name, used throughout |
| **Negative listing** | "Not a X. Not a Y. A Z." | Just say Z |
| **Dramatic fragments** | "That's it. That's the whole thing." | Complete sentences |
| **Robotic rhythm** | Repeated sentence shapes, stacked punchy fragments | Vary only when it helps the point |
| **Rhetorical setups** | "What if I told you," "Think about it:", "Plot twist:" | Drop them and make the point |
| **Fake-profound kicker** | "The future isn't coming. It's already here." | Delete. End on the clearest concrete sentence already in the draft |
| **Summary-recap ending** | "In conclusion," "Ultimately," a final restating paragraph | End on the last real point, takeaway, or next action |
| **Formatting slop** | Emoji in headings, bold sprinkled mid-sentence, bullets where two sentences read better, headers over two-sentence sections | Format follows content |
| **Em dash crutch** | Clusters of decorative dashes | None in short copy; one or two in longer drafts, only when they beat a comma or a period |

**Often-empty adverbs:** just, literally, honestly, simply, actually, truly, fundamentally, importantly, crucially, inherently, inevitably. Cut them when they add nothing. Keep them when they carry real emphasis or uncertainty.

## Fundamentals

- **Active voice.** "The team shipped it Tuesday," not "the decision emerged." Inanimate things do not perform human verbs.
- **Verbs do the work.** "Made a decision" becomes "decided." "Has the ability to" becomes "can."
- **Lead with the point** when the setup adds nothing.
- **Open it up, don't dumb it down.** Keep the substance, nuance and precision. Strip only what makes it hard to read: jargon, long sentences, abstract nouns, tangled structure.
- **Never invent** a claim, number, example or source. If it is unknown, say so, or ask.

## Pre-publish check

Run before anything goes to a board, an executive, a partner, or the public. Answer each pass or fail, and fix before delivering.

1. Are binary contrasts, negative listings, rhetorical setups and throat-clearing openers gone?
2. Are faux-insight setups, colon reveals, superficial analysis, fake-strong verbs, synonym cycling, dramatic fragments and robotic rhythm fixed?
3. Is importance puffery replaced with plain fact, and every weasel attribution either given a named source or cut?
4. Is interpretive metadiscourse removed, including commentary telling the reader what to notice?
5. Does the ending land on a concrete point, takeaway or next action rather than a kicker or a recap?
6. **Would every sentence read differently if it were about a different product?** If not, it is filler.
7. Are all numbers, dates and names traceable to a source?

To audit without rewriting, name each pattern found, quote the line, and give the fix in a few words. Don't guess whether AI wrote something. A named pattern is evidence the reader can check; a detector score is not.

## Why this is a rule and not a command

The obvious alternative is a `/polish` slash command. I chose a rule because the moment you most need this is a status update drafted at speed the morning it's due, which is exactly the moment nobody remembers to invoke anything. A rule that loads every session costs a few hundred tokens. A command you forget costs the document.

The same logic applies to most writing tooling: if it only works when you remember it, assume it doesn't work.

---

The pattern list is adapted from [no-ai-slop](https://github.com/petergyang/no-ai-slop) by Peter Yang (MIT), rewritten as an always-on rule and extended with the three checks above that are specific to portfolio reporting. The `eval.md` idea in that repo — a skill that grades its own output against a fixed checklist before returning it — is worth stealing generally, and the pre-publish check above is that idea applied here.
