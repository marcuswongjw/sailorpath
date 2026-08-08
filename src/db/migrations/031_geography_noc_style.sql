-- Store regatta geography as NOC-style codes (SGP not SG), matching nationality.
-- Maps common ISO2 values; leaves already-correct 3-letter codes alone.

UPDATE public.regattas
SET geography = CASE upper(trim(geography))
  WHEN 'SG' THEN 'SGP'
  WHEN 'MY' THEN 'MAS'
  WHEN 'ID' THEN 'INA'
  WHEN 'TH' THEN 'THA'
  WHEN 'PH' THEN 'PHI'
  WHEN 'VN' THEN 'VIE'
  WHEN 'CN' THEN 'CHN'
  WHEN 'HK' THEN 'HKG'
  WHEN 'TW' THEN 'TPE'
  WHEN 'JP' THEN 'JPN'
  WHEN 'KR' THEN 'KOR'
  WHEN 'AU' THEN 'AUS'
  WHEN 'NZ' THEN 'NZL'
  WHEN 'US' THEN 'USA'
  WHEN 'GB' THEN 'GBR'
  WHEN 'DE' THEN 'GER'
  WHEN 'FR' THEN 'FRA'
  WHEN 'IT' THEN 'ITA'
  WHEN 'ES' THEN 'ESP'
  WHEN 'NL' THEN 'NED'
  WHEN 'BE' THEN 'BEL'
  WHEN 'CH' THEN 'SUI'
  WHEN 'AT' THEN 'AUT'
  WHEN 'SE' THEN 'SWE'
  WHEN 'NO' THEN 'NOR'
  WHEN 'DK' THEN 'DEN'
  WHEN 'FI' THEN 'FIN'
  WHEN 'PL' THEN 'POL'
  WHEN 'BR' THEN 'BRA'
  WHEN 'AR' THEN 'ARG'
  WHEN 'CA' THEN 'CAN'
  WHEN 'ZA' THEN 'RSA'
  WHEN 'IN' THEN 'IND'
  ELSE upper(trim(geography))
END
WHERE geography IS NOT NULL
  AND length(trim(geography)) = 2;

-- Default for any empty geography
UPDATE public.regattas
SET geography = 'SGP'
WHERE geography IS NULL OR trim(geography) = '';
