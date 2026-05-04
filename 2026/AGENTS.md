# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Scope
This `AGENTS.md` applies to the `2026/` subtree only.
Use it as the primary long-term context when the working directory is `2026/`.

## What this folder contains
- `day-01` to `day-90`: one folder per day in the 2026 cohort.
- `README.md`: master index that maps day folders to topic progression.

## Core workflow
- Most tasks are markdown content edits in one or more `day-XX/README.md` files.
- If day titles/topic sequencing changes, update `README.md` in this folder to stay aligned.
- Keep edits scoped to requested day folders; avoid unrelated cross-day churn.

## Commands commonly used here
- Inspect current changes:
  - `git --no-pager status`
  - `git --no-pager diff -- 2026`
- Find day content quickly:
  - `rg "Day 0[1-9]|Day [1-9][0-9]" 2026`
  - `rg "Expected Output|Submission|Task" 2026/day-*/README.md`
- Optional structure repair from repo root:
  - `python scripts/generate_days.py`

## Content conventions to preserve
- Keep day documents practical and task-oriented.
- Preserve each day file’s “Task / Expected Output / Guidelines / Submission” structure when present.
- Respect repository contribution rule: no emojis in README files.

