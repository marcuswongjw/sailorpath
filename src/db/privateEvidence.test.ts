import { readFileSync } from "node:fs";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import { PGlite } from "@electric-sql/pglite";
const migration = readFileSync(new URL("./migrations/20261026102457_private_regatta_evidence.sql", import.meta.url), "utf8");
const uploadMigration = readFileSync(new URL("./migrations/20261028095000_evidence_upload_quotas_and_claim_check.sql", import.meta.url), "utf8");
const previous = readFileSync(new URL("./migrations/102_storage_object_owner_policies.sql", import.meta.url), "utf8");
const helper = previous.match(/CREATE OR REPLACE FUNCTION private\.can_manage_evidence_object[\s\S]*?\$\$;/)![0];
const owner = "11111111-1111-4111-8111-111111111111";
const other = "22222222-2222-4222-8222-222222222222";
const admin = "33333333-3333-4333-8333-333333333333";
let database: PGlite;
beforeAll(async () => {
  database = new PGlite();
  await database.exec(`create role anon; create role authenticated; create role service_role;
    create schema storage; create schema private; create schema auth;
    create table storage.buckets (id text, public boolean);
    insert into storage.buckets values ('regatta-evidence', true), ('avatars', true);
    create table storage.objects (bucket_id text, name text, metadata jsonb default '{}'::jsonb);
    insert into storage.objects (bucket_id, name, metadata) values ('regatta-evidence', '${owner}/123_results.pdf', '{"size": 1024}'::jsonb);
    create table public.profiles (id uuid, role text);
    insert into profiles values ('${admin}', 'superadmin');
    create table public.sailors (id uuid, parent_id uuid);
    create table public.sailor_claims (id uuid, sailor_id uuid, requester_id uuid, status text);
    insert into public.sailor_claims values ('44444444-4444-4444-8444-444444444444', '55555555-5555-4555-8555-555555555555', '${owner}', 'approved');
    create function auth.uid() returns uuid language sql stable as $$ select nullif(current_setting('test.user', true), '')::uuid $$;
    ${helper}
    grant usage on schema storage, private, auth to anon, authenticated;
    revoke all on function private.can_manage_evidence_object(text) from public, anon;
    grant execute on function private.can_manage_evidence_object(text) to authenticated;
    grant select, insert on storage.objects to anon, authenticated;
    grant select on public.profiles, public.sailors, public.sailor_claims to authenticated;
    alter table storage.objects enable row level security;
    create policy "Regatta evidence public read" on storage.objects for select to public using (bucket_id='regatta-evidence');
    create policy "Regatta evidence owner read" on storage.objects for select to authenticated using (bucket_id='regatta-evidence' and private.can_manage_evidence_object(name));
    create policy "Regatta evidence authenticated upload" on storage.objects for insert to authenticated with check (bucket_id='regatta-evidence' and private.can_manage_evidence_object(name));`);
  await database.exec(migration);
  await database.exec(uploadMigration);
});
afterAll(async () => database.close());
async function visible(role: string, user: string) {
  await database.exec(`set role ${role};`);
  try {
    await database.query("select set_config('test.user', $1, false)", [user]);
    const result = await database.query<{ n: number }>("select count(*)::int as n from storage.objects");
    return result.rows[0].n;
  } finally { await database.exec("reset role"); }
}
async function canInsert(user: string, objectName: string) {
  await database.exec("set role authenticated;");
  try {
    await database.query("select set_config('test.user', $1, false)", [user]);
    await database.query(
      "insert into storage.objects (bucket_id, name, metadata) values ('regatta-evidence', $1, '{\"size\": 1024}'::jsonb)",
      [objectName]
    );
    return true;
  } catch {
    return false;
  } finally {
    await database.exec("reset role");
  }
}
describe("private evidence storage migration", () => {
  it("makes only evidence private without deleting objects or changing avatars", async () => {
    const result = await database.query<{ id: string; public: boolean }>("select * from storage.buckets order by id");
    expect(result.rows).toEqual([{ id: "avatars", public: true }, { id: "regatta-evidence", public: false }]);
  });
  it("denies anonymous and unrelated users while retaining uploader and reviewer access", async () => {
    expect(await visible("anon", "")).toBe(0);
    expect(await visible("authenticated", other)).toBe(0);
    expect(await visible("authenticated", owner)).toBe(1);
    expect(await visible("authenticated", admin)).toBe(1);
  });
  it("requires an approved claim or ownership and enforces aggregate quotas on upload", async () => {
    expect(await canInsert(other, `${other}/unclaimed.pdf`)).toBe(false);
    expect(await canInsert(owner, `${owner}/allowed.pdf`)).toBe(true);
    await database.query(
      "insert into storage.objects (bucket_id, name, metadata) values ('regatta-evidence', $1, '{\"size\": 104857600}'::jsonb)",
      [`${owner}/quota_fill.pdf`]
    );
    expect(await canInsert(owner, `${owner}/over_quota.pdf`)).toBe(false);
    expect(await canInsert(admin, `${admin}/admin_upload.pdf`)).toBe(true);
  });
});
