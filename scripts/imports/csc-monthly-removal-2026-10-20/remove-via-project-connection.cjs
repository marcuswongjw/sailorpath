const fs = require('node:fs');
const {Client} = require('pg');
const env = require('dotenv').parse(fs.readFileSync('.env.local'));
const url = new URL(env.DATABASE_URL);
if (!(url.hostname.includes('fdziuyexczkngvugvsbu') || decodeURIComponent(url.username).includes('fdziuyexczkngvugvsbu'))) throw new Error('Database project differs from authorized SailorPath production');
for (const key of ['sslmode','sslcert','sslkey','sslrootcert']) url.searchParams.delete(key);
const caSource = fs.readFileSync('src/db/supabaseCa.ts','utf8');
const ca = JSON.parse(caSource.match(/SUPABASE_ROOT_CA = ("[^;]+");/)[1]);
const client = new Client({connectionString:url.toString(),ssl:{ca,rejectUnauthorized:true},connectionTimeoutMillis:15000,query_timeout:45000});
(async()=>{
 try {
  await client.connect();
  const pre = await client.query("select count(*)::int sheets from regattas where slug like 'csc-monthly-dinghy-race-%'");
  console.log('Matching monthly sheets:',pre.rows[0].sheets);
  if (process.argv.includes('--apply')) {
   if (pre.rows[0].sheets!==18) throw new Error('Expected 18 sheets; no mutation attempted');
   await client.query(fs.readFileSync('scripts/imports/csc-monthly-removal-2026-10-20/02-remove-monthly-events.sql','utf8'));
   console.log('Authorized monthly results removal committed');
  }
 } catch(error) {console.error(error.code||'DATABASE_ERROR',error.message.replace(/postgres(?:ql)?:\/\/\S+/g,'[redacted connection]'));process.exitCode=1;}
 finally{await client.end();}
})();
