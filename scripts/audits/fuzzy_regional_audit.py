#!/usr/bin/env python3
import json
import re
from difflib import SequenceMatcher
from collections import defaultdict

with open('/tmp/all_sailors_with_counts.json') as f:
    all_sailors = json.load(f)['rows']

with open('/tmp/regional_target_sailors.json') as f:
    target_sailors_raw = json.load(f)['rows']

all_sailor_map = {s['id']: s for s in all_sailors}
target_ids = set(r['id'] for r in target_sailors_raw)

# Target sailor details
target_details = {}
for r in target_sailors_raw:
    sid = r['id']
    if sid not in target_details:
        target_details[sid] = {
            'id': sid,
            'name': r['name'],
            'nationality': r['nationality'],
            'club': r['club'],
            'sail_number': r['sail_number'],
            'regattas': set()
        }
    target_details[sid]['regattas'].add(r['regatta_name'])

def normalize_tokens(name: str) -> list[str]:
    # Replace non-alphanumeric with spaces, lower
    cleaned = re.sub(r'[^a-zA-Z0-9\s]', ' ', name.lower())
    # Common abbreviations/prefixes
    tokens = [t for t in cleaned.split() if t]
    mapped = []
    for t in tokens:
        if t in ('mohd', 'mohamad', 'mohamed', 'muhamad', 'md'):
            mapped.append('muhammad')
        elif t in ('bin', 'binti', 'bt', 'b'):
            continue  # ignore patronymic particle for comparison
        else:
            mapped.append(t)
    return mapped

def token_sort_key(tokens: list[str]) -> str:
    return " ".join(sorted(tokens))

def similarity_ratio(a: str, b: str) -> float:
    return SequenceMatcher(None, a, b).ratio()

# Find matches
high_confidence = []
medium_confidence = []
seen_pairs = set()

for tid in target_ids:
    t_info = target_details[tid]
    t_name = t_info['name']
    t_tokens = normalize_tokens(t_name)
    t_sorted = token_sort_key(t_tokens)
    t_set = set(t_tokens)

    for other in all_sailors:
        oid = other['id']
        if oid == tid:
            continue

        pair_key = tuple(sorted([tid, oid]))
        if pair_key in seen_pairs:
            continue

        o_name = other['name']
        o_tokens = normalize_tokens(o_name)
        o_sorted = token_sort_key(o_tokens)
        o_set = set(o_tokens)

        # 1. Exact token set match (name inversion)
        if t_sorted == o_sorted and len(t_tokens) >= 2:
            seen_pairs.add(pair_key)
            high_confidence.append({
                'type': 'EXACT_INVERSION',
                'target': t_info,
                'candidate': other,
                'score': 1.0,
                'reason': f"Inverted word order: '{t_name}' vs '{o_name}'"
            })
            continue

        # 2. Subset token match (e.g. middle name omitted or patronymic omitted)
        if (t_set.issubset(o_set) or o_set.issubset(t_set)) and len(min(t_set, o_set, key=len)) >= 2:
            shared = t_set.intersection(o_set)
            # Make sure shared tokens are significant (not just single letters)
            if all(len(tk) >= 3 for tk in shared):
                seen_pairs.add(pair_key)
                # Check nationalities
                nat_match = (t_info['nationality'] and other['nationality'] and t_info['nationality'] == other['nationality'])
                sim = len(shared) / max(len(t_set), len(o_set))
                if sim >= 0.66:
                    high_confidence.append({
                        'type': 'TOKEN_SUBSET',
                        'target': t_info,
                        'candidate': other,
                        'score': sim,
                        'reason': f"Token subset: '{t_name}' ({t_info['nationality']}) vs '{o_name}' ({other['nationality']})"
                    })
                continue

        # 3. Overall string similarity (Levenshtein/difflib)
        sim = similarity_ratio(t_name.lower(), o_name.lower())
        sorted_sim = similarity_ratio(t_sorted, o_sorted)
        best_sim = max(sim, sorted_sim)

        if best_sim >= 0.88 and len(t_name) >= 5 and len(o_name) >= 5:
            seen_pairs.add(pair_key)
            high_confidence.append({
                'type': 'HIGH_STRING_SIMILARITY',
                'target': t_info,
                'candidate': other,
                'score': best_sim,
                'reason': f"High similarity ({best_sim:.2f}): '{t_name}' ({t_info['nationality']}) vs '{o_name}' ({other['nationality']})"
            })
        elif best_sim >= 0.80 and len(t_name) >= 6 and len(o_name) >= 6:
            # Check if same nationality or sail number
            same_nat = (t_info['nationality'] and other['nationality'] and t_info['nationality'] == other['nationality'])
            same_sail = (t_info['sail_number'] and other['sail_number'] and t_info['sail_number'] != 'TBD' and t_info['sail_number'] == other['sail_number'])
            if same_nat or same_sail or best_sim >= 0.84:
                seen_pairs.add(pair_key)
                medium_confidence.append({
                    'type': 'MEDIUM_SIMILARITY',
                    'target': t_info,
                    'candidate': other,
                    'score': best_sim,
                    'reason': f"Similarity ({best_sim:.2f}) [same_nat={same_nat}, same_sail={same_sail}]: '{t_name}' vs '{o_name}'"
                })

print(f"Audit completed.")
print(f"High-confidence candidates: {len(high_confidence)}")
print(f"Medium-confidence candidates: {len(medium_confidence)}")

with open('/tmp/fuzzy_audit_results.json', 'w') as f:
    json.dump({'high': high_confidence, 'medium': medium_confidence}, f, indent=2, default=list)
