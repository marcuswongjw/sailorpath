import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ revalidate: vi.fn(), manage: vi.fn(), write: vi.fn() }));
vi.mock("@/lib/userChanges", () => ({ withUserChangeTracking: (_scope: string, handler: unknown) => handler }));
vi.mock("@/lib/revalidatePublic", () => ({ revalidatePublicRankings: mocks.revalidate }));
vi.mock("@/lib/auth", () => ({ getAuthContext: async () => ({ userId: "owner", role: "parent" }), jsonError: () => Response.json({}, { status: 500 }) }));
vi.mock("@/lib/claimAccess", () => ({ canManageSailor: mocks.manage }));
vi.mock("@/db", () => ({ db: {
  select: () => ({ from: () => ({ where: () => ({ limit: async () => [{ id: "obs", sailorId: "sailor", parentId: "owner" }] }) }) }),
  insert: () => ({ values: () => ({ onConflictDoUpdate: () => ({ returning: mocks.write }) }) }),
  delete: () => ({ where: mocks.write }),
} }));
import { POST, DELETE } from "./route";
beforeEach(() => { vi.clearAllMocks(); mocks.manage.mockResolvedValue(true); mocks.write.mockResolvedValue([{ id: "obs" }]); });
describe("private observation cache isolation", () => {
  it.each([POST, DELETE])("saves private changes without flushing public ranking snapshots", async (handler) => {
    const response = await handler(new Request("https://sailorpath.com/api/account/observations", {
      method: handler === POST ? "POST" : "DELETE", headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ id: "obs", sailorId: "sailor", regattaId: "regatta", raceNumber: 1, note: "Private note" }),
    }));
    expect(response.status).toBe(200); expect(mocks.write).toHaveBeenCalled(); expect(mocks.revalidate).not.toHaveBeenCalled();
  });
});
