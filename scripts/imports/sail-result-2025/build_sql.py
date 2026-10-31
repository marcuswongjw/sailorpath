import json
from pathlib import Path
O=Path('scripts/imports/sail-result-2025')
template=Path('scripts/imports/sail-result-2026/transaction-template.sql').read_text().replace('results.import_official_sailresult2026','results.import_official_sailresult2025').replace('Imported reviewed 2026','Imported reviewed 2025')
summary=[]
for p in sorted(O.glob('*.json')):
 m=json.load(open(p))
 if not isinstance(m,dict) or 'sheet' not in m:continue
 body=template.replace('__MANIFEST__',json.dumps(m,ensure_ascii=False,separators=(',',':')))
 if m['sheet'].get('status')=='draft':body=body.replace("'published'","'draft'")
 (O/(p.stem+'.sql')).write_text(body)
 summary.append({'file':p.stem+'.sql','event':m['event']['name'],'sheet':m['sheet']['slug'],'entries':len(m['results']),'scores':sum(len(r['races']) for r in m['results']),'pending':m['deferredEntryCount']})
(O/'inventory.json').write_text(json.dumps(summary,indent=2));print(len(summary),sum(s['entries'] for s in summary),sum(s['scores'] for s in summary))
