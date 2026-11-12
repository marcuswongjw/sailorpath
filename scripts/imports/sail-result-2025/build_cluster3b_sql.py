import json
import uuid

# Sheet UUIDs
sheets = {
    "pre_ilca4_girls": "869a681e-7bb1-5f34-bb98-7f5658dc1091",
    "pre_opti_boys": "68fee56a-f7ec-5e48-bc9d-6e3fe3716379",
    "pre_opti_girls": "b9a09331-71de-5250-a8f2-ad989781c8a9",
    "sea_ilca4_boys": "ea6be3b0-32e9-51bf-a164-43643891f486",
    "sea_ilca4_girls": "42879c98-f145-5ab7-9595-36615d5fafb1",
    "sea_opti_boys": "dd5239ba-7bf5-591a-802c-0340070c591d",
    "sea_opti_girls": "ad71e545-0b78-5aac-aeeb-555a916747d0"
}

with open('scripts/imports/sail-result-2025/pending-identities.json') as f:
    d = json.load(f)

entries = [e for e in d if e.get('eventKey') in ('sea-games-2025', 'pre-sea-games-2025')]

mapping = [
    # 0: MUHAMMAD YAASIN SYAHRIZAN
    {
        "sailor_id": "3a2198bc-fe35-49c3-a5ba-2a32a35c81c6",
        "sheet_id": sheets["sea_opti_boys"],
        "entry_label": "MUHAMMAD YAASIN SYAHRIZAN",
        "sail_num": "MAS 115",
        "nationality": "MAS",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/170952",
        "evidence_name": "33rd SEA Games 2025 — Sailing — Optimist Boys results",
        "evidence_notes": "Identity resolved: Matches existing profile Muhammad Yaasin Bin Syahrizan (MAS, sail 115, bronze medalist). Excluded from Singapore rankings.",
        "aliases": ["MUHAMMAD YAASIN SYAHRIZAN", "Muhammad Yaasin Syahrizan"]
    },
    # 1: AUNG SITT MOUNG
    {
        "sailor_id": "3d2fede9-5b4d-444d-9eb1-49d05991d128",
        "sheet_id": sheets["sea_opti_boys"],
        "entry_label": "AUNG SITT MOUNG",
        "sail_num": "MYA 1",
        "nationality": "MYA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/170952",
        "evidence_name": "33rd SEA Games 2025 — Sailing — Optimist Boys results",
        "evidence_notes": "Identity resolved: Matches existing profile Aung Sitt Maung (Yangon Sailing Club, MYA). Transliteration variant Moung vs Maung. Excluded from Singapore rankings.",
        "aliases": ["AUNG SITT MOUNG", "Aung Sitt Moung"]
    },
    # 2: LYDIA HANNAH JASMINE LUKMAN
    {
        "sailor_id": "d4115422-92eb-49c1-b0fe-92da82fd4957",
        "sheet_id": sheets["sea_opti_girls"],
        "entry_label": "LYDIA HANNAH JASMINE LUKMAN",
        "sail_num": "MAS 112",
        "nationality": "MAS",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/170952",
        "evidence_name": "33rd SEA Games 2025 — Sailing — Optimist Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Lydia Hannah Jasmine Binti Lukman (MAS, sail 112, bronze medalist). Excluded from Singapore rankings.",
        "aliases": ["LYDIA HANNAH JASMINE LUKMAN", "Lydia Hannah Jasmine Lukman"]
    },
    # 3: DANIELA SOPHIA MAYOR
    {
        "sailor_id": "7b927e81-db43-6629-1296-8e09329a33d5",
        "sheet_id": sheets["sea_opti_girls"],
        "entry_label": "DANIELA SOPHIA MAYOR",
        "sail_num": "PHI 7",
        "nationality": "PHI",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/170952",
        "evidence_name": "33rd SEA Games 2025 — Sailing — Optimist Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Daniela Mayor (PSA, PHI). Full name recorded. Excluded from Singapore rankings.",
        "aliases": ["DANIELA SOPHIA MAYOR", "Daniela Sophia Mayor"]
    },
    # 4: IQBAL NAZHAM MUSMULIADI
    {
        "sailor_id": "ffa6f01a-8891-4c9a-a169-33a1008ecd31",
        "sheet_id": sheets["sea_ilca4_boys"],
        "entry_label": "IQBAL NAZHAM MUSMULIADI",
        "sail_num": "MAS209887",
        "nationality": "MAS",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/170965",
        "evidence_name": "33rd SEA Games 2025 — Sailing — ILCA 4 Boys results",
        "evidence_notes": "Identity resolved: Matches existing profile Iqbal Nazham Bin Musmuliadi (MSN/MSA, MAS). Excluded from Singapore rankings.",
        "aliases": ["IQBAL NAZHAM MUSMULIADI", "Iqbal Nazham Musmuliadi"]
    },
    # 5: MARK ADREY AMADEO
    {
        "sailor_id": "a6963324-b0a4-56dc-94f5-f78816b28b6b",
        "sheet_id": sheets["sea_ilca4_boys"],
        "entry_label": "MARK ADREY AMADEO",
        "sail_num": "PHI225455",
        "nationality": "PHI",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/170965",
        "evidence_name": "33rd SEA Games 2025 — Sailing — ILCA 4 Boys results",
        "evidence_notes": "Identity resolved: Matches existing profile Mark Amadeo (PSA, PHI, sail PHI225455). Excluded from Singapore rankings.",
        "aliases": ["MARK ADREY AMADEO", "Mark Adrey Amadeo"]
    },
    # 6: NUR ZAFRINA SYUHADA MOHD ZAILAN
    {
        "sailor_id": "b33f7ace-2a40-5394-8858-007b26ae3163",
        "sheet_id": sheets["sea_ilca4_girls"],
        "entry_label": "NUR ZAFRINA SYUHADA MOHD ZAILAN",
        "sail_num": "MAS209888",
        "nationality": "MAS",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/170965",
        "evidence_name": "33rd SEA Games 2025 — Sailing — ILCA 4 Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Nur Zafrina Syuhada Binti Mohd Zailan (MSN/MSA, MAS, silver medalist). Excluded from Singapore rankings.",
        "aliases": ["NUR ZAFRINA SYUHADA MOHD ZAILAN", "Nur Zafrina Syuhada Mohd Zailan"]
    },
    # 7: NIA ZAHADI
    {
        "sailor_id": "20af3d01-7d86-4111-bad1-0c2be026e039",
        "sheet_id": sheets["pre_ilca4_girls"],
        "entry_label": "NIA ZAHADI",
        "sail_num": "SGP224245",
        "nationality": "SGP",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/168534",
        "evidence_name": "Pre-33rd SEA Games 2025 — ILCA 4 Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Nia Mehry Zahedi (Singapore Sailing Federation, sail 224245). Excluded from Singapore rankings.",
        "aliases": ["NIA ZAHADI", "Nia Zahadi"]
    },
    # 8: EHAN LEE
    {
        "sailor_id": "c4e262cc-1d16-4e95-90a0-c168b25c2de1",
        "sheet_id": sheets["pre_opti_boys"],
        "entry_label": "EHAN LEE",
        "sail_num": "SGP83",
        "nationality": "SGP",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/168536",
        "evidence_name": "Provisional — Pre-33rd SEA Games 2025 — Optimist Boys results",
        "evidence_notes": "Identity resolved: Matches existing profile Ethan Lee (Singapore Sailing Federation, international sail SGP 83). Typo Ehan in source table. Excluded from Singapore rankings.",
        "aliases": ["EHAN LEE", "Ehan Lee"]
    },
    # 9: DANIAN HUANG
    {
        "sailor_id": "644b1498-1f04-4e1e-b7a0-f2bd29f874d7",
        "sheet_id": sheets["pre_opti_boys"],
        "entry_label": "DANIAN HUANG",
        "sail_num": "SGP3300",
        "nationality": "SGP",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/168536",
        "evidence_name": "Provisional — Pre-33rd SEA Games 2025 — Optimist Boys results",
        "evidence_notes": "Identity resolved: Matches existing profile Damien Huang (Singapore Sailing Federation / SAFYC, sail 3300). Typo Danian in source table. Excluded from Singapore rankings.",
        "aliases": ["DANIAN HUANG", "Danian Huang"]
    },
    # 10: NAPAPHAT/BUASUANG
    {
        "sailor_id": "e4c77476-aeef-45b2-b905-495b594b1353",
        "sheet_id": sheets["pre_opti_boys"],
        "entry_label": "NAPAPHAT/BUASUANG",
        "sail_num": "THA544",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/168536",
        "evidence_name": "Provisional — Pre-33rd SEA Games 2025 — Optimist Boys results",
        "evidence_notes": "Identity resolved: Matches existing profile Napabhat Buasuang (ACDC.SC, THA). Excluded from Singapore rankings.",
        "aliases": ["NAPAPHAT/BUASUANG", "Napaphat Buasuang", "Napaphat/Buasuang"]
    },
    # 11: SURAPA MUANGNGAM
    {
        "sailor_id": "3b9072c4-2980-4557-b1f1-b9993c803824",
        "sheet_id": sheets["pre_opti_girls"],
        "entry_label": "SURAPA MUANGNGAM",
        "sail_num": "THA1941",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/168536",
        "evidence_name": "Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Surapha Muangngam (YRAT, THA, sail 1941, gold medalist). Excluded from Singapore rankings.",
        "aliases": ["SURAPA MUANGNGAM", "Surapa Muangngam"]
    },
    # 12: DHAMAPORN ARUNO
    {
        "sailor_id": "b6cda8c3-5a90-4a1d-88d6-b0f52996cab7",
        "sheet_id": sheets["pre_opti_girls"],
        "entry_label": "DHAMAPORN ARUNO",
        "sail_num": "THA1881",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/168536",
        "evidence_name": "Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Dhammaporn Aruno (ACDC.SC, THA, sail 1881). Excluded from Singapore rankings.",
        "aliases": ["DHAMAPORN ARUNO", "Dhamaporn Aruno"]
    },
    # 13: SURATSAYAPORN KAEWRAKUM
    {
        "sailor_id": "6d6d7dd3-8b95-4230-af00-01321a224c3e",
        "sheet_id": sheets["pre_opti_girls"],
        "entry_label": "SURATSAYAPORN KAEWRAKUM",
        "sail_num": "THA1696",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/168536",
        "evidence_name": "Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Suratsayapron Kaewrakum (ACDC.SC, THA, sail 1696). Excluded from Singapore rankings.",
        "aliases": ["SURATSAYAPORN KAEWRAKUM", "Suratsayaporn Kaewrakum"]
    },
    # 14: ARAYA KLANGMUEANG
    {
        "sailor_id": "9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96",
        "sheet_id": sheets["pre_opti_girls"],
        "entry_label": "ARAYA KLANGMUEANG",
        "sail_num": "THA1498",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/168536",
        "evidence_name": "Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results",
        "evidence_notes": "Identity resolved: Matches existing profile Aranya Klangmueang (YRAT, THA, sail 1498). Transliteration variant Araya vs Aranya. Excluded from Singapore rankings.",
        "aliases": ["ARAYA KLANGMUEANG", "Araya Klangmueang"]
    }
]

