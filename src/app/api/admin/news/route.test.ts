import { describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  inserts: [] as Record<string, unknown>[],
}));

vi.mock("@/lib/auth", () => ({
  requireSuperadmin: async () => ({ userId: "admin-id", email: "admin@example.com" }),
  jsonError: (error: Error) => Response.json({ error: error.message }, { status: 400 }),
}));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn() }));
vi.mock("@/lib/revalidatePublic", () => ({ revalidatePublicNews: vi.fn() }));
vi.mock("@/db", () => ({
  db: {
    insert: () => ({
      values: (values: Record<string, unknown>) => {
        mocks.inserts.push(values);
        return {
          returning: async () => [{
            ...values,
            id: "article-id",
            reviewedBy: null,
            reviewedAt: null,
            publishedAt: null,
            updatedAt: values.updatedAt ?? new Date(),
          }],
        };
      },
    }),
  },
}));

import { POST } from "./route";

describe("POST /api/admin/news", () => {
  it("creates a draft rather than accepting a direct publish request", async () => {
    mocks.inserts.length = 0;
    const response = await POST(
      new Request("https://admin.sailorpath.com/api/admin/news", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          slug: "x15-source-review",
          status: "published",
          kind: "class_announcement",
          title: "X-15 source review",
          summary: "Reviewed calendar information.",
          body: "A draft that must be submitted for review before publication.",
          sourceUrl: "https://x-15class.org/events/",
          sourceLabel: "Official calendar",
        }),
      })
    );

    expect(response.status).toBe(201);
    expect(mocks.inserts).toHaveLength(1);
    expect(mocks.inserts[0]).toMatchObject({ status: "draft", slug: "x15-source-review" });
  });

  it("rejects an unsafe editorial slug before writing", async () => {
    mocks.inserts.length = 0;
    const response = await POST(
      new Request("https://admin.sailorpath.com/api/admin/news", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          slug: "Unsafe slug",
          title: "Title",
          summary: "Summary",
          body: "Body",
        }),
      })
    );

    expect(response.status).toBe(400);
    expect(mocks.inserts).toHaveLength(0);
  });
});
