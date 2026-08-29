-- Coach-owned observations, development goals, and attendance history.
CREATE TABLE IF NOT EXISTS coach_development_records (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  coach_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  sailor_id uuid NOT NULL REFERENCES sailors(id) ON DELETE CASCADE,
  type text NOT NULL CHECK (type IN ('observation', 'goal', 'attendance')),
  category text,
  title text NOT NULL CHECK (char_length(btrim(title)) BETWEEN 1 AND 160),
  detail text CHECK (detail IS NULL OR char_length(detail) <= 4000),
  record_date date NOT NULL,
  status text NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed', 'present', 'absent', 'planned')),
  target_date date,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS coach_development_records_coach_sailor_date_idx
  ON coach_development_records (coach_id, sailor_id, record_date DESC);
CREATE INDEX IF NOT EXISTS coach_development_records_sailor_id_idx
  ON coach_development_records (sailor_id);
ALTER TABLE coach_development_records ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON coach_development_records FROM anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON coach_development_records TO authenticated;
CREATE POLICY coach_development_records_select_own ON coach_development_records FOR SELECT TO authenticated USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_development_records_insert_own ON coach_development_records FOR INSERT TO authenticated WITH CHECK ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_development_records_update_own ON coach_development_records FOR UPDATE TO authenticated USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id) WITH CHECK ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_development_records_delete_own ON coach_development_records FOR DELETE TO authenticated USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);

CREATE TABLE IF NOT EXISTS coach_action_reviews (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  coach_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  sailor_id uuid NOT NULL REFERENCES sailors(id) ON DELETE CASCADE,
  action_key text NOT NULL CHECK (char_length(action_key) BETWEEN 1 AND 240),
  status text NOT NULL CHECK (status IN ('reviewed', 'dismissed')),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT coach_action_reviews_coach_action_unq UNIQUE (coach_id, action_key)
);
CREATE INDEX IF NOT EXISTS coach_action_reviews_sailor_id_idx ON coach_action_reviews (sailor_id);
ALTER TABLE coach_action_reviews ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON coach_action_reviews FROM anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON coach_action_reviews TO authenticated;
CREATE POLICY coach_action_reviews_select_own ON coach_action_reviews FOR SELECT TO authenticated USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_action_reviews_insert_own ON coach_action_reviews FOR INSERT TO authenticated WITH CHECK ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_action_reviews_update_own ON coach_action_reviews FOR UPDATE TO authenticated USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id) WITH CHECK ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_action_reviews_delete_own ON coach_action_reviews FOR DELETE TO authenticated USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
