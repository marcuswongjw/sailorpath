import {beforeEach,describe,expect,it,vi} from 'vitest';
const mocks=vi.hoisted(()=>({auth:vi.fn(),select:vi.fn(),sheet:{
 id:'sheet-1',name:'Official overseas regatta',date:'2026-01-01',boatClass:'Optimist',division:'Open',
 totalFleetSize:3,raceCount:3,countsForRanking:false,geography:'THA',status:'draft',
 officialResultsUrl:null as string|null,officialResultsSourceName:null as string|null,
}}));
vi.mock('@/lib/auth',()=>({requireSuperadmin:mocks.auth,jsonError:()=>Response.json({error:'Forbidden'},{status:403})}));
vi.mock('@/db',()=>({
 withDatabaseRetry:<T>(fn:()=>Promise<T>)=>fn(),
 withSequentialDatabaseReads:async (reads:ReadonlyArray<() => Promise<unknown>>)=>{
  const results=[];
  for (const read of reads) results.push(await read());
  return results;
 },
 db:{select:mocks.select},
}));
import {GET} from './route';
beforeEach(()=>{
 vi.clearAllMocks();mocks.auth.mockResolvedValue({role:'superadmin'});
 Object.assign(mocks.sheet,{countsForRanking:false,officialResultsUrl:null,officialResultsSourceName:null});
 mocks.select.mockImplementation((selection?:Record<string,unknown>)=>({from:()=>({where:()=>{
  const rows=selection&&'n' in selection?[{regattaId:mocks.sheet.id,n:3}]:[mocks.sheet];
  return {limit:()=>Promise.resolve(rows),groupBy:()=>Promise.resolve(rows),then:(resolve:(value:unknown)=>unknown)=>Promise.resolve(rows).then(resolve)};
 }})}));
});
describe('regatta readiness uses the same source/ranking policy as the overview and publish gate',()=>{
 it('requires a sheet or sheets parameter',async()=>{
  const response=await GET(new Request('https://example.com/api/admin/regatta-readiness'));
  expect(response.status).toBe(400);
  expect((await response.json()).error).toContain('sheet or sheets is required');
 });
 it('requires overseas source metadata for a single sheet, then accepts a complete source',async()=>{
  const missing=await(await GET(new Request('https://example.com/api/admin/regatta-readiness?sheet=sheet-1'))).json();
  expect(missing.readiness.summary).toBe('incomplete');
  expect(missing.readiness.checks.map((c:{code:string})=>c.code)).toEqual(expect.arrayContaining(['official-results-url-missing','official-results-source-missing']));
  Object.assign(mocks.sheet,{officialResultsUrl:'https://example.com/official.pdf',officialResultsSourceName:'Official results.pdf'});
  const ready=await(await GET(new Request('https://example.com/api/admin/regatta-readiness?sheet=sheet-1'))).json();
  expect(ready.readiness.summary).toBe('publishable_non_ranking');
 });
 it('blocks overseas ranking inclusion in batch checks too',async()=>{
  Object.assign(mocks.sheet,{countsForRanking:true,officialResultsUrl:'https://example.com/official.pdf',officialResultsSourceName:'Official results.pdf'});
  const body=await(await GET(new Request('https://example.com/api/admin/regatta-readiness?sheets=sheet-1'))).json();
  expect(body.readinessBySheet['sheet-1'].summary).toBe('blocked');
  expect(body.readinessBySheet['sheet-1'].checks.map((c:{code:string})=>c.code)).toContain('external-ranking-blocked');
 });
 it('requires superadmin before reading the database',async()=>{
  mocks.auth.mockRejectedValue(new Error('Forbidden'));
  expect((await GET(new Request('https://example.com/api/admin/regatta-readiness?sheet=sheet-1'))).status).toBe(403);
  expect(mocks.select).not.toHaveBeenCalled();
 });
});
