import json
import re
import uuid
import hashlib
import pypdf

# 1. Load Existing Sailors
with open('scripts/imports/asian-championships-priority1/existing-sailors.json') as f:
    d = json.load(f)
existing_sailors = d['rows'][0]['json_agg']

with open('scripts/imports/asian-championships-priority1/keep-separate.json') as f:
    kd = json.load(f)
keep_separate = set(k['pair_key'] for k in (kd.get('rows', [{}])[0].get('json_agg') or []))

def normalize_name(s):
    if not s:
        return ''
    return ' '.join(s.strip().split())

def name_key(s):
    return re.sub(r'[^a-z0-9]', '', (s or '').lower())

sailors_by_name_and_nat = {}
sailors_by_name = {}

for s in existing_sailors:
    k_name = name_key(s['name'])
    k_nat = (s.get('nationality') or '').upper()
    if k_name:
        key = f"{k_name}_{k_nat}"
        sailors_by_name_and_nat.setdefault(key, []).append(s)
        sailors_by_name.setdefault(k_name, []).append(s)

# Known canonical mappings for Singapore youth squad
sgp_canonical_map = {
    'aurick you shun leow': '85614793-d030-483c-9ce8-57f7edcc4add', # Aurick Leow You Shun
    'austin jia yu yeo': 'd7ce117b-5c64-40ea-86bd-79a7a73bb833',    # Austin Yeo Jia Yu
    'eitan oh': '922e1135-5c83-45cc-81cd-69c7b5a5ee65',             # Eitan Oh
    'ian goh': 'd52d284f-c0d7-4a72-b86d-45c57b963c6c',              # Ian Goh
    'zachary wong': 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a',         # Wong Weikai Zachary
    'caleb peck': '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f',           # Caleb Peck Rui Kai
    'danielle lai': 'a95b6b0a-6c38-40b6-a0bc-2dcaa9bcb9e2',         # Danielle Lai
    'gabi oh': 'ee4ffc51-2ad1-46fd-85d1-0d100676840f',              # Gabi Oh
    'sarah yong': '82ab4ba4-a693-4e7d-a9c5-6531752cea6e',           # Sarah Yong
    'jemima chang': '1ba65410-fa86-472d-ad75-bc510bffd07b',         # Jemima Chang
    'nicholette lee': '37d98dd9-3749-45ce-8195-c1b9cce74f60',       # Nicholette Lee Wee Wen
    'mildred wong': '3cf3ef94-6f08-485b-86f0-6c1d46de7a02',         # Wong Li Xuan Mildred
    'isaac goh': '93fc1c81-1ec7-4600-b9a1-bc613d11449c',            # Isaac Goh
    'kenan kee zen tan': '7baafbd0-cddb-4217-9727-a692f6902b79',    # Kenan Kee Zen Tan
    'ethan yi xuan lim': '28084792-a8b9-4ef8-b621-55231cb559a1',    # Ethan Yi Xuan Lim
    'clive seah': '9feccee3-556f-494a-bb80-593be88884cc',           # Clive Wei Jun Seah
    'jania ang': 'ddfe8d27-5c27-4cc6-b7b3-5c5d89564914',            # Jania Ang
    'abigail koh': '63d082ef-363c-4b69-929a-25341b195a08',          # Abigail Koh
    'keira marie carlyle': 'be779040-d45c-4052-b458-9c9e88803505',  # Keira Carlyle
    'keira carlyle': 'be779040-d45c-4052-b458-9c9e88803505',        # Keira Carlyle
    'elisha lim': '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01',           # Elisha Lim Yu Ting
    'charlotte lee': 'aa04fecc-d984-4a81-8119-532dbbfea7fa',        # Charlotte Wee Shuen Lee
    'sarah seow': 'fc5e098b-be2e-4466-8b92-bada3a3479db',           # Sarah Seow Hui Yan
    'jarrod toh': '34e36e78-abc0-4ba7-9739-3fe5b465be89',           # Jarrod Toh
}

# Known international mappings
intl_canonical_map = {
    'nicholas halliday': '06bd4877-4d96-44b0-9f66-c14f0061fe59',
    'tiago cheng de villemor salgado': 'ad785bc0-da18-41e2-aa35-f8d90af36153',
    'lucas collin': 'a0c43406-eac5-5b58-9e94-684f1644e454',
    'weka bhanubandh': 'ecf12b3f-820d-4827-ba12-4bff8f22c012',
}

