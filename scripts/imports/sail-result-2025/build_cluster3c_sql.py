import json
import uuid

# Sheet UUIDs for Phuket King's Cup 2025
sheets = {
    "pkc_ilca6": "2cef00cb-a63b-5eca-b905-5c76cb43d130",
    "pkc_ilca7": "f2d53719-ece3-5162-92dd-87b247029fcd",
    "pkc_opti": "a3f68fb2-f72e-5eaf-b452-9a5671749ce6"
}

with open('scripts/imports/sail-result-2025/pending-identities.json') as f:
    d = json.load(f)

entries = [e for e in d if e.get('eventKey') == 'phuket-kings-cup-2025']

# New profile IDs to generate
marcus_yau_id = "07d9bca1-925a-5282-bdae-40fa1878b1d9"
tanyatip_id = "1bfa6741-cb12-58e1-95be-286a073deba3"

# Entry 0: CHRISTIAN WIEDMANN is already in DB as Apiwat Christian Wiedmann (3b468b8a-579d-5429-8d3f-27db5e17aed2), result id b6c2d134-8c01-5d97-8c34-71285491ce60.
# Only needs alias and schedule notes update.

mapping = [
    # 1: MARCUS YAU
    {
        "sailor_id": marcus_yau_id,
        "is_new": True,
        "new_name": "Marcus Yau",
        "new_handle": "marcus-yau-sr25-07d9bc",
        "new_club": "UWC",
        "new_nationality": "HKG",
        "new_sail": "HKG 195004",
        "new_gender": "M",
        "sheet_id": sheets["pkc_ilca6"],
        "entry_label": "MARCUS YAU",
        "sail_num": "HKG 195004",
        "nationality": "HKG",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/169974",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — ILCA 6 Open results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Marcus Yau (HKG, UWC). Original combined PY handicap fleet ranks and scores retained; this class is a subset of the official fleet.",
        "aliases": ["MARCUS YAU", "Marcus Yau"]
    },
    # 2: SURAPA MUANGNGAM
    {
        "sailor_id": "3b9072c4-2980-4557-b1f1-b9993c803824",
        "is_new": False,
        "sheet_id": sheets["pkc_opti"],
        "entry_label": "SURAPA MUANGNGAM",
        "sail_num": "1941",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/169977",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — Optimist Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Surapha Muangngam (YRAT, THA, sail 1941).",
        "aliases": ["SURAPA MUANGNGAM", "Surapa Muangngam"]
    },
    # 3: TAWAREE RUKSAPAN
    {
        "sailor_id": "efc33f0d-a581-4dd3-99ee-2c245bb1c9cd",
        "is_new": False,
        "sheet_id": sheets["pkc_opti"],
        "entry_label": "TAWAREE RUKSAPAN",
        "sail_num": "1789",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/169977",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — Optimist Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Thawaree Raksapun (YRAT/RTFYC, THA, sail 1789).",
        "aliases": ["TAWAREE RUKSAPAN", "Tawaree Ruksapan"]
    },
    # 4: AUMMARIN JUNTAJON
    {
        "sailor_id": "aa2952d1-ba70-464e-8666-096ff9fef554",
        "is_new": False,
        "sheet_id": sheets["pkc_opti"],
        "entry_label": "AUMMARIN JUNTAJON",
        "sail_num": "THA 1395",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/169977",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — Optimist Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Amarin Juntajon (YRAT, THA). Romanisation variant Aummarin vs Amarin.",
        "aliases": ["AUMMARIN JUNTAJON", "Aummarin Juntajon"]
    },
    # 5: NIRADA SASIWUATTANAPORN
    {
        "sailor_id": "fd3c4362-b9e5-4fce-bac2-01232f20d014",
        "is_new": False,
        "sheet_id": sheets["pkc_opti"],
        "entry_label": "NIRADA SASIWUATTANAPORN",
        "sail_num": "1373",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/169977",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — Optimist Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Nirada Sasiwattanaporn (YRAT, THA). Source spelling variant Sasiwuattanaporn vs Sasiwattanaporn.",
        "aliases": ["NIRADA SASIWUATTANAPORN", "Nirada Sasiwuattanaporn"]
    },
    # 6: NOPPADOL TOKPO
    {
        "sailor_id": "d5453895-83cb-4b63-b701-804ce42ce4b2",
        "is_new": False,
        "sheet_id": sheets["pkc_opti"],
        "entry_label": "NOPPADOL TOKPO",
        "sail_num": "THA 8884",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/169977",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — Optimist Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Nopadol Tokpo (RNSC, THA, sail 8884). Romanisation variant Noppadol vs Nopadol.",
        "aliases": ["NOPPADOL TOKPO", "Noppadol Tokpo"]
    },
    # 7: TANYATIP
    {
        "sailor_id": tanyatip_id,
        "is_new": True,
        "new_name": "Tanyatip",
        "new_handle": "tanyatip-sr25-1bfa67",
        "new_club": "NAC3.SC.",
        "new_nationality": "THA",
        "new_sail": "723",
        "new_gender": "F",
        "sheet_id": sheets["pkc_opti"],
        "entry_label": "TANYATIP",
        "sail_num": "723",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/169977",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — Optimist Open results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Tanyatip (THA, NAC3.SC., sail 723).",
        "aliases": ["TANYATIP", "Tanyatip"]
    },
    # 8: KANYAPAT PISOOTTIWING
    {
        "sailor_id": "6b42e276-4836-4f99-bb40-0542ee7b5dde",
        "is_new": False,
        "sheet_id": sheets["pkc_opti"],
        "entry_label": "KANYAPAT PISOOTTIWING",
        "sail_num": "THA 1556",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/169977",
        "evidence_name": "37th Phuket King’s Cup Regatta 2025 — Optimist Open results",
        "evidence_notes": "Identity resolved: Matches existing profile Kanyapat Pisoottiwong (YRAT, THA, sail 1556). Source spelling variant Pisoottiwing vs Pisoottiwong.",
        "aliases": ["KANYAPAT PISOOTTIWING", "Kanyapat Pisoottiwing"]
    }
]

