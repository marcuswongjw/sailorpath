# Asian Index birth-year verification

Verified 20 October 2026 on https://sailorpath.com/optimist/asian-index.

The Index previously used a checked-in profile list. It now derives birth years from current database DOBs server-side. Full DOBs are not returned to the page.

- All 175 live entries checked against the current database query: zero mismatches.
- 80 sailors have a birth year; 95 have no recorded DOB.
- 64 additional birth years now appear.
- The 2014 filter shows nine sailors.
- 13 relevant tests and targeted lint passed.

Production deployment: dpl_CpmGtipRveNMqKM4m2xxBSqpdCfo (READY).
Commit: b5ccec16de03a2c80bb6d3d604e036d026753f1b.
Source PR: https://github.com/marcuswongjw/sailorpath/pull/81 (open, ready for review).

The release changes only the DOB-derived year lookup, its tests, and the Index page integration. Scores and cohort membership are unchanged.
