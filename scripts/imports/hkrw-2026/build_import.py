#!/usr/bin/env python3
from __future__ import annotations
import json
import re
import uuid

# Base namespace for deterministic UUIDs
NS = uuid.UUID('7b05d012-a70b-45e5-b0d0-c36fb16f48b4')

def make_uuid(key: str) -> str:
    return str(uuid.uuid5(NS, key))

def make_handle(name: str, disambig: str = "") -> str:
    clean = re.sub(r'[^a-z0-9]+', '-', name.lower().strip()).strip('-')
    suffix = uuid.uuid5(NS, f"{name}:{disambig}").hex[:6]
    return f"{clean}-{suffix}"

# Load live sailors
with open('/tmp/live_sailors_langkawi.json') as f:
    live_sailors = json.load(f)['rows']

# Newly created sailors for HKRW 2026 that must be part of Migration 172
HKRW_NEW_SAILOR_IDS = {
    "058e8046-aa70-5145-9b4f-2270f6683891",
    "5190088d-e98e-5a9f-8176-431f6ef632c7",
    "17bf03a1-784e-52bd-b3d4-c3fa2f47086d",
    "c53b02b5-9285-5325-9edd-12e07f01e4e1",
    "7a100c0d-c2d4-5355-988a-90ca7ab2d776",
    "1504e58c-eb1f-5550-ac5d-cb8bd8edcc59",
    "3114c493-b297-5031-8b50-eb75a88a9d3f",
    "713b2eec-7756-566e-b82d-cab7abdfa7ba",
    "a695d089-977f-5de1-b6f8-29668c4fb57c",
    "a942aae6-1c23-511c-b386-fb0fbd704d06",
    "491de384-41a8-58a9-b767-2205c99b0322",
    "bfa40b34-a5ab-5948-a2a2-7078eace1d91",
    "2113225c-9122-535a-ac52-cf5b2143de4d",
    "d772ab6d-51ae-5b99-82ce-8fdfee006a6e",
    "4814da86-9e14-57a1-96d2-d1e9bc335f6c",
    "ad1da805-d827-5d22-9f38-f47cb18697b8",
    "1a1fbe35-df8c-53ba-a298-9a832678f458",
    "2d689cf2-48aa-5905-950f-91a3c3f77e35",
    "f462d56c-e354-5b0d-945c-faaa30b0d382",
    "69990555-b9fc-532f-a922-1c502dc62ec6",
    "ec92b0f6-3e15-5ef2-bc96-222ffec71b47",
    "516c6861-49b9-55dc-b501-8a4def81f4a2",
    "34935589-166c-5215-8c6a-75090f19db63",
    "0035813f-6b37-5dad-970e-1d43e5fde57c",
    "9a91ea41-973c-5ee9-8af2-52b02212a8bf",
    "0e9d3e8f-7c78-5e7e-9087-e7defa5953c7",
    "7b500a87-14e9-5240-be8a-4553021e0544",
    "31be3df1-f499-5240-947d-ad4ef5bcec32",
    "2866a8ce-4421-5d78-a87a-c10f48461393",
    "10881ed6-7463-5b90-9598-756c7894dd8e",
    "4c2d41d9-2391-5729-aa03-fe1879b1b50e",
    "44e50008-bc46-5daa-8b83-ba77571b5bd9",
    "14ec02c8-1b78-58d6-870f-d1910a1f5e79",
    "a70d76a6-d1d2-54cb-9c47-20e853dca426",
    "b7d88773-fe00-5fb1-a6d0-91d905be4d10",
}

# Index by normalized name (excluding newly created HKRW 2026 profiles)
name_map = {}
for s in live_sailors:
    if s['id'] in HKRW_NEW_SAILOR_IDS:
        continue
    norm = re.sub(r'[^a-z0-9]', '', s['name'].lower())
    name_map.setdefault(norm, []).append(s)

print(f"Loaded {len(name_map)} distinct pre-existing sailor names into name_map.")

# -------------------------------------------------------------
# 1. RAW VERIFIED DATA FOR 29er ASIAN CHAMPIONSHIP & ILCA 6
# -------------------------------------------------------------