sql = []
sql.append("-- SEA Games & Pre-SEA Games 2025: Resolution of 15 held entries across 7 sheets")
sql.append("BEGIN;")
sql.append("DO $resolve$")
sql.append("DECLARE")
for k, sid in sheets.items():
    sql.append(f"  v_{k} uuid := '{sid}';")
sql.append("  v_count int;")
sql.append("BEGIN")
sql.append("  PERFORM pg_advisory_xact_lock(hashtextextended('sea-games-2025-resolution', 0));")
sql.append("")

# Pre-checks
sql.append("  -- Verify current result counts on the 7 sheets")
expected_pre = {
    "pre_ilca4_girls": 7,
    "pre_opti_boys": 35,
    "pre_opti_girls": 23,
    "sea_ilca4_boys": 4,
    "sea_ilca4_girls": 4,
    "sea_opti_boys": 5,
    "sea_opti_girls": 4
}
for k, exp in expected_pre.items():
    sql.append(f"  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_{k};")
    sql.append(f"  IF v_count != {exp} THEN RAISE EXCEPTION 'Expected {exp} results on {k}, found %', v_count; END IF;")
sql.append("")

# Step 1: Register aliases
sql.append("  -- Step 1: Register aliases for matched sailors")
for m in mapping:
    s_id = m["sailor_id"]
    for al in m["aliases"]:
        al_esc = al.replace("'", "''")
        sql.append(f"  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('{s_id}', '{al_esc}') ON CONFLICT DO NOTHING;")
