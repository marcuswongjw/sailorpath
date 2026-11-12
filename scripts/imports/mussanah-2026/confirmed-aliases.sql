-- Individually corroborated variants only. No profile merges or result edits.
BEGIN;
DO $review$
DECLARE
  item record;
  target uuid;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtext('mussanah-2026-confirmed-aliases'));
  FOR item IN SELECT * FROM (VALUES
    ('ad45bec2-2ef9-44c6-8ac9-e440c71bcb97'::uuid,'Hood Al Nofli','Hood Saad Al Nofli','2025 Admiral Cup source identifies HOOD SAAD LAHAQ AL ABD ALNOFLI and OMA 320; 2025 GCC list names Hood Saad Al Nofli OMA 320.','https://www.racingrulesofsailing.org/documents/10212/event'),
    ('09429d47-67b4-4953-b50c-c5da84fed18c'::uuid,'Tarteel Al Hasani','Tarteel Zaid Al Hasani','2025 Admiral Cup source identifies TARTEEL ZAID AL-ABD AEDULLAH AL-HASANI and OMA 311, and prior evidence on this profile records that sail.','https://www.racingrulesofsailing.org/documents/10212/event'),
    ('c522825b-efc4-47f6-8a48-a3becbf051e7'::uuid,'Hadeel Al Mushaifri','Hadeel Yousuf Almushaifri','2025 Admiral Cup source identifies HADEEL YOUSUF JAMIL THUNAI AL MUSHAIFRI and OMA 313, and prior evidence on this profile records that sail.','https://www.racingrulesofsailing.org/documents/10212/event'),
    ('f8ae9c66-c9e2-4aef-b63f-27cc8faa0644'::uuid,'Khalid Al Sarihi','Khaled Yahya Al Sarihi','Oman Sail Worlds team announcement identifies Khalid bin Yahya al Sarihi; the only Al Sarihi in the five-person Omani Worlds results is this profile.','https://www.omanobserver.om/ampArticle/1191383'),
    ('d03104ca-65f4-4d11-9c0c-cfee015642bf'::uuid,'Mohammed Al Balushi','Mohammed Suleiman Al balushi','Oman Sail Worlds team announcement distinguishes Mohammed bin Sulaiman from Mohammed bin Nabel; the official Worlds sheet has one Mohammed Al-Balushi and a separate Mohammed Nabil Al-Balushi.','https://www.omanobserver.om/ampArticle/1191383'),
    ('baa12d8d-ecc6-55a1-9787-ed9b00843eba'::uuid,'Mohammed Nabil Al-Balushi','Mohamed Nabeel Al Baloshi','Oman Sail Worlds team announcement identifies Mohammed bin Nabel al Balushi; the 2026 official Worlds sheet distinguishes his entry from Mohammed Al-Balushi.','https://www.omanobserver.om/ampArticle/1191383'),
    ('de2db5b8-1479-525b-a0ea-a7abd20a5f22'::uuid,'Mohammed Al-Qartoubi','Mohammed Said Al Qurtubi','Oman Sail Worlds team announcement identifies Mohammed bin Saeed al Qartoubi; he is the only Qartoubi in the five-person Omani Worlds result.','https://www.omanobserver.om/ampArticle/1191383'),
    ('e6c8df5b-331a-5bac-9140-a5dbaca79d5e'::uuid,'Saleh Almethen','Salah Almedhen','Arab Sailing Championship 2026 entry names KUW sailor Saleh Almethen with sail KUW 3355, matching the source nationality, sail and similar name; 2026 Worlds entry identifies the existing profile.','https://rrs.sh/competitors/13524/event')
  ) AS x(sailor_id,expected_name,alias_name,evidence,evidence_url) LOOP
    SELECT id INTO STRICT target FROM public.sailors WHERE id=item.sailor_id AND name=item.expected_name AND nationality IN ('OMA','KUW');
    IF EXISTS(SELECT 1 FROM public.sailor_aliases WHERE lower(alias_name)=lower(item.alias_name) AND sailor_id<>target)
       OR EXISTS(SELECT 1 FROM public.sailors WHERE lower(name)=lower(item.alias_name) AND id<>target) THEN
      RAISE EXCEPTION 'Alias conflicts with another sailor: %',item.alias_name;
    END IF;
    IF NOT EXISTS(SELECT 1 FROM public.sailor_aliases WHERE lower(alias_name)=lower(item.alias_name) AND sailor_id=target) THEN
      INSERT INTO public.sailor_aliases(sailor_id,alias_name) VALUES(target,item.alias_name);
      INSERT INTO public.admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
      VALUES('sailors.alias.reviewed','sailor',target,item.expected_name,'Added a corroborated Mussanah source-name variant.',jsonb_build_object('alias',item.alias_name,'evidence',item.evidence,'source_url',item.evidence_url,'event_source','https://www.omansail.om/events/mussanah-race-week-2026#results'),'mussanah-2026-identity-review');
    END IF;
  END LOOP;
END $review$;
COMMIT;