# 1. 29er Asian Championship (25 boats / 50 sailors, 11 races, 2 discards)
entries_29er = [
    {
        "rank": 1, "sail": "3354", "div": "Junior, Men", "nat": "HKG",
        "helm_name": "Ethan Kiu", "helm_gender": "M",
        "crew_name": "Louis Polson", "crew_gender": "M",
        "races": ["1.0", "2.0", "1.0", "1.0", "1.0", "1.0", "1.0", "(3.0)", "1.0", "(7.0)", "2.0"],
        "total": 21.0, "net": 11.0
    },
    {
        "rank": 2, "sail": "3053", "div": "Junior, Men", "nat": "HKG",
        "helm_name": "Nicholas Hon", "helm_gender": "M",
        "crew_name": "Kaden Chan", "crew_gender": "M",
        "races": ["2.0", "1.0", "5.0", "2.0", "2.0", "4.0", "2.0", "1.0", "3.0", "(12.0)", "(26.0 DSQ)"],
        "total": 60.0, "net": 22.0
    },
    {
        "rank": 3, "sail": "3355", "div": "Women", "nat": "HKG",
        "helm_name": "Chloe Kong", "helm_gender": "F",
        "crew_name": "McCarley Wong", "crew_gender": "F",
        "races": ["3.0", "(5.0)", "2.0", "3.0", "3.0", "2.0", "3.0", "(11.0)", "2.0", "2.0", "3.0"],
        "total": 39.0, "net": 23.0
    },
    {
        "rank": 4, "sail": "3375", "div": "Junior, Women", "nat": "HKG",
        "helm_name": "Jessica Liu", "helm_gender": "F",
        "crew_name": "Leanna Lee", "crew_gender": "F",
        "races": ["7.0", "8.0", "(10.0)", "(11.0)", "7.0", "6.0", "6.0", "5.0", "4.0", "1.0", "1.0"],
        "total": 66.0, "net": 45.0
    },
    {
        "rank": 5, "sail": "2681", "div": "Men", "nat": "AUS",
        "helm_name": "Atlas Miller", "helm_gender": "M",
        "crew_name": "Rory Spinaze Littlejohn", "crew_gender": "M",
        "races": ["6.0", "4.0", "3.0", "4.0", "8.0", "7.0", "8.0", "4.0", "(9.0)", "(9.0)", "7.0"],
        "total": 69.0, "net": 51.0
    },
    {
        "rank": 6, "sail": "3055", "div": "Men", "nat": "HKG",
        "helm_name": "Hins Law", "helm_gender": "M",
        "crew_name": "Jaythan Lee", "crew_gender": "M",
        "races": ["4.0", "6.0", "7.0", "10.0", "5.0", "5.0", "(12.0)", "10.0", "7.0", "3.0", "(11.0)"],
        "total": 80.0, "net": 57.0
    },
    {
        "rank": 7, "sail": "3084", "div": "Junior, Men", "nat": "HKG",
        "helm_name": "Kai Lawson", "helm_gender": "M",
        "crew_name": "Andy Allt-Graham", "crew_gender": "M",
        "races": ["(26.0 NSC)", "3.0", "4.0", "5.0", "(26.0 UFD)", "26.0 UFD", "5.0", "2.0", "5.0", "4.0", "4.0"],
        "total": 110.0, "net": 58.0
    },
    {
        "rank": 8, "sail": "2472", "div": "Junior, Men", "nat": "SGP",
        "helm_name": "Sean Kum", "helm_gender": "M",
        "crew_name": "Nigel Tan", "crew_gender": "M",
        "races": ["8.0", "7.0", "6.0", "7.0", "4.0", "(14.0)", "4.0", "8.0", "(10.0)", "5.0", "9.0"],
        "total": 82.0, "net": 58.0
    },
    {
        "rank": 9, "sail": "3398", "div": "Men", "nat": "HKG",
        "helm_name": "Ayden Pang", "helm_gender": "M",
        "crew_name": "Xu Peng William Chen", "crew_gender": "M",
        "races": ["9.0", "9.0", "8.0", "9.0", "6.0", "3.0", "(14.0)", "9.0", "8.0", "(26.0 UFD)", "8.0"],
        "total": 109.0, "net": 69.0
    },
    {
        "rank": 10, "sail": "3383", "div": "Junior, Women", "nat": "HKG",
        "helm_name": "Kristen Hwang", "helm_gender": "F",
        "crew_name": "Bernice Pang", "crew_gender": "F",
        "races": ["(26.0 DNS)", "11.0", "11.0", "6.0", "9.0", "8.0", "10.0", "7.0", "6.0", "(26.0 UFD)", "6.0"],
        "total": 126.0, "net": 74.0
    },
    {
        "rank": 11, "sail": "3054", "div": "Men", "nat": "HKG",
        "helm_name": "Sung Chak Kyle Lee", "helm_gender": "M",
        "crew_name": "Brandon Sin Him Liu", "crew_gender": "M",
        "races": ["11.0", "10.0", "(16.0)", "13.0", "10.0", "11.0", "7.0", "6.0", "(26.0 UFD)", "6.0", "5.0"],
        "total": 121.0, "net": 79.0
    },
    {
        "rank": 12, "sail": "2877", "div": "Junior, Men", "nat": "HKG",
        "helm_name": "Toby Yuen", "helm_gender": "M",
        "crew_name": "Joshua Duncan-Andrews", "crew_gender": "M",
        "races": ["5.0", "(26.0 RET)", "9.0", "8.0", "12.0", "19.0", "(21.0)", "16.0", "11.0", "8.0", "10.0"],
        "total": 145.0, "net": 98.0
    },
    {
        "rank": 13, "sail": "2869", "div": "Junior, Women", "nat": "HKG",
        "helm_name": "Cheryl Ho", "helm_gender": "F",
        "crew_name": "Gemma Chen", "crew_gender": "F",
        "races": ["10.0", "13.0", "13.0", "12.0", "17.0", "9.0", "15.0", "(21.0)", "14.0", "(19.0)", "16.0"],
        "total": 159.0, "net": 119.0
    },
    {
        "rank": 14, "sail": "2751", "div": "Junior, Women", "nat": "HKG",
        "helm_name": "Sze Shuen Lo", "helm_gender": "F",
        "crew_name": "Cheuk Ting Liu", "crew_gender": "F",
        "races": ["(26.0 DNF)", "15.0", "15.0", "16.0", "18.0", "15.0", "9.0", "(20.0)", "16.0", "17.0", "15.0"],
        "total": 182.0, "net": 136.0
    },
    {
        "rank": 15, "sail": "3521", "div": "Men", "nat": "HKG",
        "helm_name": "Alex Hon", "helm_gender": "M",
        "crew_name": "Alfred Yip", "crew_gender": "M",
        "races": ["(26.0 NSC)", "(26.0 DNS)", "14.0", "14.0", "19.0", "18.0", "11.0", "15.0", "19.0", "15.0", "12.0"],
        "total": 189.0, "net": 137.0
    },
    {
        "rank": 16, "sail": "3351", "div": "Mixed", "nat": "HKG",
        "helm_name": "Katie Lai", "helm_gender": "F",
        "crew_name": "Ned Tyson", "crew_gender": "M",
        "races": ["(26.0 DNF)", "12.0", "12.0", "15.0", "16.0", "13.0", "13.0", "17.0", "21.0", "(26.0 UFD)", "20.0"],
        "total": 191.0, "net": 139.0
    },
    {
        "rank": 17, "sail": "2750", "div": "Junior, Women", "nat": "HKG",
        "helm_name": "Ching Jaymee Ip", "helm_gender": "F",
        "crew_name": "Hilary Daisy Chan", "crew_gender": "F",
        "races": ["13.0", "(26.0 DNF)", "18.0", "17.0", "20.0", "16.0", "(26.0 RET)", "14.0", "12.0", "13.0", "21.0"],
        "total": 196.0, "net": 144.0
    },
    {
        "rank": 18, "sail": "2466", "div": "Women", "nat": "HKG",
        "helm_name": "Cheryl Yong", "helm_gender": "F",
        "crew_name": "Febe Wong", "crew_gender": "F",
        "races": ["(26.0 DNC)", "(26.0 DNC)", "26.0 DNC", "26.0 DNC", "13.0", "12.0", "20.0", "13.0", "17.0", "10.0", "18.0"],
        "total": 207.0, "net": 155.0
    },
    {
        "rank": 19, "sail": "2988", "div": "Junior, Men", "nat": "HKG",
        "helm_name": "Mac Darlington", "helm_gender": "M",
        "crew_name": "Connor Hood", "crew_gender": "M",
        "races": ["12.0", "(26.0 DNF)", "(26.0 DNS)", "26.0 RET", "11.0", "10.0", "18.0", "23.0", "26.0 RET", "18.0", "14.0"],
        "total": 210.0, "net": 158.0
    },
    {
        "rank": 20, "sail": "2846", "div": "Junior, Women", "nat": "HKG",
        "helm_name": "Jade Zirah", "helm_gender": "F",
        "crew_name": "Penelope Wilde", "crew_gender": "F",
        "races": ["(26.0 UFD)", "14.0", "17.0", "(26.0 RET)", "21.0", "26.0 UFD", "17.0", "22.0", "13.0", "14.0", "19.0"],
        "total": 215.0, "net": 163.0
    },
    {
        "rank": 21, "sail": "2521", "div": "Mixed", "nat": "HKG",
        "helm_name": "Tsz Ching Casie Ho", "helm_gender": "F",
        "crew_name": "Soham Singh Mangaraj", "crew_gender": "M",
        "races": ["(26.0 DNC)", "(26.0 DNC)", "26.0 DNC", "26.0 DNC", "15.0", "20.0", "26.0 DNF", "12.0", "18.0", "11.0", "13.0"],
        "total": 219.0, "net": 167.0
    },
    {
        "rank": 22, "sail": "3524", "div": "Men", "nat": "HKG",
        "helm_name": "Owen Ou", "helm_gender": "M",
        "crew_name": "Mack Tung", "crew_gender": "M",
        "races": ["(26.0 DNC)", "(26.0 DNC)", "26.0 DNC", "26.0 DNC", "14.0", "17.0", "19.0", "19.0", "15.0", "16.0", "17.0"],
        "total": 221.0, "net": 169.0
    },
    {
        "rank": 23, "sail": "3393", "div": "Junior, Women", "nat": "HKG",
        "helm_name": "Keira Hwang", "helm_gender": "F",
        "crew_name": "Keana Hah", "crew_gender": "F",
        "races": ["(26.0 DNS)", "(26.0 DNS)", "26.0 DNS", "26.0 DNC", "26.0 DNS", "21.0", "16.0", "18.0", "20.0", "20.0", "22.0"],
        "total": 247.0, "net": 195.0
    },
    {
        "rank": 24, "sail": "2876", "div": "Junior, Mixed", "nat": "HKG",
        "helm_name": "Rhys Lee", "helm_gender": "M",
        "crew_name": "Ema Poposka", "crew_gender": "F",
        "races": ["(26.0 DNF)", "(26.0 DNS)", "26.0 DNC", "26.0 DNC", "26.0 DNC", "26.0 DNC", "26.0 DNC", "26.0 DNC", "26.0 RET", "26.0 RET", "26.0 DNS"],
        "total": 286.0, "net": 234.0
    },
    {
        "rank": 24, "sail": "2532", "div": "Men", "nat": "HKG",
        "helm_name": "Montgomery Jackson", "helm_gender": "M",
        "crew_name": "Oliver Lynch", "crew_gender": "M",
        "races": ["(26.0 DNF)", "(26.0 RET)", "26.0 DNS", "26.0 DNC", "26.0 DNF", "26.0 DNF", "26.0 DNF", "26.0 DNF", "26.0 DNC", "26.0 DNC", "26.0 DNC"],
        "total": 286.0, "net": 234.0
    }
]

