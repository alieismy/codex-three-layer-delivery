# Temporary Data Boundary

`.tmp/` is not a blanket disposable directory in this repository. Files already tracked directly under `.tmp/` are reviewed repository artifacts and must not be deleted merely because of the directory name.

Use `.tmp/local/` for task-local clones, downloads, logs, generated probes, and other reproducible scratch data. That subdirectory is ignored by Git and may be removed after the task. Never place authoritative documents, release assets, required evidence, credentials, or the only copy of recovery data there.

New durable artifacts belong in an established public location such as `docs/`, `examples/`, or the owning Skill. Before a pull request or release, inspect tracked, staged, untracked, and ignored state explicitly, and remove obsolete task-local data.
