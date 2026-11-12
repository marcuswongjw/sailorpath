import json
import uuid

# Sheet UUIDs
sheet_ilca4 = 'c319a67f-0640-540f-92a9-69718217c089'
sheet_gold = 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0'
sheet_silver = 'f8b2ae66-e664-5b49-bc41-a1325ac63e2e'

# Duplicate to merge
huanran_zheng_id = '87cc8912-d304-407f-934f-5cadd7a4921e'
jolin_zheng_id = '018b6ed4-9636-47e1-8d40-aa5e21a22f32'

with open('scripts/imports/sail-result-2025/pending-identities.json') as f:
    d = json.load(f)

# Keep only the 10 junior entries for YRAT Series 5
entries = [e for e in d if e.get('eventKey') == 'yrat-cup-series-5-2025' and e.get('division') != 'Master']

# Map each entry to its canonical sailor id and aliases
mapping = [
    # 0: Zheng
    {
        "sailor_id": jolin_zheng_id,
        "sheet_id": sheet_ilca4,
        "entry_label": "Zheng",
        "sail_num": "209319",
        "nationality": "SGP",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/156704",
        "evidence_name": "2025 YRAT Cup Series 5 — ILCA 4 Open results",
        "evidence_notes": "Identity resolved: RHKYC entry Zheng (sail 209319) matches canonical profile Jolin Zheng (Huanran Zheng). Duplicate Huanran Zheng merged into Jolin Zheng. Excluded from Singapore rankings.",
        "aliases": ["Zheng", "Huanran Zheng", "Huanran ZHENG"]
    },
    # 1: KITCHAKHUN SOMKHANNGONE
    {
        "sailor_id": "90a471f5-bd58-400f-a995-e115951ee1ed", # Kiitchakhun Somkhanngoen
        "sheet_id": sheet_ilca4,
        "entry_label": "KITCHAKHUN SOMKHANNGONE",
        "sail_num": "21738",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/156704",
        "evidence_name": "2025 YRAT Cup Series 5 — ILCA 4 Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (YRAT, THA). Registered alias Kitchakhun Somkhanngone. Excluded from Singapore rankings.",
        "aliases": ["Kitchakhun Somkhanngone", "KITCHAKHUN SOMKHANNGONE"]
    },
    # 2: PUMITUS MEE-EIAMSIN
    {
        "sailor_id": "4f1eb555-5b44-517d-8d05-9ff0fd18f5ec", # Pumitus Mee-Iamsin
        "sheet_id": sheet_ilca4,
        "entry_label": "PUMITUS MEE-EIAMSIN",
        "sail_num": "THA 22023",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/156704",
        "evidence_name": "2025 YRAT Cup Series 5 — ILCA 4 Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Pumitus Mee-Iamsin (YRAT, THA). Historic event sail: THA 22023. Excluded from Singapore rankings.",
        "aliases": ["Pumitus Mee-Eiamsin", "PUMITUS MEE-EIAMSIN"]
    },
    # 3: Ratcharta Sadtrakulwattan
    {
        "sailor_id": "071e2770-8de0-4d2f-b8c3-bd6cb31fef05", # Rachata Sadtrakulwatanna
        "sheet_id": sheet_gold,
        "entry_label": "Ratcharta Sadtrakulwattan",
        "sail_num": "THA1963",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/156714",
        "evidence_name": "Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Rachata Sadtrakulwatanna (YRAT, THA, sail 1963). Registered alias Ratcharta Sadtrakulwattan. Excluded from Singapore rankings.",
        "aliases": ["Ratcharta Sadtrakulwattan"]
    },
    # 4: ITTHICHAI TAITHONGCHAI
    {
        "sailor_id": "182f006d-6103-4990-a289-421c0d94e552", # Itthichai Tiathongchai
        "sheet_id": sheet_gold,
        "entry_label": "ITTHICHAI TAITHONGCHAI",
        "sail_num": "THA2865",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/156714",
        "evidence_name": "Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Itthichai Tiathongchai (YRAT, THA). Registered alias Itthichai Taithongchai. Excluded from Singapore rankings.",
        "aliases": ["Itthichai Taithongchai", "ITTHICHAI TAITHONGCHAI"]
    },
    # 5: Yue Yan
    {
        "sailor_id": "4ea7704c-a106-47d1-b424-6565e8dd9c3f", # Yueyan Jin
        "sheet_id": sheet_gold,
        "entry_label": "Yue Yan",
        "sail_num": "CHN7709",
        "nationality": "CHN",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/156714",
        "evidence_name": "Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Yueyan Jin (CHN, sail CHN7709 across regional regattas). Official source table omitted surname Jin. Registered alias Yue Yan. Excluded from Singapore rankings.",
        "aliases": ["Yue Yan"]
    },
    # 6: PATARAKORN POONPAT
    {
        "sailor_id": "9fe16e38-700a-4ba6-8618-5f6779a9b23f", # Pattarakorn Poonpat
        "sheet_id": sheet_gold,
        "entry_label": "PATARAKORN POONPAT",
        "sail_num": "THA88",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/156714",
        "evidence_name": "Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Pattarakorn Poonpat (ACDC.SC, THA, sail 88). Registered alias Patarakorn Poonpat. Excluded from Singapore rankings.",
        "aliases": ["Patarakorn Poonpat", "PATARAKORN POONPAT"]
    },
    # 7: Santhat Suthamgoasl
    {
        "sailor_id": "154feedb-6173-4142-8d3e-88f1567b22e7", # Santhat Suthamgosal
        "sheet_id": sheet_gold,
        "entry_label": "Santhat Suthamgoasl",
        "sail_num": "THA1879",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/156714",
        "evidence_name": "Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Santhat Suthamgosal (ACDC, THA, sail 1879). Registered alias Santhat Suthamgoasl. Excluded from Singapore rankings.",
        "aliases": ["Santhat Suthamgoasl"]
    },
    # 8: NETCHANOK CHATAWATTANASOPSKUN
    {
        "sailor_id": "8b594c37-db52-4549-a765-f51fd619238d", # Netchanok Chatawattanasopakun
        "sheet_id": sheet_silver,
        "entry_label": "NETCHANOK CHATAWATTANASOPSKUN",
        "sail_num": "1562",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/156714",
        "evidence_name": "Provisional — 2025 YRAT Cup Series 5 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Netchanok Chatawattanasopakun (ACDC.SC, THA). Registered alias Netchanok Chatawattanasopskun. Excluded from Singapore rankings.",
        "aliases": ["Netchanok Chatawattanasopskun", "NETCHANOK CHATAWATTANASOPSKUN"]
    },
    # 9: Navatawan Jaemjit
    {
        "sailor_id": "1c03e3e7-ea29-526f-88b3-fd77ce113868", # Navatawan Jeanjit
        "sheet_id": sheet_silver,
        "entry_label": "Navatawan Jaemjit",
        "sail_num": "THA1979",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/156714",
        "evidence_name": "Provisional — 2025 YRAT Cup Series 5 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Navatawan Jeanjit (RTFYC, THA, sail 1979). Registered alias Navatawan Jaemjit. Excluded from Singapore rankings.",
        "aliases": ["Navatawan Jaemjit"]
    }
]

