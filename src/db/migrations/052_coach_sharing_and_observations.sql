-- 052_coach_sharing_and_observations.sql
-- Add visibility ('coach_only' | 'shared') and sentiment ('strength' | 'focus' | 'neutral') to coach_development_records
ALTER TABLE coach_development_records
  ADD COLUMN IF NOT EXISTS visibility text NOT NULL DEFAULT 'coach_only',
  ADD COLUMN IF NOT EXISTS sentiment text NOT NULL DEFAULT 'neutral';

-- Add visibility ('coach_only' | 'shared') to coach_sailor_notes
ALTER TABLE coach_sailor_notes
  ADD COLUMN IF NOT EXISTS visibility text NOT NULL DEFAULT 'coach_only';
