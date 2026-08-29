-- Coach-only athlete notes. These are never part of the public sailor profile.
CREATE TABLE IF NOT EXISTS coach_sailor_notes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  coach_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  sailor_id uuid NOT NULL REFERENCES sailors(id) ON DELETE CASCADE,
  note text NOT NULL CHECK (char_length(note) BETWEEN 1 AND 4000),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT coach_sailor_notes_coach_sailor_unq UNIQUE (coach_id, sailor_id)
);

CREATE INDEX IF NOT EXISTS coach_sailor_notes_sailor_id_idx
  ON coach_sailor_notes (sailor_id);

ALTER TABLE coach_sailor_notes ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON coach_sailor_notes FROM anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON coach_sailor_notes TO authenticated;

CREATE POLICY coach_sailor_notes_select_own ON coach_sailor_notes
  FOR SELECT TO authenticated USING ((select auth.uid()) = coach_id);
CREATE POLICY coach_sailor_notes_insert_own ON coach_sailor_notes
  FOR INSERT TO authenticated WITH CHECK ((select auth.uid()) = coach_id);
CREATE POLICY coach_sailor_notes_update_own ON coach_sailor_notes
  FOR UPDATE TO authenticated
  USING ((select auth.uid()) = coach_id)
  WITH CHECK ((select auth.uid()) = coach_id);
CREATE POLICY coach_sailor_notes_delete_own ON coach_sailor_notes
  FOR DELETE TO authenticated USING ((select auth.uid()) = coach_id);
