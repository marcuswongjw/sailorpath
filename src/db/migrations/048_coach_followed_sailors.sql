-- Private coach watchlist, deliberately separate from active squad membership.
CREATE TABLE IF NOT EXISTS coach_followed_sailors (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  coach_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  sailor_id uuid NOT NULL REFERENCES sailors(id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT coach_followed_sailors_coach_sailor_unq UNIQUE (coach_id, sailor_id)
);

CREATE INDEX IF NOT EXISTS coach_followed_sailors_sailor_id_idx
  ON coach_followed_sailors (sailor_id);

ALTER TABLE coach_followed_sailors ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON coach_followed_sailors FROM anon, authenticated;
GRANT SELECT, INSERT, DELETE ON coach_followed_sailors TO authenticated;

CREATE POLICY coach_followed_sailors_select_own ON coach_followed_sailors
  FOR SELECT TO authenticated
  USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_followed_sailors_insert_own ON coach_followed_sailors
  FOR INSERT TO authenticated
  WITH CHECK ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
CREATE POLICY coach_followed_sailors_delete_own ON coach_followed_sailors
  FOR DELETE TO authenticated
  USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = coach_id);
