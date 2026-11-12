import json
import uuid

# Sheet UUIDs
sheets = {
    "childrens_ilca6": "159c4ad0-d7ee-543b-aa1c-752898cfeabc",
    "childrens_opti_green": "571a6dae-7ec0-596c-aa35-1eaa0c9f13a0",
    "childrens_opti_gold": "4d9921dd-f364-54d1-b8e7-1395e3836e08",
    "childrens_opti_silver": "a631abfa-5b04-59aa-9b71-3afe5490d542",
    "longdist_ilca4": "17541783-3aa2-5bcf-8c85-1af83adb290d",
    "longdist_opti": "eeafd5ca-f435-5efb-b58e-d4c98bf53eca",
    "district_ilca4": "c9fcde35-3332-5194-906f-774fe4ee8502",
    "district_ilca7": "39c41f2f-9c85-575a-b009-665d52c7a17c",
    "nationals_ilca4": "81faaba4-7246-5e56-9de1-bd3ba0e19a00",
    "nationals_ilca6": "cd3712e1-b4a9-50a0-b3a6-0e1fa96640c4",
    "nationals_ilca7": "5fcf0002-c34f-592b-8f17-5d55dd165050"
}

with open('scripts/imports/sail-result-2025/pending-identities.json') as f:
    d = json.load(f)

# UUIDs for new profiles
kim_kor_id = "e976db5a-36bb-5fe4-8509-3221ac075841"
wonjeong_lee_id = "c78219ad-ecf3-529a-9e11-8be4f10a8c22"
minsol_jeon_id = "fb14e7a2-f584-5f21-9486-d242c75a34e0"
aran_klangmueang_id = "07bf0465-389d-5487-b6f7-b248a3cb859b"

