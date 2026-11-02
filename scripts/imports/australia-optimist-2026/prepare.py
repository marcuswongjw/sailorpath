import os
import re
import json
import uuid

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
NAMESPACE_SAILOR = uuid.UUID('6ba7b810-9dad-11d1-80b4-00c04fd430c8')

with open('scripts/imports/asian-championships-priority1/existing-sailors.json') as f:
    existing_data = json.load(f)
existing_sailors = existing_data['rows'][0]['json_agg']

def norm_name(n):
    return re.sub(r'[^a-z0-9]', '', n.lower())

def slugify(s):
    s = s.lower().strip()
    s = re.sub(r'[^a-z0-9]+', '-', s)
    return s.strip('-')

sailor_by_norm = {}
for s in existing_sailors:
    norm = norm_name(s['name'])
    sailor_by_norm.setdefault(norm, []).append(s)

def parse_cell(val):
    val = val.strip().replace('&nbsp;', ' ')
    discarded = False
    code = None
    pts = None
    m_disc = re.search(r'\(([^)]+)\)', val)
    if m_disc:
        discarded = True
        inner = m_disc.group(1).strip()
        remainder = val.replace(f'({m_disc.group(1)})', '').strip()
        m_num = re.search(r'([0-9.]+)', inner)
        if m_num:
            pts = float(m_num.group(1))
        code_str = remainder + re.sub(r'[0-9.\s]', '', inner)
        if code_str:
            code = code_str.strip()
    else:
        m_num = re.match(r'^([0-9.]+)\s*([A-Z]*)$', val)
        if m_num:
            pts = float(m_num.group(1))
            code = m_num.group(2) if m_num.group(2) else None
        else:
            code = val
    return pts, code, discarded

print('Starting extraction and preparation...')
