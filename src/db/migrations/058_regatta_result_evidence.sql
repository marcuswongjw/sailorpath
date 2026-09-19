-- 058_regatta_result_evidence.sql: Regatta Result Evidence and Verification

-- 1. Add evidence and verification fields to regatta_results
ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS evidence_url text,
  ADD COLUMN IF NOT EXISTS evidence_name text,
  ADD COLUMN IF NOT EXISTS evidence_type varchar(20),
  ADD COLUMN IF NOT EXISTS official_url text,
  ADD COLUMN IF NOT EXISTS evidence_notes text,
  ADD COLUMN IF NOT EXISTS verification_status varchar(30) DEFAULT 'self_reported' NOT NULL,
  ADD COLUMN IF NOT EXISTS verified_at timestamptz,
  ADD COLUMN IF NOT EXISTS verified_by uuid REFERENCES public.profiles(id) ON DELETE SET NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'regatta_results_verification_status_check'
  ) THEN
    ALTER TABLE public.regatta_results
      ADD CONSTRAINT regatta_results_verification_status_check
      CHECK (verification_status IN ('self_reported', 'pending_review', 'verified', 'rejected'));
  END IF;
END $$;

-- 2. Performance indexes for athlete results & verification queues
CREATE INDEX IF NOT EXISTS regatta_results_verification_status_idx
  ON public.regatta_results (verification_status);

CREATE INDEX IF NOT EXISTS regatta_results_sailor_verification_idx
  ON public.regatta_results (sailor_id, verification_status);

-- 3. Storage bucket setup for regatta evidence (PDFs and photos)
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'storage') THEN
    INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
    VALUES (
      'regatta-evidence',
      'regatta-evidence',
      true,
      10485760, -- 10MB
      ARRAY['application/pdf', 'image/jpeg', 'image/png', 'image/webp']
    )
    ON CONFLICT (id) DO UPDATE SET
      public = true,
      file_size_limit = 10485760;

    -- Public read
    DROP POLICY IF EXISTS "Regatta evidence public read" ON storage.objects;
    CREATE POLICY "Regatta evidence public read"
      ON storage.objects FOR SELECT
      USING (bucket_id = 'regatta-evidence');

    -- Authenticated upload
    DROP POLICY IF EXISTS "Regatta evidence authenticated upload" ON storage.objects;
    CREATE POLICY "Regatta evidence authenticated upload"
      ON storage.objects FOR INSERT
      TO authenticated
      WITH CHECK (bucket_id = 'regatta-evidence');

    DROP POLICY IF EXISTS "Regatta evidence authenticated update" ON storage.objects;
    CREATE POLICY "Regatta evidence authenticated update"
      ON storage.objects FOR UPDATE
      TO authenticated
      USING (bucket_id = 'regatta-evidence');

    DROP POLICY IF EXISTS "Regatta evidence authenticated delete" ON storage.objects;
    CREATE POLICY "Regatta evidence authenticated delete"
      ON storage.objects FOR DELETE
      TO authenticated
      USING (bucket_id = 'regatta-evidence');
  END IF;
END $$;