mapping = [
    # 0: Kim (Children's Day ILCA 6, rank 8)
    {
        "sailor_id": kim_kor_id,
        "is_new": True,
        "new_name": "Kim (Jeonbuk)",
        "new_handle": "kim-jeonbuk-sr25-e976db",
        "new_club": "Jeun buk",
        "new_nationality": "KOR",
        "new_sail": "215573",
        "new_gender": "F",
        "sheet_id": sheets["childrens_ilca6"],
        "entry_label": "Kim",
        "sail_num": "215573",
        "nationality": "KOR",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/103603",
        "evidence_name": "Children’s Day Regatta 2025 — ILCA 6 results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Korean youth competitor Kim (Jeonbuk, KOR, sail 215573).",
        "aliases": ["Kim"]
    },
    # 1: NETCHANOK CHATAAWATTANASOPAKUN (Children's Day Opti Green, rank 3)
    {
        "sailor_id": "8b594c37-db52-4549-a765-f51fd619238d",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_green"],
        "entry_label": "NETCHANOK CHATAAWATTANASOPAKUN",
        "sail_num": "THA15",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/103602",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Green results",
        "evidence_notes": "Identity resolved: Matches existing profile Netchanok Chatawattanasopakun (ACDC.SC, THA).",
        "aliases": ["NETCHANOK CHATAAWATTANASOPAKUN", "Netchanok Chataawattanasopakun"]
    },
    # 2: Suwaphark Plumjit (Children's Day Opti Green, rank 8)
    {
        "sailor_id": "a5a0ff6f-0576-4a4c-b583-149f6f6d7304",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_green"],
        "entry_label": "Suwaphark Plumjit",
        "sail_num": "THA1589",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/103602",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Green results",
        "evidence_notes": "Identity resolved: Matches existing profile Suwaphak Plumjit (ACDC.SC, THA). Romanisation variant Suwaphark.",
        "aliases": ["Suwaphark Plumjit", "SUWAPHARK PLUMJIT"]
    },
    # 3: Kunthon Khunmuang (Children's Day Opti Green, rank 21)
    {
        "sailor_id": "fe102225-248d-48a9-a92c-683cadcdbda8",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_green"],
        "entry_label": "Kunthon Khunmuang",
        "sail_num": "35",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/103602",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Green results",
        "evidence_notes": "Identity resolved: Matches existing profile Kanthon Khunmuang (YRAT, THA). Romanisation variant Kunthon.",
        "aliases": ["Kunthon Khunmuang", "KUNTHON KHUNMUANG"]
    },
    # 4: Tara (Children's Day Opti Gold, rank 13)
    {
        "sailor_id": "bcb9374d-c256-4add-9abe-98b7832706cc",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_gold"],
        "entry_label": "Tara",
        "sail_num": "HKG184",
        "nationality": "HKG",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/103600",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Tara Maliah (RHKYC / HKODA, HKG, sail HKG184).",
        "aliases": ["Tara"]
    },
    # 5: CHANANCHAI TAITHONGCHAI (Children's Day Opti Gold, rank 26)
    {
        "sailor_id": "611e949a-fdcf-4727-8dbf-1430097ac813",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_gold"],
        "entry_label": "CHANANCHAI TAITHONGCHAI",
        "sail_num": "THA1487",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/103600",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Chananchai Tiathongchai (ACDC.SC, THA). Romanisation variant Taithongchai.",
        "aliases": ["CHANANCHAI TAITHONGCHAI", "Chananchai Taithongchai"]
    },
    # 6: KITCHAKHUN SOMKHANNGONE (Children's Day Opti Gold, rank 29)
    {
        "sailor_id": "90a471f5-bd58-400f-a995-e115951ee1ed",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_gold"],
        "entry_label": "KITCHAKHUN SOMKHANNGONE",
        "sail_num": "THA1567",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/103600",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Gold results",
        "evidence_notes": "Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (ACDC.SC, THA).",
        "aliases": []
    },
    # 7: Rohan (Children's Day Opti Silver, rank 7)
    {
        "sailor_id": "21fee251-d07b-4f4b-be01-efead0178e57",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_silver"],
        "entry_label": "Rohan",
        "sail_num": "HKG173",
        "nationality": "HKG",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/103601",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Rohan Maliah (RHKYC, HKG, sail HKG173).",
        "aliases": ["Rohan"]
    },
    # 8: JUSTIN LIU (Children's Day Opti Silver, rank 12)
    {
        "sailor_id": "04d423bc-bd18-47ad-967a-45b1ef44cefd",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_silver"],
        "entry_label": "JUSTIN LIU",
        "sail_num": "HKG236",
        "nationality": "HKG",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/103601",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Liu Qi Heng (RHKYC, HKG, sail HKG 236; English name Justin Liu).",
        "aliases": ["JUSTIN LIU", "Justin Liu"]
    },
    # 9: ARAN KLANGMUEANG (Children's Day Opti Silver, rank 20)
    {
        "sailor_id": aran_klangmueang_id,
        "is_new": True,
        "new_name": "Aran Klangmueang",
        "new_handle": "aran-klangmueang-sr25-07bf04",
        "new_club": "YRAT",
        "new_nationality": "THA",
        "new_sail": "1903",
        "new_gender": "M",
        "sheet_id": sheets["childrens_opti_silver"],
        "entry_label": "ARAN KLANGMUEANG",
        "sail_num": "THA1903",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/103601",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Thai youth competitor Aran Klangmueang (YRAT, THA, sail THA1903). Distinct from Aranya Klangmueang (sail THA1775).",
        "aliases": ["ARAN KLANGMUEANG", "Aran Klangmueang"]
    },
    # 10: ANANCHAI TAITHONGCHAI (Children's Day Opti Silver, rank 21)
    {
        "sailor_id": "638fc9a3-1d0e-4e9d-a750-e44f46655473",
        "is_new": False,
        "sheet_id": sheets["childrens_opti_silver"],
        "entry_label": "ANANCHAI TAITHONGCHAI",
        "sail_num": "THA1549",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/103601",
        "evidence_name": "Children’s Day Regatta 2025 — Optimist Silver results",
        "evidence_notes": "Identity resolved: Matches existing profile Anantachai Tiathongchai (ACDC.SC, THA). Romanisation variant Ananchai Taithongchai.",
        "aliases": ["ANANCHAI TAITHONGCHAI", "Ananchai Taithongchai"]
    },
    # 11: KLAOCHNOK CHTAWATTANASOPAKUN (Long Distance Opti, rank 27)
    {
        "sailor_id": "04f1c65e-eeb7-4c89-9f6e-16298c33be02",
        "is_new": False,
        "sheet_id": sheets["longdist_opti"],
        "entry_label": "KLAOCHNOK CHTAWATTANASOPAKUN",
        "sail_num": "THA1246",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/141362",
        "evidence_name": "Thailand Nationals Long Distance 2025 — Optimist results",
        "evidence_notes": "Identity resolved: Matches existing profile Klaochanok Chatawattanasopakun (ACDC.SC, THA). Source spelling typo Klaochnok Chtawattanasopakun.",
        "aliases": ["KLAOCHNOK CHTAWATTANASOPAKUN", "Klaochnok Chtawattanasopakun"]
    },
    # 12: NAVATAWAN JAEMJIT (Long Distance Opti, rank 44)
    {
        "sailor_id": "1c03e3e7-ea29-526f-88b3-fd77ce113868",
        "is_new": False,
        "sheet_id": sheets["longdist_opti"],
        "entry_label": "NAVATAWAN JAEMJIT",
        "sail_num": "THA1979",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141362",
        "evidence_name": "Thailand Nationals Long Distance 2025 — Optimist results",
        "evidence_notes": "Identity resolved: Matches existing profile Navatawan Jeanjit (RTFYC, THA, sail 1979).",
        "aliases": []
    },
    # 13: PIMPISA DEVAHASTIN NA AYUDHAYA (Long Distance Opti, rank 50)
    {
        "sailor_id": "976342b7-69ec-4200-8e46-684855939591",
        "is_new": False,
        "sheet_id": sheets["longdist_opti"],
        "entry_label": "PIMPISA DEVAHASTIN NA AYUDHAYA",
        "sail_num": "THA599",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/141362",
        "evidence_name": "Thailand Nationals Long Distance 2025 — Optimist results",
        "evidence_notes": "Identity resolved: Matches existing profile Pimpisa Devahastin Na Ayudhya (ACDC.SC, THA). Spelling variant Ayudhaya.",
        "aliases": ["PIMPISA DEVAHASTIN NA AYUDHAYA", "Pimpisa Devahastin Na Ayudhaya"]
    },
    # 14: NUFAEL HAKIMI BIN IZHAR (Long Distance Opti, rank 50)
    {
        "sailor_id": "1b12d594-107f-40e1-9967-c65f59f6b27a",
        "is_new": False,
        "sheet_id": sheets["longdist_opti"],
        "entry_label": "NUFAEL HAKIMI BIN IZHAR",
        "sail_num": "MAS 246",
        "nationality": "MAS",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141362",
        "evidence_name": "Thailand Nationals Long Distance 2025 — Optimist results",
        "evidence_notes": "Identity resolved: Matches existing profile Nufael Hakimi Izhar (MAS, TSA).",
        "aliases": ["NUFAEL HAKIMI BIN IZHAR", "Nufael Hakimi Bin Izhar"]
    },
    # 15: IMANINA RAISYA BINTI IZHAR (Long Distance Opti, rank 50)
    {
        "sailor_id": "241af289-a3d3-4054-8f9a-a874c1a62471",
        "is_new": False,
        "sheet_id": sheets["longdist_opti"],
        "entry_label": "IMANINA RAISYA BINTI IZHAR",
        "sail_num": "MAS 245",
        "nationality": "MAS",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/141362",
        "evidence_name": "Thailand Nationals Long Distance 2025 — Optimist results",
        "evidence_notes": "Identity resolved: Matches existing profile Imanina Raisya bt Izhar (MAS, TSA).",
        "aliases": ["IMANINA RAISYA BINTI IZHAR", "Imanina Raisya Binti Izhar"]
    },
    # 16: PUMITUS MEEIMSIN (Long Distance ILCA 4, rank 15)
    {
        "sailor_id": "4f1eb555-5b44-517d-8d05-9ff0fd18f5ec",
        "is_new": False,
        "sheet_id": sheets["longdist_ilca4"],
        "entry_label": "PUMITUS MEEIMSIN",
        "sail_num": "22023",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/141364",
        "evidence_name": "Thailand Nationals Long Distance 2025 — ILCA 4 results",
        "evidence_notes": "Identity resolved: Matches existing profile Pumitus Mee-Iamsin (YRAT, THA). Spelling variant Meeimsin.",
        "aliases": ["PUMITUS MEEIMSIN", "Pumitus Meeimsin"]
    },
    # 17: KITCHAKHUN (District ILCA 4, rank 15)
    {
        "sailor_id": "90a471f5-bd58-400f-a995-e115951ee1ed",
        "is_new": False,
        "sheet_id": sheets["district_ilca4"],
        "entry_label": "KITCHAKHUN",
        "sail_num": "THA 228917",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/116666",
        "evidence_name": "ILCA District Championship 2025 — ILCA 4 results",
        "evidence_notes": "Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (YRAT, THA). Source published with first name only.",
        "aliases": ["KITCHAKHUN"]
    },
    # 18: JEMIMMA CHANG (District ILCA 4, rank 16)
    {
        "sailor_id": "1ba65410-fa86-472d-ad75-bc510bffd07b",
        "is_new": False,
        "sheet_id": sheets["district_ilca4"],
        "entry_label": "JEMIMMA CHANG",
        "sail_num": "SGP 214636",
        "nationality": "SGP",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/116666",
        "evidence_name": "ILCA District Championship 2025 — ILCA 4 results",
        "evidence_notes": "Identity resolved: Matches existing profile Jemima Chang (PAssion Wave / PA, SGP). Source spelling variant Jemimma.",
        "aliases": ["JEMIMMA CHANG", "Jemimma Chang"]
    },
    # 19: CASEY (District ILCA 7, rank 11)
    {
        "sailor_id": "957c49e1-11ff-5bd5-adbe-e59de172eb0c",
        "is_new": False,
        "sheet_id": sheets["district_ilca7"],
        "entry_label": "CASEY",
        "sail_num": "THA 200119",
        "nationality": "THA",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/116665",
        "evidence_name": "ILCA District Championship 2025 — ILCA 7 results",
        "evidence_notes": "Identity resolved: Matches existing profile Casey Algra (RVYC, THA, sail 200119). Source published with first name only.",
        "aliases": ["CASEY"]
    },
    # 20: WONJEONGLEE (Nationals ILCA 7, rank 16)
    {
        "sailor_id": wonjeong_lee_id,
        "is_new": True,
        "new_name": "Wonjeong Lee",
        "new_handle": "wonjeong-lee-sr25-c78219",
        "new_club": "GYEONGGI-DO YACHT ASSOCIATION",
        "new_nationality": "KOR",
        "new_sail": "224347",
        "new_gender": "M",
        "sheet_id": sheets["nationals_ilca7"],
        "entry_label": "WONJEONGLEE",
        "sail_num": "224347",
        "nationality": "KOR",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/116670",
        "evidence_name": "ILCA Thailand Nationals 2025 — ILCA 7 results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Korean competitor Wonjeong Lee (Gyeonggi-do Yacht Association, KOR, sail 224347).",
        "aliases": ["WONJEONGLEE", "Wonjeong Lee"]
    },
    # 21: NOPPASORN KHUNBOONJAN (Nationals ILCA 6, rank 3)
    {
        "sailor_id": "d29da64f-723a-45e0-a4d6-57eb7a1b1e82",
        "is_new": False,
        "sheet_id": sheets["nationals_ilca6"],
        "entry_label": "NOPPASORN KHUNBOONJAN",
        "sail_num": "220240",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/116669",
        "evidence_name": "ILCA Thailand Nationals 2025 — ILCA 6 results",
        "evidence_notes": "Identity resolved: Matches existing profile Noppassorn Khunboonjan (YRAT, THA). Romanisation variant Noppasorn.",
        "aliases": ["NOPPASORN KHUNBOONJAN", "Noppasorn Khunboonjan"]
    },
    # 22: BRANEE MUANGNGAM (Nationals ILCA 6, rank 8)
    {
        "sailor_id": "92b23e0a-9b81-518e-b23a-a46fab806ace",
        "is_new": False,
        "sheet_id": sheets["nationals_ilca6"],
        "entry_label": "BRANEE MUANGNGAM",
        "sail_num": "210290",
        "nationality": "THA",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/116669",
        "evidence_name": "ILCA Thailand Nationals 2025 — ILCA 6 results",
        "evidence_notes": "Identity resolved: Matches existing profile Paranee Muangngam (YRAT, THA). Romanisation variant Branee vs Paranee.",
        "aliases": ["BRANEE MUANGNGAM", "Branee Muangngam"]
    },
    # 23: NANAFUNAZAWA (Nationals ILCA 6, rank 10)
    {
        "sailor_id": "5ec2f363-6683-5607-8bd8-b2984890b6c2",
        "is_new": False,
        "sheet_id": sheets["nationals_ilca6"],
        "entry_label": "NANAFUNAZAWA",
        "sail_num": "208625",
        "nationality": "JPN",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/116669",
        "evidence_name": "ILCA Thailand Nationals 2025 — ILCA 6 results",
        "evidence_notes": "Identity resolved: Matches existing profile Nana Funazawa (JPN).",
        "aliases": ["NANAFUNAZAWA"]
    },
    # 24: JEONMINSOL (Nationals ILCA 6, rank 29)
    {
        "sailor_id": minsol_jeon_id,
        "is_new": True,
        "new_name": "Minsol Jeon",
        "new_handle": "minsol-jeon-sr25-fb14e7",
        "new_club": "GANGWON",
        "new_nationality": "KOR",
        "new_sail": "207987",
        "new_gender": "F",
        "sheet_id": sheets["nationals_ilca6"],
        "entry_label": "JEONMINSOL",
        "sail_num": "207987",
        "nationality": "KOR",
        "gender": "F",
        "official_url": "https://www.racingrulesofsailing.org/documents/116669",
        "evidence_name": "ILCA Thailand Nationals 2025 — ILCA 6 results",
        "evidence_notes": "Identity resolved: Source-faithful profile created for Korean competitor Minsol Jeon (Gangwon, KOR, sail 207987).",
        "aliases": ["JEONMINSOL", "Jeonminsol", "Minsol Jeon"]
    },
    # 25: MUHAMMAD ADAM AIERELL BIN MOHD AZIZOL AMIRUL (Nationals ILCA 4, rank 5)
    {
        "sailor_id": "5878691c-f01b-4ab4-976c-e6ad27b8782d",
        "is_new": False,
        "sheet_id": sheets["nationals_ilca4"],
        "entry_label": "MUHAMMAD ADAM AIERELL BIN MOHD AZIZOL AMIRUL",
        "sail_num": "209892",
        "nationality": "MAS",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/116668",
        "evidence_name": "ILCA Thailand Nationals 2025 — ILCA 4 results",
        "evidence_notes": "Identity resolved: Matches existing profile Muhammad Adam Aierell Mohd Azizol Amirul (MSA/MSN, MAS).",
        "aliases": ["MUHAMMAD ADAM AIERELL BIN MOHD AZIZOL AMIRUL", "Muhammad Adam Aierell Bin Mohd Azizol Amirul"]
    },
    # 26: JUNG YEON KIM (Nationals ILCA 4, rank 30)
    {
        "sailor_id": "7302a702-2b88-5d53-a946-0bd10f257f43",
        "is_new": False,
        "sheet_id": sheets["nationals_ilca4"],
        "entry_label": "JUNG YEON KIM",
        "sail_num": "215619",
        "nationality": "KOR",
        "gender": "M",
        "official_url": "https://www.racingrulesofsailing.org/documents/116668",
        "evidence_name": "ILCA Thailand Nationals 2025 — ILCA 4 results",
        "evidence_notes": "Identity resolved: Matches existing profile Jeongyeon Kim (Gangwon, KOR). Romanisation variant Jung Yeon Kim.",
        "aliases": ["JUNG YEON KIM", "Jung Yeon Kim"]
    }
]