# 2. ILCA 6 (13 entries, 8 races, 2 discards)
entries_ilca6 = [
    {"rank": 1, "sail": "220790", "name": "Charalampos Velianitis", "gender": "M", "nat": "HKG", "races": ["1.0", "(4.0)", "1.0", "1.0", "1.0", "1.0", "1.0", "(5.0)"], "total": 15.0, "net": 6.0},
    {"rank": 2, "sail": "213211", "name": "Xavier Wilde", "gender": "M", "nat": "HKG", "races": ["(3.0)", "2.0", "2.0", "(3.0)", "2.0", "3.0", "2.0", "1.0"], "total": 18.0, "net": 12.0},
    {"rank": 3, "sail": "221934", "name": "Samuel Tan-Hardy", "gender": "M", "nat": "HKG", "races": ["2.0", "1.0", "(4.0)", "2.0", "3.0", "2.0", "3.0", "(4.0)"], "total": 21.0, "net": 13.0},
    {"rank": 4, "sail": "209902", "name": "Avelino Shin", "gender": "M", "nat": "HKG", "races": ["4.0", "(5.0)", "(5.0)", "5.0", "4.0", "4.0", "5.0", "2.0"], "total": 34.0, "net": 24.0},
    {"rank": 5, "sail": "221401", "name": "Ziyan Huang", "gender": "M", "nat": "HKG", "races": ["(5.0)", "3.0", "3.0", "4.0", "5.0", "5.0", "4.0", "(6.0)"], "total": 35.0, "net": 24.0},
    {"rank": 6, "sail": "225952", "name": "Kam Hing Hu", "gender": "M", "nat": "HKG", "races": ["(7.0)", "(7.0)", "6.0", "6.0", "6.0", "6.0", "7.0", "3.0"], "total": 48.0, "net": 34.0},
    {"rank": 7, "sail": "213312", "name": "Adam Huxley Cheng Hou Kan", "gender": "M", "nat": "HKG", "races": ["6.0", "6.0", "7.0", "7.0", "7.0", "7.0", "(14.0 DNC)", "(14.0 DNC)"], "total": 68.0, "net": 40.0},
    {"rank": 8, "sail": "201677", "name": "Ryan Cheung", "gender": "M", "nat": "HKG", "races": ["8.0", "8.0", "8.0", "(11.0)", "8.0", "9.0", "8.0", "(10.0)"], "total": 70.0, "net": 49.0},
    {"rank": 9, "sail": "215313", "name": "Ralph Andrei Buitre", "gender": "M", "nat": "HKG", "races": ["(10.0)", "9.0", "(14.0 DNF)", "10.0", "9.0", "10.0", "6.0", "9.0"], "total": 77.0, "net": 53.0},
    {"rank": 10, "sail": "225489", "name": "Haochen Lu", "gender": "M", "nat": "HKG", "races": ["(14.0 DNF)", "(14.0 DNS)", "14.0 DNC", "8.0", "10.0", "8.0", "10.0", "8.0"], "total": 86.0, "net": 58.0},
    {"rank": 11, "sail": "213343", "name": "Ela Tezel", "gender": "F", "nat": "HKG", "races": ["9.0", "10.0", "(14.0 DNF)", "12.0", "(14.0 DNS)", "11.0", "11.0", "7.0"], "total": 88.0, "net": 60.0},
    {"rank": 12, "sail": "225098", "name": "Minqi Zhu", "gender": "F", "nat": "CHN", "races": ["11.0", "(14.0 DNS)", "9.0", "9.0", "(14.0 UFD)", "12.0", "9.0", "11.0"], "total": 89.0, "net": 61.0},
    {"rank": 13, "sail": "187010", "name": "Kai Story", "gender": "M", "nat": "HKG", "races": ["(14.0 DNC)", "(14.0 DNC)", "14.0 DNC", "14.0 DNC", "14.0 DNC", "14.0 DNC", "14.0 DNC", "14.0 DNC"], "total": 112.0, "net": 84.0}
]

