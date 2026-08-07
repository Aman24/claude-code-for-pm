# Adopting Third-Party Skills

Public skill catalogues are multiplying. Most of them are good. Installing them anyway is usually a mistake, and the reasons have almost nothing to do with quality.

I run a little over a hundred skills across a global directory and a project directory. Roughly a fifth were written for the work; the rest came from public collections. This is the process I use before anything joins that set, and the two failure modes it exists to prevent.

## Why "it's free, just install it" is wrong

A skill isn't free. It costs:

- **Selection surface.** Every skill is one more candidate the agent weighs when deciding what to invoke. Two skills that do nearly the same thing don't average out. They make the routing worse.
- **A second source of truth.** If an installed skill says one thing and your rules say another, you now have a conflict you'll discover mid-task, at speed, in front of someone.
- **An unread dependency.** Skills are instructions to your agent. Installing one you haven't read is running code you haven't reviewed.
- **Obligations.** Some of them are licensed in ways that follow the file.

None of that argues against adopting external skills. It argues for a gate.

## The four gates

### 1. Overlap — do I already have this?

List the skills you own whose names or descriptions sit near the candidate, then read them. Not the names, the files.

The honest question isn't "is this good?" It's **"what can this do that the thing I already have cannot?"** If the answer is a nicer format, skip it. If the answer is a decision rule or a refusal mode you don't currently have, that's real.

I rejected twelve of sixteen skills from one strong catalogue on this gate alone. Not because they were weak; several were better constructed than my own. I rejected them because I already had something occupying that slot, and two mediocre-fit options beat one good one only in a catalogue, never in a session.

### 2. Fit — does the framing match my context?

This is the gate people skip, and it's the one that produces confidently wrong advice.

Skills encode a worldview along with a method. A catalogue written for venture-backed SaaS carries assumptions about product-market fit, conversion, growth levers and paywalls. Run those unmodified inside a non-profit, a regulated business, or an internal-tools team and you'll get output that is technically competent and contextually wrong, which is more dangerous than output that's obviously wrong, because it survives review.

Two questions:

- **Whose success does this skill define?** If its definition of winning isn't yours, the mechanics may still transfer but the judgment won't.
- **What does it refuse?** Good skills have refusal modes. Read them. A skill that refuses to paywall a core workflow is telling you what it values, and you should agree before you install it.

Sometimes the answer is a pleasant surprise. One pricing skill I adopted refuses to paywall any step of the core workflow, a commercial rule that happened to point the same direction as the organisation's own position on access. That alignment is worth checking for rather than assuming.

### 3. Licence — what does copying this oblige?

Check before you copy, not after.

**MIT / Apache-2.0** — adapt freely, keep the attribution. You can rewrite the content into your house style and your own structure.

**CC BY-SA** — attribution *and* share-alike. Derivatives you distribute must carry the same licence. Read that sentence again if you maintain any public repository.

The distinction that matters: **these obligations attach on redistribution, not on use.** A CC BY-SA skill sitting in your private repo obliges you nothing. The moment it lands in a public one, you owe complete attribution and the receiving repo inherits share-alike.

That trap is easy to walk into if you keep a public repo of your own setup. You sanitize a folder, push it, and quietly relicense someone else's work by accident.

Two practical notes:

- **Marketing tracking is not attribution.** Some skills ship footers containing UTM-tagged links to a paid product. Attribution names the author; a UTM parameter reports a click to someone else's analytics. Stripping tracking while keeping author, source and licence is honest, and under private use it's unconditionally fine.
- **If you need a public version of a CC BY-SA framework, don't adapt the file.** Methods and frameworks aren't copyrightable. Only that particular expression is. Write your own treatment from the underlying idea and you inherit nothing. Editing theirs down is the one route that definitely does.

### 4. Collision — does the name already exist?

Cheap, mechanical, and it will bite you eventually. Check the candidate name against every skill directory you load, global and project-scoped. Two skills with the same name in different scopes is a debugging session you don't want.

## Install, or absorb into a rule?

Passing all four gates still leaves a choice, and it's the one I get wrong most often.

**Install as a skill** when the thing is a *procedure* invoked for a specific job: analysing a competitor, sizing a market, designing a pricing tier. You reach for it deliberately, and it's fine that it sits idle until you do.

**Absorb into a rule** when the thing is a *standard* that should apply to everything. Writing quality, confidence tagging, security hygiene, tone.

The test: **would you be upset if it silently didn't apply?**

If yes, it must not be a command. A skill you have to remember is a skill that fails exactly when you're busy, and being busy is the condition under which quality slips in the first place. I converted a writing-quality skill into `rules/writing-standards.md` for this reason. The content was excellent and the delivery mechanism was wrong.

The cost of a rule is tokens on every session. The cost of a forgotten command is the document you already sent.

## Record what you took

Keep a `SOURCES.md` next to your skills. For anything external:

- Where it came from, and the date or commit
- The licence, stated explicitly
- What you changed, and why that was permitted
- Any rule that keeps you compliant, most usefully whether it may ever be published

This takes ten minutes and answers a question your future self will otherwise have to reverse-engineer under time pressure: *can I publish this?*

## Verify before you trust it

Read every file you install. All of them, including the reference files a skill loads at runtime.

Then check the boring things, because they're the ones that actually break: frontmatter parses, `name` matches its folder, the description is specific enough for the agent to route on, and referenced files exist.

A skill that fails to load usually fails quietly. So does a hook. I shipped seven of those to a public repo and only found out months later that five of them had been silently inert the whole time. The habit that catches both is the same one: after installing anything, prove it fires. A positive control that should trigger, and a negative control that should stay silent.

The negative control is the one people skip, and it's the one that finds real bugs.