sql_lines = [
    "-- Thailand Nationals, District, and Children's Day 2025: Resolution of 27 held entries (Cluster 3E)",
    "BEGIN;",
    "DO $resolve$",
    "DECLARE",
    f"  v_childrens_ilca6 uuid := '{sheets['childrens_ilca6']}';",
    f"  v_childrens_opti_green uuid := '{sheets['childrens_opti_green']}';",
    f"  v_childrens_opti_gold uuid := '{sheets['childrens_opti_gold']}';",
    f"  v_childrens_opti_silver uuid := '{sheets['childrens_opti_silver']}';",
    f"  v_longdist_ilca4 uuid := '{sheets['longdist_ilca4']}';",
    f"  v_longdist_opti uuid := '{sheets['longdist_opti']}';",
    f"  v_district_ilca4 uuid := '{sheets['district_ilca4']}';",
    f"  v_district_ilca7 uuid := '{sheets['district_ilca7']}';",
    f"  v_nationals_ilca4 uuid := '{sheets['nationals_ilca4']}';",
    f"  v_nationals_ilca6 uuid := '{sheets['nationals_ilca6']}';",
    f"  v_nationals_ilca7 uuid := '{sheets['nationals_ilca7']}';",
    "  v_count int;",
    "BEGIN",
    "  PERFORM pg_advisory_xact_lock(hashtextextended('nationals-district-childrens-2025-resolution', 0));",
    "",
    "  -- Verify initial counts on sheets",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_ilca6;",
    "  IF v_count != 10 THEN RAISE EXCEPTION 'Expected 10 results on childrens_ilca6, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_green;",
    "  IF v_count != 24 THEN RAISE EXCEPTION 'Expected 24 results on childrens_opti_green, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_gold;",
    "  IF v_count != 30 THEN RAISE EXCEPTION 'Expected 30 results on childrens_opti_gold, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_silver;",
    "  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on childrens_opti_silver, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_ilca4;",
    "  IF v_count != 12 THEN RAISE EXCEPTION 'Expected 12 results on longdist_ilca4, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_opti;",
    "  IF v_count != 53 THEN RAISE EXCEPTION 'Expected 53 results on longdist_opti, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca4;",
    "  IF v_count != 40 THEN RAISE EXCEPTION 'Expected 40 results on district_ilca4, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca7;",
    "  IF v_count != 12 THEN RAISE EXCEPTION 'Expected 12 results on district_ilca7, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca4;",
    "  IF v_count != 32 THEN RAISE EXCEPTION 'Expected 32 results on nationals_ilca4, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca6;",
    "  IF v_count != 28 THEN RAISE EXCEPTION 'Expected 28 results on nationals_ilca6, found %', v_count; END IF;",
    "  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca7;",
    "  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on nationals_ilca7, found %', v_count; END IF;",
    "",
    "  -- Step 1: Create source-faithful profiles for new sailors and restore unmerged profiles",
    "  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, dob, created_at, updated_at)",
    "  VALUES ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Torn Rattana', 'torn-rattana-thai25-efba7d', 'RVYC/YRAT', 'THA', '221947', 'M', '2008-01-01', now(), now())",
    "  ON CONFLICT (id) DO UPDATE SET",
    "    name = EXCLUDED.name, handle = EXCLUDED.handle, club = EXCLUDED.club, nationality = EXCLUDED.nationality, sail_number = EXCLUDED.sail_number, gender = EXCLUDED.gender, dob = EXCLUDED.dob;",
]

