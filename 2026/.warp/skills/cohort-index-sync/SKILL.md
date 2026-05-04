---
name: cohort-index-sync
description: Keep `2026/README.md` synchronized with day folder content and ordering. Use this whenever day topics are changed, renamed, reordered, or newly added and the cohort index may become stale.
---

# Cohort Index Sync

## Goal
Ensure `2026/README.md` remains the authoritative table-of-contents for day topics and references.

## Required approach
1. Read `2026/README.md` and the affected `2026/day-XX/README.md` files.
2. Identify mismatches in day title, grouping, ordering, or links.
3. Update only the impacted sections in `2026/README.md`.
4. Preserve existing style and heading hierarchy.

## Validation checklist
- Each referenced day exists in `2026/day-XX/`.
- Link format remains relative and valid.
- Day title in index reflects the target day README title/topic.

