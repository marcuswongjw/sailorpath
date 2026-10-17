# Du Xiangyu — approved merge, 17 October 2026

The user directed Du Xingyu into Du Xiangyu. Retain `5a313b0a-c910-4c3a-bd06-1d11164c85cb` (`du-xiangyu`, current sail 3761) and consolidate `6675fa04-6e21-432c-8b01-de80baf28dfc`. The source spelling remains an alias and historical sail 2041 remains in the private audit. Nonblank survivor fields remain unchanged.

Production verification preserved all five results, 20 race rows and five participant links byte-for-byte except the intended sailor foreign key and update timestamps. The two profiles occupy different sheets, and identity/ownership checks passed. An account following both profiles retains one subscription; both original follow records and profiles are recorded in the private audit. No official score, discard, total, net or evidence link was replaced.

`merge.sql` is atomic and idempotent, locks both profiles, blocks conflicting identity/shared-sheet entries and active different-person decisions, and updates all 18 relationship types. Conflicts other than identical follow subscriptions roll back the transaction. `validate.mts` replays a private local snapshot and checks preservation, follow retention, rerun safety, and rejection of a shared-sheet conflict or confirmed-different decision. Private snapshots are excluded from Git.
