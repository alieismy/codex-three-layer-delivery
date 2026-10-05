# B1 — One word across three contracts

SYNTHETIC fixture, based on the repository's distinction between document processing and approval authority. The API, records and numeric limits are invented. Excerpts below are complete for the terms and behavior being compared.

## R1 — Approved product requirements, req-r2

Submitting a review request returns a receipt within 2 seconds after durable queue acceptance. The receipt is not an owner approval. A named authorized document owner decides approval after reviewing the relevant evidence. Request submission must remain usable while that owner is offline. Existing clients consume the Boolean field `accepted` as “the queue durably received the request.” The public response field is retained for this release.

## D1 — Current design, design-r3, in review

POST /reviews returns `{accepted: true, request_id: ...}` after the queue acknowledges durable receipt. The text says: “An accepted request enters the approved document state. The caller may treat accepted=true as permission to publish.” The state list uses `accepted` for both queue receipt and owner approval without defining which one is persisted. D1 does not describe a later owner-approval event. The approved requirement does not specify a publication API or authorize automatic publication.

## T1 — Existing acceptance checklist, test-r1

During a synthetic queue stub exercise, a receipt was returned in 0.7 seconds. The checklist labels that row PASS for the 2-second receipt requirement. A different row labels “owner approval and publish permission” PASS because `accepted=true` was seen. No human approval or publish action occurred in the exercise.

## M1 — Maintainer request scope

The owner requests review of these three contract excerpts and a minimal wording/interface clarification that preserves approved behavior and existing client compatibility. No implementation, normative requirement change or new test execution is requested. Missing contract decisions can be assigned to the owner for resolution while the independently supported corrections proceed.
