import json
import uuid

# Sheet UUIDs
sheets = {
    "acdc_ilca4": "b8d4edd6-9059-579b-84f9-30198597f440",
    "acdc_ilca6": "a62775e2-103c-52f9-827a-e4e01066e2d4",
    "acdc_ilca7": "7a8de0db-47a2-56dc-b240-fb2b46075a12",
    "acdc_opti_gold": "e1a64cdd-fa07-553c-bc72-e56fd1f86fee",
    "acdc_opti_silver": "b4595995-1be5-505f-b1a9-5cb00005c04b",
    "trat_ilca6": "b8df6f6f-d18a-52db-a03b-7b0e96603c00",
    "trat_opti_silver": "7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e"
}

with open('scripts/imports/sail-result-2025/pending-identities.json') as f:
    d = json.load(f)

c3d_entries = [e for e in d if e.get('eventKey') in ('acdc-cup-international-2025', 'trat-regatta-2025')]

# UUIDs for new profiles
ya_zhang_id = "51a8b92d-74d1-52a1-bf87-4328eb92040c"
nuttapat_id = "729acda4-25b3-57df-b11c-2f31f9d45e52"
klaochanok_dnc_id = "f4c93ba2-66ab-5908-99cf-59e3bdc60f4e"
t_dnc_id = "c37db018-8ee6-5fb6-9f82-a0eb82fa9b61"

