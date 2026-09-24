#!/usr/bin/env node
/**
 * One-time rewrite helper: fill-style Optimist DNS ranks → max(sheet place)+1.
 *
 * Fill-style heuristic (safe):
 *   is_dns = true
 *   AND rank = regattas.total_fleet_size + 1
 *   AND boat_class is Optimist (or empty legacy)
 *
 * Official sheet DNS (e.g. rank 81 in fleet of 83) is NOT rewritten.
 *
 * Usage:
 *   node scripts/rewrite-fill-style-dns.mjs           # dry-run (default)
 *   node scripts/rewrite-fill-style-dns.mjs --apply   # UPDATE (requires confirm)
 *
 * Prefers DATABASE_URL; otherwise prints SQL for Supabase SQL editor.
 */
import postgres from "postgres";

const APPLY = process.argv.includes("--apply");
const PROJECT_HINT = "fdziuyexczkngvugvsbu";

const PREVIEW_SQL = `
WITH sheet_max AS (
  SELECT
    r.regatta_id,
    MAX(r.rank) FILTER (
      WHERE NOT (
        COALESCE(r.is_dns, false)
        AND r.rank = reg.total_fleet_size + 1
      )
    ) AS max_non_fill_rank
  FROM regatta_results r
  JOIN regattas reg ON reg.id = r.regatta_id
  WHERE COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
     OR COALESCE(reg.boat_class, '') = ''
  GROUP BY r.regatta_id
),
fill_rows AS (
  SELECT
    r.id,
    r.regatta_id,
    r.sailor_id,
    r.rank AS old_rank,
    reg.total_fleet_size,
    reg.name AS regatta_name,
    sm.max_non_fill_rank,
    CASE
      WHEN sm.max_non_fill_rank IS NULL THEN NULL
      ELSE sm.max_non_fill_rank + 1
    END AS new_rank
  FROM regatta_results r
  JOIN regattas reg ON reg.id = r.regatta_id
  LEFT JOIN sheet_max sm ON sm.regatta_id = r.regatta_id
  WHERE COALESCE(r.is_dns, false)
    AND r.rank = reg.total_fleet_size + 1
    AND (
      COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
      OR COALESCE(reg.boat_class, '') = ''
    )
)
SELECT * FROM fill_rows
ORDER BY regatta_name, old_rank;
`;

const COUNT_SQL = `
SELECT
  COUNT(*)::int AS fill_style_dns_rows,
  COUNT(DISTINCT r.regatta_id)::int AS fill_style_regattas,
  (
    SELECT COUNT(*)::int
    FROM regatta_results r2
    JOIN regattas reg2 ON reg2.id = r2.regatta_id
    WHERE COALESCE(r2.is_dns, false)
      AND r2.rank <> reg2.total_fleet_size + 1
      AND (
        COALESCE(reg2.boat_class, 'Optimist') ILIKE '%optimist%'
        OR COALESCE(reg2.boat_class, '') = ''
      )
  ) AS official_sheet_dns_rows_preserved
FROM regatta_results r
JOIN regattas reg ON reg.id = r.regatta_id
WHERE COALESCE(r.is_dns, false)
  AND r.rank = reg.total_fleet_size + 1
  AND (
    COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
    OR COALESCE(reg.boat_class, '') = ''
  );
`;

const UPDATE_SQL = `
WITH sheet_max AS (
  SELECT
    r.regatta_id,
    MAX(r.rank) FILTER (
      WHERE NOT (
        COALESCE(r.is_dns, false)
        AND r.rank = reg.total_fleet_size + 1
      )
    ) AS max_non_fill_rank
  FROM regatta_results r
  JOIN regattas reg ON reg.id = r.regatta_id
  WHERE COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
     OR COALESCE(reg.boat_class, '') = ''
  GROUP BY r.regatta_id
),
fill_rows AS (
  SELECT
    r.id,
    sm.max_non_fill_rank + 1 AS new_rank
  FROM regatta_results r
  JOIN regattas reg ON reg.id = r.regatta_id
  JOIN sheet_max sm ON sm.regatta_id = r.regatta_id
  WHERE COALESCE(r.is_dns, false)
    AND r.rank = reg.total_fleet_size + 1
    AND sm.max_non_fill_rank IS NOT NULL
    AND (
      COALESCE(reg.boat_class, 'Optimist') ILIKE '%optimist%'
      OR COALESCE(reg.boat_class, '') = ''
    )
)
UPDATE regatta_results rr
SET rank = fr.new_rank,
    updated_at = NOW()
FROM fill_rows fr
WHERE rr.id = fr.id
  AND rr.rank IS DISTINCT FROM fr.new_rank
RETURNING rr.id, rr.rank;
`;

async function main() {
  const url = process.env.DATABASE_URL || process.env.POSTGRES_URL;
  console.log("SailorPath Optimist fill-style DNS rewrite");
  console.log(`Mode: ${APPLY ? "APPLY" : "DRY-RUN"}`);
  console.log(`Supabase project hint: ${PROJECT_HINT}`);

  if (!url) {
    console.log("\nNo DATABASE_URL — printing SQL only.\n--- COUNT ---\n");
    console.log(COUNT_SQL);
    console.log("\n--- PREVIEW ---\n");
    console.log(PREVIEW_SQL);
    if (APPLY) {
      console.log("\n--- UPDATE (not executed) ---\n");
      console.log(UPDATE_SQL);
      console.log(
        "\nRefusing --apply without DATABASE_URL. Run COUNT/PREVIEW in Supabase first."
      );
      process.exit(2);
    }
    return;
  }

  const sql = postgres(url, { max: 1 });
  try {
    const counts = await sql.unsafe(COUNT_SQL);
    console.log("\nCounts:", counts[0]);
    const preview = await sql.unsafe(PREVIEW_SQL);
    console.log(`Preview rows: ${preview.length}`);
    for (const row of preview.slice(0, 30)) {
      console.log(
        `  ${row.regatta_name}: sailor ${row.sailor_id} ${row.old_rank} → ${row.new_rank}`
      );
    }
    if (preview.length > 30) console.log(`  … ${preview.length - 30} more`);

    if (!APPLY) {
      console.log(
        "\nDry-run only. Re-run with --apply after confirming preview."
      );
      return;
    }

    if (!process.env.REWRITE_DNS_CONFIRM) {
      console.error(
        "Refusing UPDATE: set REWRITE_DNS_CONFIRM=yes to apply production rewrite."
      );
      process.exit(3);
    }

    const updated = await sql.unsafe(UPDATE_SQL);
    console.log(`Updated ${updated.length} rows.`);
  } finally {
    await sql.end({ timeout: 5 });
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
