# Configuration and Infrastructure Research

Use this mode for operating systems, VPN/VPS/proxy networks, network services, security controls, installation, migration, and configuration behavior.

## Establish the Environment

- Record operating system/build, software/version, architecture, privilege level, installation method, network topology, provider constraints, and target outcome
- Separate control plane, data plane, DNS/name resolution, routing, authentication, storage, logging, and external dependencies
- Define the trust and threat boundary: assets, actors, ingress/egress, credentials, metadata exposure, and acceptable residual risk

## Evidence and Testing

- Prefer official manuals, source/config schemas, release notes, system state, logs, packet/routing evidence, and reproducible probes
- Compare documented defaults with effective runtime configuration
- Correlate timestamps and environment changes before attributing causality
- Separate configuration validity, connectivity, security, privacy, performance, and operational maintainability
- State prerequisites, expected observations, validation method, failure signals, rollback path, and any destructive or external-write approval gate

## Failure Patterns

- Treating one successful connection as proof of security, privacy, or stability
- Assuming a GUI toggle maps directly to one runtime setting
- Copying provider or forum commands across versions or operating systems
- Declaring success without runtime evidence, or declaring root cause from temporal coincidence alone
