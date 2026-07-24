-- Admin / data-quality audit trail (names allowed — superadmin only).
CREATE TABLE IF NOT EXISTS public.admin_change_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz NOT NULL DEFAULT now(),
  actor_user_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  actor_email text,
  action text NOT NULL,
  entity_type text NOT NULL,
  entity_id uuid,
  entity_label text,
  summary text NOT NULL,
  details jsonb,
  source text
);

CREATE INDEX IF NOT EXISTS admin_change_log_created_at_idx
  ON public.admin_change_log (created_at DESC);

CREATE INDEX IF NOT EXISTS admin_change_log_entity_idx
  ON public.admin_change_log (entity_type, entity_id);