sql = []
sql.append("-- YRAT Cup Series 5 (2025): Resolution of 10 held junior entries and sailor deduplication")
sql.append("BEGIN;")
sql.append("DO $resolve$")
sql.append("DECLARE")
sql.append("  v_sheet_ilca4 uuid := 'c319a67f-0640-540f-92a9-69718217c089';")
sql.append("  v_sheet_gold uuid := 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0';")
sql.append("  v_sheet_silver uuid := 'f8b2ae66-e664-5b49-bc41-a1325ac63e2e';")
sql.append(f"  v_huanran_id uuid := '{huanran_zheng_id}';")
sql.append(f"  v_jolin_id uuid := '{jolin_zheng_id}';")
sql.append("  v_count int;")
sql.append("BEGIN")
sql.append("  PERFORM pg_advisory_xact_lock(hashtextextended('yrat-series5-resolution', 0));")
sql.append("")
sql.append("  -- Verify current result counts on the 3 sheets")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_ilca4;")
sql.append("  IF v_count != 16 THEN RAISE EXCEPTION 'Expected 16 results on YRAT ILCA 4, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_gold;")
sql.append("  IF v_count != 36 THEN RAISE EXCEPTION 'Expected 36 results on YRAT Opti Gold, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_silver;")
sql.append("  IF v_count != 24 THEN RAISE EXCEPTION 'Expected 24 results on YRAT Opti Silver, found %', v_count; END IF;")
sql.append("")

