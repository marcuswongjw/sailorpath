#!/usr/bin/env node
/**
 * One-time rewrite helper for Optimist DNS stored ranks under the 2026-09-24
 * two-group national scoring model:
 *
 *   Group 1 (on sheet, is_dns):  started + 1
 *   Group 2 (never registered):  registered + 1  (live; prefer DELETE fill rows)
 *
 * Fill-style heuristic (old admin fill):
 *   is_dns = true AND rank = total_fleet_size + 1
 * Those rows make never-registered sailors look "on sheet" → wrong Group 1 score.
 * Dry-run recommends DELETE of fill-style rows; optionally UPDATE official sheet
 * DNS ranks to started+1 for display.
 *
 * Usage:
 *   node scripts/rewrite-fill-style-dns.mjs           # dry-run (default)
 *   node scripts/rewrite-fill-style-dns.mjs --apply   # requires REWRITE_DNS_CONFIRM=yes
 */
import postgres from "postgres";

const APPLY = process.argv.includes("--apply");
const PROJECT_HINT = "fdziuyexczkngvugvsbu";

const COUNT_SQL = `
WITH sheet AS (
  SELECT
    r.regatta_id,
    COUNT(*)::int AS registered,
    COUNT(*) FILTER (
      WHERE NOT COALESCE(r.is_dns, false)
        AND NOT COALESCE(r.is_overseas_commitment, false)
    )::int AS started
  FROM regatta_results r
  JOIN regattas reg ON reg.id = r.regatta_id
  WHERE COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
     OR COALESCE(reg.boat_class, '') = ''
  GROUP BY r.regatta_id
)
SELECT
  COUNT(*) FILTER (
    WHERE COALESCE(r.is_dns, false)
      AND r.rank = reg.total_fleet_size + 1
  )::int AS fill_style_rows_recommend_delete,
  COUNT(DISTINCT r.regatta_id) FILTER (
    WHERE COALESCE(r.is_dns, false)
      AND r.rank = reg.total_fleet_size + 1
  )::int AS fill_style_regattas,
  COUNT(*) FILTER (
    WHERE COALESCE(r.is_dns, false)
      AND NOT COALESCE(r.is_overseas_commitment, false)
      AND r.rank IS DISTINCT FROM (s.started + 1)
      AND NOT (r.rank = reg.total_fleet_size + 1)
  )::int AS official_dns_rows_rank_ne_started_plus_1,
  COUNT(*) FILTER (
    WHERE COALESCE(r.is_dns, false)
      AND NOT COALESCE(r.is_overseas_commitment, false)
      AND NOT (r.rank = reg.total_fleet_size + 1)
  )::int AS official_sheet_dns_rows
FROM regatta_results r
JOIN regattas reg ON reg.id = r.regatta_id
LEFT JOIN sheet s ON s.regatta_id = r.regatta_id
WHERE COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
   OR COALESCE(reg.boat_class, '') = '';
`;

const PREVIEW_FILL_SQL = `
WITH sheet AS (
  SELECT
    r.regatta_id,
    COUNT(*)::int AS registered,
    COUNT(*) FILTER (
      WHERE NOT COALESCE(r.is_dns, false)
        AND NOT COALESCE(r.is_overseas_commitment, false)
    )::int AS started
  FROM regatta_results r
  JOIN regattas reg ON reg.id = r.regatta_id
  WHERE COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
     OR COALESCE(reg.boat_class, '') = ''
  GROUP BY r.regatta_id
)
SELECT
  r.id,
  reg.name AS regatta_name,
  r.sailor_id,
  r.rank AS old_rank,
  reg.total_fleet_size,
  s.registered,
  s.started,
  s.registered + 1 AS group2_score_if_deleted,
  s.started + 1 AS group1_score_if_kept_as_onsheet_dns,
  'DELETE fill-style row (prefer Group 2 live score)' AS recommended_action
FROM regatta_results r
JOIN regattas reg ON reg.id = r.regatta_id
JOIN sheet s ON s.regatta_id = r.regatta_id
WHERE COALESCE(r.is_dns, false)
  AND r.rank = reg.total_fleet_size + 1
  AND (
    COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
    OR COALESCE(reg.boat_class, '') = ''
  )
ORDER BY reg.name, r.rank
LIMIT 100;
`;

