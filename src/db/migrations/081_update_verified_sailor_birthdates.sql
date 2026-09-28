-- DOB corrections transcribed from the supplied sailor roster screenshots.
-- Only rows whose screenshot value differs from the existing profile are updated.
update public.sailors
set dob = '2016-12-03', updated_at = now()
where name = 'Ashleigh Li Ying Teh'
  and sail_number = '788';

update public.sailors
set dob = '2016-09-21', updated_at = now()
where name = 'Moyan Han'
  and sail_number = '2042';

update public.sailors
set dob = '2015-04-02', updated_at = now()
where name = 'Yasin Yusuf Yusfianshah'
  and sail_number = '3575';
