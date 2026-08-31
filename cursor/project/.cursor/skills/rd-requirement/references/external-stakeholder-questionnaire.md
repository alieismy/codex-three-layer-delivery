# External Stakeholder Questionnaire

Use this mode when requirements work is blocked by facts, decisions, or approval held by an identifiable person or role outside the current conversation. The questionnaire is a bounded requirements-elicitation artifact, not a substitute for research, feasibility analysis, or stakeholder approval. Drafting it does not authorize sending it or changing an external system.

## Entry Gate

Use a questionnaire only when all of the following are true:

- the missing answer materially affects scope, rules, constraints, priority, acceptance, or another requirements decision;
- the current user lacks the knowledge or authority to answer on the recipient's behalf;
- a recipient role with the relevant knowledge or decision authority can be identified; and
- receiving the answer will close or narrow a recorded blocker.

Do not use this mode when the fact can be retrieved from supplied material, the project, or an authoritative source; when the current user can make the decision; or when the question is non-blocking. Do not shift the agent's own analysis or evidence-retrieval duty to a stakeholder.

## Method

### Define the Handoff

Confirm only what the current user can reliably provide:

- the recipient's role, relevant expertise, and relationship to the work;
- the facts, decisions, or approval that must come back;
- the requirement, artifact, or decision currently blocked; and
- how the returned answer will be used.

Do not ask the current user to guess the recipient's substantive answer.

### Separate Answer Types

Mark each question as one of:

- **Fact:** asks for current or historical information and, where material, its source or evidence;
- **Decision:** asks an authorized owner to choose among bounded alternatives or define a rule;
- **Approval:** asks an authorized owner to accept, reject, or conditionally accept an identified baseline.

Keep evidence that the agent can independently retrieve out of the questionnaire. A recommendation may accompany a decision question only when its basis and trade-offs are explicit; it must not be presented as the recipient's decision.

### Draft the Minimum Sufficient Questionnaire

- Order questions by decision impact because only a partial response may return.
- Ask one question per intent; split compound questions.
- Give enough context to answer without reproducing the full project history.
- Add a short “why this matters” only when it prevents ambiguity or a superficial answer.
- State an acceptable evidence or decision form when the return would otherwise be unverifiable.
- Put an answer placeholder immediately after each question and allow “unknown” or “not authorized” as valid responses.
- Include deadlines or expected effort only when supplied or confirmed; do not invent them.
- Use a short list instead of the full template when only a few questions are needed.

### Track the Return

Map each question to the blocked requirement, decision, or acceptance criterion, together with the recipient role and the condition for closing the blocker. When answers return, preserve their source and authority, distinguish facts from decisions, and keep unanswered or disputed items open. Do not treat receipt as approval unless the recipient had approval authority and gave an explicit approval decision.

## Minimal Template

```markdown
# <Questionnaire title>

**Purpose:** <blocked requirement or decision this questionnaire will resolve>

**Suggested recipient:** <role and relevant responsibility>

**How the answers will be used:** <artifact, decision, or acceptance update>

## Context

<Minimum context needed to answer accurately.>

## How to answer

Answer what you can. Mark uncertainty, missing evidence, or lack of authority rather than guessing.

## Questions

### Q1. <One question with one intent>

**Type:** Fact / Decision / Approval

**Why this matters:** <include only when needed>

**Acceptable evidence or decision form:** <include when needed>

**Answer:**

>

## Return Criteria

- <Question or answer> closes or narrows <requirement, decision, or blocker ID> when <checkable condition>.

## Anything Else?

Identify material context the questionnaire did not ask for.
```

## Completion Check

The questionnaire is complete when every included question maps to a real blocker, has one intent and an answer location, identifies the required fact or authority, and has a checkable return criterion. It is not complete if it asks the current user to impersonate the recipient, contains answers presented as confirmed without evidence, or silently authorizes external sending or approval.