const PREVIEW_OFFICIAL_SQL = `
WITH sheet AS (
  SELECT
    r.regatta_id,
    COUNT(*)::int AS registered,
    COUNT(*) FILTER (
      WHERE NOT COALESCE(r.is_dns, false)
        AND NOT COALESCE(r.is_overseas_commitment, false)
    )::int AS started
  FROM regatta_results r
  JOIN regattas reg ON reg.id = r.regatta_id
  WHERE COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
     OR COALESCE(reg.boat_class, '') = ''
  GROUP BY r.regatta_id
)
SELECT
  r.id,
  reg.name AS regatta_name,
  r.sailor_id,
  r.rank AS old_rank,
  s.started + 1 AS new_rank_group1,
  s.registered,
  s.started
FROM regatta_results r
JOIN regattas reg ON reg.id = r.regatta_id
JOIN sheet s ON s.regatta_id = r.regatta_id
WHERE COALESCE(r.is_dns, false)
  AND NOT COALESCE(r.is_overseas_commitment, false)
  AND r.rank IS DISTINCT FROM (s.started + 1)
  AND NOT (r.rank = reg.total_fleet_size + 1)
  AND (
    COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
    OR COALESCE(reg.boat_class, '') = ''
  )
ORDER BY reg.name
LIMIT 100;
`;

const DELETE_FILL_SQL = `
DELETE FROM regatta_results r
USING regattas reg
WHERE r.regatta_id = reg.id
  AND COALESCE(r.is_dns, false)
  AND r.rank = reg.total_fleet_size + 1
  AND (
    COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
    OR COALESCE(reg.boat_class, '') = ''
  )
RETURNING r.id;
`;

async function main() {
  const url = process.env.DATABASE_URL || process.env.POSTGRES_URL;
  console.log("Optimist DNS rewrite (Group1=started+1, Group2=registered+1)");
  console.log(`Mode: ${APPLY ? "APPLY" : "DRY-RUN"}`);
  console.log(`Supabase project hint: ${PROJECT_HINT}`);

  if (!url) {
    console.log("\\nNo DATABASE_URL — printing SQL only.\\n--- COUNT ---\\n");
    console.log(COUNT_SQL);
    console.log("\\n--- PREVIEW FILL (delete candidates) ---\\n");
    console.log(PREVIEW_FILL_SQL);
    console.log("\\n--- PREVIEW OFFICIAL DNS (optional update to started+1) ---\\n");
    console.log(PREVIEW_OFFICIAL_SQL);
    if (APPLY) {
      console.log("\\nRefusing --apply without DATABASE_URL.");
      process.exit(2);
    }
    return;
  }

  const sql = postgres(url, { max: 1 });
  try {
    const counts = await sql.unsafe(COUNT_SQL);
    console.log("\\nCounts:", counts[0]);
    const fill = await sql.unsafe(PREVIEW_FILL_SQL);
    console.log(`Fill-style delete candidates (sample): ${fill.length}`);
    for (const row of fill.slice(0, 20)) {
      console.log(
        `  ${row.regatta_name}: ${row.old_rank} → DELETE (Group2 live=${row.group2_score_if_deleted})`
      );
    }
    const official = await sql.unsafe(PREVIEW_OFFICIAL_SQL);
    console.log(
      `Official DNS rows with rank ≠ started+1 (sample): ${official.length}`
    );
    for (const row of official.slice(0, 20)) {
      console.log(
        `  ${row.regatta_name}: ${row.old_rank} → ${row.new_rank_group1}`
      );
    }
    if (!APPLY) {
      console.log("\\nDry-run only. Re-run with --apply after confirming.");
      return;
    }
    if (process.env.REWRITE_DNS_CONFIRM !== "yes") {
      console.error("Set REWRITE_DNS_CONFIRM=yes to apply.");
      process.exit(3);
    }
    const deleted = await sql.unsafe(DELETE_FILL_SQL);
    console.log(`Deleted ${deleted.length} fill-style rows.`);
  } finally {
    await sql.end({ timeout: 5 });
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
