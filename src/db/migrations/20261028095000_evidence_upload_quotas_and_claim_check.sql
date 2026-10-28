-- Require an approved sailor claim (or owned sailor profile / superadmin) and enforce
-- per-user aggregate storage quotas (50 files / 100 MB) for regatta evidence uploads.
BEGIN;

CREATE OR REPLACE FUNCTION private.can_upload_evidence_object(object_name text)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT
    private.can_manage_evidence_object(object_name)
    AND (
      EXISTS (
        SELECT 1
        FROM public.profiles p
        WHERE p.id = auth.uid()
          AND p.role = 'superadmin'
      )
      OR (
        (
          EXISTS (
            SELECT 1
            FROM public.sailors s
            WHERE s.parent_id = auth.uid()
          )
          OR EXISTS (
            SELECT 1
            FROM public.sailor_claims sc
            WHERE sc.requester_id = auth.uid()
              AND sc.status = 'approved'
          )
        )
        AND (
          SELECT count(*) < 50
            AND COALESCE(sum(NULLIF(o.metadata->>'size', '')::bigint), 0) < 104857600
          FROM storage.objects o
          WHERE o.bucket_id = 'regatta-evidence'
            AND split_part(o.name, '/', 1) = auth.uid()::text
        )
      )
    );
$$;

REVOKE ALL ON FUNCTION private.can_upload_evidence_object(text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION private.can_upload_evidence_object(text) TO authenticated, service_role;

DROP POLICY IF EXISTS "Regatta evidence authenticated upload" ON storage.objects;
CREATE POLICY "Regatta evidence authenticated upload"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'regatta-evidence'
    AND private.can_upload_evidence_object(name)
  );

COMMIT;