mapping = [
    # 0: YA ZHANG (ACDC Opti Silver, rank 10)
    {
        "sailor_id": ya_zhang_id,
        "is_new": True,
        "new_name": "Ya Zhang",
        "new_handle": "ya-zhang-sr25-51a8b9",
        "new_club": "QINGDAO",
        "new_nationality": "CHN",
        "new_sail": "CHN122",
        "new_gender": "F",
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "YA ZHANG",
        "sail_num": "CHN122",
        "nationality": "CHN",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Ya Zhang (Qingdao, CHN, sail CHN122).",
        "aliases": ["YA ZHANG", "Ya Zhang"]
    },
    # 1: KUNPICHET PANCHANG (ACDC Opti Silver, rank 11)
    {
        "sailor_id": "97050c23-371f-427e-a571-e20486cbb936",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "KUNPICHET PANCHANG",
        "sail_num": "THA798",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Kulpichet Phanchang (RNSC, THA). Romanisation variant Kunpichet Panchang.",
        "aliases": ["KUNPICHET PANCHANG", "Kunpichet Panchang"]
    },
    # 2: KAUNG KHANT KO (ACDC Opti Silver, rank 21)
    {
        "sailor_id": "611ef739-d28b-57c3-b6fe-183b006a2a38",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "KAUNG KHANT KO",
        "sail_num": "MYA277",
        "nationality": "MYA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Kaung Khant Khant Ko (YSC, MYA). Naming variant Kaung Khant Ko.",
        "aliases": ["KAUNG KHANT KO", "Kaung Khant Ko"]
    },
    # 3: DUANGDUENG WICHAI (ACDC Opti Silver, rank 24)
    {
        "sailor_id": "dfefca66-a570-5f96-bec6-eb566501bdbb",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "DUANGDUENG WICHAI",
        "sail_num": "THA723",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Duangdeuen Wichai (RNSC, THA). Romanisation variant Duangdueng.",
        "aliases": ["DUANGDUENG WICHAI", "Duangdueng Wichai"]
    },
    # 4: NAVATAWAN Jaemjit (ACDC Opti Silver, rank 25)
    {
        "sailor_id": "1c03e3e7-ea29-526f-88b3-fd77ce113868",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "NAVATAWAN Jaemjit",
        "sail_num": "(R)THA1979",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Navatawan Jeanjit (RTFYC, THA, sail 1979).",
        "aliases": ["NAVATAWAN Jaemjit", "Navatawan Jaemjit"]
    },
    # 5: Kunthee Khunmuang (ACDC Opti Silver, rank 30)
    {
        "sailor_id": "8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "Kunthee Khunmuang",
        "sail_num": "THA54",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Kanthee Khunmuang (SSA, THA, sail 54). Romanisation variant Kunthee.",
        "aliases": ["Kunthee Khunmuang", "KUNTHEE KHUNMUANG"]
    },
    # 6: CHARIE BASNET (ACDC Opti Silver, rank 41)
    {
        "sailor_id": "02f7450f-b247-49cf-ba12-2f33a7f0642e",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "CHARIE BASNET",
        "sail_num": "THA115",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Charlie Basnet (RNSC, THA). Source spelling typo Charie.",
        "aliases": ["CHARIE BASNET", "Charie Basnet"]
    },
    # 7: NUTTAPAT ARTTAPIYAPUN (ACDC Opti Silver, rank 50)
    {
        "sailor_id": nuttapat_id,
        "is_new": True,
        "new_name": "Nuttapat Arttapiyapun",
        "new_handle": "nuttapat-arttapiyapun-sr25-729acd",
        "new_club": "ACDC. SC",
        "new_nationality": "THA",
        "new_sail": "THA187",
        "new_gender": "M",
        "sheet_id": sheets["acdc_opti_silver"],
        "entry_label": "NUTTAPAT ARTTAPIYAPUN",
        "sail_num": "THA187",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134936",
        "evidence_name": "ACDC Cup 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Nuttapat Arttapiyapun (ACDC.SC, THA, sail THA187).",
        "aliases": ["NUTTAPAT ARTTAPIYAPUN", "Nuttapat Arttapiyapun"]
    },
    # 8: KHAIRUL ILZANI MOND AFENDY (ACDC Opti Gold, rank 13)
    {
        "sailor_id": "ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_gold"],
        "entry_label": "KHAIRUL ILZANI MOND AFENDY",
        "sail_num": "MAS31",
        "nationality": "MAS",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134935",
        "evidence_name": "ACDC Cup 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Khairul Ilzani Bin Mohd Afendy (MAS). Source spelling typo MOND vs Mohd.",
        "aliases": ["KHAIRUL ILZANI MOND AFENDY", "Khairul Ilzani Mond Afendy"]
    },
    # 9: MUAZ MUJAHID KHAMARUE AZUAN (ACDC Opti Gold, rank 20)
    {
        "sailor_id": "2bda4fc0-b72c-4b0b-b21f-597107dc5ca8",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_gold"],
        "entry_label": "MUAZ MUJAHID KHAMARUE AZUAN",
        "sail_num": "MAS28",
        "nationality": "MAS",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134935",
        "evidence_name": "ACDC Cup 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Muaz Mujahid Bin Khamarul Azwan (MAS, sail 28). Transliteration variant Khamarue Azuan.",
        "aliases": ["MUAZ MUJAHID KHAMARUE AZUAN", "Muaz Mujahid Khamarue Azuan"]
    },
    # 10: ITTIVORAKUL (ACDC Opti Gold, rank 21)
    {
        "sailor_id": "863b5d54-6357-50d0-b16e-75e44de37e41",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_gold"],
        "entry_label": "ITTIVORAKUL",
        "sail_num": "THA1887",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134935",
        "evidence_name": "ACDC Cup 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Chanyachart Ittivorakul (ACDC.SC, THA, sail 1887). Source published with surname only.",
        "aliases": ["ITTIVORAKUL", "Ittivorakul"]
    },
    # 11: NIRADA SASIWATTHANAPORN (ACDC Opti Gold, rank 36)
    {
        "sailor_id": "fd3c4362-b9e5-4fce-bac2-01232f20d014",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_gold"],
        "entry_label": "NIRADA SASIWATTHANAPORN",
        "sail_num": "THA1925",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/134935",
        "evidence_name": "ACDC Cup 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Nirada Sasiwattanaporn (YRAT, THA, sail 1925). Transliteration variant Sasiwatthanaporn.",
        "aliases": ["NIRADA SASIWATTHANAPORN", "Nirada Sasiwatthanaporn"]
    },
    # 12: MIA AZRAHIA MOHDAZRALD (ACDC Opti Gold, rank 43)
    {
        "sailor_id": "796bc25b-e641-4630-8c8d-20241e73f843",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_gold"],
        "entry_label": "MIA AZRAHIA MOHDAZRALD",
        "sail_num": "MAS89",
        "nationality": "MAS",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/134935",
        "evidence_name": "ACDC Cup 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Mia Azrania bt Mohd Azrald (MAS). Source OCR/spelling typo Azrahia.",
        "aliases": ["MIA AZRAHIA MOHDAZRALD", "Mia Azrahia Mohdazrald"]
    },
    # 13: Klaochanok Chatawattanasopakul (ACDC Opti Gold, rank 59)
    {
        "sailor_id": "04f1c65e-eeb7-4c89-9f6e-16298c33be02",
        "is_new": False,
        "sheet_id": sheets["acdc_opti_gold"],
        "entry_label": "Klaochanok Chatawattanasopakul",
        "sail_num": "THA3935",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/134935",
        "evidence_name": "ACDC Cup 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Klaochanok Chatawattanasopakun (ACDC.SC, THA, sail 3935). Final consonant variant l vs n.",
        "aliases": ["Klaochanok Chatawattanasopakul", "KLAOCHANOK CHATAWATTANASOPAKUL"]
    },
    # 14: NITHATSANA RODNUN (ACDC ILCA 7, rank 1)
    {
        "sailor_id": "0788d794-c84e-5242-9da9-3d51d26e4eb7",
        "is_new": False,
        "sheet_id": sheets["acdc_ilca7"],
        "entry_label": "NITHATSANA RODNUN",
        "sail_num": "180177",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134934",
        "evidence_name": "ACDC Cup 2025 — ILCA 7 results",
        "evidence_notes": "Identity resolved: Matches existing profile Nithasn Rodhnun (RTNYC, THA, sail 180177). Transliteration variant Nithatsana Rodnun.",
        "aliases": ["NITHATSANA RODNUN", "Nithatsana Rodnun"]
    },
    # 15: KITCHAKHUN SOMKHANNGONE (ACDC ILCA 4, rank 4)
    {
        "sailor_id": "90a471f5-bd58-400f-a995-e115951ee1ed",
        "is_new": False,
        "sheet_id": sheets["acdc_ilca4"],
        "entry_label": "KITCHAKHUN SOMKHANNGONE",
        "sail_num": "21738",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134932",
        "evidence_name": "ACDC Cup 2025 — ILCA 4 results",
        "evidence_notes": "Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (YRAT, THA). Romanisation variant Somkhanngone.",
        "aliases": ["KITCHAKHUN SOMKHANNGONE", "Kitchakhun Somkhanngone"]
    },
    # 16: Aueaoangkun jadsanam (ACDC ILCA 6, rank 1)
    {
        "sailor_id": "2b2f3955-49bf-5a67-8643-70307409f211",
        "is_new": False,
        "sheet_id": sheets["acdc_ilca6"],
        "entry_label": "Aueaoangkun jadsanam",
        "sail_num": "9",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/134933",
        "evidence_name": "ACDC Cup 2025 — ILCA 6 results",
        "evidence_notes": "Identity resolved: Matches existing profile Aueangkun Jadsanam (ACDC SC, THA, sail 9). Romanisation variant Aueaoangkun.",
        "aliases": ["Aueaoangkun jadsanam", "AUEAOANGKUN JADSANAM"]
    },
    # 17: AUEAOANGKUN JADSANAM (Trat ILCA 6, rank 4)
    {
        "sailor_id": "2b2f3955-49bf-5a67-8643-70307409f211",
        "is_new": False,
        "sheet_id": sheets["trat_ilca6"],
        "entry_label": "AUEAOANGKUN JADSANAM",
        "sail_num": "NO. NUM",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141363",
        "evidence_name": "Trat Regatta 2025 — ILCA 6 results",
        "evidence_notes": "Identity resolved: Matches existing profile Aueangkun Jadsanam (ACDC.SC, THA).",
        "aliases": []
    },
    # 18: NAVATAWAN JAEMJIT (Trat Opti Silver, rank 3)
    {
        "sailor_id": "1c03e3e7-ea29-526f-88b3-fd77ce113868",
        "is_new": False,
        "sheet_id": sheets["trat_opti_silver"],
        "entry_label": "NAVATAWAN JAEMJIT",
        "sail_num": "THA1979",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141365",
        "evidence_name": "Trat Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Navatawan Jeanjit (MRS.SC., THA, sail 1979).",
        "aliases": ["NAVATAWAN JAEMJIT", "Navatawan Jaemjit"]
    },
    # 19: KITTIKPHAT SACHATO (Trat Opti Silver, rank 9)
    {
        "sailor_id": "433063e8-3178-50b1-8b3e-68470a3e8cc6",
        "is_new": False,
        "sheet_id": sheets["trat_opti_silver"],
        "entry_label": "KITTIKPHAT SACHATO",
        "sail_num": "NZL4529",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141365",
        "evidence_name": "Trat Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Kittiphat Sachato (YRAT, THA, sail NZL4529). Source spelling variant Kittikphat.",
        "aliases": ["KITTIKPHAT SACHATO", "Kittikphat Sachato"]
    },
    # 20: BOONTARIKA BANTICHAT (Trat Opti Silver, rank 19)
    {
        "sailor_id": "28ed0b2b-49b3-52ff-ad02-f1f260bfac0b",
        "is_new": False,
        "sheet_id": sheets["trat_opti_silver"],
        "entry_label": "BOONTARIKA BANTICHAT",
        "sail_num": "53",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/141365",
        "evidence_name": "Trat Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Boontarik Bantichat (MRS.SC, THA). Source name variant Boontarika.",
        "aliases": ["BOONTARIKA BANTICHAT", "Boontarika Bantichat"]
    },
    # 21: KLAOCHANOK (Trat Opti Silver, rank 25 DNC)
    {
        "sailor_id": klaochanok_dnc_id,
        "is_new": True,
        "new_name": "Klaochanok (Trat DNC)",
        "new_handle": "klaochanok-trat-dnc-sr25-f4c93b",
        "new_club": "YRAT",
        "new_nationality": "THA",
        "new_sail": "",
        "new_gender": "F",
        "sheet_id": sheets["trat_opti_silver"],
        "entry_label": "KLAOCHANOK",
        "sail_num": "",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/141365",
        "evidence_name": "Trat Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for unstarted entry Klaochanok (YRAT, DNC entry).",
        "aliases": ["KLAOCHANOK"]
    },
    # 22: T (Trat Opti Silver, rank 25 DNC)
    {
        "sailor_id": t_dnc_id,
        "is_new": True,
        "new_name": "T (Trat DNC)",
        "new_handle": "t-trat-dnc-sr25-c37db0",
        "new_club": "YRAT",
        "new_nationality": "THA",
        "new_sail": "",
        "new_gender": "M",
        "sheet_id": sheets["trat_opti_silver"],
        "entry_label": "T",
        "sail_num": "",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141365",
        "evidence_name": "Trat Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for unstarted entry T (YRAT, DNC entry).",
        "aliases": ["T"]
    },
    # 23: SUTNINAN NAKPASOM (Trat Opti Silver, rank 25 DNC)
    {
        "sailor_id": "f3e4cce1-2a81-4794-ba02-a570d43efb21",
        "is_new": False,
        "sheet_id": sheets["trat_opti_silver"],
        "entry_label": "SUTNINAN NAKPASOM",
        "sail_num": "THA 1987",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141365",
        "evidence_name": "Trat Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Suthinan Nakpasom (YRAT, THA, sail 1987). Source spelling variant Sutninan.",
        "aliases": ["SUTNINAN NAKPASOM", "Sutninan Nakpasom"]
    }
]

