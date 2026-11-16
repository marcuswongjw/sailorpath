import "server-only";

import { sql } from "drizzle-orm";
import { db, withDatabaseRetry } from "@/db";

type IndexBirthYearEntry = {
  identityKey: string;
  name: string;
  nationality: string;
  profileHref: string | null;
  birthYear: number | null;
};

/**
 * Read current profile birth years without selecting or returning full DOBs.
 * Confirmed Index links take precedence over saved handles. A unique exact
 * name/NOC match recovers a handle that changed after an established merge.
 * Scores, cohort membership and profile presentation remain unchanged.
 */
export async function withAsianOptimistIndexBirthYears<T extends IndexBirthYearEntry>(
  entries: readonly T[]
): Promise<T[]> {
  if (!entries.length) return [];
  const inputs = entries.map((entry) => ({
    identity_key: entry.identityKey.toLowerCase(),
    normalized_name: entry.name.toLowerCase().replace(/[^a-z0-9]/g, ""),
    nationality: entry.nationality.toUpperCase(),
    handle: entry.profileHref?.replace(/^\/sailors\//, "").replace(/^\//, "") ?? "",
  }));

  try {
    const result = await withDatabaseRetry(
      () => db.execute<{ identityKey: string; birthYear: number | null }>(sql`
        with input as (
          select * from jsonb_to_recordset(${JSON.stringify(inputs)}::jsonb)
          as i(identity_key text, normalized_name text, nationality text, handle text)
        ), exact_names as (
          select i.identity_key, min(s.id::text)::uuid as sailor_id
          from input i join sailors s
            on regexp_replace(lower(s.name), '[^a-z0-9]', '', 'g') = i.normalized_name
            and upper(s.nationality) = i.nationality
          group by i.identity_key
          having count(*) = 1
        )
        select i.identity_key as "identityKey",
          extract(year from current_profile.dob)::integer as "birthYear"
        from input i
        left join asian_optimist_index_sailors ix
          on ix.identity_key = i.identity_key and ix.match_status = 'matched'
        left join sailors confirmed on confirmed.id = ix.sailor_id
        left join sailors saved on saved.handle = i.handle
        left join exact_names names on names.identity_key = i.identity_key
        left join sailors current_profile
          on current_profile.id = coalesce(confirmed.id, saved.id, names.sailor_id)
      `),
      { timeoutMs: 3_000, label: "asian-index.birth-years" }
    );
    const years = new Map(result.rows.map((row) => [row.identityKey, row.birthYear]));
    return entries.map((entry) => {
      const year = years.get(entry.identityKey.toLowerCase());
      return {
        ...entry,
        birthYear: typeof year === "number" && Number.isInteger(year) && year >= 1900 && year <= 2100
          ? year
          : null,
      };
    });
  } catch {
    // Keep the standings available during a temporary database outage.
    console.warn("[asian-index] Current birth-year lookup unavailable");
    return [...entries];
  }
}
