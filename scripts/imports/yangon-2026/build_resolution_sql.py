import json
import uuid

# Sheet UUIDs
sheet_cfc_opti = '7c9c1cb9-a3c7-505e-a3c9-801dac28a926'
sheet_odmr_ilca4 = 'a9eafd0b-6c55-502c-be33-511f68187ef8'
sheet_odmr_opti = '491f5d6c-8cc7-5675-b704-4b20c72a4830'

# Sailor UUIDs
thurein_lin_id = '293148bf-0533-5e0f-934a-6567b089996a'
myat_toe_khant_id = 'a98245bb-cdc1-5316-b2fb-a3a3b6abe97a'
thein_thurain_myint_id = '5d1cab86-4cd9-41da-875e-ffe63608a3dd'
su_latt_lin_tun_id = 'ba1644c5-63ee-5037-bed9-a6621cdf326a'
lucas_id = '93ad80e2-dd33-5f0d-8f66-f2bf251aaff0'

with open('scripts/imports/yangon-2026/pending-entries.json') as f:
    entries = json.load(f)

sql = []
sql.append("-- Yangon 2026: Resolution of 7 held entries across 3 provisional sheets")
sql.append("BEGIN;")
sql.append("DO $resolve$")
sql.append("DECLARE")
sql.append("  v_cfc_opti uuid := '7c9c1cb9-a3c7-505e-a3c9-801dac28a926';")
sql.append("  v_odmr_ilca4 uuid := 'a9eafd0b-6c55-502c-be33-511f68187ef8';")
sql.append("  v_odmr_opti uuid := '491f5d6c-8cc7-5675-b704-4b20c72a4830';")
sql.append("  v_count int;")
sql.append("BEGIN")
sql.append("  PERFORM pg_advisory_xact_lock(hashtextextended('yangon-2026-resolution', 0));")
sql.append("")
sql.append("  -- Verify current result counts on the 3 sheets")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_cfc_opti;")
sql.append("  IF v_count != 28 THEN RAISE EXCEPTION 'Expected 28 results on CFC Opti, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_ilca4;")
sql.append("  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on ODMR ILCA 4, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_opti;")
sql.append("  IF v_count != 29 THEN RAISE EXCEPTION 'Expected 29 results on ODMR Opti, found %', v_count; END IF;")
sql.append("")
sql.append("  -- 1. Create source-faithful profile for Lucas")
sql.append(f"  INSERT INTO public.sailors(id, name, handle, sail_number, club, nationality, gender)")
sql.append(f"  VALUES ('{lucas_id}', 'Lucas', 'lucas-mya-354', 'MYA354', 'Yangon Sailing Club', 'MYA', 'M')")
sql.append("  ON CONFLICT (id) DO UPDATE SET club = 'Yangon Sailing Club', nationality = 'MYA';")
sql.append("")
sql.append("  -- 2. Register aliases and update nationality where appropriate")
sql.append(f"  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES")
sql.append(f"    ('{thurein_lin_id}', 'Thurain Lin'),")
sql.append(f"    ('{thurein_lin_id}', 'Thuyein Lin'),")
sql.append(f"    ('{thein_thurain_myint_id}', 'Thein Thuyein Myint'),")
sql.append(f"    ('{su_latt_lin_tun_id}', 'Suu Labb Lin Tun')")
sql.append("  ON CONFLICT DO NOTHING;")
sql.append("")
sql.append(f"  UPDATE public.sailors SET nationality = 'MYA', club = 'Yangon Sailing Club' WHERE id = '{thein_thurain_myint_id}';")
sql.append("")

