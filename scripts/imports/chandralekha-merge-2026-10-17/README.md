# Chandralekha Tattari — confirmed merge, 17 October 2026

The user confirmed the two profiles represent the same sailor and the current sail is IND 1711. Retain historical profile `c766be2b-32b7-4e38-9f7f-d31332e58c80` (`chandralekha-tattari-fg1jg3a`) and merge Index-only profile `9a81d511-ade5-428c-b79f-1d6e13977120`.

Production verification preserved the one regatta entry, all 11 individual race rows, participant source link and the original Asian Index source result. The Index’s historical IND1712 entry remains unchanged, and its profile association now points to the retained sailor. Current profile sail is IND 1711; nationality IND and gender F fill previously empty values. Both before-profiles and the user’s confirmation are retained in the private admin audit. No ownership override or shared-sheet result selection was used.

`merge.sql` is transactional and idempotent, checks identity/shared-sheet conflicts and saved different-sailor decisions before writing, repoints all 18 direct relationship types, and guards result/race/evidence preservation with before/after comparisons. Local PostgreSQL-compatible replay and negative checks passed. Private snapshots are stored outside the committed files.

The public Index fallback handle is also updated so it cannot point to the removed profile during a database outage. Official source names, sail numbers and scores remain unchanged.
