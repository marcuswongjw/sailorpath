-- Migration 189: Attach Mikaela Wong's latest uploaded PNG and verified public portraits for the 5 inaugural X-15 World Champions.

BEGIN;

-- 1. Mikaela Hui Ting Wong: attach her latest uploaded avatar PNG from Supabase Storage
UPDATE public.sailors
SET avatar_url = 'https://fdziuyexczkngvugvsbu.supabase.co/storage/v1/object/public/avatars/7bead077-410f-4f39-9d90-16664ae8e81c/1794359620982.png',
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = '7bead077-410f-4f39-9d90-16664ae8e81c';

-- 2. X-15 World Champions (Ibiza 2026): attach verified public athlete portraits & Instagram handles
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/kamil-manowiecki.jpg',
    instagram = coalesce(nullif(trim(instagram), ''), 'kamil_manowiecki'),
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = 'd63c8fb8-c610-52f3-aa60-fd59da54f3b8';

UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/jette-koep.jpg',
    instagram = coalesce(nullif(trim(instagram), ''), 'jette_ko'),
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = 'f72c0494-bba8-54be-9326-615785ba54d3';

UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/holland-vierling.jpg',
    instagram = coalesce(nullif(trim(instagram), ''), 'hollandthefoiler'),
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = '9643a3c3-c78d-52b0-8ad2-84a1f359cb38';

UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/yana-li.jpg',
    instagram = coalesce(nullif(trim(instagram), ''), 'li_ioanna1'),
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = 'e5d5e06e-8ad3-5a45-91a7-1b80eca34f37';

UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/benjamin-almeida.jpg',
    instagram = coalesce(nullif(trim(instagram), ''), 'benja_.wingg'),
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = '6f327ee4-03ca-5f58-b99c-882df0deba2a';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES
(
  'sailors.profile_photo_enrichment',
  'sailor',
  '7bead077-410f-4f39-9d90-16664ae8e81c',
  'Mikaela Hui Ting Wong — Attach Uploaded PNG',
  'Attached latest uploaded Storage PNG (1794359620982.png) to Mikaela Hui Ting Wong profile.',
  jsonb_build_object('storage_object', '7bead077-410f-4f39-9d90-16664ae8e81c/1794359620982.png'),
  'migration_189',
  clock_timestamp()
),
(
  'sailors.profile_photo_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'X-15 World Champions Portraits — Migration 189',
  'Attached verified public athlete portraits and Instagram handles for the 5 2026 X-15 World Champions (Kamil Manowiecki, Jette Koep, Holland Vierling, Yana Li, Benjamin Almeida).',
  jsonb_build_object(
    'champions', jsonb_build_array(
      'kamil-manowiecki.jpg (wingfoilworldtour.com)',
      'jette-koep.jpg (wingdaily.de / @jette_ko)',
      'holland-vierling.jpg (axisfoils.com / @hollandthefoiler)',
      'yana-li.jpg (mysailing.com.au / IWSA Media Robert Hajduk)',
      'benjamin-almeida.jpg (sueltalabarra.com / @benja_.wingg)'
    )
  ),
  'migration_189',
  clock_timestamp()
);

COMMIT;