sql_lines = [
    "-- Phuket King's Cup 2025: Resolution of 9 held entries (Cluster 3C)",
    "BEGIN;",
    "DO $resolve$",
    "DECLARE",
    f"  v_pkc_ilca6 uuid := '{sheets['pkc_ilca6']}';",
    f"  v_pkc_ilca7 uuid := '{sheets['pkc_ilca7']}';",
    f"  v_pkc_opti uuid := '{sheets['pkc_opti']}';",
    "  v_count int;",
    "BEGIN",
    "  PERFORM pg_advisory_xact_lock(hashtextextended('phuket-kings-cup-2025-resolution', 0));",
    "",
    "  -- Verify initial counts on sheets",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca6;",
    "  IF v_count != 2 THEN RAISE EXCEPTION 'Expected 2 results on pkc_ilca6, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca7;",
    "  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on pkc_ilca7 (Christian Wiedmann already inserted), found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_opti;",
    "  IF v_count != 34 THEN RAISE EXCEPTION 'Expected 34 results on pkc_opti, found %', v_count; END IF;",
    "",
    "  -- Step 1: Create source-faithful profiles for new sailors",
]

for m in mapping:
    if m.get("is_new"):
        sql_lines.append(f"  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)")
        sql_lines.append(f"  VALUES ('{m['sailor_id']}', '{m['new_name']}', '{m['new_handle']}', '{m['new_club']}', '{m['new_nationality']}', '{m['new_sail']}', '{m['new_gender']}', now(), now())")
        sql_lines.append(f"  ON CONFLICT (id) DO NOTHING;")

sql_lines.append("")
sql_lines.append("  -- Step 2: Register aliases for matched and new sailors (including Christian Wiedmann)")
sql_lines.append("  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b468b8a-579d-5429-8d3f-27db5e17aed2', 'CHRISTIAN WIEDMANN') ON CONFLICT DO NOTHING;")
sql_lines.append("  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b468b8a-579d-5429-8d3f-27db5e17aed2', 'Christian Wiedmann') ON CONFLICT DO NOTHING;")

for m in mapping:
    for a in m["aliases"]:
        sql_lines.append(f"  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('{m['sailor_id']}', '{a}') ON CONFLICT DO NOTHING;")

sql_lines.append("")
sql_lines.append("  -- Step 3: Insert 8 regatta results, participants, and race scores")

