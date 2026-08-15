-- When an Auth user is deleted in Supabase, also remove public.profiles.
-- That sets sailors.parent_id → NULL (ON DELETE SET NULL) so the athlete
-- is unclaimed, and cascades sailor_claims for that requester.
--
-- Previously only handle_new_user() ran on INSERT — DELETE left orphan
-- profiles + parent_id, so profiles still showed as "Claimed / Verified".

CREATE OR REPLACE FUNCTION public.handle_auth_user_deleted()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  DELETE FROM public.profiles WHERE id = OLD.id;
  RETURN OLD;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_deleted ON auth.users;
CREATE TRIGGER on_auth_user_deleted
  AFTER DELETE ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_auth_user_deleted();

-- One-time cleanup: unclaim sailors whose owner no longer exists in Auth
UPDATE public.sailors s
SET
  parent_id = NULL,
  updated_at = now()
WHERE s.parent_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM auth.users u WHERE u.id = s.parent_id
  );

-- Remove orphan profile rows (no matching auth.users).
-- Cascades: sailor_claims.requester_id; SET NULL: sailors.parent_id, support, etc.
DELETE FROM public.profiles p
WHERE NOT EXISTS (
  SELECT 1 FROM auth.users u WHERE u.id = p.id
);
