# Official sailor headshot import — 21 October 2026

Source: Team Singapore's Sailing athlete directory, pages 1 and 2 (28 athletes).

20 portraits were matched to existing, unclaimed SailorPath profiles and published with the administrator's requested public display. The source pages and original URLs are in sources.json; reviewed assignments are in matched.json. before.json preserves the prior photo URLs and visibility settings. Each production update also has a private administration audit entry with its source, prior values, new values and matching basis.

18 profiles already had corresponding labelled Team Singapore URLs but their public-photo settings were false. Two additional matches use the corresponding abbreviated Singapore WindFoil identities: Elkan Oh / Elkan Reshawn Oh and Marsha Shahrin / Marsha Binte Shahrin. No profiles or results were merged, renamed or created. Ange Chew remains without a photo; Angel Chew and Angyal Chew have their own separate official portraits.

Eight directory entries were skipped: seven have no reliable existing profile match (Amanda Ng, Cecilia Low, Chia Teck Pin, David Ng Tiong Gee, Ellyn Tan Jiamin, Kimberly Lim Min and Maximilian Maeder); Jonathan Chan has no directory portrait.

Official 800-pixel-wide image renditions preserve proportions. The extracted assets are hosted by SailorPath, with provenance in docs/team-singapore-portraits.md. Avatar display uses a head-focused viewport; full-body and wider portraits have reviewed individual framing adjustments. Original facial appearance is preserved.

Validation: all 20 portraits visually reviewed in the final avatar framing gallery, all 20 production image URLs returned HTTP 200 with an image content type, and production data confirms 20 attached / 20 publicly displayed photo settings. Full production build passed. The public profile cache was refreshed so visitors receive the new images.

Final release commit: ec404247d3e7bf418a7f7ad6331e63718b18cdbb.
Production deployment: dpl_GnT5vYByBVaVheQmmrsUDSRvgCLq.

Deployment reached READY on sailorpath.com and admin.sailorpath.com. The live Angel Chew profile was visually checked with its clear, correctly assigned headshot.
