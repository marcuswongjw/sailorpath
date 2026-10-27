import { readFileSync } from "node:fs";
import { afterEach, describe, expect, it } from "vitest";
import { PGlite } from "@electric-sql/pglite";
const sql = readFileSync(new URL("./migrations/20261027023700_private_avatar_reads.sql", import.meta.url), "utf8");
let database: PGlite | undefined;
afterEach(async () => { await database?.close(); database = undefined; });
describe("avatar storage consent policies", () => {
  it("revokes public originals, isolates old photos, prevents signing and denies overwrites", async () => {
    database = new PGlite();
    await database.exec(`
      create role anon; create role authenticated; create role service_role;
      create schema storage; create schema private;
      create table storage.buckets(id text, public boolean);
      insert into storage.buckets values ('avatars', true);
      create table storage.objects(bucket_id text, name text);
      create table public.sailors(id uuid, show_profile_photo_on_public_profile boolean, avatar_url text);
      insert into public.sailors values ('11111111-1111-4111-8111-111111111111', true,
        'https://project.supabase.co/storage/v1/object/public/avatars/11111111-1111-4111-8111-111111111111/current.jpg');
      insert into storage.objects values
        ('avatars','11111111-1111-4111-8111-111111111111/current.jpg'),
        ('avatars','11111111-1111-4111-8111-111111111111/old.jpg'),
        ('avatars','11111111-1111-4111-8111-111111111111/curr_nt.jpg');
      create function private.can_manage_sailor_storage_folder(folder text) returns boolean language sql as $$
        select current_setting('test.actor', true) in ('owner', 'guardian', 'admin') $$;
      create function storage.allow_any_operation(operations text[]) returns boolean language sql as $$
        select current_setting('test.operation', true) = any(operations) $$;
      create function storage.foldername(name text) returns text[] language sql as $$ select string_to_array(name, '/') $$;
      grant usage on schema storage, private to authenticated;
      grant usage on schema storage to anon;
      grant select, update on storage.objects to anon, authenticated;
      alter table storage.objects enable row level security;
      create policy "Avatar public read" on storage.objects for select using (bucket_id='avatars');
      create policy "Avatar authenticated update" on storage.objects for update to authenticated using(true) with check(true);
    `);
    await database.exec(sql);
    expect((await database.query<{public:boolean}>("select public from storage.buckets")).rows[0].public).toBe(false);
    await database.exec("set role anon; set test.operation='storage.object.get_authenticated'");
    const visible = await database.query<{name:string}>("select name from storage.objects");
    expect(visible.rows.map(r=>r.name)).toEqual(['11111111-1111-4111-8111-111111111111/current.jpg']);
    for (const operation of ['storage.object.sign', 'storage.object.list', 'storage.object.get_public']) {
      await database.exec(`set test.operation='${operation}'`);
      expect((await database.query("select * from storage.objects")).rows).toHaveLength(0);
    }
    await database.exec("reset role; update public.sailors set show_profile_photo_on_public_profile=false; set role anon; set test.operation='storage.object.get_authenticated'");
    expect((await database.query("select * from storage.objects")).rows).toHaveLength(0);
    await database.exec("set role authenticated; set test.actor='unrelated'");
    expect((await database.query("select * from storage.objects")).rows).toHaveLength(0);
    for (const actor of ['owner','guardian','admin']) {
      await database.exec(`set test.actor='${actor}'`);
      expect((await database.query("select * from storage.objects")).rows).toHaveLength(3);
      expect((await database.query("update storage.objects set name='overwritten.jpg' returning name")).rows).toHaveLength(0);
    }
  });
});
