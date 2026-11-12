import json

EXPLICIT_MATCHES = {
    # ILCA 4
    'Hood Saad Al Nofli': 'ad45bec2-2ef9-44c6-8ac9-e440c71bcb97',
    'Tarteel Zaid Al Hasani': '09429d47-67b4-4953-b50c-c5da84fed18c',
    'Hadeel Yousuf Almushaifri': 'c522825b-efc4-47f6-8a48-a3becbf051e7',
    # ILCA 6
    'Simeon Hristov': '5d0b77cc-e232-4cd8-87b5-51233104abfb',
    'Ameena Shah': 'c8aa8931-e608-5dd1-bb56-7babc54470c1',
    # Optimist
    'Khaled Yahya Al Sarihi': 'f8ae9c66-c9e2-4aef-b63f-27cc8faa0644',
    'Mohammed Ziyad al Gasim': '7ca68e3c-0e44-4b3b-93f1-e94394e4fe24',
    'Theyab Almehairi': 'ee43ee17-da20-4db7-885f-8267eb4da7a4',
    'Krishna Venkitachalam': '5acf2723-193a-4697-a38b-d5d23302bef3',
    'Shringhari Roy': '65545132-7379-4d67-8cda-91867a1a1334',
    'Mohammed Suleiman Al balushi': 'd03104ca-65f4-4d11-9c0c-cfee015642bf',
    'Rashed Alneyadi': '4d828529-455c-49d9-b5d1-26f451a8cec7',
    'Mohammed Said Al Qurtubi': 'de2db5b8-1479-525b-a0ea-a7abd20a5f22',
    'Mohamed Nabeel Al Baloshi': 'baa12d8d-ecc6-55a1-9787-ed9b00843eba',
    'Salah Almedhen': 'e6c8df5b-331a-5bac-9140-a5dbaca79d5e'
}