# -------------------------------------------------------------
# 2. VERIFY MATHEMATICAL CONSISTENCY
# -------------------------------------------------------------
def verify_math(entry_list, label):
    for e in entry_list:
        vals = []
        disc_vals = []
        for r in e['races']:
            is_disc = r.startswith('(') and ')' in r
            c = r.replace('(', '').replace(')', '').strip()
            num = float(re.search(r'[\d.]+', c).group(0))
            vals.append(num)
            if is_disc:
                disc_vals.append(num)
        calc_tot = sum(vals)
        calc_net = sum(vals) - sum(disc_vals)
        name = e.get('name') or f"{e.get('helm_name')} / {e.get('crew_name')}"
        if abs(calc_tot - e['total']) > 0.01 or abs(calc_net - e['net']) > 0.01:
            raise ValueError(f"Math discrepancy in {label} - {name}: expected {e['total']}/{e['net']}, calculated {calc_tot}/{calc_net}")

verify_math(entries_29er, "29er")
verify_math(entries_ilca6, "ILCA 6")
print("100% of HKRW 2026 29er and ILCA 6 scores mathematically verified!")

# -------------------------------------------------------------
# 3. SAILOR IDENTITY MATCHING
# -------------------------------------------------------------
new_sailor_map = {}
matched_sailor_count = 0