# Helper for each entry
entry_configs = [
    # 0: Thurain Lin
    {
        "sailor_id": thurein_lin_id,
        "sheet_id": sheet_cfc_opti,
        "entry_label": "Thurain Lin",
        "sail_num": "MYA2",
        "gender": "M",
        "club": "Yangon Sailing Club",
        "official_url": "https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm",
        "evidence_name": "Yangon Sailing Club Combined Fleet Championships 2026 — Optimist provisional results",
        "evidence_notes": "Identity resolved: Phonetic Burmese transliteration variant for Thurein Lin (MYA 2), matches ODMR entry Thuyein Lin (MYA 2). Linked to canonical profile with registered aliases Thurain Lin and Thuyein Lin. Excluded from Singapore rankings."
    },
    # 1: Lucas
    {
        "sailor_id": lucas_id,
        "sheet_id": sheet_cfc_opti,
        "entry_label": "Lucas",
        "sail_num": "MYA354",
        "gender": "M",
        "club": "Yangon Sailing Club",
        "official_url": "https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm",
        "evidence_name": "Yangon Sailing Club Combined Fleet Championships 2026 — Optimist provisional results",
        "evidence_notes": "Identity resolved: Source-faithful profile for local YSC junior competitor Lucas (MYA 354). Excluded from Singapore rankings."
    },
    # 2: Myat Toe Khant (CFC)
    {
        "sailor_id": myat_toe_khant_id,
        "sheet_id": sheet_cfc_opti,
        "entry_label": "Myat Toe Khant",
        "sail_num": "MYA400",
        "gender": "M",
        "club": "Yangon Sailing Club",
        "official_url": "https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm",
        "evidence_name": "Yangon Sailing Club Combined Fleet Championships 2026 — Optimist provisional results",
        "evidence_notes": "Identity resolved: Matches existing profile Myat Toe Khant (Yangon Sailing Club). Historic event sail: MYA400. Excluded from Singapore rankings."
    },
    # 3: Thein Thuyein Myint
    {
        "sailor_id": thein_thurain_myint_id,
        "sheet_id": sheet_odmr_ilca4,
        "entry_label": "Thein Thuyein Myint",
        "sail_num": "",
        "gender": "M",
        "club": "Yangon Sailing Club",
        "official_url": "https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm",
        "evidence_name": "Olympic Day Movement Regatta 2026 — ILCA 4 provisional results",
        "evidence_notes": "Identity resolved: Matches existing profile Thein Thurain Myint (MYA), aged up from Optimist to ILCA 4 at YSC. Registered alias Thein Thuyein Myint. Excluded from Singapore rankings."
    },
    # 4: Suu Labb Lin Tun
    {
        "sailor_id": su_latt_lin_tun_id,
        "sheet_id": sheet_odmr_ilca4,
        "entry_label": "Suu Labb Lin Tun",
        "sail_num": "",
        "gender": "F",
        "club": "ISPE",
        "official_url": "https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm",
        "evidence_name": "Olympic Day Movement Regatta 2026 — ILCA 4 provisional results",
        "evidence_notes": "Identity resolved: Phonetic transliteration variant for Su Latt Lin Tun (ISPE), aged up from Optimist to ILCA 4. Registered alias Suu Labb Lin Tun. Excluded from Singapore rankings."
    },
    # 5: Thuyein Lin
    {
        "sailor_id": thurein_lin_id,
        "sheet_id": sheet_odmr_opti,
        "entry_label": "Thuyein Lin",
        "sail_num": "MYA2",
        "gender": "M",
        "club": "ISPE",
        "official_url": "https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm",
        "evidence_name": "Olympic Day Movement Regatta 2026 — Optimist provisional results",
        "evidence_notes": "Identity resolved: Phonetic Burmese transliteration variant for Thurein Lin (MYA 2), matches CFC entry Thurain Lin (MYA 2). Linked to canonical profile with registered aliases Thurain Lin and Thuyein Lin. Excluded from Singapore rankings."
    },
    # 6: Myat Toe Khant (ODMR)
    {
        "sailor_id": myat_toe_khant_id,
        "sheet_id": sheet_odmr_opti,
        "entry_label": "Myat Toe Khant",
        "sail_num": "MYA2(400)",
        "gender": "M",
        "club": "Yangon Sailing Club",
        "official_url": "https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm",
        "evidence_name": "Olympic Day Movement Regatta 2026 — Optimist provisional results",
        "evidence_notes": "Identity resolved: Matches existing profile Myat Toe Khant (Yangon Sailing Club). Historic event sail: MYA2(400). Source table arithmetic discrepancy preserved per user instruction (published gross 256 / nett 192). Excluded from Singapore rankings."
    }
]

for i, e in enumerate(entries):
    cfg = entry_configs[i]
    sid = cfg["sheet_id"]
    name = e["name"]
    rank = e["rank"]
    res_id = str(uuid.uuid5(uuid.UUID(sid), f"result-{rank}-{name.lower()}"))
    part_id = str(uuid.uuid5(uuid.UUID(sid), f"part-{rank}-{name.lower()}"))
    gross = float(e["grossScore"])
    nett = float(e["nettScore"])
    sail_num = cfg["sail_num"]
    sailor_id = cfg["sailor_id"]
    label = cfg["entry_label"]
    gender = cfg["gender"]
    url = cfg["official_url"]
    ev_name = cfg["evidence_name"]
    ev_notes = cfg["evidence_notes"].replace("'", "''")

    sql.append(f"  -- Entry {i+1}: {label} ({e['event']} - Rank {rank})")
    sql.append(f"  INSERT INTO public.regatta_results(")
    sql.append(f"    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,")
    sql.append(f"    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,")
    sql.append(f"    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,")
    sql.append(f"    verification_status, verified_at")
    sql.append(f"  ) VALUES (")
    sql.append(f"    '{res_id}', '{sailor_id}', '{sid}', '{label}', '{sail_num}', 'individual',")
    sql.append(f"    {rank}, {gross}, {nett}, '{gender}', 'MYA', false, false,")
    sql.append(f"    '{url}', '{url}', '{ev_name}', 'url', '{ev_notes}',")
    sql.append(f"    'pending_review', now()")
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