pdf_path = 'scripts/imports/asian-championships-priority1/sources/2024-ilca-asian-championship-results-book.pdf'
reader = pypdf.PdfReader(pdf_path)

def slugify(s):
    s = s.lower().strip()
    s = re.sub(r'[^a-z0-9]+', '-', s)
    return s.strip('-')

sheets_def = [
    {
        'id': 'b1a02024-a510-48e0-8003-000000000001',
        'slug': '2024-ilca-asian-open-championship-ilca4-boys',
        'name': '2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18)',
        'boatClass': 'ILCA 4',
        'division': 'Youth Boys U18',
        'gender': 'M',
        'pages': [9, 10, 11],
        'raceCount': 10,
        'discardCount': 1,
        'expectedCount': 77,
    },
    {
        'id': 'b1a02024-a510-48e0-8003-000000000002',
        'slug': '2024-ilca-asian-open-championship-ilca4-girls',
        'name': '2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18)',
        'boatClass': 'ILCA 4',
        'division': 'Youth Girls U18',
        'gender': 'W',
        'pages': [14, 15],
        'raceCount': 10,
        'discardCount': 1,
        'expectedCount': 52,
    },
    {
        'id': 'b1a02024-a510-48e0-8003-000000000003',
        'slug': '2024-ilca-asian-open-championship-ilca6-men',
        'name': '2024 ILCA Asian Open Championship (ILCA 6 Men)',
        'boatClass': 'ILCA 6',
        'division': 'Men',
        'gender': 'M',
        'pages': [4],
        'raceCount': 10,
        'discardCount': 1,
        'expectedCount': 30,
    },
    {
        'id': 'b1a02024-a510-48e0-8003-000000000004',
        'slug': '2024-ilca-asian-open-championship-ilca6-women',
        'name': '2024 ILCA Asian Open Championship (ILCA 6 Women)',
        'boatClass': 'ILCA 6',
        'division': 'Women',
        'gender': 'W',
        'pages': [6, 7],
        'raceCount': 10,
        'discardCount': 1,
        'expectedCount': 43,
    },
    {
        'id': 'b1a02024-a510-48e0-8003-000000000005',
        'slug': '2024-ilca-asian-open-championship-ilca7-men',
        'name': '2024 ILCA Asian Open Championship (ILCA 7 Men)',
        'boatClass': 'ILCA 7',
        'division': 'Men',
        'gender': 'M',
        'pages': [1, 2],
        'raceCount': 10,
        'discardCount': 1,
        'expectedCount': 47,
    },
]

manifest = {
    'batch': '2024-ilca-asian-championship-import-2026-10-29',
    'event': {
        'id': 'e1a02024-a510-48e0-8003-000000002024',
        'slug': '2024-ilca-asian-open-championship',
        'name': '2024 ILCA Asian Open Championship',
        'startDate': '2024-12-14',
        'endDate': '2024-12-20',
        'venue': 'Haikou, Hainan, China',
        'organizer': 'Asian Sailing Federation (ASAF) / ILCA Asia / Chinese Yachting Association (CYA)',
        'norUrl': 'https://sailwave.com/',
    },
    'sheets': [],
    'newProfiles': [],
}

new_profiles_by_id = {}
all_allocated_handles = set(s.get('handle') for s in existing_sailors if s.get('handle'))