for m in mapping:
    if m.get("is_new"):
        sql_lines.append(f"  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)")
        sql_lines.append(f"  VALUES ('{m['sailor_id']}', '{m['new_name']}', '{m['new_handle']}', '{m['new_club']}', '{m['new_nationality']}', '{m['new_sail']}', '{m['new_gender']}', now(), now())")
        sql_lines.append(f"  ON CONFLICT (id) DO NOTHING;")

sql_lines.append("")
sql_lines.append("  -- Step 2: Register aliases and restore distinct results for Torn Rattana")
sql_lines.append("  DELETE FROM public.sailor_aliases WHERE sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' AND alias_name = 'Torn Rattana';")
sql_lines.append("  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES")
sql_lines.append("    ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Torn Rattana'),")
sql_lines.append("    ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'TORN RATTANA'),")
sql_lines.append("    ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Torn RATTANA')")
sql_lines.append("  ON CONFLICT (alias_name) DO UPDATE SET sailor_id = EXCLUDED.sailor_id;")
sql_lines.append("")
sql_lines.append("  -- Repoint existing results of Torn Rattana (sail 221947) previously merged into Ton Rattana")
sql_lines.append("  UPDATE public.regatta_results SET sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'")
sql_lines.append("  WHERE id IN (")
sql_lines.append("    '11b5d23c-71fb-5559-8816-a4a9e2247c07',")
sql_lines.append("    '88522579-83bc-547a-89f9-b3b082d56fcd',")
sql_lines.append("    '57f9fb2d-c022-50a4-8fb2-e5cedfd3e2ec',")
sql_lines.append("    '9783ff6b-c307-5bc2-ac7b-518c3c6a7f2d',")
sql_lines.append("    '5d5bf98c-da7a-52ed-9ba9-2ffd10dd70b0',")
sql_lines.append("    '31d214ea-f890-598a-a9e0-8e3f9df61ded'")
sql_lines.append("  );")
sql_lines.append("  UPDATE public.regatta_result_participants SET sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'")
sql_lines.append("  WHERE regatta_result_id IN (")
sql_lines.append("    '11b5d23c-71fb-5559-8816-a4a9e2247c07',")
sql_lines.append("    '88522579-83bc-547a-89f9-b3b082d56fcd',")
sql_lines.append("    '57f9fb2d-c022-50a4-8fb2-e5cedfd3e2ec',")
sql_lines.append("    '9783ff6b-c307-5bc2-ac7b-518c3c6a7f2d',")
sql_lines.append("    '5d5bf98c-da7a-52ed-9ba9-2ffd10dd70b0',")
sql_lines.append("    '31d214ea-f890-598a-a9e0-8e3f9df61ded'")
sql_lines.append("  );")
sql_lines.append("")
sql_lines.append("  -- Re-insert Torn Rattana Rank 3 in ILCA Thailand Nationals 2025 (ILCA 4)")
sql_lines.append("  INSERT INTO public.regatta_results (")
sql_lines.append("    id, sailor_id, regatta_id, rank, nett_score, total_score,")
sql_lines.append("    is_dns, is_overseas_commitment, gender, nationality,")
sql_lines.append("    official_url, evidence_name, evidence_type, evidence_notes,")
sql_lines.append("    verification_status, verified_at, entry_label, entry_sail_number,")
sql_lines.append("    entry_type, created_at, updated_at")
sql_lines.append("  ) VALUES (")
sql_lines.append("    'cb4f9040-48d7-5248-b5ce-4aeb934924cd', 'efba7d9a-d71a-55b9-90fc-5ec21941baa1', v_nationals_ilca4, 3, 42.0, 55.0,")
sql_lines.append("    false, false, 'M', 'THA',")
sql_lines.append("    'https://www.racingrulesofsailing.org/documents/116668', 'ILCA Thailand Nationals 2025 — ILCA 4 results', 'pdf',")
sql_lines.append("    'Identity unmerged & restored: Torn Rattana (RVYC/YRAT, sail 221947) distinct from Ton Rattana (RVYC, sail 222180).',")
sql_lines.append("    'verified', now(), 'TORN RATTANA', '221947',")
sql_lines.append("    'individual', now(), now()")
sql_lines.append("  );")
sql_lines.append("  INSERT INTO public.regatta_result_participants (")
sql_lines.append("    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at")
sql_lines.append("  ) VALUES (")
sql_lines.append("    'e58ed71d-be6e-536d-9f56-f2a50d737a32', 'cb4f9040-48d7-5248-b5ce-4aeb934924cd', 'efba7d9a-d71a-55b9-90fc-5ec21941baa1',")
sql_lines.append("    'TORN RATTANA', 1, 'solo', 'matched', true, now(), now()")
sql_lines.append("  );")
sql_lines.append("  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 1, 8.0, NULL, false, '8.0'),")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 2, 9.0, NULL, false, '9.0'),")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 3, 9.0, NULL, false, '9.0'),")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 4, 13.0, NULL, true, '(13.0)'),")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 5, 5.0, NULL, false, '5.0'),")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 6, 5.0, NULL, false, '5.0'),")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 7, 4.0, NULL, false, '4.0'),")
sql_lines.append("    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 8, 2.0, NULL, false, '2.0');")
sql_lines.append("")
sql_lines.append("  -- Insert missing Rank 2 and Rank 6 in Children's Day 2025 Optimist Gold (Sorawit Naksuk, Panudat Polpool)")
sql_lines.append("  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES")
sql_lines.append("    ('5d26c5a2-fefa-462b-9aea-23fc1092f5cf', 'SORAWIT NAKSUK'),")
sql_lines.append("    ('2c3a793f-5bb5-531e-9290-5d976898618a', 'PANUDAT POLPOOL'),")
sql_lines.append("    ('2c3a793f-5bb5-531e-9290-5d976898618a', 'panudat polpool')")
sql_lines.append("  ON CONFLICT DO NOTHING;")
sql_lines.append("")
sql_lines.append("  INSERT INTO public.regatta_results (")
sql_lines.append("    id, sailor_id, regatta_id, rank, nett_score, total_score,")
sql_lines.append("    is_dns, is_overseas_commitment, gender, nationality,")
sql_lines.append("    official_url, evidence_name, evidence_type, evidence_notes,")
sql_lines.append("    verification_status, verified_at, entry_label, entry_sail_number,")
sql_lines.append("    entry_type, created_at, updated_at")
sql_lines.append("  ) VALUES (")
sql_lines.append("    'f2e4b419-58ec-5cf4-b841-382a887b4ea1', '5d26c5a2-fefa-462b-9aea-23fc1092f5cf', v_childrens_opti_gold, 2, 18.0, 28.0,")
sql_lines.append("    false, false, 'M', 'THA',")
sql_lines.append("    'https://www.racingrulesofsailing.org/documents/103600', 'Children’s Day Regatta 2025 — Optimist Gold results', 'pdf',")
sql_lines.append("    'Official provisional source: SORAWIT NAKSUK; sail THA1493; club YRAT; YOB 2012. Series score excluding worst score yields nett 18.0, gross 28.0.',")
sql_lines.append("    'verified', now(), 'SORAWIT NAKSUK', 'THA1493',")
sql_lines.append("    'individual', now(), now()")
sql_lines.append("  );")
sql_lines.append("  INSERT INTO public.regatta_result_participants (")
sql_lines.append("    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at")
sql_lines.append("  ) VALUES (")
sql_lines.append("    '7ba78db6-e910-53bc-9ebf-4f6ffad67a12', 'f2e4b419-58ec-5cf4-b841-382a887b4ea1', '5d26c5a2-fefa-462b-9aea-23fc1092f5cf',")
sql_lines.append("    'SORAWIT NAKSUK', 1, 'solo', 'matched', true, now(), now()")
sql_lines.append("  );")
sql_lines.append("  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES")
sql_lines.append("    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 1, 3.0, NULL, false, '3'),")
sql_lines.append("    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 2, 8.0, NULL, false, '8.0'),")
sql_lines.append("    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 3, 3.0, NULL, false, '3'),")
sql_lines.append("    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 4, 1.0, NULL, false, '1'),")
sql_lines.append("    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 5, 3.0, NULL, false, '3'),")
sql_lines.append("    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 6, 10.0, NULL, true, '(10.0)');")
sql_lines.append("")
sql_lines.append("  INSERT INTO public.regatta_results (")
sql_lines.append("    id, sailor_id, regatta_id, rank, nett_score, total_score,")
sql_lines.append("    is_dns, is_overseas_commitment, gender, nationality,")
sql_lines.append("    official_url, evidence_name, evidence_type, evidence_notes,")
sql_lines.append("    verification_status, verified_at, entry_label, entry_sail_number,")
sql_lines.append("    entry_type, created_at, updated_at")
sql_lines.append("  ) VALUES (")
sql_lines.append("    'd4c1f938-1649-5da7-95ae-13e64f777e48', '2c3a793f-5bb5-531e-9290-5d976898618a', v_childrens_opti_gold, 6, 38.0, 52.0,")
sql_lines.append("    false, false, 'M', 'THA',")
sql_lines.append("    'https://www.racingrulesofsailing.org/documents/103600', 'Children’s Day Regatta 2025 — Optimist Gold results', 'pdf',")
sql_lines.append("    'Official provisional source: panudat polpool; sail THA1295; club YRAT; YOB 2012. Series score excluding worst score yields nett 38.0, gross 52.0.',")
sql_lines.append("    'verified', now(), 'panudat polpool', 'THA1295',")
sql_lines.append("    'individual', now(), now()")
sql_lines.append("  );")
sql_lines.append("  INSERT INTO public.regatta_result_participants (")
sql_lines.append("    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at")
sql_lines.append("  ) VALUES (")
sql_lines.append("    'a5e4d291-766a-54cf-bfa4-0c2ef3899723', 'd4c1f938-1649-5da7-95ae-13e64f777e48', '2c3a793f-5bb5-531e-9290-5d976898618a',")
sql_lines.append("    'panudat polpool', 1, 'solo', 'matched', true, now(), now()")
sql_lines.append("  );")
sql_lines.append("  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES")
sql_lines.append("    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 1, 12.0, NULL, false, '12.0'),")
sql_lines.append("    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 2, 11.0, NULL, false, '11.0'),")
sql_lines.append("    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 3, 7.0, NULL, false, '7.0'),")
sql_lines.append("    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 4, 14.0, NULL, true, '(14.0)'),")
sql_lines.append("    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 5, 1.0, NULL, false, '1.0'),")
sql_lines.append("    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 6, 7.0, NULL, false, '7.0');")
sql_lines.append("")

