---
name: submission-checker
description: Validate day-level learner submissions against the stated expected output and submission instructions in `2026/day-XX/README.md`. Use this when asked to review if a day task is complete or correctly formatted.
---

# Submission Checker

## Goal
Quickly verify whether a submission satisfies the day’s required output without expanding scope.

## Required approach
1. Read the target `2026/day-XX/README.md`.
2. Extract expected deliverables and naming constraints.
3. Compare expected outputs against actual files/changes.
4. Report only concrete pass/fail items and missing pieces.

## Output format
- `Matched requirements`
- `Missing or incorrect items`
- `Minimal next edits`