# Process entries 1 to 8 (entry 0 is already in DB)
for idx, m in enumerate(mapping, start=1):
    e = entries[idx]
    res_id = str(uuid.uuid4())
    part_id = str(uuid.uuid4())
    
    sql_lines.append(f"  -- [{idx}] {e['name']} (rank {e['rank']})")
    sql_lines.append("  INSERT INTO public.regatta_results (")
    sql_lines.append("    id, sailor_id, regatta_id, rank, nett_score, total_score,")
    sql_lines.append("    is_dns, is_overseas_commitment, gender, nationality,")
    sql_lines.append("    official_url, evidence_name, evidence_type, evidence_notes,")
    sql_lines.append("    verification_status, verified_at, entry_label, entry_sail_number,")
    sql_lines.append("    entry_type, created_at, updated_at")
    sql_lines.append("  ) VALUES (")
    sql_lines.append(f"    '{res_id}', '{m['sailor_id']}', '{m['sheet_id']}', {e['rank']}, {e['nettScore']}, {e['grossScore']},")
    sql_lines.append(f"    false, false, '{m['gender']}', '{m['nationality']}',")
    sql_lines.append(f"    '{m['official_url']}', '{m['evidence_name']}', 'pdf', '{m['evidence_notes']}',")
    sql_lines.append(f"    'verified', now(), '{m['entry_label']}', '{m['sail_num']}',")
    sql_lines.append("    'individual', now(), now()")
    sql_lines.append("  );")
    
    sql_lines.append("  INSERT INTO public.regatta_result_participants (")
    sql_lines.append("    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at")
    sql_lines.append("  ) VALUES (")
    sql_lines.append(f"    '{part_id}', '{res_id}', '{m['sailor_id']}', '{m['entry_label']}', 1, 'solo', 'matched', true, now(), now()")
    sql_lines.append("  );")
    
    for r in e['races']:
        code_str = f"'{r['code']}'" if r.get('code') else "NULL"
        disc_str = "true" if r.get('discarded') else "false"
        sql_lines.append("  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)")
        sql_lines.append(f"  VALUES ('{res_id}', {r['raceNumber']}, {r['score']}, {code_str}, {disc_str}, '{r['raw']}');")
    sql_lines.append("")

sql_lines.append("  -- Step 4: Verify final counts")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca6;")
sql_lines.append("  IF v_count != 3 THEN RAISE EXCEPTION 'Expected 3 results on pkc_ilca6, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca7;")
sql_lines.append("  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on pkc_ilca7, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_opti;")
sql_lines.append("  IF v_count != 41 THEN RAISE EXCEPTION 'Expected 41 results on pkc_opti, found %', v_count; END IF;")
sql_lines.append("")
sql_lines.append("  -- Step 5: Update schedule_notes to reflect complete imports")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Original combined PY handicap standings; class subset, with original ranks and scores. Complete import: 3 of 3 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_pkc_ilca6;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Original combined PY handicap standings; class subset, with original ranks and scores. Complete import: 5 of 5 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_pkc_ilca7;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 41 of 41 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_pkc_opti;")
sql_lines.append("")
sql_lines.append("  -- Step 6: Audit logging")
sql_lines.append("  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_pkc_ilca6, 'phuket-kings-cup-2025-ilca6', 'Resolved 1 held entry (Marcus Yau). Sheet is now 100% complete (3/3 class entries).', '{\"resolved_count\": 1}'::jsonb, 'phuket-kings-cup-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_pkc_ilca7, 'phuket-kings-cup-2025-ilca7', 'Corroborated 1 previously resolved entry (Apiwat Christian Wiedmann). Sheet is 100% complete (5/5 class entries).', '{\"resolved_count\": 1}'::jsonb, 'phuket-kings-cup-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_pkc_opti, 'phuket-kings-cup-2025-optimist', 'Resolved 7 held entries. Sheet is now 100% complete (41/41).', '{\"resolved_count\": 7}'::jsonb, 'phuket-kings-cup-2025-resolution-2026-11-12');")
sql_lines.append("")
sql_lines.append("END $resolve$;")
sql_lines.append("COMMIT;")

with open('scripts/imports/sail-result-2025/resolve_phuket_kings_cup_2025.sql', 'w') as f:
    f.write('\n'.join(sql_lines) + '\n')

print("Generated scripts/imports/sail-result-2025/resolve_phuket_kings_cup_2025.sql successfully!")
