-- ILCA 4 display name corrections (preferred given-name order).
-- Old names are kept as aliases for import matching.

-- 1) Travis Yeo → Travis Jia Le Yeo
UPDATE public.sailors
SET name = 'Travis Jia Le Yeo', updated_at = now()
WHERE trim(name) = 'Travis Yeo';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
SELECT id, 'Travis Yeo'
FROM public.sailors
WHERE name = 'Travis Jia Le Yeo'
  AND NOT EXISTS (
    SELECT 1 FROM public.sailor_aliases a WHERE a.alias_name = 'Travis Yeo'
  )
ON CONFLICT (alias_name) DO NOTHING;

-- 2) Tan Reyes Jit Eng → Reyes Jit Eng Tan
UPDATE public.sailors
SET name = 'Reyes Jit Eng Tan', updated_at = now()
WHERE trim(name) = 'Tan Reyes Jit Eng';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
SELECT id, 'Tan Reyes Jit Eng'
FROM public.sailors
WHERE name = 'Reyes Jit Eng Tan'
  AND NOT EXISTS (
    SELECT 1 FROM public.sailor_aliases a WHERE a.alias_name = 'Tan Reyes Jit Eng'
  )
ON CONFLICT (alias_name) DO NOTHING;

-- 3) Regis Wong Xuan Kai → Wong Kai Lun
UPDATE public.sailors
SET name = 'Wong Kai Lun', updated_at = now()
WHERE trim(name) = 'Regis Wong Xuan Kai';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
SELECT id, 'Regis Wong Xuan Kai'
FROM public.sailors
WHERE name = 'Wong Kai Lun'
  AND NOT EXISTS (
    SELECT 1 FROM public.sailor_aliases a WHERE a.alias_name = 'Regis Wong Xuan Kai'
  )
ON CONFLICT (alias_name) DO NOTHING;
