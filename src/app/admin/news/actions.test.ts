import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  select: vi.fn(), insert: vi.fn(), update: vi.fn(),
  auth: vi.fn(), revalidate: vi.fn(),
}));
vi.mock("next/navigation", () => ({
  redirect: (url: string) => { throw new Error(`REDIRECT:${url}`); },
}));
vi.mock("@/lib/auth", () => ({ requireSuperadmin: mocks.auth }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn() }));
vi.mock("@/lib/revalidatePublic", () => ({ revalidatePublicNews: mocks.revalidate }));
vi.mock("@/db", () => ({
  withDatabaseRetry: (run: () => unknown) => run(),
  db: {
    select: () => ({ from: () => ({ where: () => ({ limit: mocks.select }) }) }),
    insert: () => ({ values: (values: unknown) => ({ returning: () => mocks.insert(values) }) }),
    update: () => ({ set: (values: unknown) => ({ where: () => ({ returning: () => mocks.update(values) }) }) }),
  },
}));

import { createEditorialDraft, updateEditorialArticle } from "./actions";

const existing = { id: "article-id", slug: "article", title: "Article", status: "draft", publishedAt: null };
function form(overrides: Record<string, string> = {}) {
  const data = new FormData();
  for (const [key, value] of Object.entries({
    id: existing.id, slug: existing.slug, title: existing.title,
    summary: "Summary", body: "Body", action: "save_draft", ...overrides,
  })) data.set(key, value);
  return data;
}
async function destination(action: () => Promise<unknown>) {
  try { await action(); } catch (error) {
    if (error instanceof Error && error.message.startsWith("REDIRECT:")) {
      return new URL(error.message.slice("REDIRECT:".length), "https://admin.sailorpath.com");
    }
    throw error;
  }
  throw new Error("Expected redirect");
}

beforeEach(() => {
  vi.resetAllMocks();
  mocks.auth.mockResolvedValue({ userId: "admin-id", email: "admin@example.com" });
  mocks.select.mockResolvedValue([existing]);
  mocks.insert.mockImplementation(async (values) => [{ ...existing, ...values }]);
  mocks.update.mockImplementation(async (values) => [{ ...existing, ...values }]);
});

describe.each([
  ["create", createEditorialDraft, "new"],
  ["update", updateEditorialArticle, existing.id],
] as const)("%s editorial action", (_name, action, selectedId) => {
  it.each([
    [{ slug: "Invalid slug" }, "slug"],
    [{ sourceLabel: "Missing URL" }, "source label"],
  ] as const)("redirects validation errors back to the editor (%j)", async (fields, message) => {
    const url = await destination(() => action(form(fields)));
    expect(url.searchParams.get("article")).toBe(selectedId);
    expect(url.searchParams.get("error")).toContain(message);
    expect(mocks.insert).not.toHaveBeenCalled();
    expect(mocks.update).not.toHaveBeenCalled();
  });

  it("redirects duplicate slug failures instead of throwing into the page boundary", async () => {
    mocks.insert.mockRejectedValue(new Error("duplicate slug"));
    mocks.update.mockRejectedValue(new Error("duplicate slug"));
    const url = await destination(() => action(form()));
    expect(url.searchParams.get("article")).toBe(selectedId);
    expect(url.searchParams.get("error")).toContain("duplicate slug");
    expect(url.searchParams.has("saved")).toBe(false);
  });

  it.each([true, false])("publishes with a reviewer only if a profile exists (%s)", async (hasProfile) => {
    const profile = hasProfile ? [{ id: "admin-id" }] : [];
    if (selectedId === "new") mocks.select.mockResolvedValueOnce(profile);
    else mocks.select.mockResolvedValueOnce([existing]).mockResolvedValueOnce(profile);
    const url = await destination(() => action(form({ action: "publish" })));
    const mutation = selectedId === "new" ? mocks.insert : mocks.update;
    expect(mutation).toHaveBeenCalledWith(expect.objectContaining({
      status: "published", reviewedBy: hasProfile ? "admin-id" : null,
      reviewedAt: expect.any(Date), publishedAt: expect.any(Date),
    }));
    expect(url.searchParams.get("saved")).toContain("published");
    expect(url.searchParams.has("error")).toBe(false);
    expect(mocks.revalidate).toHaveBeenCalledWith(existing.slug);
  });
});

it("unpublishes an article, clears publication metadata and invalidates its public cache", async () => {
  mocks.select.mockResolvedValue([{ ...existing, status: "published", publishedAt: new Date() }]);
  const url = await destination(() => updateEditorialArticle(form()));
  expect(mocks.update).toHaveBeenCalledWith(expect.objectContaining({
    status: "draft", reviewedBy: null, reviewedAt: null, publishedAt: null,
  }));
  expect(url.searchParams.get("saved")).toBe("Saved as draft.");
  expect(mocks.revalidate).toHaveBeenCalledWith(existing.slug);
});

it("keeps authentication failures outside mutation error handling", async () => {
  mocks.auth.mockRejectedValue(new Error("Unauthorized"));
  await expect(createEditorialDraft(form())).rejects.toThrow("Unauthorized");
  await expect(updateEditorialArticle(form())).rejects.toThrow("Unauthorized");
  expect(mocks.insert).not.toHaveBeenCalled();
  expect(mocks.update).not.toHaveBeenCalled();
});