def allocate_sailor(name, nat, sail_no, gender, fleet_label):
    n_lower = name.lower().strip()
    # 1. SGP Canonical Map
    if n_lower in sgp_canonical_map:
        return sgp_canonical_map[n_lower], False, 'Corroborated Singapore youth squad athlete identity'
    # 2. International Canonical Map
    if n_lower in intl_canonical_map:
        return intl_canonical_map[n_lower], False, 'Corroborated international championship athlete identity'
    
    # 3. Exact name and nationality match in DB
    k_name = name_key(name)
    k_nat = nat.upper()
    if f"{k_name}_{k_nat}" in sailors_by_name_and_nat:
        candidates = sailors_by_name_and_nat[f"{k_name}_{k_nat}"]
        if len(candidates) == 1:
            return candidates[0]['id'], False, f'Exact name and nationality ({nat}) match in database'
            
    # 4. Generate new profile
    # Deterministic UUIDv5 based on name + nat
    namespace = uuid.UUID('e1a02024-a510-48e0-8003-000000002024')
    new_id = str(uuid.uuid5(namespace, f"{nat}_{name}"))
    
    if new_id not in new_profiles_by_id:
        base_handle = slugify(name)
        short_nat = nat.lower()
        handle = f"{base_handle}-ilca24-{short_nat}"
        counter = 1
        while handle in all_allocated_handles:
            handle = f"{base_handle}-{counter}-ilca24-{short_nat}"
            counter += 1
        all_allocated_handles.add(handle)
        
        profile = {
            'id': new_id,
            'name': name,
            'handle': handle,
            'sail_number': sail_no,
            'sail_number_ilca4': sail_no if 'ILCA 4' in fleet_label else None,
            'gender': gender,
            'nationality': nat,
            'club': 'N/A',
            'school': None
        }
        new_profiles_by_id[new_id] = profile
        manifest['newProfiles'].append(profile)
        
    return new_id, True, 'New international sailor profile created from official ILCA Asian Championship results book'

