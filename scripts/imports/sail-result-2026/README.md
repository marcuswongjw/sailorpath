# Sail-Result 2026

**22 October user override (applied):** Optimist Newborn is excluded. Five sheets, 129 entries, 816 race scores and 36 exclusively Newborn profiles were removed. Do not recreate those sheets or profiles from the historical manifests. DOH VINNA is confirmed as Markus Doh Vinna; his held ILCA 4 result and 12 race scores have been attached. See `user-overrides.json` and `user-cleanup-20261022.sql`. Original manifest/SQL files are historical evidence, not the current desired state.

See [import report](../../../outputs/sail-result-2026/report.md).

Run the retained manifest validator before applying any SQL. Every sheet SQL is a standalone transaction, guarded against source/identity/count changes and conflicting existing sheets. Pending rows are intentionally excluded. Completing pending rows requires a new guarded follow-up transaction; replaying an unchanged transaction only verifies the existing import.

Raw downloaded sources and rendered pages: `.work/sail-result-2026/`. Source discovery, normalization, comparison and explicit identity decisions are retained here.

**Identity decisions applied 22 October:** Henry Atichat Wiedmann is Henry Wiedmann; Jiahe Liu is JiaHe Liu. Natidej Termtakulwattana is a separate sailor from Natidej Termwattanapakdee. Four held entries and 34 scores imported; 11 other entries remain pending. Retained follow-up manifests/SQL: `identity-resolutions-20261022/`.