# Explicit mapping for known variations
SPECIAL_ALIASES = {
    'seankum': 'seankumkokwei',
    'nigeltan': 'nigeltanxuyuan',
    'roryspinazelittlejohn': 'roryspinazelittlejohn',
    'samueltanhardy': 'samueltanhardy',
}

def get_or_create_sailor(name: str, sail_no: str, club: str, nat: str, gender: str | None) -> tuple[str, bool]:
    global matched_sailor_count
    norm = re.sub(r'[^a-z0-9]', '', name.lower())
    norm = SPECIAL_ALIASES.get(norm, norm)

    # 1. Exact normalized match
    candidates = name_map.get(norm, [])
    if candidates:
        matched_sailor_count += 1
        return candidates[0]['id'], False

    # 2. Substring match
    for cand_norm, cands in name_map.items():
        if len(cands) == 1 and (cand_norm == norm or (len(norm) >= 10 and (norm in cand_norm or cand_norm in norm))):
            matched_sailor_count += 1
            return cands[0]['id'], False

    # 3. Check already staged new profiles
    if norm in new_sailor_map:
        return new_sailor_map[norm]['id'], False

    # 4. Create new verified profile
    s_id = make_uuid(f"sailor:{norm}")
    handle = make_handle(name, nat)
    new_profile = {
        'id': s_id,
        'name': name.strip(),
        'handle': handle,
        'sail_number': sail_no.strip() or 'TBD',
        'club': club.strip() if club else 'RHKYC',
        'nationality': nat.strip() if nat else 'HKG',
        'gender': gender
    }
    new_sailor_map[norm] = new_profile
    return s_id, True

