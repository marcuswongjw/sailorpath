-- Official race-by-race scores imported from published regatta results.
-- Deliberately separate from race_observations, which are private sailor notes.
CREATE TABLE IF NOT EXISTS regatta_race_results (
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

CREATE INDEX IF NOT EXISTS regatta_race_results_result_id_idx
  ON regatta_race_results (regatta_result_id);
