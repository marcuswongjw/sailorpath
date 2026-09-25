// Prepare data from legacy import SQL without executing its destructive statements.
// Output is reviewed and applied separately; this script never connects to a database.
import fs from 'node:fs';
import path from 'node:path';

const dir = 'src/db/migrations';
const out = 'artifacts/supabase-sync';
fs.mkdirSync(out, { recursive: true });
function splitValues(s) {
  const values = []; let start = 0, depth = 0, quoted = false;
  for (let i = 0; i < s.length; i++) {
    if (s[i] === "'") {
      if (quoted && s[i + 1] === "'") { i++; continue; }
      quoted = !quoted;
    } else if (!quoted) {
      if (s[i] === '(') depth++;
      if (s[i] === ')') depth--;
      if (s[i] === ',' && depth === 0) { values.push(s.slice(start, i).trim()); start = i + 1; }
    }
  }
  values.push(s.slice(start).trim());
  return values;
}
function literal(s) {
  if (/^'.*'$/s.test(s)) return s.slice(1, -1).replaceAll("''", "'");
  if (/^null$/i.test(s)) return null;
  if (/^(true|false)$/i.test(s)) return s.toLowerCase() === 'true';
  if (/^-?\d+(\.\d+)?$/.test(s)) return Number(s);
  if (/^(v_\w+|gen_random_uuid\(\)|now\(\))$/.test(s)) return undefined;
  throw new Error(`Unsupported SQL value: ${s}`);
}
function inserts(s, table) {
  const re = new RegExp(`INSERT INTO public\\.${table}\\s*\\(([^;]+?)\\)\\s*VALUES\\s*\\(([\\s\\S]+?)\\);`, 'g');
  return [...s.matchAll(re)].map(m => {
    const cols = m[1].split(',').map(c => c.trim());
    const vals = splitValues(m[2]);
    if (cols.length !== vals.length) throw new Error(`Column mismatch ${table}`);
    return Object.fromEntries(cols.map((c, i) => [c, literal(vals[i])]));
  });
}
const aliases = {
  'safyc-2026-ilca-4': 'safyc-ilca4-feb-26-2026-02-14',
  'snsc-ilca-4-sep-25-2025-09-06': 'snsc-ilca4-sep-25-2025-09-06',
  'pesta-sukan-ilca-4-aug-25-2025-08-02': 'pesta-sukan-ilca4-aug-25-2025-08-02',
};
const events = [];
for (const file of fs.readdirSync(dir).filter(f => /^(063|064|065|066|067|069|070)_/.test(f)).sort()) {
  const sql = fs.readFileSync(path.join(dir, file), 'utf8');
  for (const block of sql.split(/\bDO (?:\$\$|\d+)\s*\n/).slice(1)) {
    const regatta = inserts(block, 'regattas')[0];
    if (!regatta) throw new Error(`Missing regatta in ${file}`);
    regatta.slug = aliases[regatta.slug] || regatta.slug;
    regatta.geography = 'SGP';
    regatta.status = 'published';
    const competitors = block.split(/-- Competitor:/).slice(1).map(part => {
      const sailor = inserts(part, 'sailors')[0];
      const raw = inserts(part, 'regatta_results')[0];
      if (!sailor || !raw) throw new Error(`Missing competitor in ${file}`);
      const result = {
        rank: raw.rank ?? raw.position,
        total_score: raw.total_score ?? raw.points,
        nett_score: raw.nett_score ?? raw.nett,
        is_dns: raw.is_dns ?? false,
        is_overseas_commitment: raw.is_overseas_commitment ?? false,
        gender: raw.gender ?? raw.sailor_gender ?? sailor.gender ?? null,
        nationality: raw.nationality ?? sailor.nationality ?? null,
        verification_status: 'verified',
      };
      const races = inserts(part, 'regatta_race_results').map(r => ({
        race_number: r.race_number, score: r.score,
        raw_value: r.raw_value ?? (r.scoring_code || String(r.score)),
        scoring_code: r.scoring_code ?? null, discarded: r.discarded ?? r.is_discard ?? false,
      }));
      if (!Number.isInteger(result.rank) || result.rank < 1 || races.length !== regatta.race_count) throw new Error(`Invalid result ${file}: ${sailor.name}`);
      return { sailor, result, races };
    });
    if (competitors.length !== regatta.total_fleet_size) throw new Error(`Fleet mismatch ${regatta.slug}: ${competitors.length}/${regatta.total_fleet_size}`);
    events.push({ source: file, regatta, competitors });
  }
}
fs.writeFileSync(path.join(out, 'events.json'), JSON.stringify(events, null, 2));
console.log(JSON.stringify(events.map(e => ({ slug: e.regatta.slug, sailors: e.competitors.length, races: e.competitors.reduce((n,c)=>n+c.races.length,0) })), null, 2));
