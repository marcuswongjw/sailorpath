-- Migration 148: Auto-approve pending claim on Chiang Zhiyi Aaron for eeleentay25@gmail.com

BEGIN;

UPDATE public.sailor_claims
SET status = 'approved',
    relation = 'parent',
    updated_at = NOW()
WHERE id = '03988c74-cb44-4a30-ab87-b773e34b1405';

UPDATE public.sailors
SET parent_id = '5b3c9380-4082-461f-9849-a5757646f4c2',
    owner_relation = 'parent',
    updated_at = NOW()
WHERE id = '165560d0-d029-4580-bc7e-5b7e46cd2b20';

UPDATE public.profiles
SET role = 'parent',
    updated_at = NOW()
WHERE id = '5b3c9380-4082-461f-9849-a5757646f4c2';

INSERT INTO public.admin_change_log (
  actor_user_id,
  actor_email,
  action,
  entity_type,
  entity_id,
  entity_label,
  summary,
  details,
  source
) VALUES (
  '5b3c9380-4082-461f-9849-a5757646f4c2',
  'eeleentay25@gmail.com',
  'claim.approve',
  'claim',
  '03988c74-cb44-4a30-ab87-b773e34b1405',
  'Chiang Zhiyi Aaron',
  'Approved parent claim on Chiang Zhiyi Aaron for eeleentay25@gmail.com',
  '{"sailorId": "165560d0-d029-4580-bc7e-5b7e46cd2b20", "requesterId": "5b3c9380-4082-461f-9849-a5757646f4c2", "relation": "parent", "status": "approved"}'::jsonb,
  'migration_148'
);

COMMIT;
