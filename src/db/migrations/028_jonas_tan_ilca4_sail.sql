-- Jonas Tan Kia Jeng: set ILCA 4 sail number 197840.
-- If a duplicate "Jonas Tan Yi Jun" still exists, merge via admin
-- (Apply ILCA sailor fixes) or /api/admin/sailors action applyIlcaSailorFixes.

UPDATE public.sailors
SET sail_number_ilca4 = '197840', updated_at = now()
WHERE trim(name) = 'Jonas Tan Kia Jeng'
  AND (
    sail_number_ilca4 IS NULL
    OR trim(sail_number_ilca4) = ''
    OR trim(sail_number_ilca4) <> '197840'
  );

-- Alias for import matching if Yi Jun name was used on results
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
SELECT id, 'Jonas Tan Yi Jun'
FROM public.sailors
WHERE name = 'Jonas Tan Kia Jeng'
  AND NOT EXISTS (
    SELECT 1 FROM public.sailor_aliases a WHERE a.alias_name = 'Jonas Tan Yi Jun'
  )
ON CONFLICT (alias_name) DO NOTHING;
