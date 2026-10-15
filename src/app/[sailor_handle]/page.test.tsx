import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ lookup: vi.fn(), redirect: vi.fn() }));
vi.mock("@/lib/queries", () => ({ getCachedSailorByHandle: mocks.lookup }));
vi.mock("@/db", () => ({ DbUnavailableError: class extends Error {} }));
vi.mock("next/navigation", () => ({
  notFound: () => { throw new Error("NOT_FOUND"); },
  permanentRedirect: mocks.redirect,
}));

import LegacySailorHandlePage from "./page";

describe("legacy root sailor handles", () => {
  beforeEach(() => vi.clearAllMocks());

  it("redirects a verified handle to the canonical public profile", async () => {
    mocks.lookup.mockResolvedValue({ handle: "test-sailor" });
    await LegacySailorHandlePage({ params: Promise.resolve({ sailor_handle: "test-sailor" }) });
    expect(mocks.redirect).toHaveBeenCalledWith("/sailors/test-sailor");
  });

  it("returns not found for an unknown root slug", async () => {
    mocks.lookup.mockResolvedValue(null);
    await expect(LegacySailorHandlePage({ params: Promise.resolve({ sailor_handle: "not-a-sailor" }) })).rejects.toThrow("NOT_FOUND");
    expect(mocks.redirect).not.toHaveBeenCalled();
  });
});