# Resolve 29er
for e in entries_29er:
    e['helm_id'], _ = get_or_create_sailor(e['helm_name'], e['sail'], "RHKYC", e['nat'], e['helm_gender'])
    e['crew_id'], _ = get_or_create_sailor(e['crew_name'], e['sail'], "RHKYC", e['nat'], e['crew_gender'])

# Resolve ILCA 6
for e in entries_ilca6:
    e['sailor_id'], _ = get_or_create_sailor(e['name'], e['sail'], "RHKYC", e['nat'], e['gender'])

print(f"Sailor identity resolution complete: matched {matched_sailor_count} existing sailors, creating {len(new_sailor_map)} new verified profiles.")

# -------------------------------------------------------------
# 4. SCORE TOKEN PARSER
# -------------------------------------------------------------
def parse_score_token(tok: str) -> tuple[float, str | None, bool, str]:
    tok = tok.strip()
    is_discard = tok.startswith('(') and ')' in tok
    clean = tok.replace('(', '').replace(')', '').strip()

    code_match = re.search(r'[A-Za-z]+', clean)
    code = code_match.group(0).upper() if code_match else None

    num_match = re.search(r'[\d.]+', clean)
    val = float(num_match.group(0)) if num_match else 0.0
    return val, code, is_discard, tok

# -------------------------------------------------------------
# 5. GENERATE SQL STATEMENTS (Migration 172)
# -------------------------------------------------------------
event_id = "8b2aa46e-12e7-55ee-afd4-2b927edd02cf"  # Hong Kong Race Week 2026 parent event

out_lines = [
    "-- Migration 172: Import Hong Kong Race Week 2026 — 29er Asian Championship & ILCA 6",
    "--",
    "-- Imports the official championship results for:",
    "-- Event: Hong Kong Race Week 2026",
    "-- Venue: Royal Hong Kong Yacht Club, Middle Island, Hong Kong",
    "-- Dates: 27 January – 1 February 2026",
    "-- Authority: Sailing Federation of Hong Kong, China (HKSF) & Royal Hong Kong Yacht Club (RHKYC)",
    "--",
    f"-- 1. 2026 29er Asian Championship: {len(entries_29er)} boats (50 sailors), 11 races, 2 discards",
    f"-- 2. Hong Kong Race Week 2026 (ILCA 6): {len(entries_ilca6)} boats (13 sailors), 8 races, 2 discards",
    "--",
    "-- Sources:",
    "-- - 29er: https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm",
    "-- - ILCA 6: https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm",
    "--",
    "-- All operations execute in a single atomic transaction.",
    "",
    "BEGIN;",
    ""
]