# Step 1: Merge Huanran Zheng into Jolin Zheng
sql.append("  -- Step 1: Merge duplicate Huanran Zheng into canonical Jolin Zheng")
sql.append("  IF EXISTS (SELECT 1 FROM public.sailors WHERE id = v_huanran_id) THEN")
sql.append("    UPDATE public.regatta_results SET sailor_id = v_jolin_id WHERE sailor_id = v_huanran_id;")
sql.append("    UPDATE public.regatta_result_participants SET sailor_id = v_jolin_id WHERE sailor_id = v_huanran_id;")
sql.append("    DELETE FROM public.sailor_aliases WHERE sailor_id = v_huanran_id;")
sql.append("    INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES")
sql.append("      (v_jolin_id, 'Huanran Zheng'),")
sql.append("      (v_jolin_id, 'Huanran ZHENG'),")
sql.append("      (v_jolin_id, 'Zheng')")
sql.append("    ON CONFLICT DO NOTHING;")
sql.append("    DELETE FROM public.sailors WHERE id = v_huanran_id;")
sql.append("    INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES")
sql.append("      ('sailor.merge', 'sailor', v_jolin_id, 'Jolin Zheng', 'Merged duplicate Huanran Zheng into canonical profile Jolin Zheng (RHKYC, sail 209319, DOB 2011-01-01).', jsonb_build_object('merged_from', v_huanran_id), 'yrat-series5-resolution-2026-11-12');")
sql.append("  END IF;")
sql.append("")

# Step 2: Register aliases for other matched sailors
sql.append("  -- Step 2: Register aliases for matched sailors")
for m in mapping:
    s_id = m["sailor_id"]
    for al in m["aliases"]:
        al_esc = al.replace("'", "''")
        sql.append(f"  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('{s_id}', '{al_esc}') ON CONFLICT DO NOTHING;")
sql.append("")

# Step 3: Insert results, participants, race results
sql.append("  -- Step 3: Insert the 10 junior results, participants, and race results")
for i, e in enumerate(entries):
    m = mapping[i]
    sid = m["sheet_id"]
    name = e["name"]
    rank = e["rank"]
    res_id = str(uuid.uuid5(uuid.UUID(sid), f"result-{rank}-{name.lower()}"))
    part_id = str(uuid.uuid5(uuid.UUID(sid), f"part-{rank}-{name.lower()}"))
    gross = float(e["grossScore"])
    nett = float(e["nettScore"])
    sail_num = m["sail_num"]
    sailor_id = m["sailor_id"]
    label = m["entry_label"].replace("'", "''")
    gender = m["gender"]
    nat = m["nationality"]
    url = m["official_url"]
    ev_name = m["evidence_name"].replace("'", "''")
    ev_notes = m["evidence_notes"].replace("'", "''")

    sql.append(f"  -- Entry {i+1}: {label} ({e['boatClass']} {e['division']} - Rank {rank})")
    sql.append(f"  INSERT INTO public.regatta_results(")
    sql.append(f"    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,")
    sql.append(f"    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,")
    sql.append(f"    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,")
    sql.append(f"    verification_status, verified_at")
    sql.append(f"  ) VALUES (")
    sql.append(f"    '{res_id}', '{sailor_id}', '{sid}', '{label}', '{sail_num}', 'individual',")
    sql.append(f"    {rank}, {gross}, {nett}, '{gender}', '{nat}', false, false,")
    sql.append(f"    '{url}', '{url}', '{ev_name}', 'pdf', '{ev_notes}',")
    sql.append(f"    'verified', now()")
    sql.append(f"  );")
    sql.append("")
    sql.append(f"  INSERT INTO public.regatta_result_participants(")
    sql.append(f"    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit")
    sql.append(f"  ) VALUES (")
    sql.append(f"    '{part_id}', '{res_id}', '{sailor_id}', '{label}', 1, 'solo', 'matched', false")
    sql.append(f"  );")
    sql.append("")

    for r in e["races"]:
        r_num = r["raceNumber"]
        r_score = float(r["score"])
        r_code = f"'{r['code']}'" if r["code"] else "NULL"
        r_disc = "true" if r["discarded"] else "false"
        r_raw = r["raw"].replace("'", "''")
        sql.append(f"  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)")
        sql.append(f"  VALUES ('{res_id}', {r_num}, {r_score}, {r_code}, {r_disc}, '{r_raw}');")
    sql.append("")

