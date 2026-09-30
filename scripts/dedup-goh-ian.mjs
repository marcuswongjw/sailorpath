import postgres from 'postgres';
import fs from 'fs';
import path from 'path';

// Manual env load
const envPath = path.join(process.cwd(), '.env.local');
const env = {};
if (fs.existsSync(envPath)) {
  fs.readFileSync(envPath, 'utf8').split('\n').forEach(line => {
    const [key, ...val] = line.split('=');
    if (key && val) env[key.trim()] = val.join('=').trim().replace(/^"|"$/g, '');
  });
}

const url = env.DATABASE_URL;
if (!url) {
  console.error("No DATABASE_URL found in .env.local");
  process.exit(1);
}

const sql = postgres(url);

async function run() {
  try {
    console.log("Finding sailors...");
    const sailors = await sql`
      SELECT id, name FROM sailors 
      WHERE name = 'Goh Siak Yiak Ian' OR name = 'Ian Goh'
    `;
    
    const gohSiyak = sailors.find(s => s.name === 'Goh Siak Yiak Ian');
    const ianGoh = sailors.find(s => s.name === 'Ian Goh');
    
    if (!gohSiyak || !ianGoh) {
      console.error("Could not find both sailors.");
      return;
    }
    
    console.log(`Found: ${gohSiyak.name} (${gohSiyak.id}) and ${ianGoh.name} (${ianGoh.id})`);
    
    const results = await sql`
      SELECT id, regatta_id, sailor_id 
      FROM regatta_results 
      WHERE sailor_id = ${gohSiyak.id} OR sailor_id = ${ianGoh.id}
    `;
    
    const regattaIds = [...new Set(results.map(r => r.regatta_id))];
    const regattaRows = await sql`
      SELECT id, boat_class, division 
      FROM regattas 
      WHERE id IN ${regattaIds}
    `;
    const regMap = new Map(regattaRows.map(r => [r.id, r]));
    
    let movedCount = 0;
    
    for (const res of results) {
      const reg = regMap.get(res.regatta_id);
      if (!reg) continue;
      
      const boatClass = (reg.boat_class || "Optimist").toLowerCase();
      const division = (reg.division || "").toLowerCase();
      
      let shouldMoveToIan = false;
      if (boatClass.includes("ilca")) {
        shouldMoveToIan = true;
      } else if (boatClass.includes("optimist")) {
        if (division.includes("gold")) {
          shouldMoveToIan = true;
        }
      }
      
      if (shouldMoveToIan && res.sailor_id === gohSiyak.id) {
        await sql`
          UPDATE regatta_results 
          SET sailor_id = ${ianGoh.id}, updated_at = NOW() 
          WHERE id = ${res.id}
        `;
        movedCount++;
      }
    }
    
    console.log(`Successfully moved ${movedCount} results to Ian Goh.`);
  } catch (e) {
    console.error(e);
  } finally {
    await sql.end();
  }
}

run();
