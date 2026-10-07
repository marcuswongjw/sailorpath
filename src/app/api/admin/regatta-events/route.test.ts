import { describe, expect, it, vi } from "vitest";
import { regattas } from "@/db/schema";
const mocks = vi.hoisted(() => ({ writes: [] as Record<string, unknown>[] }));
const sheets = [
  { id: "short", eventId: null, raceCount: 2, countsForRanking: false },
  { id: "excluded", eventId: null, raceCount: 5, countsForRanking: false },
  { id: "ranking", eventId: "event", raceCount: 5, countsForRanking: true },
];
vi.mock("@/lib/auth", () => ({ requireSuperadmin: async () => ({ userId: "admin", email: "admin@example.com" }), jsonError: (error: Error) => Response.json({ error: error.message }, { status: 500 }) }));
vi.mock("next/cache", () => ({ revalidatePath: vi.fn() }));
vi.mock("@/lib/revalidatePublic", () => ({ revalidatePublicRankings: vi.fn() }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn() }));
vi.mock("@/lib/admin/groupRegattaEvents", () => ({ groupRegattaEvents: () => ({ events: [{ slug: "test", sheets }] }) }));
vi.mock("@/db", () => ({ db: {
  select: () => ({ from: (table: unknown) => Object.assign(Promise.resolve(table === regattas ? sheets : [{ id: "event", slug: "test" }]), { where: () => ({ limit: async () => [{ id: "event", slug: "test", name: "Test" }] }) }) }),
  insert: () => ({ values: (values: object) => ({ onConflictDoUpdate: () => ({ returning: async () => [{ ...values, id: "event" }] }) }) }),
  update: () => ({ set: (values: Record<string, unknown>) => { mocks.writes.push(values); return { where: async () => undefined }; } }),
} }));
import { PATCH } from "./route";
describe("calendar edits preserve class ranking", () => {
  it.each([true, false])("does not overwrite class flags when calendar ranking is %s", async (countsForRanking) => {
    mocks.writes.length = 0;
    const response = await PATCH(new Request("https://sailorpath.com/api/admin/regatta-events", { method: "PATCH", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ slug: "test", name: "Test", startDate: "2026-01-01", countsForRanking }) }));
    expect(response.status).toBe(200);
    expect(mocks.writes).toHaveLength(2);
    for (const write of mocks.writes) {
      expect(write.eventId).toBe("event");
      expect(write).not.toHaveProperty("countsForRanking");
    }
  });
});
