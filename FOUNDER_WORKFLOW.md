<!-- Purpose: Plain-language operating manual for a non-technical founder or operator using this system. -->
# Founder Workflow

This page is for you, not for the AI agent. It's written in plain language on purpose. If you want the technical version, the rest of this repository is that — but you shouldn't need to read any of it to use the system day to day.

The short version: **you never have to know which document or command to use.** Just tell the agent what you want in plain English. It's the agent's job to figure out the right process — see [`DECISION_ROUTER.md`](./DECISION_ROUTER.md), which exists specifically so you don't have to.

## I have a new idea. What do I do?

Just describe it to the agent, in as much or as little detail as you have. Say what problem it solves and who it's for if you can — you don't need acceptance criteria, tickets, or technical detail. The agent will turn a rough idea into a real plan (this is called "Plan," sometimes "Specification" first if the idea is big or fuzzy). It should come back to you with a short written plan and ask you to confirm the scope before anything gets built.

**What you should expect back:** a plain-English summary of what will be built, what's explicitly out of scope, and any open questions it needs you to answer. If you don't get that, ask for it.

## I want to understand a repository before changing it. What do I do?

Ask the agent to "review" the repository (or a specific part of it). This is a read-only pass — it will look at what exists today and tell you what it found, without changing anything. Use this before asking for a new feature in an area you're unfamiliar with, or when something feels off and you want to know why before deciding what to do about it.

**What you should expect back:** a list of findings, each one tied to a specific file or piece of evidence — not vague impressions. If a finding sounds urgent (a security problem, something that could lose data), the agent should flag it as urgent, not bury it in a list.

## I want an agent to start coding. What do I do?

Say what you want built or fixed. If it's already a tracked, ready piece of work (an existing work item), just say "implement it" or "implement the next ready thing." If it's brand new, the agent will first make sure it's properly planned and tracked as a work-item file before writing any code — **this is not optional, and you shouldn't ask the agent to skip it**, even for something that looks small. A "quick fix" that skips planning is how small problems become untracked, unverified changes nobody can account for later.

**What you should expect back:** confirmation of exactly what's being built, a link to the tracked work-item file, and — once done — a pull request with evidence that it works (see "what to ask for" below).

## I got a pull request. How do I decide whether to merge it?

Don't merge based on the code alone. Ask for, and check, three things:

1. **Does it match what was asked for?** Compare the PR description against the original request — not more, not less.
2. **Is there evidence it works?** Every PR should have a verification report — actual test output or a description of what was checked, not just "should work."
3. **Was it reviewed?** Someone (human or agent) should have looked at the diff itself, not just the description.

If any of those three is missing, ask for it before merging — don't assume it's fine.

## When do I ask for review vs. plan vs. execute vs. verify vs. ship?

You don't have to know the difference — say what you want in plain words and the agent routes it (see [`DECISION_ROUTER.md`](./DECISION_ROUTER.md)). As a rough mental model:

| You say... | What's actually happening |
| --- | --- |
| "What's going on with X?" / "Look into X" | **Review** — understand, don't change anything yet |
| "I want to build X" | **Plan** — turn the idea into a scoped, trackable piece of work |
| "Build it" / "implement it" | **Execute** — write the code, but only once it's properly planned and tracked |
| "Does it actually work?" | **Verify** — prove it, with evidence, not just an assertion |
| "Ship it" / "Merge it" | **Ship** — the last step, and only after review and verification both passed |

## What should I never skip?

- **Never skip verification.** "It's a small change" is not evidence that it works.
- **Never let the agent implement something that isn't tracked as a real, planned piece of work** — even if it feels faster. A change with no tracked work-item file behind it is a change nobody can account for six months from now.
- **Never take "it's done" at face value without a link** — to the pull request, the work-item file, or the verification evidence. If you can't click through to it, it isn't confirmed.
- **Never assume a repository is fully set up just because it's a TFRS repository.** Some are, some aren't — see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) if you want to know which.

## What should I ask the agent to show me before I approve anything?

Before you approve a plan:
- A one-paragraph summary of what will change and why.
- What's explicitly *not* included (scope).
- Anything it's unsure about or needs a decision from you on.

Before you merge a pull request:
- A link to the actual diff (the code change), not just a description of it.
- The verification evidence — what was tested and what the result was.
- Confirmation that the change matches the original request, with nothing extra folded in.

If any of these is missing, that's a completely reasonable thing to ask for — this system is built to produce exactly this evidence at every step, so asking for it is never an imposition.

## Related Documents

This page intentionally doesn't explain the underlying mechanics — that's the rest of this repository's job. If you want to go one level deeper without reading everything: [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) is the routing table this page is built on, and [`README.md`](./README.md#source-of-truth-map) has a map of which document covers which concept.
