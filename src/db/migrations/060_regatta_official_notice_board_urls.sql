-- 060_regatta_official_notice_board_urls.sql
-- Add Official Notice Board (ONB) and Notice of Race portal links to 2026, 2025, and 2024 Singapore regattas

-- ==========================================
-- 2026 REGATTAS
-- ==========================================

-- 1. Singapore National Sailing Championships (SNSC) 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/14487/event'
WHERE (
  (name ILIKE '%Singapore National Sailing Championship%' OR name ILIKE '%SNSC%')
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 2. SSF Selection Trials (Aug 2026)
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/200930'
WHERE (
  (name ILIKE '%SSF Selection Trials%' OR name ILIKE '%Selection Trials%')
  AND name NOT ILIKE '%HKRW%'
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 3. Pesta Sukan 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/14397/event'
WHERE (
  name ILIKE '%Pesta Sukan%'
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 4. Cincapura Regatta 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/14587/event'
WHERE (
  name ILIKE '%Cincapura%'
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 5. 2nd SAFYC Optimist Championships 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/14691/event'
WHERE (
  (name ILIKE '%2nd SAFYC Optimist%' OR (name ILIKE '%SAFYC%Optimist%' AND (name ILIKE '%Championship%' OR name ILIKE '%2nd%')) OR slug ILIKE '%2nd-safyc-optimist%')
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 6. Temasek Regatta 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/13596/event'
WHERE (
  name ILIKE '%Temasek%'
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 7. 22nd SAFYC Regatta 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/13551/event'
WHERE (
  (name ILIKE '%22nd SAFYC%' OR (name ILIKE '%SAFYC%' AND name NOT ILIKE '%Optimist Championship%') OR slug ILIKE '%22nd-safyc%')
  AND name NOT ILIKE '%Friendship%'
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
  AND nor_url IS DISTINCT FROM 'https://www.racingrulesofsailing.org/documents/14691/event'
);

-- 8. Singapore Youth Sailing Championship (SYSC) 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/178539'
WHERE (
  (name ILIKE '%Singapore Youth Sailing Championship%' OR name ILIKE '%SYSC%')
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 9. Pulau Ujong Regatta 2026
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event'
WHERE (
  name ILIKE '%Pulau Ujong%'
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 10. HKRW Optimist Selection Trials (Jan 2026)
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/170680'
WHERE (
  (name ILIKE '%HKRW%Selection%' OR name ILIKE '%HKRW%Trial%' OR name ILIKE '%Hong Kong Race Week%Selection%' OR slug ILIKE '%hkrw%selection%')
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);


-- ==========================================
-- 2025 REGATTAS
-- ==========================================

-- 11. Singapore National Sailing Championships (SNSC) 2025
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event'
WHERE (
  (name ILIKE '%Singapore National Sailing Championship%' OR name ILIKE '%SNSC%')
  AND (name ILIKE '%2025%' OR name ILIKE '%25%' OR slug ILIKE '%2025%' OR slug ILIKE '%25%' OR (date >= '2025-01-01' AND date <= '2025-12-31'))
);

-- 12. Pesta Sukan Regatta 2025
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/11535/event'
WHERE (
  name ILIKE '%Pesta Sukan%'
  AND (name ILIKE '%2025%' OR name ILIKE '%25%' OR slug ILIKE '%2025%' OR slug ILIKE '%25%' OR (date >= '2025-01-01' AND date <= '2025-12-31'))
);

-- 13. 1st SAFYC Optimist Championship 2025
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/11991/event'
WHERE (
  (name ILIKE '%1st SAFYC Optimist%' OR (name ILIKE '%SAFYC%Optimist%' AND (name ILIKE '%Championship%' OR name ILIKE '%1st%')) OR slug ILIKE '%1st-safyc-optimist%')
  AND (name ILIKE '%2025%' OR name ILIKE '%25%' OR slug ILIKE '%2025%' OR slug ILIKE '%25%' OR (date >= '2025-01-01' AND date <= '2025-12-31'))
);

-- 14. 33rd SEA Games Selection Trials 2025
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/146550'
WHERE (
  (name ILIKE '%SEA Games%' OR name ILIKE '%33rd SEA Games%')
  AND (name ILIKE '%2025%' OR name ILIKE '%25%' OR slug ILIKE '%2025%' OR slug ILIKE '%25%' OR (date >= '2025-01-01' AND date <= '2025-12-31'))
);

-- 15. 21st SAFYC Regatta 2025
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/10436/event'
WHERE (
  (name ILIKE '%21st SAFYC%' OR (name ILIKE '%SAFYC%' AND name NOT ILIKE '%Optimist Championship%') OR slug ILIKE '%21st-safyc%')
  AND name NOT ILIKE '%Friendship%'
  AND (name ILIKE '%2025%' OR name ILIKE '%25%' OR slug ILIKE '%2025%' OR slug ILIKE '%25%' OR (date >= '2025-01-01' AND date <= '2025-12-31'))
  AND nor_url IS DISTINCT FROM 'https://www.racingrulesofsailing.org/documents/11991/event'
);


-- ==========================================
-- 2024 REGATTAS
-- ==========================================

-- 16. Singapore National Sailing Championships (SNSC) 2024
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/9423/event'
WHERE (
  (name ILIKE '%Singapore National Sailing Championship%' OR name ILIKE '%SNSC%')
  AND (name ILIKE '%2024%' OR name ILIKE '%24%' OR slug ILIKE '%2024%' OR slug ILIKE '%24%' OR (date >= '2024-01-01' AND date <= '2024-12-31'))
);

-- 17. Pesta Sukan 2024
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/117102'
WHERE (
  name ILIKE '%Pesta Sukan%'
  AND (name ILIKE '%2024%' OR name ILIKE '%24%' OR slug ILIKE '%2024%' OR slug ILIKE '%24%' OR (date >= '2024-01-01' AND date <= '2024-12-31'))
);

-- 18. Friendship Regatta 2024 (SAFYC)
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/9131/event'
WHERE (
  (name ILIKE '%Friendship Regatta%' OR (name ILIKE '%Friendship%' AND name ILIKE '%SAFYC%') OR slug ILIKE '%friendship%')
  AND (name ILIKE '%2024%' OR name ILIKE '%24%' OR slug ILIKE '%2024%' OR slug ILIKE '%24%' OR (date >= '2024-01-01' AND date <= '2024-12-31'))
);

-- 19. 20th SAFYC Regatta 2024
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/8114/event'
WHERE (
  (name ILIKE '%20th SAFYC%' OR (name ILIKE '%SAFYC%' AND name NOT ILIKE '%Friendship%') OR slug ILIKE '%20th-safyc%')
  AND name NOT ILIKE '%Friendship%'
  AND (name ILIKE '%2024%' OR name ILIKE '%24%' OR slug ILIKE '%2024%' OR slug ILIKE '%24%' OR (date >= '2024-01-01' AND date <= '2024-12-31'))
  AND nor_url IS DISTINCT FROM 'https://www.racingrulesofsailing.org/documents/9131/event'
);

-- 20. Singapore Youth Sailing Championship (SYSC) 2024
UPDATE public.regattas
SET nor_url = 'https://www.racingrulesofsailing.org/documents/93647'
WHERE (
  (name ILIKE '%Singapore Youth Sailing Championship%' OR name ILIKE '%SYSC%')
  AND (name ILIKE '%2024%' OR name ILIKE '%24%' OR slug ILIKE '%2024%' OR slug ILIKE '%24%' OR (date >= '2024-01-01' AND date <= '2024-12-31'))
);