sql_lines = [
    "-- ACDC Cup & Trat Regatta 2025: Resolution of 24 held entries (Cluster 3D)",
    "BEGIN;",
    "DO $resolve$",
    "DECLARE",
    f"  v_acdc_ilca4 uuid := '{sheets['acdc_ilca4']}';",
    f"  v_acdc_ilca6 uuid := '{sheets['acdc_ilca6']}';",
    f"  v_acdc_ilca7 uuid := '{sheets['acdc_ilca7']}';",
    f"  v_acdc_opti_gold uuid := '{sheets['acdc_opti_gold']}';",
    f"  v_acdc_opti_silver uuid := '{sheets['acdc_opti_silver']}';",
    f"  v_trat_ilca6 uuid := '{sheets['trat_ilca6']}';",
    f"  v_trat_opti_silver uuid := '{sheets['trat_opti_silver']}';",
    "  v_count int;",
    "BEGIN",
    "  PERFORM pg_advisory_xact_lock(hashtextextended('acdc-trat-2025-resolution', 0));",
    "",
    "  -- Verify initial counts on sheets",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca4;",
    "  IF v_count != 15 THEN RAISE EXCEPTION 'Expected 15 results on acdc_ilca4, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca6;",
    "  IF v_count != 2 THEN RAISE EXCEPTION 'Expected 2 results on acdc_ilca6, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca7;",
    "  IF v_count != 2 THEN RAISE EXCEPTION 'Expected 2 results on acdc_ilca7, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_gold;",
    "  IF v_count != 61 THEN RAISE EXCEPTION 'Expected 61 results on acdc_opti_gold, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_silver;",
    "  IF v_count != 43 THEN RAISE EXCEPTION 'Expected 43 results on acdc_opti_silver, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_ilca6;",
    "  IF v_count != 8 THEN RAISE EXCEPTION 'Expected 8 results on trat_ilca6, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_opti_silver;",
    "  IF v_count != 40 THEN RAISE EXCEPTION 'Expected 40 results on trat_opti_silver, found %', v_count; END IF;",
    "",
    "  -- Step 1: Create source-faithful profiles for new sailors",
]

