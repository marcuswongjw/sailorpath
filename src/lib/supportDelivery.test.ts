import { readFileSync } from "node:fs";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/pglite";
import { afterAll, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { supportDeliveries } from "@/db/schema";
const mocks = vi.hoisted(() => ({ db: null as unknown, send: vi.fn() }));
vi.mock("@/db", () => ({ get db() { return mocks.db; } }));
vi.mock("@/lib/notifications", () => ({ sendResendTextEmail: mocks.send }));
import { deliverSupportEmail } from "./supportDelivery";
const pg = new PGlite();
const database = drizzle(pg);
const ticket = "00000000-0000-4000-8000-000000000001";
const replyId = "00000000-0000-4000-8000-000000000002";
const actor = "00000000-0000-4000-8000-000000000003";
beforeAll(async () => {
  await pg.exec(`CREATE ROLE anon; CREATE ROLE authenticated;
    CREATE TABLE profiles(id uuid primary key);
    CREATE TABLE support_messages(id uuid primary key,user_id uuid,email text,name text,topic text,body text,page_url text,status text,created_at timestamp default now(),updated_at timestamp default now());`);
  await pg.exec(readFileSync("src/db/migrations/20261023005413_support_delivery_history.sql", "utf8"));
  mocks.db = database;
}, 30000);
afterAll(async () => { await pg.close(); });
beforeEach(async () => {
  await pg.exec(`truncate support_deliveries,support_messages,profiles cascade;
    insert into profiles values ('${actor}');
    insert into support_messages(id,email,body,status) values ('${ticket}','requester@example.com','PRIVATE INCOMING REQUEST','new');`);
  mocks.send.mockReset().mockResolvedValue("sent");
});
const reply = { id: replyId, messageId: ticket, kind: "reply" as const, text: "We have fixed the issue.", actorUserId: actor, actorEmail: "team@example.com" };
describe("support email correspondence", () => {
  it("sends a generic acknowledgement once and never echoes untrusted incoming content", async () => {
    const input = { id: ticket, messageId: ticket, kind: "acknowledgement" as const };
    expect((await deliverSupportEmail(input)).status).toBe("sent");
    await deliverSupportEmail(input);
    expect(mocks.send).toHaveBeenCalledTimes(1);
    expect(mocks.send.mock.calls[0][0]).toMatchObject({ to: "requester@example.com", idempotencyKey: `support/${ticket}` });
    expect(mocks.send.mock.calls[0][0].text).not.toContain("PRIVATE INCOMING");
  });
  it("stores replies, fixes recipients on the server, and marks new requests read after acceptance", async () => {
    const result = await deliverSupportEmail(reply);
    expect(result).toMatchObject({ recipient: "requester@example.com", replyTo: "team@example.com", body: reply.text, status: "sent" });
    expect((await pg.query<{status:string}>(`select status from support_messages`)).rows[0].status).toBe("read");
    await expect(deliverSupportEmail({...reply, text:"Different payload"})).rejects.toMatchObject({status:409});
    expect(mocks.send).toHaveBeenCalledTimes(1);
  });
  it("preserves failed history and retries with exactly the original key and payload", async () => {
    mocks.send.mockResolvedValueOnce("failed");
    expect((await deliverSupportEmail(reply)).status).toBe("failed");
    expect((await pg.query<{status:string}>(`select status from support_messages`)).rows[0].status).toBe("new");
    await deliverSupportEmail({...reply, actorEmail:"changed@example.com"});
    expect(mocks.send.mock.calls[0][0]).toEqual(mocks.send.mock.calls[1][0]);
    expect(await database.select().from(supportDeliveries)).toHaveLength(1);
  });
  it("does not send concurrent duplicate requests twice", async () => {
    const outcomes = await Promise.allSettled([deliverSupportEmail(reply),deliverSupportEmail(reply)]);
    expect(outcomes.some((outcome)=>outcome.status==="fulfilled")).toBe(true);
    expect(mocks.send).toHaveBeenCalledTimes(1);
  });
  it("does not silently retry uncertain attempts outside the provider idempotency window", async () => {
    mocks.send.mockResolvedValueOnce("failed"); await deliverSupportEmail(reply);
    await pg.exec("update support_deliveries set created_at=now()-interval '2 days'");
    await expect(deliverSupportEmail(reply)).rejects.toMatchObject({status:409});
    expect(mocks.send).toHaveBeenCalledTimes(1);
  });
  it("denies direct browser-role access to correspondence", async () => {
    const rows=await pg.query<{rls:boolean,anon:boolean,authenticated:boolean}>("select c.relrowsecurity as rls,has_table_privilege('anon','support_deliveries','select') as anon,has_table_privilege('authenticated','support_deliveries','select') as authenticated from pg_class c where c.relname='support_deliveries'");
    expect(rows.rows[0]).toEqual({rls:true,anon:false,authenticated:false});
  });
});