sql.append("")

# Step 2: Insert results, participants, race results
sql.append("  -- Step 2: Insert the 15 held results, participants, and race results")
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

    sql.append(f"  -- Entry {i+1}: {label} ({e['eventKey']} {e['boatClass']} - Rank {rank})")
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

# Step 3: Verify final counts on all 7 sheets
sql.append("  -- Step 3: Verify final counts on all 7 sheets")
expected_post = {
    "pre_ilca4_girls": 8,
    "pre_opti_boys": 38,
    "pre_opti_girls": 27,
    "sea_ilca4_boys": 6,
    "sea_ilca4_girls": 5,
    "sea_opti_boys": 7,
    "sea_opti_girls": 6
}
for k, exp in expected_post.items():
    sql.append(f"  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_{k};")
    sql.append(f"  IF v_count != {exp} THEN RAISE EXCEPTION 'Expected {exp} results on {k}, found %', v_count; END IF;")
sql.append("")

# Step 4: Update schedule_notes on all 7 sheets
sql.append("  -- Step 4: Update schedule_notes on all 7 sheets to reflect 100% completion")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 8 of 8 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql.append(f"  WHERE id = v_pre_ilca4_girls AND total_fleet_size = 8;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 38 of 38 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql.append(f"  WHERE id = v_pre_opti_boys AND total_fleet_size = 38;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 27 of 27 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql.append(f"  WHERE id = v_pre_opti_girls AND total_fleet_size = 27;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 6 of 6 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql.append(f"  WHERE id = v_sea_ilca4_boys AND total_fleet_size = 6;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 5 of 5 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql.append(f"  WHERE id = v_sea_ilca4_girls AND total_fleet_size = 5;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 7 of 7 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql.append(f"  WHERE id = v_sea_opti_boys AND total_fleet_size = 7;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 6 of 6 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql.append(f"  WHERE id = v_sea_opti_girls AND total_fleet_size = 6;")
sql.append("")

# Step 5: Audit logging
sql.append("  -- Step 5: Audit logging")
sql.append("  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES")
sql.append("    ('results.resolve_identity', 'regatta', v_pre_ilca4_girls, 'pre-sea-games-2025-ilca4-girls', 'Resolved 1 held entry (Nia Zahedi). Sheet is now 100% complete (8/8).', '{\"resolved_count\": 1}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_pre_opti_boys, 'pre-sea-games-2025-optimist-boys', 'Resolved 3 held entries (Ethan Lee, Damien Huang, Napabhat Buasuang). Sheet is now 100% complete (38/38).', '{\"resolved_count\": 3}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_pre_opti_girls, 'pre-sea-games-2025-optimist-girls', 'Resolved 4 held entries (Surapha Muangngam, Dhammaporn Aruno, Suratsayapron Kaewrakum, Aranya Klangmueang). Sheet is now 100% complete (27/27).', '{\"resolved_count\": 4}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_sea_ilca4_boys, 'sea-games-2025-ilca4-boys', 'Resolved 2 held entries (Iqbal Nazham Musmuliadi, Mark Adrey Amadeo). Sheet is now 100% complete (6/6).', '{\"resolved_count\": 2}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_sea_ilca4_girls, 'sea-games-2025-ilca4-girls', 'Resolved 1 held entry (Nur Zafrina Syuhada Mohd Zailan). Sheet is now 100% complete (5/5).', '{\"resolved_count\": 1}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_sea_opti_boys, 'sea-games-2025-optimist-boys', 'Resolved 2 held entries (Muhammad Yaasin Syahrizan, Aung Sitt Moung). Sheet is now 100% complete (7/7).', '{\"resolved_count\": 2}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_sea_opti_girls, 'sea-games-2025-optimist-girls', 'Resolved 2 held entries (Lydia Hannah Jasmine Lukman, Daniela Sophia Mayor). Sheet is now 100% complete (6/6).', '{\"resolved_count\": 2}'::jsonb, 'sea-games-2025-resolution-2026-11-12');")
sql.append("")
sql.append("END $resolve$;")
sql.append("COMMIT;")

with open('scripts/imports/sail-result-2025/resolve_sea_games_2025.sql', 'w') as f:
    f.write('\n'.join(sql) + '\n')

print('Generated scripts/imports/sail-result-2025/resolve_sea_games_2025.sql successfully!')
