import { pgSql, resolveConnectionString } from "./client";

let schemaEnsured = false;
let schemaPromise: Promise<void> | null = null;

/**
 * Idempotent runtime schema verification and self-healing.
 * Ensures tables and columns added in recent migrations (e.g. 051 regatta calendar fields,
 * 044 official race results) exist in PostgreSQL before Drizzle executes queries that
 * reference them.
 */
export async function ensureCoreSchema(): Promise<void> {
  if (schemaEnsured) return;
  if (!resolveConnectionString()) return;
  if (schemaPromise) return schemaPromise;

  schemaPromise = (async () => {
    try {
      // 051_regatta_calendar_fields.sql: Add calendar event metadata to regattas
      await pgSql`
        ALTER TABLE public.regattas
          ADD COLUMN IF NOT EXISTS venue text,
          ADD COLUMN IF NOT EXISTS end_date date,
          ADD COLUMN IF NOT EXISTS nor_url text,
          ADD COLUMN IF NOT EXISTS registration_url text,
          ADD COLUMN IF NOT EXISTS is_selection_trial boolean DEFAULT false NOT NULL,
          ADD COLUMN IF NOT EXISTS organizer text,
          ADD COLUMN IF NOT EXISTS schedule_notes text;
      `;

      // 044_official_race_results.sql: Ensure official race results storage exists
      await pgSql`
        CREATE TABLE IF NOT EXISTS public.regatta_race_results (
          id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
          regatta_result_id uuid NOT NULL REFERENCES regatta_results(id) ON DELETE CASCADE,
          race_number integer NOT NULL CHECK (race_number > 0),
          score real NOT NULL,
          scoring_code text,
          discarded boolean NOT NULL DEFAULT false,
          raw_value text NOT NULL,
          created_at timestamptz NOT NULL DEFAULT now(),
          updated_at timestamptz NOT NULL DEFAULT now(),
          UNIQUE (regatta_result_id, race_number)
        );
      `;

      await pgSql`
        CREATE INDEX IF NOT EXISTS regatta_race_results_result_id_idx
          ON public.regatta_race_results (regatta_result_id);
      `;

      schemaEnsured = true;
      console.info("[sailorpath] Core database schema verified & ensured.");
    } catch (e) {
      console.warn("[sailorpath] ensureCoreSchema attempt warning:", e);
      schemaPromise = null;
    }
  })();

  return schemaPromise;
}
