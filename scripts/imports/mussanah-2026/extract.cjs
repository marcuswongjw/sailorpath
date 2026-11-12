const fs = require('fs');
const { JSDOM } = require('jsdom');
const file = process.argv[2];
if (!file) throw new Error('Supply the saved official Oman Sail HTML');
const document = new JSDOM(fs.readFileSync(file, 'utf8')).window.document;
const sheets = [];
for (const [id, name] of [['optimist','Optimist'],['ilca-4','ILCA 4'],['ilca-6','ILCA 6'],['ilca-7','ILCA 7']]) {
  const day = document.querySelector(`#evr-${id} [data-evr-day="day-4"]`);
  if (!day) throw new Error(`Missing final day for ${name}`);
  const rows = [...day.querySelectorAll('table.evr-table tbody tr[data-evr-row]')].map(row => {
    const text = selector => row.querySelector(selector)?.textContent.trim() || '';
    const entry = row.querySelector('.evr-sub');
    const tags = JSON.parse(row.getAttribute('data-tags') || '{}');
    const sail = [...entry.querySelectorAll('span')].map(el => el.textContent.trim()).find(v => v.startsWith('#'))?.slice(1) || '';
    const race = [...row.querySelectorAll('td.evr-race')].map((cell, index) => ({raceNumber:index+1,score:Number(cell.querySelector('.evr-score')?.textContent.trim()),code:cell.querySelector('.evr-code')?.textContent.trim() || null,discarded:cell.classList.contains('is-disc'),raw:cell.textContent.trim().replace(/\s+/g,' ')}));
    const numbers = [...row.querySelectorAll('td.evr-num')].map(el => Number(el.textContent.trim()));
    return {rank:parseInt(text('.evr-rank'),10), name:text('.evr-name'), nationality:tags.nat || '',gender:tags.gender || null,sail, total:numbers[0],nett:numbers[1],race};
  });
  for (const row of rows) {
    const sum=row.race.reduce((s,r)=>s+r.score,0), net=row.race.filter(r=>!r.discarded).reduce((s,r)=>s+r.score,0);
    if (row.race.length!==12 || !row.name || !row.sail || !Number.isFinite(sum) || Math.abs(sum-row.total)>0.001 || Math.abs(net-row.nett)>0.001) throw new Error(`${name} ${row.rank} ${row.name}: scores=${row.race.length}, total=${sum}/${row.total}, nett=${net}/${row.nett}`);
  }
  sheets.push({id,name,rows});
}
fs.writeFileSync('scripts/imports/mussanah-2026/extracted.json', JSON.stringify(sheets,null,2)+'\n');
for (const s of sheets) console.log(`${s.name}: ${s.rows.length} entries, ${s.rows.reduce((n,r)=>n+r.race.length,0)} race scores`);
