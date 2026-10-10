import { beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";
import { PgDialect } from "drizzle-orm/pg-core";

const mocks = vi.hoisted(() => ({ auth: vi.fn(), where: vi.fn(), offset: vi.fn() }));
vi.mock("@/lib/auth", () => ({
  requireSuperadmin: mocks.auth,
  jsonError: () => Response.json({ error: "Forbidden" }, { status: 403 }),
}));
vi.mock("@/db", () => ({ db: {
  select: () => ({ from: () => ({ where: (predicate: unknown) => {
    mocks.where(predicate);
    return { orderBy: () => ({ limit: () => ({ offset: mocks.offset }) }) };
  } }) }),
} }));
import { GET } from "./route";

describe("registered user change feed", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mocks.auth.mockResolvedValue({ userId: "admin", role: "superadmin" });
    mocks.offset.mockResolvedValue([]);
  });

  it("requires superadmin before querying changes", async () => {
    mocks.auth.mockRejectedValueOnce(new Error("Forbidden"));
    expect((await GET(new Request("https://sailorpath.com/api/admin/user-changes"))).status).toBe(403);
    expect(mocks.where).not.toHaveBeenCalled();
  });

  it.each(["days=365", "offset=-1", "offset=1.5", "days=NaN"])("rejects invalid filters: %s", async (query) => {
    expect((await GET(new Request(`https://sailorpath.com/api/admin/user-changes?${query}`))).status).toBe(400);
    expect(mocks.where).not.toHaveBeenCalled();
  });

  it("paginates without silently dropping additional entries", async () => {
    mocks.offset.mockResolvedValue(Array.from({ length: 101 }, (_, id) => ({ id })));
    const response = await GET(new Request("https://sailorpath.com/api/admin/user-changes?offset=100"));
    const data = await response.json();
    expect(data.changes).toHaveLength(100);
    expect(data.hasMore).toBe(true);
    expect(mocks.offset).toHaveBeenCalledWith(100);
    expect(response.headers.get("cache-control")).toBe("private, no-store");
  });

  it("filters by user activity, date and literal email substring in SQL", async () => {
    await GET(new Request("https://sailorpath.com/api/admin/user-changes?email=parent%25"));
    const predicate = new PgDialect().sqlToQuery(mocks.where.mock.calls[0][0]);
    const database = new PGlite();
    try {
      await database.exec(`
        CREATE TABLE admin_change_log (id text, action text, actor_email text, created_at timestamptz);
        INSERT INTO admin_change_log VALUES
          ('user', 'user.results.saved', 'parent%@example.com', now()),
          ('profile', 'claimed_profile.updated', 'parent%@example.com', now()),
          ('acceptance', 'role_assignment.accepted', 'parent%@example.com', now()),
          ('admin', 'regatta.update', 'parent%@example.com', now()),
          ('other-user', 'user.results.saved', 'parent-other@example.com', now()),
          ('old', 'user.results.saved', 'parent%@example.com', now() - interval '100 days');
      `);
      const result = await database.query<{ id: string }>(
        `SELECT id FROM admin_change_log WHERE ${predicate.sql} ORDER BY id`, predicate.params
      );
      expect(result.rows.map((row) => row.id)).toEqual(["acceptance", "profile", "user"]);
    } finally { await database.close(); }
  });
});
