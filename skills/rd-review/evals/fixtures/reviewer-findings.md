# Synthetic fixture: review another review

All documents and people below are fictional. The records are the complete review inputs.

## Governing records

- **B1 — Approved requirements, revision 2:** retain audit events for 30 days; encrypt stored events; log failed deletion attempts with an error category and a retry decision.
- **B0 — Superseded revision 1:** retention was 90 days. B1 explicitly supersedes B0.
- **T1 — Target design, section 2:** retain audit events for 30 days and encrypt stored events.
- **T2 — Target design, section 3:** delete expired events daily. The document does not define the behavior when deletion fails.
- **A1 — Review scope:** independently assess the supplied findings and the target against B1; propose bounded remediation. This is a document review, not authority to implement or deploy.

## Prior reviewer findings

- **F1, Critical:** T1 has no encryption requirement. Add encryption.
- **F2, Critical:** 30-day retention contradicts the approved 90-day rule. Restore 90 days.
- **F3, Major:** T2 omits failed-deletion logging and the retry decision required by B1.

No evidence beyond the records above supports these findings. Preserve IDs so the owner can see how each finding was treated.
