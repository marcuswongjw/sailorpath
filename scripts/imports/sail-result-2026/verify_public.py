import json,urllib.request,urllib.error,concurrent.futures,re,html
from pathlib import Path
O=Path('scripts/imports/sail-result-2026');out=Path('outputs/sail-result-2026');ms=[json.load(open(p)) for p in O.glob('*.json') if isinstance(json.load(open(p)),dict) and 'sheet' in json.load(open(p))]
def check(m):
 boat=m['sheet']['boatClass'];div=m['sheet']['division'];fleet='ilca-'+boat[-1] if boat.startswith('ILCA') else 'optimist'+('-'+div.lower() if div!='Open' else '')
 url='https://sailorpath.com/regattas/'+m['event']['slug']+'/results/'+fleet
 try:
  r=urllib.request.urlopen(url,timeout=60);page=r.read().decode();text=html.unescape(re.sub(r'<!--.*?-->','',page));plain=html.unescape(re.sub('<[^>]+>',' ',page));
  return dict(sheet=m['sheet']['slug'],url=url,status=r.status,fleet=fleet,officialSourcePresent=m['officialSource']['url'].split('?')[0] in text,lastRacePresent=bool(re.search('R'+str(m['sheet']['raceCount'])+r'(?:<|\s)',text)),partialNoteVisible='Partial import:' in plain if m['deferredEntryCount'] else None,provisionalBadge=('Provisional' in text) if m['officialSource']['provisional'] else None,bytes=len(page))
 except Exception as e:return dict(sheet=m['sheet']['slug'],url=url,error=str(e))
with concurrent.futures.ThreadPoolExecutor(max_workers=6) as ex:results=list(ex.map(check,ms))
(out/'public-checks.json').write_text(json.dumps(results,indent=2)+'\n')
print('checked',len(results),'200',sum(r.get('status')==200 for r in results),'official evidence',sum(r.get('officialSourcePresent',False) for r in results))
for r in results:
 if r.get('status')!=200 or not r.get('officialSourcePresent') or not r.get('lastRacePresent') or r.get('partialNoteVisible')==False:print(r)
