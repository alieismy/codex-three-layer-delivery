# B2 — Two reasonable preparation interfaces

SYNTHETIC design-decision fixture. Neither option describes an implemented change in this repository. Numeric observations refer only to this synthetic fixture and are not measured product results.

## R1 — Approved scope and invariants

The task prepares a document review packet; it does not approve or publish the artifact. It must preserve the artifact revision, applicable requirement revision, review scope and evidence-consumption boundary together. Missing mandatory evidence must be visible to the reviewer. Existing public receipt fields and the owner's approval authority are fixed. The next decision is a reversible local prototype comparison, not production adoption.

There are currently two consumers maintained within one component. Five additional consumers owned by independent teams are anticipated but not approved or scheduled. The existing composition passed four hand-authored normal-path exercises. Concurrent requirement replacement and unreadable mandatory attachments were not exercised.

## Option P — Named preparation operation

`ReviewPacket.prepare(artifactId, reviewScope)` resolves the governing revisions, reads applicable evidence, and returns a packet containing these identities and observed read outcomes. The service owns assembling a consistent snapshot. Callers receive a packet or an explicit incomplete-evidence outcome. Draft notes estimate 130 implementation lines and one public module. No prototype has tested snapshot semantics, failure visibility or integration effort. The proposed design still needs to decide how concurrent changes are detected. It never decides owner approval.

## Option C — Explicit composition

The current caller composes `ArtifactStore.read`, `RequirementStore.read`, `EvidenceReader.load` and `PacketFormatter.build`. Each boundary and read outcome is visible. Callers must retain all returned revision identities, apply the appropriate scope, and compare them again after reads if concurrent changes are possible. Current shared call sites perform this sequence for the two existing consumers. Draft notes estimate 70 implementation lines across four modules. No independent-team consumer has used it, and no public guidance states the required ordering and recheck rule. It never decides owner approval.

## M1 — Requested design work

Prepare the smallest interface comparison that helps the owner choose the next prototype, including contracts callers must know, the evidence already available, unresolved semantics and a bounded comparison plan. Both options remain eligible. No new architecture is approved by this request.