def generate_sql(json_path, sql_path, slug_suffix, boat_class, fleet_size):
    with open(json_path) as f:
        data = json.load(f)
    results = data['results']

    payload_json = json.dumps(results).replace("'", "''")

    lines = [
        f"-- Mussanah Race Week 2026 ({boat_class}) - Published import",
        "BEGIN;",
        "DO $import$",
        "DECLARE",
        f"  payload jsonb := '{payload_json}'::jsonb;",
        "  event_id_v uuid; sheet_id_v uuid; sailor_id_v uuid; result_id_v uuid;",
        "  item jsonb; race jsonb; handle_v text; explicit_id uuid;",
        "BEGIN",
        f"  PERFORM pg_advisory_xact_lock(hashtext('mussanah-race-week-2026-{slug_suffix}'));",
        "  INSERT INTO public.regatta_events(name,slug,start_date,end_date,venue,organizer,classes,counts_for_ranking,is_selection_trial,schedule_summary)",
        "  VALUES ('Mussanah Race Week 2026','mussanah-race-week-2026','2026-10-15','2026-10-22','Barceló Mussanah Resort, Oman','Oman Sail','[\"Optimist\",\"ILCA 4\",\"ILCA 6\",\"ILCA 7\"]'::jsonb,false,false,'Racing 18–21 October 2026; official departure 22 October.')",
        "  ON CONFLICT(slug) DO UPDATE SET classes = '[\"Optimist\",\"ILCA 4\",\"ILCA 6\",\"ILCA 7\"]'::jsonb;",
        "  SELECT id INTO STRICT event_id_v FROM public.regatta_events WHERE slug='mussanah-race-week-2026';",
        "  INSERT INTO public.regattas(name,slug,event_id,date,end_date,total_fleet_size,division,race_count,geography,boat_class,counts_for_ranking,venue,organizer,status,official_results_url,official_results_source_name,reviewed_at)",
        f"  VALUES('Mussanah Race Week 2026 ({boat_class})','mussanah-race-week-2026-{slug_suffix}',event_id_v,'2026-10-15','2026-10-22',{fleet_size},'Open',12,'OMA','{boat_class}',false,'Barceló Mussanah Resort, Oman','Oman Sail','published','https://www.omansail.om/events/mussanah-race-week-2026#results','Official results on website',now())",
        "  ON CONFLICT(slug) DO UPDATE SET status='published', total_fleet_size=EXCLUDED.total_fleet_size, race_count=EXCLUDED.race_count, official_results_source_name='Official results on website', reviewed_at=now();",
        f"  SELECT id INTO STRICT sheet_id_v FROM public.regattas WHERE slug='mussanah-race-week-2026-{slug_suffix}' AND event_id=event_id_v;",
        "  FOR item IN SELECT * FROM jsonb_array_elements(payload) LOOP",
        "    explicit_id := NULL;",
    ]

    for name, sid in EXPLICIT_MATCHES.items():
        escaped_name = name.replace("'", "''")
        lines.append(f"    IF item->>'name' = '{escaped_name}' THEN explicit_id := '{sid}'::uuid; END IF;")

    lines.extend([
        "    IF explicit_id IS NOT NULL THEN",
        "      sailor_id_v := explicit_id;",
        "    ELSE",
        f"      handle_v := 'mussanah-2026-{slug_suffix}-' || substr(md5(lower(item->>'name') || '|' || coalesce(item->>'nationality','') || '|' || coalesce(item->>'sailOrBoardNumber','')), 1, 16);",
        "      INSERT INTO public.sailors(name,handle,sail_number,club,nationality,gender)",
        "      VALUES(item->>'name',handle_v,coalesce(item->>'sailOrBoardNumber',''),'N/A',item->>'nationality',item->>'gender')",
        "      ON CONFLICT(handle) DO NOTHING;",
        "      SELECT id INTO STRICT sailor_id_v FROM public.sailors WHERE handle=handle_v;",
        "    END IF;",
        "    INSERT INTO public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,nationality,entry_sail_number,verification_status,verified_at,evidence_type,evidence_url,evidence_name,official_url,evidence_notes)",
        "    VALUES(sailor_id_v,sheet_id_v,(item->>'rank')::int,(item->>'nettScore')::real,(item->>'grossScore')::real,item->>'nationality',item->>'sailOrBoardNumber','verified',now(),'link','https://www.omansail.om/events/mussanah-race-week-2026#results','Official results on website','https://www.omansail.om/events/mussanah-race-week-2026#results','Official results on website')",
        "    ON CONFLICT(sailor_id,regatta_id) DO UPDATE SET rank=EXCLUDED.rank, nett_score=EXCLUDED.nett_score, total_score=EXCLUDED.total_score, entry_sail_number=EXCLUDED.entry_sail_number, verification_status='verified', official_url=EXCLUDED.official_url, evidence_notes=EXCLUDED.evidence_notes RETURNING id INTO result_id_v;",
        "    IF result_id_v IS NULL THEN SELECT id INTO STRICT result_id_v FROM public.regatta_results WHERE sailor_id=sailor_id_v AND regatta_id=sheet_id_v; END IF;",
        "    FOR race IN SELECT * FROM jsonb_array_elements(item->'races') LOOP",
        "      INSERT INTO public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)",
        "      VALUES(result_id_v,(race->>'raceNumber')::int,(race->>'score')::real,race->>'code',(race->>'discarded')::boolean,race->>'raw')",
        "      ON CONFLICT(regatta_result_id,race_number) DO UPDATE SET score=EXCLUDED.score, scoring_code=EXCLUDED.scoring_code, discarded=EXCLUDED.discarded, raw_value=EXCLUDED.raw_value;",
        "    END LOOP;",
        "    INSERT INTO public.regatta_result_participants(regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)",
        "    VALUES(result_id_v,sailor_id_v,item->>'name',1,'solo','matched',false)",
        "    ON CONFLICT(regatta_result_id,display_order) DO UPDATE SET sailor_id=EXCLUDED.sailor_id, source_name=EXCLUDED.source_name;",
        "    IF NOT EXISTS(SELECT 1 FROM public.regatta_results WHERE id=result_id_v AND rank=(item->>'rank')::int AND total_score=(item->>'grossScore')::real AND nett_score=(item->>'nettScore')::real AND verification_status='verified') OR",
        "       (SELECT count(*) FROM public.regatta_race_results WHERE regatta_result_id=result_id_v)<>12 OR",
        "       (SELECT sum(score) FROM public.regatta_race_results WHERE regatta_result_id=result_id_v)<>(item->>'grossScore')::real OR",
        "       (SELECT sum(score) FROM public.regatta_race_results WHERE regatta_result_id=result_id_v AND NOT discarded)<>(item->>'nettScore')::real",
        "       THEN RAISE EXCEPTION 'Race reconciliation failed for %',item->>'name'; END IF;",
        "  END LOOP;",
        f"  IF (SELECT count(*) FROM public.regatta_results WHERE regatta_id=sheet_id_v)<>{fleet_size} OR",
        f"     (SELECT count(*) FROM public.regatta_race_results q JOIN public.regatta_results r ON r.id=q.regatta_result_id WHERE r.regatta_id=sheet_id_v)<>{fleet_size * 12}",
        "     THEN RAISE EXCEPTION 'Unexpected final sheet counts'; END IF;",
        "END $import$;",
        "COMMIT;"
    ])

    with open(sql_path, 'w') as f:
        f.write('\n'.join(lines) + '\n')
    print(f'Wrote {sql_path}')

generate_sql('scripts/imports/mussanah-2026/ilca-4.json', 'scripts/imports/mussanah-2026/ilca-4.sql', 'ilca-4', 'ILCA 4', 15)
generate_sql('scripts/imports/mussanah-2026/ilca-6.json', 'scripts/imports/mussanah-2026/ilca-6.sql', 'ilca-6', 'ILCA 6', 11)
generate_sql('scripts/imports/mussanah-2026/optimist.json', 'scripts/imports/mussanah-2026/optimist.sql', 'optimist', 'Optimist', 46)
