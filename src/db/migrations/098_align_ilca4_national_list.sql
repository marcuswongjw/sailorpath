-- Align sailors.ilca4_national_list with the SSF ILCA 4 national ranking
-- (https://sites.google.com/singaporesailing.org.sg/ranking/classes/ilca4),
-- 81 sailors as published on 2026-10-02.
--
-- Turns the flag on for ranking sailors who were missing, and off for
-- sailors who are no longer on that list. Matched by current display name
-- where the published name is shorter than the profile (Chinese given names)
-- or the profile already holds that sailor's ILCA results.

UPDATE public.sailors
SET ilca4_national_list = false, updated_at = now()
WHERE ilca4_national_list = true
  AND lower(trim(name)) IN (
    'goh siak yiak ian',
    'jun jie chen',
    'tan yi kai kayden'
  );

UPDATE public.sailors
SET ilca4_national_list = true, updated_at = now()
WHERE ilca4_national_list = false
  AND lower(trim(name)) IN (
    'shin lin chen rui',
    'lyric li yuxuan',
    'ethan lee',
    'jared soon kit liew',
    'daniel kocourek',
    'qiyou wu',
    'chengwei zhao',
    'wenxin ji',
    'febe wong qi ke',
    'aaron chan kal en'
  );
