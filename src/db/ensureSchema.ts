import { pgSql, resolveConnectionString } from "./client";
import { OPTIMIST_SAILOR_SAIL_NUMBERS } from "@/lib/optimistSailNumberMap";

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

      // 053_regatta_lifecycle_and_rls.sql: Store Singapore WingFoil regattas and lifecycle status
      try {
        await pgSql`
          CREATE TABLE IF NOT EXISTS public.wingfoil_regattas (
            id text PRIMARY KEY,
            status varchar(20) DEFAULT 'published' NOT NULL,
            data jsonb NOT NULL,
            updated_at timestamptz NOT NULL DEFAULT now()
          );
        `;
      } catch (e) {
        console.warn("[sailorpath] ensure wingfoil_regattas table note:", e);
      }

      try {
        await pgSql`
          ALTER TABLE public.wingfoil_regattas
            ADD COLUMN IF NOT EXISTS status varchar(20) DEFAULT 'published' NOT NULL;
        `;
      } catch (e) {
        console.warn("[sailorpath] wingfoil_regattas status column note:", e);
      }

      try {
        await pgSql`
          ALTER TABLE public.regattas
            ADD COLUMN IF NOT EXISTS status varchar(20) DEFAULT 'draft' NOT NULL;
        `;
      } catch (e) {
        console.warn("[sailorpath] regattas status column note:", e);
      }

      try {
        await pgSql`
          CREATE INDEX IF NOT EXISTS regattas_status_date_idx
            ON public.regattas (status, date DESC);
        `;
      } catch {}

      try {
        await pgSql`
          CREATE INDEX IF NOT EXISTS regattas_status_boat_class_date_idx
            ON public.regattas (status, boat_class, date DESC);
        `;
      } catch {}

      try {
        await pgSql`
          CREATE INDEX IF NOT EXISTS wingfoil_regattas_status_idx
            ON public.wingfoil_regattas (status);
        `;
      } catch {}

      // 054_optimist_sail_number_updates.sql: Self-heal missing Optimist sail numbers
      try {
        for (const item of OPTIMIST_SAILOR_SAIL_NUMBERS) {
          const cleanName = item.name.replace(/\.$/, "").trim().toLowerCase();
          await pgSql`
            UPDATE public.sailors
            SET sail_number = ${item.sailNumber},
                nationality = COALESCE(NULLIF(trim(nationality), ''), ${item.nationality}),
                updated_at = now()
            WHERE (trim(lower(name)) = ${item.name.toLowerCase()} OR trim(lower(name)) = ${cleanName})
              AND (
                sail_number IS NULL
                OR trim(sail_number) = ''
                OR sail_number ~* '^SGP[[:space:]]*0+$'
                OR sail_number = '0'
              );
          `;
        }
      } catch (e) {
        console.warn("[sailorpath] ensure Optimist sail numbers note:", e);
      }

      // 055_clean_optimist_sail_numbers.sql: Ensure all Optimist sail numbers only contain numbers
      try {
        await pgSql`
          UPDATE public.sailors
          SET nationality = CASE
                WHEN upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}')) = 'SIN' THEN 'SGP'
                WHEN upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}')) = 'SG' THEN 'SGP'
                ELSE upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}'))
              END,
              nationality_from_sail = true,
              updated_at = now()
          WHERE (nationality IS NULL OR trim(nationality) = '')
            AND trim(sail_number) ~* '^[A-Za-z]{2,3}';
        `;

        await pgSql`
          UPDATE public.sailors
          SET sail_number = CASE
                WHEN regexp_replace(trim(sail_number), '[^0-9]', '', 'g') = '' THEN '0'
                WHEN regexp_replace(trim(sail_number), '[^0-9]', '', 'g') ~ '^0+$' THEN '0'
                ELSE ltrim(regexp_replace(trim(sail_number), '[^0-9]', '', 'g'), '0')
              END,
              updated_at = now()
          WHERE sail_number ~ '[^0-9]'
             OR sail_number ~ '^0+[1-9]';
        `;
      } catch (e) {
        console.warn("[sailorpath] ensure clean Optimist sail numbers note:", e);
      }

      // 056_sw_monsoon_grand_prix_series.sql: Clean up legacy Southwest Monsoon placeholder
      try {
        await pgSql`
          DELETE FROM public.wingfoil_regattas WHERE id = 'sw-monsoon-gp-2026';
        `;
      } catch (e) {
        console.warn("[sailorpath] cleanup legacy sw-monsoon-gp-2026 note:", e);
      }

      schemaEnsured = true;
      console.info("[sailorpath] Core database schema verified & ensured.");
    } catch (e) {
      console.warn("[sailorpath] ensureCoreSchema attempt warning:", e);
      schemaPromise = null;
    }
  })();

  return schemaPromise;
}