# Step 4: Verify final counts on all 3 sheets
sql.append("  -- Step 4: Verify final counts on all 3 sheets")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_ilca4;")
sql.append("  IF v_count != 19 THEN RAISE EXCEPTION 'Expected 19 results on YRAT ILCA 4, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_gold;")
sql.append("  IF v_count != 41 THEN RAISE EXCEPTION 'Expected 41 results on YRAT Opti Gold, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_silver;")
sql.append("  IF v_count != 26 THEN RAISE EXCEPTION 'Expected 26 results on YRAT Opti Silver, found %', v_count; END IF;")
sql.append("")

# Step 5: Update schedule_notes on all 3 sheets
sql.append("  -- Step 5: Update schedule_notes on all 3 sheets to reflect 100% completion")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 19 of 19 class entries imported; 0 awaiting identity or source review.',")
sql.append("      updated_at = now()")
sql.append("  WHERE id = v_sheet_ilca4 AND total_fleet_size = 19;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 41 of 41 class entries imported; 0 awaiting identity or source review.',")
sql.append("      updated_at = now()")
sql.append("  WHERE id = v_sheet_gold AND total_fleet_size = 41;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 26 of 26 class entries imported; 0 awaiting identity or source review.',")
sql.append("      updated_at = now()")
sql.append("  WHERE id = v_sheet_silver AND total_fleet_size = 26;")
sql.append("")

# Step 6: Admin change log
sql.append("  -- Step 6: Audit logging")
sql.append("  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES")
sql.append("    ('results.resolve_identity', 'regatta', v_sheet_ilca4, 'yrat-cup-series-5-2025-ilca4', 'Resolved 3 held entries (Zheng, KITCHAKHUN SOMKHANNGONE, PUMITUS MEE-EIAMSIN). Sheet is now 100% complete (19/19).', '{\"resolved_count\": 3}'::jsonb, 'yrat-series5-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_sheet_gold, 'yrat-cup-series-5-2025-optimist-gold', 'Resolved 5 held entries (Ratcharta Sadtrakulwattan, ITTHICHAI TAITHONGCHAI, Yue Yan, PATARAKORN POONPAT, Santhat Suthamgoasl). Sheet is now 100% complete (41/41).', '{\"resolved_count\": 5}'::jsonb, 'yrat-series5-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_sheet_silver, 'yrat-cup-series-5-2025-optimist-silver', 'Resolved 2 held entries (NETCHANOK CHATAWATTANASOPSKUN, Navatawan Jaemjit). Sheet is now 100% complete (26/26).', '{\"resolved_count\": 2}'::jsonb, 'yrat-series5-resolution-2026-11-12');")
sql.append("")
sql.append("END $resolve$;")
sql.append("COMMIT;")

with open('scripts/imports/sail-result-2025/resolve_yrat_series5.sql', 'w') as f:
    f.write('\n'.join(sql) + '\n')

print('Generated scripts/imports/sail-result-2025/resolve_yrat_series5.sql successfully!')
