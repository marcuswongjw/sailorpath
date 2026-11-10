#!/usr/bin/env python3
"""Generate Migration 184: Google-Researched Sailor Enrichments, Sail Number '0' Backfills, Gender Normalization, and Verified Olympian Portraits."""

import json

def main():
    with open("/tmp/researched_sailors_db.json") as f:
        t1 = f.read()
    researched = {r["name"]: r for r in json.loads(t1[t1.find("{"):])["rows"]}

    with open("/tmp/sail_number_zero_backfills.json") as f:
        t2 = f.read()
    sn_zero_rows = json.loads(t2[t2.find("{"):])["rows"]

    def get_id(name):
        if name not in researched:
            raise KeyError(f"Missing sailor in researched_sailors_db.json: {name}")
        return researched[name]["id"]

    # 1. Nationality enrichments
    nat_updates = [
        (get_id("Rob Carmichael"), "Rob Carmichael", "THA", "UWC Thailand / Phuket King's Cup ILCA 7"),
    ]

    # 2. Sail number '0' backfills
    sail_number_updates = []
    for r in sn_zero_rows:
        entry_sn = (r.get("entry_sail_number") or "").strip()
        if not entry_sn or entry_sn in ("0", "TBD"):
            continue
        sail_number_updates.append((
            r["id"],
            r["name"],
            entry_sn,
            r.get("boat_class") or "",
            r.get("regatta_name") or "",
            r.get("date") or "",
        ))

    # 3. Gender enrichments (missing genders)
    gender_updates = [
        ("91d872b9-db2a-4d54-a62b-16cd7852e967", "Charles Lim", "M", "Singapore Sailing Olympian (SGP)"),
        (get_id("Rob Carmichael"), "Rob Carmichael", "M", "Phuket King's Cup ILCA 7 Men"),
        (get_id("William Lawson"), "William Lawson", "M", "HHSC Australian Optimist Fleet"),
        (get_id("Tom Kefford"), "Tom Kefford", "M", "CYC Australian Optimist Fleet"),
        (get_id("Edward Payne"), "Edward Payne", "M", "HHSC Australian Optimist Fleet"),
        (get_id("Sienna Murray"), "Sienna Murray", "F", "RPAYC Australian Optimist Fleet"),
        (get_id("Olivia Dorling"), "Olivia Dorling", "F", "RPAYC Australian Optimist Fleet"),
        (get_id("Kar Lai Kelly Lam"), "Kar Lai Kelly Lam", "F", "HKSF Hong Kong Optimist Fleet"),
        (get_id("Ka Wai Chloe Wan"), "Ka Wai Chloe Wan", "F", "HKSF Hong Kong Optimist Fleet"),
        (get_id("Isaac Wang"), "Isaac Wang", "M", "ABC Hong Kong Optimist Fleet"),
        (get_id("Xavier Lam"), "Xavier Lam", "M", "HHYC Hong Kong Optimist Fleet"),
        (get_id("Oliver Korn"), "Oliver Korn", "M", "GRSC Australian Optimist Fleet"),
    ]

    # 4. Exact DOB / Birth Year Enrichments
    dob_updates = [
        ("680d176e-85d5-54f6-b2df-01ca565b7ecb", "Matt Wearn", "1995-09-30", True, "Olympedia / Australian Olympic Committee"),
        ("2a7fedd4-73b4-5807-89ae-ec34197838c0", "Mara Stransky", "1999-02-13", True, "Olympedia (140654)"),
        ("0ac22efe-1376-54c7-bd3e-ee7afcea883b", "Zoe Thomson", "1998-04-02", True, "Olympedia (153891)"),
        ("8f66574a-1cc9-557a-b01b-87608ee05c60", "Elliot Hansen", "1994-02-12", True, "Olympedia (143186)"),
        ("61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1", "Lorenzo Brando Chiavarini", "1994-01-17", True, "Olympedia (153999)"),
        ("e65296f7-fdc4-582a-b74b-fc2463ea8228", "Nur Shazrin Mohamad Latif", "1998-02-02", True, "Olympedia (131040)"),
        ("98bf4b68-3283-5b87-bbbe-d11c1977eafc", "Stephanie Norton", "2000-09-18", True, "Olympedia (143573)"),
        ("f724016b-a2d6-5d4b-82a0-5ad506ba3bfb", "Arthit Mikhail Romanyk", "2001-01-16", True, "Olympedia (154051)"),
        ("36b2c840-0917-5a4d-aa40-cd2be30c9780", "Supakon Pongwichean", "1995-04-20", True, "Olympedia (1304108)"),
        ("cf6c134b-acef-4bcb-a77c-8639b4251b65", "Sophia Montgomery", "2003-04-04", True, "Olympedia (154050)"),
        ("5179761d-9f8b-498d-bf0b-17cd8dcc4fd6", "Khairulnizam Mohd Afendy", "1993-05-27", True, "Olympedia (125480)"),
        ("06bd4877-4d96-44b0-9f66-c14f0061fe59", "Nicholas Halliday", "1999-06-18", True, "Olympedia (153984)"),
        ("85b27d22-63dd-4d37-a8a5-d5284edf08b2", "Ma Kwan Ching", "1997-08-31", True, "Olympedia (153981)"),
        ("d792628c-3845-4a63-bb2c-4811e9d2dd56", "Cheng Ching Yin", "1999-08-10", True, "Olympedia (153983)"),
        ("fd29d27b-51f0-47b5-b350-47174654ba5e", "Nethra Kumanan", "1997-08-21", True, "Olympedia (143739)"),
        ("1b2c502f-5e5a-58e8-83f3-12817b1126f0", "Vishnu Saravanan", "1999-02-24", True, "Olympedia (143783)"),
        ("f563ea85-dc20-5eb5-9f2a-4ae0a3427716", "Koh Seng Leong", "1983-09-19", True, "Olympedia (92947)"),
        ("91d872b9-db2a-4d54-a62b-16cd7852e967", "Charles Lim", "1973-07-10", True, "Olympedia (62775)"),
        ("e92c8a88-4f8a-5432-9e0d-42ad1e707486", "Colin Cheng Xinru", "1989-09-10", True, "Olympedia (121476)"),
        ("4657a5d7-770c-456a-a381-4fb261c5e6e8", "Tan Wearn Haw", "1978-11-12", True, "Olympedia (92945)"),
        ("df7c6bd6-12f7-412b-994a-f116e820e30d", "Ryan Lo Jun Han", "1997-02-26", True, "Olympedia (146534)"),
        ("be779040-d45c-4052-b458-9c9e88803505", "Keira Carlyle", "2006-01-25", True, "OCA Hangzhou 2022 Asian Games Profile"),
        ("20f686db-6a99-5bd1-8db1-23e5a24368d9", "Casey Imeneo", "1998-01-01", False, "Victorian Institute of Sport Profile"),
        ("0746fdb3-9981-4881-8b8d-0db869997999", "Jonathan Chan", "2008-01-01", False, "Singapore Sailing 2025 Techno 293Plus Worlds (17yo in 2025)"),
        (get_id("Ethan Lee"), "Ethan Lee", "2011-01-01", False, "Singapore Youth Sailing / Victoria School"),
        (get_id("Wai Zhi Tong"), "Wai Zhi Tong", "2011-01-01", False, "Singapore Youth Sailing / CHIJ Secondary"),
        (get_id("Rayson Lee Yin Yi"), "Rayson Lee Yin Yi", "2013-01-01", False, "racingrulesofsailing.org / Ai Tong School"),
        (get_id("Eitan Oh"), "Eitan Oh", "2008-01-01", False, "racingrulesofsailing.org / Raffles Institution"),
        (get_id("Foo Yuei Jit"), "Foo Yuei Jit", "2009-01-01", False, "racingrulesofsailing.org / SJI"),
    ]

    # 5. Club Enrichments
    club_updates = [
        (get_id("Axl Tan Yi En"), "Axl Tan Yi En", "Constant Wind SeaSports", "racingrulesofsailing.org (Techno 293)"),
        (get_id("Merelle Xuanying Tay"), "Merelle Xuanying Tay", "SAF Yacht Club", "racingrulesofsailing.org / Sailwave"),
        (get_id("Low Hao Xuan Josh"), "Low Hao Xuan Josh", "SAF Yacht Club", "racingrulesofsailing.org"),
        (get_id("Leopold Sayawaki-Kogut"), "Leopold Sayawaki-Kogut", "Changi Sailing Club", "Sailwave / Singapore regatta records"),
        (get_id("Tham Wan Yew Amos"), "Tham Wan Yew Amos", "MOE Sea Sports Centre", "RSYC / MOE regatta records"),
        (get_id("Moses Tan Hee"), "Moses Tan Hee", "SAF Yacht Club", "racingrulesofsailing.org / Sailwave"),
        (get_id("Yap Swee Dean"), "Yap Swee Dean", "SAF Yacht Club", "racingrulesofsailing.org"),
        (get_id("Balthazar Roche"), "Balthazar Roche", "Woollahra Sailing Club", "sailingresults.net / SSCBC"),
        (get_id("Luca De Giosa"), "Luca De Giosa", "Hunters Hill Sailing Club", "sailingresults.net / HHSC"),
        (get_id("Emerald Jacobsen"), "Emerald Jacobsen", "Woollahra Sailing Club", "sailingresults.net"),
        (get_id("Sijia Deng"), "Sijia Deng", "Hunters Hill Sailing Club", "sailingresults.net / mysailing.com.au"),
        (get_id("Emma Tomkins"), "Emma Tomkins", "Hunters Hill Sailing Club", "sailingresults.net"),
        (get_id("Alix Nguyen-Minh"), "Alix Nguyen-Minh", "Aberdeen Boat Club", "racingrulesofsailing.org / HKRW"),
        (get_id("Soki Higuchi"), "Soki Higuchi", "Shonan Junior Yacht Club", "racingrulesofsailing.org"),
        (get_id("Kotaro Matsunaga"), "Kotaro Matsunaga", "Chuo Junior Yacht Club", "racingrulesofsailing.org"),
        (get_id("Natsumi Kubota"), "Natsumi Kubota", "B&G Hyogo Junior Ocean Club", "racingrulesofsailing.org"),
        (get_id("Kaito Nakamura"), "Kaito Nakamura", "Yumenoshima Yacht Club", "racingrulesofsailing.org"),
        (get_id("Riko Muranaka"), "Riko Muranaka", "B&G Hyogo Junior Ocean Club", "JODA / objectstorage records"),
        (get_id("Kaito Hirasawa"), "Kaito Hirasawa", "Team Koto", "JODA records"),
        (get_id("Tadanao Matsuoka"), "Tadanao Matsuoka", "B&G Matsuyama Sailing Club", "JODA records"),
        (get_id("Luqmaan Aneeq"), "Luqmaan Aneeq", "Royal College Sailing Team", "slsports.lk / Daily News Sri Lanka"),
        (get_id("Mckaella Karunaratne"), "Mckaella Karunaratne", "Ladies' College Sailing Club", "The Morning / Daily News Sri Lanka"),
        (get_id("Laila Hazari"), "Laila Hazari", "Methodist College Sailing Club", "Daily Mirror Sri Lanka"),
        (get_id("Aung Sitt Maung"), "Aung Sitt Maung", "Yangon Sailing Club", "Myanmar Yachting Federation / ODAM"),
        (get_id("Sitt May Chit Po"), "Sitt May Chit Po", "Yangon Sailing Club", "Myanmar Yachting Federation / ODAM"),
        (get_id("Aung Kaung Myat"), "Aung Kaung Myat", "Yangon Sailing Club", "Myanmar Yachting Federation / ODAM"),
        (get_id("Arman Aye"), "Arman Aye", "Yangon Sailing Club", "Myanmar Yachting Federation / ODAM"),
        (get_id("Shoom Lai Khin"), "Shoom Lai Khin", "Yangon Sailing Club", "Myanmar Yachting Federation / ODAM"),
        (get_id("Eaint Po Mo Chit"), "Eaint Po Mo Chit", "Yangon Sailing Club", "Myanmar Yachting Federation / ODAM"),
        (get_id("Rob Carmichael"), "Rob Carmichael", "UWC Thailand", "Phuket / UWC Thailand"),
        ("4657a5d7-770c-456a-a381-4fb261c5e6e8", "Tan Wearn Haw", "Singapore Sailing Federation", "SNOC / Olympedia"),
        ("98bf4b68-3283-5b87-bbbe-d11c1977eafc", "Stephanie Norton", "Royal Hong Kong Yacht Club", "HKSF / Olympedia"),
        ("e65296f7-fdc4-582a-b74b-fc2463ea8228", "Nur Shazrin Mohamad Latif", "Malaysian Sailing Association", "Olympedia / MSA"),
        ("06bd4877-4d96-44b0-9f66-c14f0061fe59", "Nicholas Halliday", "Royal Hong Kong Yacht Club", "HKSF"),
        ("cf6c134b-acef-4bcb-a77c-8639b4251b65", "Sophia Montgomery", "Royal Varuna Yacht Club", "YRAT"),
        ("fd29d27b-51f0-47b5-b350-47174654ba5e", "Nethra Kumanan", "Tamil Nadu Sailing Association", "YAI / TNSA"),
        ("1b2c502f-5e5a-58e8-83f3-12817b1126f0", "Vishnu Saravanan", "Army Yachting Node", "YAI / Indian Army Sailing"),
    ]

    # 6. School Enrichments
    school_updates = [
        (get_id("Axl Tan Yi En"), "Axl Tan Yi En", "Anglo-Chinese School (Barker Road)", "racingrulesofsailing.org"),
        (get_id("Cleo Seah En Rui"), "Cleo Seah En Rui", "Nanyang Polytechnic", "racingrulesofsailing.org"),
        (get_id("Elizabeth Victoria Say"), "Elizabeth Victoria Say", "Dunman High School", "racingrulesofsailing.org"),
        (get_id("Merelle Xuanying Tay"), "Merelle Xuanying Tay", "St. Hilda's Secondary School", "racingrulesofsailing.org"),
        (get_id("Low Hao Xuan Josh"), "Low Hao Xuan Josh", "Victoria School", "moe.edu.sg / racingrulesofsailing.org"),
        (get_id("Leopold Sayawaki-Kogut"), "Leopold Sayawaki-Kogut", "The Japanese School", "Sailwave / Singapore Youth Regatta"),
        (get_id("Tham Wan Yew Amos"), "Tham Wan Yew Amos", "Victoria School", "moe.edu.sg"),
        (get_id("Moses Tan Hee"), "Moses Tan Hee", "Anglo-Chinese School (Junior)", "racingrulesofsailing.org"),
        (get_id("Catherine Maiden"), "Catherine Maiden", "Opera Estate Primary School", "racingrulesofsailing.org"),
        (get_id("Cheung Kai Jeng Keenan"), "Cheung Kai Jeng Keenan", "Raffles Institution", "Raffles Press / racingrulesofsailing.org"),
        (get_id("Cheung Shou Jeng Declan"), "Cheung Shou Jeng Declan", "Raffles Institution", "moe.edu.sg / racingrulesofsailing.org"),
        (get_id("Yap Swee Dean"), "Yap Swee Dean", "Raffles Institution", "racingrulesofsailing.org"),
        (get_id("Rayson Lee Yin Yi"), "Rayson Lee Yin Yi", "Ai Tong School", "moe.edu.sg / racingrulesofsailing.org"),
        (get_id("Eitan Oh"), "Eitan Oh", "Raffles Institution", "racingrulesofsailing.org"),
        (get_id("Foo Yuei Jit"), "Foo Yuei Jit", "Anderson Serangoon Junior College", "racingrulesofsailing.org"),
        (get_id("Clive Wei Jun Seah"), "Clive Wei Jun Seah", "Catholic Junior College", "racingrulesofsailing.org"),
        (get_id("Mathias Yu Da Wong"), "Mathias Yu Da Wong", "Raffles Institution", "racingrulesofsailing.org"),
        (get_id("Ethan Lee"), "Ethan Lee", "Victoria School", "racingrulesofsailing.org"),
        (get_id("Wai Zhi Tong"), "Wai Zhi Tong", "CHIJ Secondary (Toa Payoh)", "racingrulesofsailing.org"),
        (get_id("Zeph Wan"), "Zeph Wan", "Anglo-Chinese School (Independent)", "racingrulesofsailing.org"),
        (get_id("Desiree Lee Yuet Chi"), "Desiree Lee Yuet Chi", "Tanjong Katong Girls' School", "racingrulesofsailing.org"),
        (get_id("Abigail Jia En Ling"), "Abigail Jia En Ling", "Dunman High School", "National School Games"),
        (get_id("Arabelle En Xi Tan"), "Arabelle En Xi Tan", "Tanjong Katong Girls' School", "racingrulesofsailing.org"),
        (get_id("Elisha Lim Yu Ting"), "Elisha Lim Yu Ting", "Raffles Girls' School", "racingrulesofsailing.org"),
        (get_id("Eugene Tan Yi Ze"), "Eugene Tan Yi Ze", "St. Joseph's Institution Junior", "racingrulesofsailing.org"),
        (get_id("Zachary Hong Yi Zhang"), "Zachary Hong Yi Zhang", "St. Joseph's Institution", "racingrulesofsailing.org"),
        (get_id("Jonathan Ho Jian Yi"), "Jonathan Ho Jian Yi", "Anglo-Chinese School (Independent)", "racingrulesofsailing.org"),
        (get_id("Aaron Abraham Say"), "Aaron Abraham Say", "Victoria School", "racingrulesofsailing.org"),
        (get_id("Maia Kiran Lim Laurie"), "Maia Kiran Lim Laurie", "Singapore American School", "racingrulesofsailing.org"),
        (get_id("Misa Lim Laurie"), "Misa Lim Laurie", "Singapore American School", "racingrulesofsailing.org"),
        (get_id("Luqmaan Aneeq"), "Luqmaan Aneeq", "Royal College, Colombo", "slsports.lk"),
        (get_id("Mckaella Karunaratne"), "Mckaella Karunaratne", "Ladies' College, Colombo", "Daily News Sri Lanka"),
        (get_id("Laila Hazari"), "Laila Hazari", "Methodist College, Colombo", "Daily Mirror Sri Lanka"),
    ]

    # 7. Verified Portraits
    photo_updates = [
        ("e92c8a88-4f8a-5432-9e0d-42ad1e707486", "Colin Cheng Xinru", "https://sailorpath.com/athlete-portraits/team-singapore/colin-cheng-xinru.jpg", "Olympedia 121476 official headshot"),
        ("f563ea85-dc20-5eb5-9f2a-4ae0a3427716", "Koh Seng Leong", "https://sailorpath.com/athlete-portraits/team-singapore/koh-seng-leong.jpg", "Olympedia 92947 official headshot"),
        ("91d872b9-db2a-4d54-a62b-16cd7852e967", "Charles Lim", "https://sailorpath.com/athlete-portraits/team-singapore/charles-lim.jpg", "Olympedia 62775 official headshot"),
        ("680d176e-85d5-54f6-b2df-01ca565b7ecb", "Matt Wearn", "https://sailorpath.com/athlete-portraits/international/matt-wearn.jpg", "Olympedia 140820 Tokyo 2020 official headshot"),
        ("2a7fedd4-73b4-5807-89ae-ec34197838c0", "Mara Stransky", "https://sailorpath.com/athlete-portraits/international/mara-stransky.jpg", "Olympedia 140654 Tokyo 2020 official headshot"),
        ("0ac22efe-1376-54c7-bd3e-ee7afcea883b", "Zoe Thomson", "https://sailorpath.com/athlete-portraits/international/zoe-thomson.jpg", "Olympedia 153891 Paris 2024 official headshot"),
        ("8f66574a-1cc9-557a-b01b-87608ee05c60", "Elliot Hansen", "https://sailorpath.com/athlete-portraits/international/elliot-hanson.jpg", "Olympedia 143186 Tokyo 2020 official headshot"),
        ("61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1", "Lorenzo Brando Chiavarini", "https://sailorpath.com/athlete-portraits/international/lorenzo-chiavarini.jpg", "Olympedia 153999 FIV official headshot"),
        ("e65296f7-fdc4-582a-b74b-fc2463ea8228", "Nur Shazrin Mohamad Latif", "https://sailorpath.com/athlete-portraits/international/nur-shazrin-mohamad-latif.jpg", "Olympedia 131040 29th SEA Games official headshot"),
        ("98bf4b68-3283-5b87-bbbe-d11c1977eafc", "Stephanie Norton", "https://sailorpath.com/athlete-portraits/international/stephanie-norton.jpg", "Olympedia 143573 SF&OC HK official headshot"),
        ("f724016b-a2d6-5d4b-82a0-5ad506ba3bfb", "Arthit Mikhail Romanyk", "https://sailorpath.com/athlete-portraits/international/arthit-mikhail-romanyk.jpg", "Olympedia 154051 Paris 2024 official headshot"),
        ("cf6c134b-acef-4bcb-a77c-8639b4251b65", "Sophia Montgomery", "https://sailorpath.com/athlete-portraits/international/sophia-montgomery.jpg", "Olympedia 154050 Paris 2024 official headshot"),
        ("5179761d-9f8b-498d-bf0b-17cd8dcc4fd6", "Khairulnizam Mohd Afendy", "https://sailorpath.com/athlete-portraits/international/khairulnizam-mohd-afendy.jpg", "Olympedia 125480 29th SEA Games official headshot"),
        ("06bd4877-4d96-44b0-9f66-c14f0061fe59", "Nicholas Halliday", "https://sailorpath.com/athlete-portraits/international/nicholas-halliday.jpg", "Olympedia 153984 Paris 2024 official headshot"),
        ("85b27d22-63dd-4d37-a8a5-d5284edf08b2", "Ma Kwan Ching", "https://sailorpath.com/athlete-portraits/international/ma-kwan-ching.jpg", "Olympedia 153981 Paris 2024 official headshot"),
        ("d792628c-3845-4a63-bb2c-4811e9d2dd56", "Cheng Ching Yin", "https://sailorpath.com/athlete-portraits/international/cheng-ching-yin.jpg", "Olympedia 153983 Paris 2024 official headshot"),
        ("fd29d27b-51f0-47b5-b350-47174654ba5e", "Nethra Kumanan", "https://sailorpath.com/athlete-portraits/international/nethra-kumanan.jpg", "Olympedia 143739 official headshot"),
        ("1b2c502f-5e5a-58e8-83f3-12817b1126f0", "Vishnu Saravanan", "https://sailorpath.com/athlete-portraits/international/vishnu-saravanan.jpg", "Olympedia 143783 official headshot"),
    ]

    lines = []
    lines.append("-- Migration 184: Google-Researched Sailor Enrichments, Sail Number '0' Backfills, Gender Normalization, and Verified Olympian Portraits")
    lines.append("--")
    lines.append(f"-- 1. Normalizes legacy 'W' -> 'F' and 'Unknown' -> NULL genders across all sailors.")
    lines.append(f"-- 2. Backfills {len(sail_number_updates)} sail numbers currently set to '0' with official entry_sail_number values.")
    lines.append(f"-- 3. Enriches {len(nat_updates)} nationality, {len(gender_updates)} genders, {len(dob_updates)} DOBs, {len(club_updates)} clubs, and {len(school_updates)} schools from Google Search & Olympic/Federation records.")
    lines.append(f"-- 4. Attaches {len(photo_updates)} verified official Olympic athlete portraits and clears Victoria Chan's unverified placeholder.")
    lines.append("")
    lines.append("BEGIN;")
    lines.append("")

    lines.append("-- ============================================================================")
    lines.append("-- 1. GENDER NORMALIZATION ('W' -> 'F', 'Unknown' -> NULL)")
    lines.append("-- ============================================================================")
    lines.append("UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE gender = 'W';")
    lines.append("UPDATE public.sailors SET gender = NULL, updated_at = clock_timestamp() WHERE gender = 'Unknown';")
    lines.append("")

    lines.append(f"-- ============================================================================")
    lines.append(f"-- 2. SAIL NUMBER '0' BACKFILLS ({len(sail_number_updates)} SAILORS)")
    lines.append(f"-- ============================================================================")
    for sid, name, entry_sn, boat_class, reg_name, reg_date in sail_number_updates:
        s_name = name.replace("'", "''")
        s_sn = entry_sn.replace("'", "''")
        s_reg = reg_name.replace("'", "''")
        lines.append(f"-- {s_name} ({sid}) -> Sail #{s_sn} (from {s_reg}, {reg_date})")
        if "ILCA 4" in boat_class:
            lines.append("UPDATE public.sailors")
            lines.append(f"SET sail_number = '{s_sn}', sail_number_ilca4 = COALESCE(sail_number_ilca4, '{s_sn}'), updated_at = clock_timestamp()")
            lines.append(f"WHERE id = '{sid}' AND sail_number = '0';")
        else:
            lines.append("UPDATE public.sailors")
            lines.append(f"SET sail_number = '{s_sn}', updated_at = clock_timestamp()")
            lines.append(f"WHERE id = '{sid}' AND sail_number = '0';")
        lines.append("")

    lines.append(f"-- ============================================================================")
    lines.append(f"-- 3. NATIONALITY ENRICHMENTS ({len(nat_updates)} SAILOR)")
    lines.append(f"-- ============================================================================")
    for sid, name, nat, src in nat_updates:
        lines.append(f"-- {name} ({sid}) -> {nat} ({src})")
        lines.append(f"UPDATE public.sailors SET nationality = '{nat}', updated_at = clock_timestamp() WHERE id = '{sid}' AND (nationality IS NULL OR nationality = '');")
        lines.append("")

    lines.append(f"-- ============================================================================")
    lines.append(f"-- 4. GENDER ENRICHMENTS ({len(gender_updates)} SAILORS)")
    lines.append(f"-- ============================================================================")
    for sid, name, g, src in gender_updates:
        lines.append(f"-- {name} ({sid}) -> '{g}' ({src})")
        lines.append(f"UPDATE public.sailors SET gender = '{g}', updated_at = clock_timestamp() WHERE id = '{sid}' AND (gender IS NULL OR gender = '');")
        lines.append("")

    lines.append(f"-- ============================================================================")
    lines.append(f"-- 5. DOB ENRICHMENTS ({len(dob_updates)} SAILORS)")
    lines.append(f"-- ============================================================================")
    for sid, name, dob_str, upgrade_jan1, src in dob_updates:
        s_name = name.replace("'", "''")
        s_src = src.replace("'", "''")
        lines.append(f"-- {s_name} ({sid}) -> '{dob_str}' (Source: {s_src})")
        lines.append("UPDATE public.sailors")
        lines.append(f"SET dob = '{dob_str}'::date, updated_at = clock_timestamp()")
        if upgrade_jan1:
            lines.append(f"WHERE id = '{sid}' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');")
        else:
            lines.append(f"WHERE id = '{sid}' AND dob IS NULL;")
        lines.append("")

    lines.append(f"-- ============================================================================")
    lines.append(f"-- 6. CLUB ENRICHMENTS ({len(club_updates)} SAILORS)")
    lines.append(f"-- ============================================================================")
    for sid, name, club, src in club_updates:
        s_name = name.replace("'", "''")
        s_club = club.replace("'", "''")
        s_src = src.replace("'", "''")
        lines.append(f"-- {s_name} ({sid}) -> Club: '{s_club}' (Source: {s_src})")
        lines.append("UPDATE public.sailors")
        lines.append(f"SET club = '{s_club}', updated_at = clock_timestamp()")
        lines.append(f"WHERE id = '{sid}' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');")
        lines.append("")

    lines.append(f"-- ============================================================================")
    lines.append(f"-- 7. SCHOOL ENRICHMENTS ({len(school_updates)} SAILORS)")
    lines.append(f"-- ============================================================================")
    for sid, name, school, src in school_updates:
        s_name = name.replace("'", "''")
        s_school = school.replace("'", "''")
        s_src = src.replace("'", "''")
        lines.append(f"-- {s_name} ({sid}) -> School: '{s_school}' (Source: {s_src})")
        lines.append("UPDATE public.sailors")
        lines.append(f"SET school = '{s_school}', updated_at = clock_timestamp()")
        lines.append(f"WHERE id = '{sid}' AND (school IS NULL OR school = '');")
        lines.append("")

    lines.append(f"-- ============================================================================")
    lines.append(f"-- 8. VERIFIED OLYMPIC PORTRAITS ({len(photo_updates)} SAILORS + 1 CLEAR)")
    lines.append(f"-- ============================================================================")
    lines.append("-- Clear unverified placeholder for Victoria Chan (97cbde3f-9b92-5b2b-abbd-416a43ad32c9)")
    lines.append("UPDATE public.sailors SET avatar_url = NULL, show_profile_photo_on_public_profile = false, updated_at = clock_timestamp() WHERE id = '97cbde3f-9b92-5b2b-abbd-416a43ad32c9';")
    lines.append("")
    for sid, name, url, src in photo_updates:
        s_name = name.replace("'", "''")
        s_src = src.replace("'", "''")
        lines.append(f"-- {s_name} ({sid}) -> {url} ({s_src})")
        lines.append("UPDATE public.sailors")
        lines.append(f"SET avatar_url = '{url}', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()")
        lines.append(f"WHERE id = '{sid}';")
        lines.append("")

    lines.append("-- ============================================================================")
    lines.append("-- 9. AUDIT LOG ENTRY")
    lines.append("-- ============================================================================")
    lines.append("INSERT INTO public.admin_change_log (")
    lines.append("  action, entity_type, entity_id, entity_label, summary, details, source, created_at")
    lines.append(") VALUES (")
    lines.append("  'sailors.demographics_enrichment',")
    lines.append("  'sailor',")
    lines.append("  '00000000-0000-0000-0000-000000000000',")
    lines.append("  'Google Research Profile Enrichment — Migration 184',")
    lines.append(f"  'Normalized genders, backfilled {len(sail_number_updates)} sail_number=0 entries, enriched {len(dob_updates)} DOBs, {len(club_updates)} clubs, {len(school_updates)} schools, {len(gender_updates)} genders, and attached {len(photo_updates)} verified Olympic athlete portraits.',")
    lines.append("  jsonb_build_object(")
    lines.append(f"    'sail_numbers_backfilled', {len(sail_number_updates)},")
    lines.append(f"    'genders_enriched', {len(gender_updates)},")
    lines.append(f"    'dobs_enriched', {len(dob_updates)},")
    lines.append(f"    'clubs_enriched', {len(club_updates)},")
    lines.append(f"    'schools_enriched', {len(school_updates)},")
    lines.append(f"    'photos_attached', {len(photo_updates)}")
    lines.append("  ),")
    lines.append("  'migration_184',")
    lines.append("  clock_timestamp()")
    lines.append(");")
    lines.append("")
    lines.append("COMMIT;")
    lines.append("")

    out_path = "src/db/migrations/184_google_research_enrichments_and_olympic_portraits.sql"
    with open(out_path, "w") as f:
        f.write("\n".join(lines))
    print(f"Generated {out_path} ({len(lines)} lines)")

if __name__ == "__main__":
    main()
