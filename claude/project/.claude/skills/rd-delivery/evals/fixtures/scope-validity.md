# A1 — Scoped document evidence

SYNTHETIC fixture, derived from this repository's document authority and gate semantics. Names, revisions and events below are invented; they are not repository execution or business acceptance evidence. All supplied excerpts are complete for the stated scope. Revision labels identify fixture snapshots, not Git hashes.

## R — Authorized requirement records

R1, revision req-r1, approved by the document owner: a package may be marked Ready for Owner Review when its applicable requirement-to-design links have been checked. Owner approval remains a separate human decision. For the recovery-design package, the restoration budget is 30 minutes. The interface-glossary package uses the unchanged term definitions in section 2.

R2, revision req-r2: the same authorized owner changes only the recovery-design restoration budget to 15 minutes. The requirement revision is approved. Section 2 and the owner-approval rule are unchanged. The cover page also replaces a spelling error in the organization-neutral title; this carries no normative change. No waiver is recorded.

## E — Existing verification records

E1: recovery design D-REC-r3 was reviewed against R1's 30-minute criterion. Its documented recovery path is 22 minutes. Review scope was recovery budget, failure-return target and recovery ownership; the disposition was Ready for Owner Review. No new recovery test has occurred since E1.

E2: glossary design D-TERM-r2 was reviewed against R1 section 2. Review scope was term definitions and their use in the interface glossary; the disposition was Ready for Owner Review. The glossary content is unchanged in the current snapshots.

E3: static link check on the two current design files returned PASS; all local document pointers in its declared scope resolved. It does not test requirement satisfaction or record owner approval.

## H — Current handoff request context

The new session received R2, E1, E2 and E3 in full and loaded the current D-REC-r3 and D-TERM-r2 snapshots. The old record lists both packages as Ready for Owner Review and leaves owner approval blank. Work on the recovery design has not restarted. The current engagement is authorized to maintain this document package and its cross-session delivery record. It is not authorized to approve documents for their owner or deploy a recovery procedure.