for m in mapping:
    if m.get("is_new"):
        sql_lines.append(f"  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)")
        sql_lines.append(f"  VALUES ('{m['sailor_id']}', '{m['new_name']}', '{m['new_handle']}', '{m['new_club']}', '{m['new_nationality']}', '{m['new_sail']}', '{m['new_gender']}', now(), now())")
        sql_lines.append(f"  ON CONFLICT (id) DO NOTHING;")

sql_lines.append("")
sql_lines.append("  -- Step 2: Register aliases for matched and new sailors")
for m in mapping:
    for a in m["aliases"]:
        sql_lines.append(f"  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('{m['sailor_id']}', '{a}') ON CONFLICT DO NOTHING;")

sql_lines.append("")
sql_lines.append("  -- Step 3: Insert 24 regatta results, participants, and race scores")

for idx, m in enumerate(mapping):
    e = c3d_entries[idx]
    res_id = str(uuid.uuid4())
    part_id = str(uuid.uuid4())
    
    sql_lines.append(f"  -- [{idx}] {e['name']} ({e['eventKey']}, rank {e['rank']})")
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

sql_lines.append("  -- Step 4: Verify final counts on all 7 affected sheets")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca4;")
sql_lines.append("  IF v_count != 16 THEN RAISE EXCEPTION 'Expected 16 results on acdc_ilca4, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca6;")
sql_lines.append("  IF v_count != 3 THEN RAISE EXCEPTION 'Expected 3 results on acdc_ilca6, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca7;")
sql_lines.append("  IF v_count != 3 THEN RAISE EXCEPTION 'Expected 3 results on acdc_ilca7, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_gold;")
sql_lines.append("  IF v_count != 67 THEN RAISE EXCEPTION 'Expected 67 results on acdc_opti_gold, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_silver;")
sql_lines.append("  IF v_count != 51 THEN RAISE EXCEPTION 'Expected 51 results on acdc_opti_silver, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_ilca6;")
sql_lines.append("  IF v_count != 9 THEN RAISE EXCEPTION 'Expected 9 results on trat_ilca6, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_opti_silver;")
sql_lines.append("  IF v_count != 46 THEN RAISE EXCEPTION 'Expected 46 results on trat_opti_silver, found %', v_count; END IF;")
sql_lines.append("")
sql_lines.append("  -- Step 5: Update schedule_notes to reflect complete imports")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 16 of 16 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_acdc_ilca4;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 3 of 3 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_acdc_ilca6;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 3 of 3 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_acdc_ilca7;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 67 of 67 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_acdc_opti_gold;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 51 of 51 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_acdc_opti_silver;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 9 of 9 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_trat_ilca6;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 46 of 46 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_trat_opti_silver;")
sql_lines.append("")
sql_lines.append("  -- Step 6: Audit logging")
sql_lines.append("  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_acdc_ilca4, 'acdc-cup-international-2025-ilca4', 'Resolved 1 held entry (Kiitchakhun Somkhanngoen). Sheet is 100% complete (16/16).', '{\"resolved_count\": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_acdc_ilca6, 'acdc-cup-international-2025-ilca6', 'Resolved 1 held entry (Aueangkun Jadsanam). Sheet is 100% complete (3/3).', '{\"resolved_count\": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_acdc_ilca7, 'acdc-cup-international-2025-ilca7', 'Resolved 1 held entry (Nithasn Rodhnun). Sheet is 100% complete (3/3).', '{\"resolved_count\": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_acdc_opti_gold, 'acdc-cup-international-2025-optimist-gold', 'Resolved 6 held entries. Sheet is 100% complete (67/67).', '{\"resolved_count\": 6}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_acdc_opti_silver, 'acdc-cup-international-2025-optimist-silver', 'Resolved 8 held entries. Sheet is 100% complete (51/51).', '{\"resolved_count\": 8}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_trat_ilca6, 'trat-regatta-2025-ilca6', 'Resolved 1 held entry (Aueangkun Jadsanam). Sheet is 100% complete (9/9).', '{\"resolved_count\": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_trat_opti_silver, 'trat-regatta-2025-optimist-silver', 'Resolved 6 held entries. Sheet is 100% complete (46/46).', '{\"resolved_count\": 6}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12');")
sql_lines.append("")
sql_lines.append("END $resolve$;")
sql_lines.append("COMMIT;")

with open('scripts/imports/sail-result-2025/resolve_acdc_trat_2025.sql', 'w') as f:
    f.write('\n'.join(sql_lines) + '\n')

print("Generated scripts/imports/sail-result-2025/resolve_acdc_trat_2025.sql successfully!")
