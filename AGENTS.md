# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository purpose
This repository is a curriculum/content repo for the `#90DaysOfDevOps` challenge, not a single deployable application.
Most changes are markdown content updates inside day/topic folders.

## Common commands
There is no repo-wide build, lint, or test pipeline configured in this repository (no `package.json`, `Makefile`, `pyproject.toml`, or CI test workflow).

Use these commands for the actual automation that exists:

- Generate/repair `2026/day-XX` folders and missing `README.md` files:
  - `python scripts/generate_days.py`
  - or `bash scripts/generate_days.sh`
- Inspect git changes before/after edits:
  - `git --no-pager status`
  - `git --no-pager diff`

Single-test command: not applicable at repository level (no centralized test suite).

## Contribution rules to preserve
From `CONTRIBUTING.md`:
- Make updates in the correct `2026/day-XX` folder for current cohort tasks.
- Keep filenames aligned with each day’s “Expected Output”.
- Keep content concise and practical.
- Do not use emojis in README files.

## High-level architecture
The repository is organized by cohort/year, with different content models:

- `2023/`: day-wise curriculum (`day01` … `day90`) with task READMEs and occasional supporting artifacts (`.yml`, `.py`, `.json`, etc.).
- `2024/`: similar day-wise structure, often with both `README.md` and `solution.md`.
- `2025/`: topic-based weekly folders (for example `linux/`, `docker/`, `terraform/`) each containing challenge guidance.
- `2026/`: current canonical cohort using `day-01` … `day-90`; `2026/README.md` is the master index and sequencing map.

Root navigation and governance files:
- `README.md`: challenge overview and participation model.
- `TOC.md`: broad topic progression, primarily mapped to the earlier day-wise structure.
- `CONTRIBUTING.md`: contribution constraints for submissions.

Automation and platform files:
- `scripts/generate_days.py`: idempotently scaffolds `2026/day-XX` directories and empty README placeholders.
- `.github/workflows/stale.yml`: stale issue/PR management only; no build/test checks are defined.

## Agent workflow in this repo
When asked to modify content, first identify the target cohort path (`2023/`, `2024/`, `2025/`, or `2026/`) because folder conventions differ.
For new current-challenge tasks, prefer `2026/day-XX/` and keep changes localized to requested day/topic folders.
