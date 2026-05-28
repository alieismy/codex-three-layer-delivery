---
name: rd-testing
description: >-
  Use when designing, writing, running, or evaluating tests for a codebase,
  feature, bugfix, or release candidate. Covers unit tests, integration tests,
  system tests, E2E tests, and performance tests with test pyramid guidance.
  Do not use for code implementation or deployment.
---

# $rd-testing

Design and execute **unit tests and system tests**, producing test suites and test reports.

## Deliverables

- Test suite (executable code or structured documentation)
- Test execution report
- Defect list (if applicable)

## Test Pyramid Design

```
         /  E2E  \           ← Few critical paths
        / Integration \      ← Inter-module interactions
       /   Unit Tests   \   ← Many, fast, independent
```

| Level | Coverage Focus | Proportion |
|-------|---------------|------------|
| Unit tests | Logic correctness of individual functions/methods | 70% |
| Integration tests | Inter-module interactions, external dependency integration | 20% |
| E2E / System tests | End-to-end business flows | 10% |

## Execution Steps

### 1. Test Scope Determination

- Confirm the scope of code under test and associated requirements/design documents
- Identify critical paths and high-risk modules
- Determine test level allocation

### 2. Unit Test Design

#### Happy Path
- At least one happy-path test case per public method
- Cover major business logic branches

#### Systematic Boundary Condition Enumeration

| Category | Checkpoints |
|----------|------------|
| Numeric | 0, 1, -1, MAX, MIN, MAX+1, MIN-1 |
| String | Empty, single character, excessively long, special characters, Unicode |
| Collection | Empty, single element, at capacity, duplicate elements |
| Time | Epoch, day boundary crossing, timezone crossing, leap second |
| State | Initial state, terminal state, invalid transition |
| Concurrency | Single-thread baseline, multi-thread contention |

#### Negative / Exception Tests
- Invalid inputs (type errors, format errors, injection attempts)
- Resource unavailability (network timeout, disk full, insufficient permissions)
- Dependency failures (downstream service errors, timeouts, empty responses)
- Concurrency conflicts (simultaneous writes, optimistic lock conflicts)

### 3. Integration Test Design

- Correctness of inter-module interface calls
- Transaction integrity of database operations
- Mock/stub strategy for external API calls
- Message queue production/consumption correctness

### 4. System Test Design

- End-to-end business flow coverage (based on requirements document acceptance criteria)
- Cross-module data flow verification
- Error recovery and degradation scenarios
- Performance baseline verification (optional)

### 5. Performance Test Design (on-demand)

| Type | Objective |
|------|-----------|
| Benchmark | Single-operation latency/throughput baseline |
| Load test | Behavior under expected peak load |
| Stress test | Degradation behavior when capacity is exceeded |
| Endurance test | Resource leak detection over extended runtime |

### 6. Test Execution & Reporting

- Execute all test cases and record results
- Attach root cause analysis to failed cases
- Output structured report: passed / failed / skipped / blocked

## Spec Injection Check

Pre-execution checks:
- Project test framework and execution method
- Existing test directory structure and naming conventions
- Test execution configuration in CI

## MCP Tool Usage

- **Context7**: Query test framework APIs and best practices
- **Sequential Thinking**: Complex test scenario logical reasoning
- **Playwright**: System test / E2E automated test execution for web applications

## Quality Gates

Pre-delivery checklist:

- [ ] Unit tests cover all public interfaces
- [ ] Happy / error / boundary conditions all covered
- [ ] Every test has explicit assertions (no print-only tests)
- [ ] Tests are independent, repeatable, and environment-agnostic
- [ ] Failed cases have root cause analysis
- [ ] Test report is structured output

## Out of Scope

- Do not write "tests" that only print without asserting
- Do not write non-repeatable tests that depend on external state
- Do not use `@Ignore` / `skip` to mask failing tests
- Do not write meaningless getter/setter tests just to increase coverage
