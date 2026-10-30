import { afterEach, describe, expect, it, vi } from 'vitest';
import { PGlite } from '@electric-sql/pglite';
import { drizzle } from 'drizzle-orm/pglite';
import { getTableColumns, getTableName } from 'drizzle-orm';
import { regattas, regattaResults, regattaResultParticipants, regattaRaceResults, sailors } from '@/db/schema';
const mock = vi.hoisted(() => ({db: undefined as unknown, reads: [] as string[]}));
vi.mock('next/cache', () => ({unstable_cache: (fn: unknown) => fn}));
vi.mock('@/db', () => ({
  db: new Proxy({}, {get: (_,key) => {const value = (mock.db as Record<PropertyKey,unknown>)[key];return typeof value === 'function' ? value.bind(mock.db) : value;}}),
  withDatabaseRetry: (fn: () => unknown, options?: {label?: string}) => { mock.reads.push(options?.label || "read"); return fn(); },
  isMissingDatabaseSchemaError: () => false,
  ensureCoreSchema: vi.fn(), formatDbError: (error: Error) => error.message,
  isRetryableDatabaseConnectionError: () => false,
  DbUnavailableError: class extends Error {},
}));
import { getResultsForSailor, getResultsForRegatta } from './queries';
let database: PGlite;
afterEach(async () => { await database.close(); });
const id = (n: number) => `00000000-0000-4000-8000-${String(n).padStart(12,'0')}`;
describe('public sailor results query', () => {
  it('filters both direct and crew results before returning history, scores or participant metadata', async () => {
    database = new PGlite();
    mock.db = drizzle(database);
    for (const table of [regattas,regattaResults,regattaResultParticipants,regattaRaceResults,sailors]) {
      const columns = Object.values(getTableColumns(table)).map(column => `"${column.name}" ${column.getSQLType()}`).join(',');
      await database.exec(`create table "${getTableName(table)}" (${columns})`);
    }
    await database.exec(`insert into sailors (id,name,handle) values ('${id(1)}','Profile sailor','profile'),('${id(2)}','Helm','helm');`);
    const fixtures = [
      ['published-direct','published',id(1),false],
      ['review-direct','in_review',id(1),false],
      ['published-crew','published',id(2),true],
      ['draft-crew','draft',id(2),true],
      ['archived-direct','archived',id(1),false],
      ['log-personal','draft',id(1),false],
    ] as const;
    for (const [index,[slug,status,sailorId,crew]] of fixtures.entries()) {
      await database.query(`insert into regattas (id,name,slug,date,status,boat_class,counts_for_ranking) values ($1,$2,$2,'2026-01-01',$3,'ILCA 6',false)`,[id(10+index),slug,status]);
      await database.query(`insert into regatta_results (id,regatta_id,sailor_id,rank,verification_status) values ($1,$2,$3,3,'self_reported')`,[id(20+index),id(10+index),sailorId]);
      if (crew) await database.query(`insert into regatta_result_participants (id,regatta_result_id,sailor_id,source_name,display_order,role) values ($1,$2,$3,'Crew sailor',1,'crew')`,[id(30+index),id(20+index),id(1)]);
    }
    await database.query(`insert into regatta_race_results (regatta_result_id,race_number,score,discarded,raw_value) values ($1,1,3,true,'(3)')`, [id(20)]);
    await database.query(`update sailors set dob='2012-08-23',school='Private fixture school',show_school_on_public_profile=false where id=$1`, [id(1)]);
    mock.reads.length = 0;
    const scorecard = await getResultsForRegatta(id(10));
    expect(scorecard[0]).toMatchObject({birthYear:2012});
    expect(scorecard[0]).not.toHaveProperty('dob');
    expect(scorecard[0]).not.toHaveProperty('school');
    expect(mock.reads).toEqual(['public.results.entries','public.results.participants','public.results.races']);
    expect(scorecard[0].raceResults?.[0]).toMatchObject({ score: 3, discarded: true, rawValue: '(3)' });
    const rows = await getResultsForSailor(id(1));
    expect(rows.map(row=>row.regattaSlug).sort()).toEqual(['published-crew','published-direct']);
    expect(rows.find(row=>row.regattaSlug==='published-crew')?.participants).toHaveLength(1);
    expect(rows.find(row=>row.regattaSlug==='log-personal')).toBeUndefined();
  });
});