# Verification of result counts and schedule notes updates
sql.append("  -- Verify final counts on all 3 sheets")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_cfc_opti;")
sql.append("  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on CFC Opti, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_ilca4;")
sql.append("  IF v_count != 7 THEN RAISE EXCEPTION 'Expected 7 results on ODMR ILCA 4, found %', v_count; END IF;")
sql.append("")
sql.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_opti;")
sql.append("  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on ODMR Opti, found %', v_count; END IF;")
sql.append("")

sql.append("  -- Update schedule_notes on all 3 sheets")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Official source status: provisional. Complete import: 31 of 31 entries; 0 entries awaiting identity review. Event dates 2026-09-19 to 2026-09-20 are assumed at user instruction and not independently verified. No official final-results PDF located; HTML source only. Published ranks, race values, discards, totals and net scores retained as supplied. 0 imported rows have source arithmetic discrepancies, preserved at user instruction. Code-only penalty points use fleet size + 1 internally; original source codes remain displayed. Excluded from Singapore rankings.',")
sql.append("      updated_at = now()")
sql.append("  WHERE id = v_cfc_opti AND total_fleet_size = 31;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Official source status: provisional. Complete import: 7 of 7 entries; 0 entries awaiting identity review. Event dates 2026-06-20 to 2026-06-21 are assumed at user instruction and not independently verified. No official final-results PDF located; HTML source only. Published ranks, race values, discards, totals and net scores retained as supplied. 0 imported rows have source arithmetic discrepancies, preserved at user instruction. Code-only penalty points use fleet size + 1 internally; original source codes remain displayed. Excluded from Singapore rankings.',")
sql.append("      updated_at = now()")
sql.append("  WHERE id = v_odmr_ilca4 AND total_fleet_size = 7;")
sql.append("")
sql.append("  UPDATE public.regattas")
sql.append("  SET schedule_notes = 'Official source status: provisional. Complete import: 31 of 31 entries; 0 entries awaiting identity review. Event dates 2026-06-20 to 2026-06-21 are assumed at user instruction and not independently verified. No official final-results PDF located; HTML source only. Published ranks, race values, discards, totals and net scores retained as supplied. 18 imported rows have source arithmetic discrepancies, preserved at user instruction. Code-only penalty points use fleet size + 1 internally; original source codes remain displayed. Excluded from Singapore rankings.',")
sql.append("      updated_at = now()")
sql.append("  WHERE id = v_odmr_opti AND total_fleet_size = 31;")
sql.append("")

# Admin change log
sql.append("  -- Audit logging")
sql.append("  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES")
sql.append("    ('results.resolve_identity', 'regatta', v_cfc_opti, 'yangon-sailing-club-combined-fleet-championships-2026-optimist', 'Resolved 3 held entries (Thurain Lin, Lucas, Myat Toe Khant). Sheet is now 100% complete (31/31).', '{\"resolved_count\": 3}'::jsonb, 'yangon-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_odmr_ilca4, 'olympic-day-movement-regatta-2026-ilca4', 'Resolved 2 held entries (Thein Thuyein Myint, Suu Labb Lin Tun). Sheet is now 100% complete (7/7).', '{\"resolved_count\": 2}'::jsonb, 'yangon-resolution-2026-11-12'),")
sql.append("    ('results.resolve_identity', 'regatta', v_odmr_opti, 'olympic-day-movement-regatta-2026-optimist', 'Resolved 2 held entries (Thuyein Lin, Myat Toe Khant). Sheet is now 100% complete (31/31).', '{\"resolved_count\": 2}'::jsonb, 'yangon-resolution-2026-11-12');")
sql.append("")
sql.append("END $resolve$;")
sql.append("COMMIT;")

with open('scripts/imports/yangon-2026/resolution.sql', 'w') as f:
    f.write('\n'.join(sql) + '\n')

print('Generated scripts/imports/yangon-2026/resolution.sql successfully!')
