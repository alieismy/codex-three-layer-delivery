# Synthetic candidate and constraint records

All requirements, candidates, measurements, and policies below are fictional evaluation inputs.

- **R1 — Approved outcome:** Reduce the freshness delay of an internal planning report to at most five minutes. The next decision concerns a bounded prototype; no production deployment is authorized.
- **R2 — Fixed boundary:** The approved `ReportV2` interface, its checksum, and its field meanings must remain unchanged. The owner has explicitly closed interface selection for this task. Processing architecture remains open.
- **R3 — Data and resources:** Processing must remain offline. Prototype work has a two-day resource limit, uses synthetic input, and must preserve a return to the current pipeline without changing source data.
- **B0 — Current approach:** A full batch rebuild produces reports every four hours. Its operators and recovery process are established, but it misses R1.
- **C1 — Shorter batches:** Reuse the current pipeline with more frequent full rebuilds. A paired synthetic laboratory trial achieved twelve-minute freshness. Most existing operations are reusable; no result below five minutes is available.
- **C2 — Incremental views:** Process source changes into an incremental view and export the same `ReportV2` interface. In the same laboratory workload, freshness was three minutes. Duplicate-event, out-of-order-event, and restart recovery behavior have not yet been tested. More frequent future reports may benefit from incremental processing, but that is an architectural hypothesis, not a demonstrated production gain.
- **C3 — Hosted autonomous service:** A vendor slide promises instant reports and no operations work. The proposal sends source data to a remote service. There is no inspected compatibility, recovery, or timing evidence.
- **D1 — Decision horizon:** Explain the next prototype choice, the cost of retaining four-hour reports, and the evidence required before wider adoption. Interface redesign is outside the requested design space.
