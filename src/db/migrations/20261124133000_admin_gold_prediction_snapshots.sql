-- Admin-only snapshots of Optimist Gold form & 30 Jun 2027 National Ranking predictions
-- Used to freeze baseline predictions (e.g. Nov 2026) and evaluate accuracy on 30 Jun 2027.

CREATE TABLE IF NOT EXISTS public.admin_gold_prediction_snapshots (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  label text NOT NULL,
  baseline_date date NOT NULL,
  target_date date NOT NULL DEFAULT '2027-06-30',
  scope text NOT NULL DEFAULT 'sg_ranking',
  summary jsonb NOT NULL,
  created_by uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS admin_gold_prediction_snapshots_created_at_idx
  ON public.admin_gold_prediction_snapshots (created_at DESC);

ALTER TABLE public.admin_gold_prediction_snapshots ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Superadmins manage gold prediction snapshots"
  ON public.admin_gold_prediction_snapshots;
CREATE POLICY "Superadmins manage gold prediction snapshots"
  ON public.admin_gold_prediction_snapshots
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND p.role = 'superadmin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND p.role = 'superadmin'
    )
  );