for m in mapping:
    for a in m["aliases"]:
        sql_lines.append(f"  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('{m['sailor_id']}', '{a}') ON CONFLICT DO NOTHING;")

sql_lines.append("")
sql_lines.append("  -- Step 3: Insert 27 regatta results, participants, and race scores")

for idx, m in enumerate(mapping):
    e = d[idx]
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

sql_lines.append("  -- Step 4: Verify final counts on all 11 affected sheets")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_ilca6;")
sql_lines.append("  IF v_count != 11 THEN RAISE EXCEPTION 'Expected 11 results on childrens_ilca6, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_green;")
sql_lines.append("  IF v_count != 27 THEN RAISE EXCEPTION 'Expected 27 results on childrens_opti_green, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_gold;")
sql_lines.append("  IF v_count != 35 THEN RAISE EXCEPTION 'Expected 35 results on childrens_opti_gold, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_silver;")
sql_lines.append("  IF v_count != 35 THEN RAISE EXCEPTION 'Expected 35 results on childrens_opti_silver, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_ilca4;")
sql_lines.append("  IF v_count != 13 THEN RAISE EXCEPTION 'Expected 13 results on longdist_ilca4, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_opti;")
sql_lines.append("  IF v_count != 58 THEN RAISE EXCEPTION 'Expected 58 results on longdist_opti, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca4;")
sql_lines.append("  IF v_count != 42 THEN RAISE EXCEPTION 'Expected 42 results on district_ilca4, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca7;")
sql_lines.append("  IF v_count != 13 THEN RAISE EXCEPTION 'Expected 13 results on district_ilca7, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca4;")
sql_lines.append("  IF v_count != 35 THEN RAISE EXCEPTION 'Expected 35 results on nationals_ilca4, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca6;")
sql_lines.append("  IF v_count != 32 THEN RAISE EXCEPTION 'Expected 32 results on nationals_ilca6, found %', v_count; END IF;")
sql_lines.append("  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca7;")
sql_lines.append("  IF v_count != 32 THEN RAISE EXCEPTION 'Expected 32 results on nationals_ilca7, found %', v_count; END IF;")
sql_lines.append("")
sql_lines.append("  -- Step 5: Update schedule_notes on all 11 sheets to reflect complete imports")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 11 of 11 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_childrens_ilca6;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 27 of 27 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_childrens_opti_green;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Official source status: provisional. Published organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 35 of 35 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_childrens_opti_gold;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Official source status: provisional. Published organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 35 of 35 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_childrens_opti_silver;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Original combined PY handicap standings; class subset, with original ranks and scores. Complete import: 13 of 13 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_longdist_ilca4;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 58 of 58 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_longdist_opti;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Official source status: provisional. Published organiser results; final/provisional status not stated. Official fleet ranks, scoring codes and discards retained. Complete import: 42 of 42 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_district_ilca4;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Official source status: provisional. Published organiser results; final/provisional status not stated. Official fleet ranks, scoring codes and discards retained. Complete import: 13 of 13 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_district_ilca7;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 35 of 35 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_nationals_ilca4;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 32 of 32 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_nationals_ilca6;")
sql_lines.append("")
sql_lines.append("  UPDATE public.regattas")
sql_lines.append("  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 32 of 32 class entries imported; 0 awaiting identity or source review.', updated_at = now()")
sql_lines.append("  WHERE id = v_nationals_ilca7;")
sql_lines.append("")
sql_lines.append("  -- Step 6: Audit logging")
sql_lines.append("  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_childrens_ilca6, 'childrens-day-regatta-2025-ilca6', 'Resolved 1 held entry (Kim). Sheet is 100% complete (11/11).', '{\"resolved_count\": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_childrens_opti_green, 'childrens-day-regatta-2025-optimist-green', 'Resolved 3 held entries. Sheet is 100% complete (27/27).', '{\"resolved_count\": 3}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_childrens_opti_gold, 'childrens-day-regatta-2025-optimist-gold', 'Resolved 3 held entries (Tara, Chananchai, Kiitchakhun) and restored 2 entries with source arithmetic discrepancies (Sorawit Naksuk, Panudat Polpool). Sheet is 100% complete (35/35).', '{\"resolved_count\": 3, \"restored_count\": 2}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_childrens_opti_silver, 'childrens-day-regatta-2025-optimist-silver', 'Resolved 4 held entries. Sheet is 100% complete (35/35).', '{\"resolved_count\": 4}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_longdist_ilca4, 'thailand-nationals-long-distance-2025-ilca4', 'Resolved 1 held entry (Pumitus Mee-Iamsin). Sheet is 100% complete (13/13).', '{\"resolved_count\": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_longdist_opti, 'thailand-nationals-long-distance-2025-optimist', 'Resolved 5 held entries. Sheet is 100% complete (58/58).', '{\"resolved_count\": 5}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_district_ilca4, 'ilca-district-championship-2025-ilca4', 'Resolved 2 held entries (Kiitchakhun, Jemima Chang). Sheet is 100% complete (42/42).', '{\"resolved_count\": 2}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_district_ilca7, 'ilca-district-championship-2025-ilca7', 'Resolved 1 held entry (Casey Algra). Sheet is 100% complete (13/13).', '{\"resolved_count\": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_nationals_ilca4, 'ilca-thailand-nationals-2025-ilca4', 'Resolved 2 held entries (Muhammad Adam Aierell, Jeongyeon Kim) and restored Torn Rattana (Rank 3) unmerged from Ton Rattana. Sheet is 100% complete (35/35).', '{\"resolved_count\": 2, \"restored_count\": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_nationals_ilca6, 'ilca-thailand-nationals-2025-ilca6', 'Resolved 4 held entries (Noppassorn, Paranee, Nana Funazawa, Minsol Jeon). Sheet is 100% complete (32/32).', '{\"resolved_count\": 4}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),")
sql_lines.append("    ('results.resolve_identity', 'regatta', v_nationals_ilca7, 'ilca-thailand-nationals-2025-ilca7', 'Resolved 1 held entry (Wonjeong Lee). Sheet is 100% complete (32/32).', '{\"resolved_count\": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12');")
sql_lines.append("")
sql_lines.append("END $resolve$;")
sql_lines.append("COMMIT;")

with open('scripts/imports/sail-result-2025/resolve_cluster3e.sql', 'w') as f:
    f.write('\n'.join(sql_lines) + '\n')

print("Generated scripts/imports/sail-result-2025/resolve_cluster3e.sql successfully!")
