import { Suspense, type ReactElement, type ReactNode } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";

const { lookup, auth } = vi.hoisted(() => ({ lookup: vi.fn(), auth: vi.fn() }));
vi.mock("@/lib/queries", () => ({ getCachedSailorByHandle: lookup }));
vi.mock("@/lib/auth", () => ({ getAuthContext: auth }));
vi.mock("@/db", () => ({ DbUnavailableError: class extends Error {} }));
vi.mock("@/components/SailorProfileView", () => ({ SailorProfileView: () => null }));
vi.mock("@/lib/claimAccess", () => ({ canManageSailor: vi.fn() }));
vi.mock("@/lib/followedSailorsQuery", () => ({ getProfileFollowState: vi.fn() }));
vi.mock("next/navigation", () => ({ notFound: () => { throw new Error("NOT_FOUND"); } }));
import SailorProfilePage from "./page";

describe("progressive sailor profile", () => {
  beforeEach(() => { vi.clearAllMocks(); });

  it("shows public identity before authentication or detailed data resolves", async () => {
    lookup.mockResolvedValue({
      id: "s1", name: "Test Sailor", handle: "test-sailor", club: "CSC",
      nationality: "SGP", sailNumber: "123", parentId: "private-owner-id",
      dob: "2012-06-15", weight: 42, equipmentNotes: "private-equipment",
    });
    // If the page accidentally waits for auth again, this promise never resolves.
    auth.mockReturnValue(new Promise(() => {}));
    const page = await SailorProfilePage({ params: Promise.resolve({ sailor_handle: "test-sailor" }) });
    expect(page.type).toBe(Suspense);
    expect(auth).not.toHaveBeenCalled();
    const shell = renderToStaticMarkup((page as ReactElement<{ fallback: ReactNode }>).props.fallback);
    expect(shell).toContain("Test Sailor");
    expect(shell).toContain("CSC");
    expect(shell).toContain("Sail 123");
    expect(shell).toContain("Loading results and rankings");
    expect(shell).not.toContain("private-owner-id");
    expect(shell).not.toContain("2012-06-15");
    expect(shell).not.toContain("private-equipment");
    expect(shell).not.toContain("No results");
  });

  it("keeps unknown handles as not found", async () => {
    lookup.mockResolvedValue(null);
    await expect(SailorProfilePage({ params: Promise.resolve({ sailor_handle: "missing" }) })).rejects.toThrow("NOT_FOUND");
  });
});
