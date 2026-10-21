import json,subprocess
from pathlib import Path
O=Path('scripts/imports/sail-result-2026');pending=json.load(open(O/'pending-identities.json'));body=(O/'transaction-template.sql').read_text();summaries=[]
for p in sorted(O.glob('*.json')):
 m=json.load(open(p))
 if not isinstance(m,dict) or 'sheet' not in m:continue
 m['pendingEntries']=[r for r in pending if r['sheet']==m['sheet']['slug']]
 inventory=json.load(open('.work/sail-result-2026/inventory.json')); sourceName=next(e['event_name'] for e in inventory if e['key']==m['results'][0]['eventKey'])
 m['officialSource']['secondaryUrl']='https://sail-result.com/result_detail.html?event='+__import__('urllib.parse',fromlist=['quote']).quote(sourceName)
 if not m['officialSource'].get('title'):m['officialSource']['title']=m['event']['name']+' — official '+m['sheet']['boatClass']+' '+m['sheet']['division']+' results'
 p.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
 v=subprocess.run(['node','/Users/marcus/.agents/skills/sailorpath-official-results-import/scripts/validate_import_manifest.mjs',str(p)],capture_output=True,text=True)
 assert v.returncode==0,v.stderr
 summaries.append(json.loads(v.stdout))
 (O/(p.stem+'.sql')).write_text('-- '+m['sheet']['name']+'; authorized unaffected entries, official fleet size retained.\n'+body.replace('__MANIFEST__',json.dumps(m,ensure_ascii=False,separators=(',',':'))))
(O/'validation.json').write_text(json.dumps(summaries,indent=2)+'\n')
print('Validated',len(summaries),'sheets,',sum(s['competitors'] for s in summaries),'entries,',sum(s['individualRaceScores'] for s in summaries),'scores')