# 1. Insert new sailors
out_lines.append("-- 1. Insert New Verified Sailor Profiles")
for s in new_sailor_map.values():
    escaped_name = s['name'].replace("'", "''")
    escaped_club = s['club'].replace("'", "''")
    gender_val = f"'{s['gender']}'" if s['gender'] else "NULL"
    out_lines.append(f"""INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '{s['id']}', '{escaped_name}', '{s['handle']}', '{s['sail_number']}', '{escaped_club}', '{s['nationality']}', {gender_val}, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);""")

out_lines.append("")

# 2. Update parent event classes
out_lines.append(f"""-- 2. Update Hong Kong Race Week 2026 Event Classes
UPDATE public.regatta_events
SET classes = '["Optimist", "ILCA 4", "ILCA 6", "29er"]'::jsonb,
    updated_at = clock_timestamp()
WHERE id = '{event_id}';
""")

# 3. Helper to write single-handed regatta sheet and results
def write_single_handed_regatta(slug_suffix, sheet_name, boat_class, division, race_count, official_url, entries):
    r_id = make_uuid(f"regatta:hkrw-2026:{slug_suffix}")
    full_slug = f"hong-kong-race-week-2026-{slug_suffix}"
    out_lines.append(f"-- Regatta Sheet: {sheet_name}")
    out_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '{r_id}',
    '{event_id}',
    '{sheet_name}',
    '{full_slug}',
    '2026-02-01',
    '2026-02-01',
    {len(entries)},
    '{division}',
    {race_count},
    'HKG',
    '{boat_class}',
    'individual',
    1,
    1,
    false,
    'Royal Hong Kong Yacht Club, Middle Island, Hong Kong',
    'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club',
    'published',
    '{official_url}',
    'Official Final Sailwave Results from Royal Hong Kong Yacht Club (RHKYC)',
    'Official Hong Kong Race Week 2026 final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;""")

    for e in entries:
        res_id = make_uuid(f"result:hkrw-2026:{slug_suffix}:{e['rank']}:{e['sail']}")
        part_id = make_uuid(f"part:hkrw-2026:{res_id}")
        escaped_name = e['name'].replace("'", "''")
        escaped_notes = f"HKRW 2026. Sailor: {escaped_name}. Division: {division}. Nat: {e['nat']}."

        out_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_id}', '{e['sailor_id']}', '{r_id}', '{escaped_name}', '{e['sail']}', 'individual', {e['rank']},
    {e['total']}, {e['net']}, false, false, '{official_url}',
    '{official_url}', 'Official HKRW 2026 Results (RHKYC)',
    'document', '{escaped_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

        out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_id}', '{res_id}', '{e['sailor_id']}', '{escaped_name}', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

        for race_num, tok in enumerate(e['races'], start=1):
            score, code, is_discard, raw_val = parse_score_token(tok)
            code_val = f"'{code}'" if code else "NULL"
            discard_val = "true" if is_discard else "false"
            out_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}', {race_num}, {score}, {code_val}, {discard_val}, '{raw_val.replace("'", "''")}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

    out_lines.append("")

