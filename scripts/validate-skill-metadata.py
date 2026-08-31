#!/usr/bin/env python3
"""Parse Skill YAML and verify local reference integrity."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path
from urllib.parse import unquote, urlsplit

try:
    import yaml
except ImportError:
    print(
        "ERROR: PyYAML is required; install validation dependencies with "
        "'python -m pip install -r requirements-validation.txt'.",
        file=sys.stderr,
    )
    raise SystemExit(2)


FRONTMATTER_PATTERN = re.compile(r"\A---\n(?P<body>.*?)\n---\n", re.DOTALL)
MARKDOWN_LINK_PATTERN = re.compile(
    r"(?<!!)\[[^\]\n]*\]\(\s*(?:<(?P<angle>[^>\n]+)>|(?P<plain>[^\s)\n]+))"
)
WINDOWS_ABSOLUTE_PATTERN = re.compile(r"^[A-Za-z]:[\\/]")
ALLOWED_REMOTE_SCHEMES = {"http", "https", "mailto", "tel"}


class UniqueKeySafeLoader(yaml.SafeLoader):
    """SafeLoader variant that rejects duplicate mapping keys."""


def construct_unique_mapping(
    loader: UniqueKeySafeLoader, node: yaml.nodes.MappingNode, deep: bool = False
) -> dict[object, object]:
    mapping: dict[object, object] = {}
    for key_node, value_node in node.value:
        key = loader.construct_object(key_node, deep=deep)
        try:
            duplicate = key in mapping
        except TypeError as error:
            raise yaml.constructor.ConstructorError(
                "while constructing a mapping",
                node.start_mark,
                f"found unhashable key {key!r}",
                key_node.start_mark,
            ) from error
        if duplicate:
            raise yaml.constructor.ConstructorError(
                "while constructing a mapping",
                node.start_mark,
                f"found duplicate key {key!r}",
                key_node.start_mark,
            )
        mapping[key] = loader.construct_object(value_node, deep=deep)
    return mapping


UniqueKeySafeLoader.add_constructor(
    yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, construct_unique_mapping
)


def compact_error(error: BaseException) -> str:
    return " ".join(str(error).split())


def parse_yaml_mapping(
    text: str, label: str, errors: list[str]
) -> dict[object, object] | None:
    try:
        document = yaml.load(text, Loader=UniqueKeySafeLoader)
    except yaml.YAMLError as error:
        errors.append(f"YAML parser rejected {label}: {compact_error(error)}")
        return None
    if not isinstance(document, dict):
        errors.append(f"YAML document must be a mapping for {label}")
        return None
    return document


def is_within(path: Path, root: Path) -> bool:
    try:
        path.relative_to(root)
        return True
    except ValueError:
        return False


def iter_markdown_targets(text: str) -> list[str]:
    targets: list[str] = []
    for match in MARKDOWN_LINK_PATTERN.finditer(text):
        target = match.group("angle") or match.group("plain")
        if target:
            targets.append(unquote(target))
    return targets


def resolve_local_target(
    source: Path, target: str, skill_root: Path, errors: list[str]
) -> Path | None:
    if target.startswith("#"):
        return None
    if WINDOWS_ABSOLUTE_PATTERN.match(target) or target.startswith(("/", "\\")):
        errors.append(f"Relative Skill link must not use an absolute path: {source} -> {target}")
        return None

    parsed = urlsplit(target)
    if parsed.scheme.lower() in ALLOWED_REMOTE_SCHEMES:
        return None
    if parsed.scheme:
        errors.append(f"Unsupported Skill link scheme: {source} -> {target}")
        return None

    local_part = parsed.path
    if not local_part:
        return None
    resolved = (source.parent / local_part).resolve()
    if not is_within(resolved, skill_root):
        errors.append(f"Relative Skill link escapes Skill root: {source} -> {target}")
        return None
    if not resolved.is_file():
        errors.append(f"Relative Skill link does not resolve to a file: {source} -> {target}")
        return None
    return resolved


def validate_skill(skill_file: Path, errors: list[str]) -> tuple[int, int, int]:
    skill_root = skill_file.parent.resolve()
    try:
        content = skill_file.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as error:
        errors.append(f"Unable to read Skill as UTF-8: {skill_file}: {compact_error(error)}")
        return (0, 0, 0)

    frontmatter_match = FRONTMATTER_PATTERN.match(content)
    if not frontmatter_match:
        errors.append(f"Skill must start with LF-delimited YAML frontmatter: {skill_file}")
        return (0, 0, 0)

    metadata = parse_yaml_mapping(
        frontmatter_match.group("body"), f"Skill frontmatter {skill_file}", errors
    )
    if metadata is not None:
        if not isinstance(metadata.get("name"), str):
            errors.append(f"Skill frontmatter name must be a string: {skill_file}")
        if not isinstance(metadata.get("description"), str):
            errors.append(f"Skill frontmatter description must be a string: {skill_file}")

    metadata_count = 0
    openai_metadata = skill_root / "agents" / "openai.yaml"
    if openai_metadata.is_file():
        metadata_count = 1
        try:
            openai_text = openai_metadata.read_text(encoding="utf-8")
        except (OSError, UnicodeError) as error:
            errors.append(
                f"Unable to read Skill agent metadata as UTF-8: {openai_metadata}: "
                f"{compact_error(error)}"
            )
        else:
            parse_yaml_mapping(openai_text, f"Skill agent metadata {openai_metadata}", errors)

    referenced_files: set[Path] = set()
    for target in iter_markdown_targets(content):
        resolved = resolve_local_target(skill_file, target, skill_root, errors)
        if resolved is None:
            continue
        if is_within(resolved, skill_root / "references"):
            relative = resolved.relative_to(skill_root)
            if len(relative.parts) != 2 or relative.parts[0] != "references":
                errors.append(
                    f"Skill references must be one level below references/: "
                    f"{skill_file} -> {target}"
                )
            referenced_files.add(resolved)

    reference_root = skill_root / "references"
    reference_files = sorted(reference_root.rglob("*.md")) if reference_root.is_dir() else []
    for reference_file in reference_files:
        resolved_reference = reference_file.resolve()
        if not is_within(resolved_reference, skill_root):
            errors.append(f"Skill reference escapes Skill root: {reference_file}")
            continue
        relative = resolved_reference.relative_to(skill_root)
        if len(relative.parts) != 2:
            errors.append(f"Skill reference must be one level deep: {reference_file}")
        if resolved_reference not in referenced_files:
            errors.append(f"Skill reference is not linked directly from SKILL.md: {reference_file}")

        try:
            reference_text = reference_file.read_text(encoding="utf-8")
        except (OSError, UnicodeError) as error:
            errors.append(
                f"Unable to read Skill reference as UTF-8: {reference_file}: "
                f"{compact_error(error)}"
            )
            continue
        for target in iter_markdown_targets(reference_text):
            resolved = resolve_local_target(reference_file, target, skill_root, errors)
            if resolved is not None and is_within(resolved, reference_root):
                errors.append(
                    f"Skill reference files must not chain to another local reference: "
                    f"{reference_file} -> {target}"
                )

    return (1, metadata_count, len(reference_files))


def main() -> int:
    if sys.version_info < (3, 9):
        print("ERROR: Skill metadata validation requires Python 3.9 or newer.", file=sys.stderr)
        return 2

    parser = argparse.ArgumentParser(
        description="Parse Skill YAML and validate one-level local references."
    )
    parser.add_argument("skill_roots", nargs="+", type=Path)
    arguments = parser.parse_args()

    errors: list[str] = []
    skill_count = 0
    metadata_count = 0
    reference_count = 0
    for supplied_root in arguments.skill_roots:
        skill_collection = supplied_root.resolve()
        if not skill_collection.is_dir():
            errors.append(f"Skill root does not exist: {supplied_root}")
            continue
        for skill_file in sorted(skill_collection.glob("*/SKILL.md")):
            skill_delta, metadata_delta, reference_delta = validate_skill(skill_file, errors)
            skill_count += skill_delta
            metadata_count += metadata_delta
            reference_count += reference_delta

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1

    print(
        f"Validated {skill_count} Skill frontmatters, {metadata_count} agent metadata "
        f"files, and {reference_count} reference files."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
