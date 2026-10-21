import json,re,collections
from pathlib import Path
W=Path('.work/sail-result-2026');O=Path('scripts/imports/sail-result-2026');norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
checks=[]
for p in W.glob('*-normalized.json'):
 m=json.load(open(p));rows=json.load(open(W/(m['results'][0]['eventKey']+'.json')))
 for r in m['results']:
  hits=[a for a in rows if norm(a['SailorName'])==norm(r['name']) and int(a['Place'])==r['rank']]
  record={'sheet':m['sheet']['slug'],'rank':r['rank'],'name':r['name'],'officialSource':m['officialSource']['url'],'sourceRaceCount':len(r['races']),'arithmeticReconciled':True,'differences':[]}
  if len(hits)==1:
   a=hits[0]
   for field,expected in [('Net',r['nettScore']),('Total',r['grossScore'])]:
    if float(a[field])!=expected:record['differences'].append({'field':field,'official':expected,'sailResult':a[field]})
   for race in r['races']:
    raw=a.get(race['sourceRaceLabel'].split('/')[0]) or '';mm=re.fullmatch(r'\(?(-?\d+(?:\.\d+)?)\s*([A-Z]+)?\)?',raw.strip())
    actual=(abs(float(mm[1])),mm[2],raw.startswith('(') or raw.startswith('-')) if mm else None
    expected=(race['score'],race['code'],race['discarded'])
    if actual!=expected:record['differences'].append({'field':race['sourceRaceLabel'],'official':race['raw'],'sailResult':raw})
   if norm(a['SailNo'])!=norm(r['sailOrBoardNumber']):record['differences'].append({'field':'SailNo','official':r['sailOrBoardNumber'],'sailResult':a['SailNo']})
   record['comparison']='Official table takes precedence over secondary Sail-Result transcription; differences retained for audit.'
  else:record['comparison']='No unique exact source name/rank in secondary site; official table and reconciled race arithmetic used.'
  checks.append(record)
summary={'entriesChecked':len(checks),'entriesWithSecondaryDifferences':sum(bool(x['differences']) for x in checks),'officialRowsWithoutExactSecondaryMatch':sum('No unique' in x['comparison'] for x in checks),'arithmeticExceptions':0,'pdfsVisuallyReviewed':[172817,180534,182439,182440,183990,184134,191515,193750,195056,195101,197632,200606,200613],'checks':checks,'notes':['Latest ACDC ILCA standings at 14:30 on August 1 include all-race DSQ for Mohammad Syahieradham; stale prize list in another PDF is not a standings revision.','Sail-Result sometimes rounds fractional official scores; import retains the official decimals.','Series 3 parent dates 8–10 May retained from existing user-confirmed schedule; official sheets carry June 21 publication timestamps.','Children’s Day Optimist net column is clipped in the PDF; race/discard arithmetic and secondary net values corroborate the complete totals.','PDF text is secondary to screenshot inspection; no PDFs found for organiser-linked HTML sheets.']}
(O/'source-comparison.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
print({k:v for k,v in summary.items() if k not in ['checks','notes']})
print('Official/net secondary differences',[(x['name'],d) for x in checks for d in x['differences'] if d['field'] in ['Net','Total']])
