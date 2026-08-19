-- Admin product changelog unread watermark (per profile).
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS last_seen_product_changelog_at timestamptz;
