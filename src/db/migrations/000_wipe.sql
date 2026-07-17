-- DESTRUCTIVE — run in Supabase SQL Editor before 001_init.sql
-- Does NOT delete auth.users (use Authentication → Users to remove accounts)

DROP TABLE IF EXISTS public.equipment_logs CASCADE;
DROP TABLE IF EXISTS public.coaching_relationships CASCADE;
DROP TABLE IF EXISTS public.sailor_aliases CASCADE;
DROP TABLE IF EXISTS public.regatta_results CASCADE;
DROP TABLE IF EXISTS public.sailor_boat_class CASCADE;
DROP TABLE IF EXISTS public.regattas CASCADE;
DROP TABLE IF EXISTS public.boat_classes CASCADE;
DROP TABLE IF EXISTS public.sailors CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;