for s_def in sheets_def:
    raw_text = '\n'.join(reader.pages[p].extract_text() for p in s_def['pages'])
    lines = raw_text.split('\n')
    filtered = []
    for l in lines:
        s = l.strip()
        if not s: continue
        if any(h in s for h in ['2024ILCA', '2024 ILCA', 'Haikou, China', 'Overall Results', '级别Class', '排名', 'Rank', '国籍', 'Nat.', '帆号', 'Sail No.', '姓名', 'Helm Group', 'Total', '净总分', 'Nett', '打印时间', '裁判长PRO', '日期Y/M/D', '2024年12月20日', '日期']):
            continue
        filtered.append(s)
    text = ' '.join(filtered)
    splits = re.split(r'\b(\d+(?:st|nd|rd|th))\b', text)
    blocks = []
    for i in range(1, len(splits), 2):
        blocks.append((splits[i], splits[i+1].strip()))
        
    print(f"Parsing {s_def['name']}: {len(blocks)} entries")
    sheet_results = []
    
    for rank_str, content in blocks:
        rank_num = int(re.match(r'^(\d+)', rank_str).group(1))
        toks = content.split()
        nat = toks[0]
        sail_no = toks[1]
        
        race_start_idx = 2
        while race_start_idx < len(toks):
            t = toks[race_start_idx]
            if t in ['U16', 'U18', 'U19', 'U21', 'Master']:
                race_start_idx += 1
                break
            if t.isdigit() or t.startswith('('):
                break
            race_start_idx += 1
            
        name_toks = toks[2:race_start_idx]
        if name_toks and name_toks[-1] in ['U16', 'U18', 'U19', 'U21', 'Master']:
            cat = name_toks[-1]
            name = ' '.join(name_toks[:-1])
        else:
            cat = None
            name = ' '.join(name_toks)
            
        r_toks = list(toks[race_start_idx:])
        # strip trailing page number if present
        if len(r_toks) >= 3 and r_toks[-1].isdigit() and r_toks[-2].isdigit() and r_toks[-3].isdigit():
            v_last = int(r_toks[-1])
            v_prev = int(r_toks[-2])
            v_prev2 = int(r_toks[-3])
            if v_prev2 >= v_prev and v_last <= 25:
                r_toks.pop()
                
        nett_str = r_toks.pop()
        total_str = r_toks.pop()
        exp_total = int(total_str)
        exp_nett = int(nett_str)
        
        races = []
        i = 0
        while i < len(r_toks):
            t = r_toks[i]
            if t.startswith('(') and not t.endswith(')'):
                comb = [t]
                i += 1
                while i < len(r_toks) and not comb[-1].endswith(')'):
                    comb.append(r_toks[i])
                    i += 1
                full = ' '.join(comb)
                m = re.match(r'^\((\d+)\s+([A-Za-z0-9%]+)\)$', full)
                races.append({
                    'raceNumber': len(races) + 1,
                    'score': int(m.group(1)),
                    'code': m.group(2),
                    'discarded': True,
                    'raw': full
                })
                continue
            if t.startswith('(') and t.endswith(')'):
                inner = t[1:-1]
                if inner.isdigit():
                    races.append({
                        'raceNumber': len(races) + 1,
                        'score': int(inner),
                        'code': None,
                        'discarded': True,
                        'raw': t
                    })
                    i += 1
                    continue
                m = re.match(r'^(\d+)\s*([A-Za-z0-9%]+)$', inner)
                races.append({
                    'raceNumber': len(races) + 1,
                    'score': int(m.group(1)),
                    'code': m.group(2),
                    'discarded': True,
                    'raw': t
                })
                i += 1
                continue
            if t.isdigit():
                score = int(t)
                if i + 1 < len(r_toks) and r_toks[i+1] in ['DNC', 'DNF', 'RET', 'BFD', 'NSC', 'UFD', 'DSQ', 'SP1']:
                    code = r_toks[i+1]
                    races.append({
                        'raceNumber': len(races) + 1,
                        'score': score,
                        'code': code,
                        'discarded': False,
                        'raw': f'{score} {code}'
                    })
                    i += 2
                    continue
                elif i + 1 < len(r_toks) and 'SCP' in r_toks[i+1]:
                    code = r_toks[i+1]
                    i += 2
                    if i < len(r_toks) and r_toks[i] == '%':
                        code += '%'
                        i += 1
                    races.append({
                        'raceNumber': len(races) + 1,
                        'score': score,
                        'code': code,
                        'discarded': False,
                        'raw': f'{score} {code}'
                    })
                    continue
                else:
                    races.append({
                        'raceNumber': len(races) + 1,
                        'score': score,
                        'code': None,
                        'discarded': False,
                        'raw': t
                    })
                    i += 1
                    continue
                    
        assert len(races) == 10, f"Expected 10 races for {name}, got {len(races)}"
        assert sum(r['score'] for r in races) == exp_total, f"Total mismatch for {name}"
        assert sum(r['score'] for r in races if not r['discarded']) == exp_nett, f"Nett mismatch for {name}"
        
        sailor_id, is_new, id_basis = allocate_sailor(name, nat, sail_no, s_def['gender'], s_def['boatClass'])
        
        # Deterministic result ID and participant ID
        res_ns = uuid.UUID(s_def['id'])
        result_id = str(uuid.uuid5(res_ns, f"result_{rank_num}_{sail_no}"))
        participant_id = str(uuid.uuid5(res_ns, f"participant_{rank_num}_{sail_no}"))
        
        sheet_results.append({
            'rank': rank_num,
            'sourceName': name,
            'name': name,
            'sailOrBoardNumber': sail_no,
            'nationality': nat,
            'gender': s_def['gender'],
            'grossScore': exp_total,
            'nettScore': exp_nett,
            'races': races,
            'sailorId': sailor_id,
            'resultId': result_id,
            'participantId': participant_id,
            'isNewProfile': is_new,
            'identityBasis': id_basis,
            'sourceNationality': nat,
            'officialName': name,
            'evidenceNotes': f"Official Results Book: 2024 ILCA Asian Open Championship, Haikou, China (Dec 14-20, 2024). Class: {s_def['boatClass']}, Division: {s_def['division']}. Sail No: {sail_no}, Nat: {nat}."
        })
        
    manifest['sheets'].append({
        'config': {
            'id': s_def['id'],
            'slug': s_def['slug'],
            'name': s_def['name'],
            'boatClass': s_def['boatClass'],
            'division': s_def['division'],
            'gender': s_def['gender'],
            'raceCount': s_def['raceCount'],
            'discardCount': s_def['discardCount'],
            'entryType': 'individual',
            'date': '2024-12-14',
            'endDate': '2024-12-20',
        },
        'results': sheet_results
    })

print(f"Total new profiles created: {len(manifest['newProfiles'])}")
print(f"Total sheets: {len(manifest['sheets'])}")

with open('scripts/imports/asian-championships-priority1/manifest-batch-c.json', 'w') as f:
    json.dump(manifest, f, indent=2)

print("Saved manifest-batch-c.json successfully!")
