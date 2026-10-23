BEGIN;
CREATE TABLE public.support_deliveries (
 id uuid PRIMARY KEY,
 message_id uuid NOT NULL REFERENCES public.support_messages(id) ON DELETE CASCADE,
 kind text NOT NULL CHECK (kind IN ('acknowledgement','reply')),
 recipient text NOT NULL,
 reply_to text,
 subject text NOT NULL,
 body text NOT NULL,
 status text NOT NULL CHECK (status IN ('sending','sent','failed','skipped')),
 actor_user_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
 created_at timestamptz NOT NULL DEFAULT now(),
 updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX support_deliveries_message_idx ON public.support_deliveries(message_id,created_at);
CREATE INDEX support_deliveries_actor_idx ON public.support_deliveries(actor_user_id);
ALTER TABLE public.support_deliveries ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.support_deliveries FROM anon, authenticated;
COMMIT;
