UPDATE public.sailors
SET nat_squad_status_jul_26 = 'Nat B',
    national_squad_status = 'Nat B',
    updated_at = now()
WHERE (
  trim(lower(name)) IN (lower('Jedd Lam Zhi Hao'), lower('Jedd Zhi Hao Lam'))
  OR handle IN ('jedd-lam-zhi-hao', 'jedd-zhi-hao-lam')
  OR (sail_number = '2000' AND trim(lower(club)) LIKE '%constant wind%')
);