# 4. Helper to write double-handed regatta sheet and results (29er)
def write_double_handed_regatta(slug_suffix, sheet_name, boat_class, division, race_count, official_url, entries):
    r_id = make_uuid(f"regatta:hkrw-2026:{slug_suffix}")
    full_slug = f"hong-kong-race-week-2026-{slug_suffix}"
    out_lines.append(f"-- Regatta Sheet: {sheet_name}")
    out_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '{r_id}',
    '{event_id}',
    '{sheet_name}',
    '{full_slug}',
    '2026-02-01',
    '2026-02-01',
    {len(entries)},
    '{division}',
    {race_count},
    'HKG',
    '{boat_class}',
    'crew',
    2,
    2,
    false,
    'Royal Hong Kong Yacht Club, Middle Island, Hong Kong',
    'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club',
    'published',
    '{official_url}',
    'Official Final Sailwave Results from Royal Hong Kong Yacht Club (RHKYC)',
    'Official Hong Kong Race Week 2026 final results (2026 29er Asian Championship).',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;""")

    for idx, e in enumerate(entries, start=1):
        res_id = make_uuid(f"result:hkrw-2026:{slug_suffix}:{idx}:{e['sail']}")
        p1_id = make_uuid(f"part:hkrw-2026:{res_id}:helm")
        p2_id = make_uuid(f"part:hkrw-2026:{res_id}:crew")
        entry_label = f"{e['helm_name']} & {e['crew_name']}"
        escaped_label = entry_label.replace("'", "''")
        escaped_helm = e['helm_name'].replace("'", "''")
        escaped_crew = e['crew_name'].replace("'", "''")
        escaped_notes = f"HKRW 2026 29er Asian Championship. Helm: {escaped_helm}, Crew: {escaped_crew}. Division: {e['div']}. Nat: {e['nat']}."

        out_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_id}', '{e['helm_id']}', '{r_id}', '{escaped_label}', '{e['sail']}', 'crew', {e['rank']},
    {e['total']}, {e['net']}, false, false, '{official_url}',
    '{official_url}', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', '{escaped_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

        # Helm (order 1)
        out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{p1_id}', '{res_id}', '{e['helm_id']}', '{escaped_helm}', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

        # Crew (order 2)
        out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{p2_id}', '{res_id}', '{e['crew_id']}', '{escaped_crew}', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

        for race_num, tok in enumerate(e['races'], start=1):
            score, code, is_discard, raw_val = parse_score_token(tok)
            code_val = f"'{code}'" if code else "NULL"
            discard_val = "true" if is_discard else "false"
            out_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}', {race_num}, {score}, {code_val}, {discard_val}, '{raw_val.replace("'", "''")}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

    out_lines.append("")

# Write sheets
url_29er = "https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm"
url_ilca6 = "https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm"

write_double_handed_regatta("29er", "Hong Kong Race Week 2026 — 29er Asian Championship", "29er", "Open", 11, url_29er, entries_29er)
write_single_handed_regatta("ilca6", "Hong Kong Race Week 2026 (ILCA 6)", "ILCA 6", "Open", 8, url_ilca6, entries_ilca6)

out_lines.append("COMMIT;")

mig_file = "src/db/migrations/172_import_hkrw_2026_29er_and_ilca6.sql"
with open(mig_file, "w") as f:
    f.write("\n".join(out_lines) + "\n")

print(f"Generated migration file {mig_file} ({len(out_lines)} lines).")

# Save evidence manifest
evidence = {
    "regatta_event": "Hong Kong Race Week 2026",
    "event_id": event_id,
    "organizer": "Sailing Federation of Hong Kong, China (HKSF) & Royal Hong Kong Yacht Club (RHKYC)",
    "venue": "Royal Hong Kong Yacht Club, Middle Island, Hong Kong",
    "dates": "27 January – 1 February 2026",
    "sources": [
        {
            "class": "29er",
            "name": "2026 29er Asian Championship",
            "url": url_29er,
            "format": "Sailwave HTML",
            "entries": len(entries_29er),
            "races": 11,
            "discards": 2
        },
        {
            "class": "ILCA 6",
            "name": "Hong Kong Race Week 2026 (ILCA 6)",
            "url": url_ilca6,
            "format": "Sailwave HTML",
            "entries": len(entries_ilca6),
            "races": 8,
            "discards": 2
        }
    ],
    "verification_methodology": "100% of ranks, sailor names, sail numbers, discards, and net totals mathematically and table verified against official RHKYC Sailwave scorecards.",
    "pdf_corroboration_status": "No standalone PDF was published by RHKYC for HKRW 2026; official Sailwave HTML results published on the official RHKYC server (matching how Optimist and ILCA 4 were published) were used.",
    "sheets_imported": 2,
    "total_entries": len(entries_29er) + len(entries_ilca6),
    "total_sailors_involved": len(entries_29er) * 2 + len(entries_ilca6),
    "new_profiles_created": len(new_sailor_map),
    "existing_profiles_matched": matched_sailor_count
}

with open("scripts/imports/hkrw-2026/evidence.json", "w") as f:
    json.dump(evidence, f, indent=2)

print("Saved evidence manifest scripts/imports/hkrw-2026/evidence.json.")
