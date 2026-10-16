/** @vitest-environment jsdom */
import { beforeEach, describe, expect, it, vi } from "vitest";
import { act, renderHook, waitFor } from "@testing-library/react";
import { useAdminAuth } from "./useAdminAuth";
import { createBrowserSupabase } from "@/lib/supabase/browser";

vi.mock("@/lib/supabase/browser", () => ({
  createBrowserSupabase: vi.fn(),
}));

describe("useAdminAuth", () => {
  let mockGetSession: ReturnType<typeof vi.fn>;
  let mockOnAuthStateChange: ReturnType<typeof vi.fn>;
  let mockUnsubscribe: ReturnType<typeof vi.fn>;

  beforeEach(() => {
    vi.clearAllMocks();
    mockUnsubscribe = vi.fn();
    mockGetSession = vi.fn().mockResolvedValue({
      data: {
        session: {
          user: { id: "admin-1", email: "admin@sailorpath.com" },
        },
      },
    });
    mockOnAuthStateChange = vi.fn().mockReturnValue({
      data: { subscription: { unsubscribe: mockUnsubscribe } },
    });

    vi.mocked(createBrowserSupabase).mockReturnValue({
      auth: {
        getSession: mockGetSession,
        onAuthStateChange: mockOnAuthStateChange,
      },
    } as unknown as ReturnType<typeof createBrowserSupabase>);
  });

  it("seeds immediate superadmin state from initialAuth without loading spinner", () => {
    global.fetch = vi.fn().mockImplementation(
      () =>
        new Promise(() => {
          /* intentionally unresolved */
        })
    );

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    expect(result.current.loading).toBe(false);
    expect(result.current.isSuperadmin).toBe(true);
    expect(result.current.adminRole).toBe("superadmin");
    expect(result.current.user).toEqual({
      id: "admin-1",
      email: "admin@sailorpath.com",
    });
    expect(result.current.authUnavailable).toBe(false);
  });

  it("updates role and user when /api/admin/me responds with 200 OK", async () => {
    global.fetch = vi.fn().mockResolvedValue({
      ok: true,
      status: 200,
      json: async () => ({
        user: { id: "admin-1", email: "admin@sailorpath.com" },
        role: "superadmin",
        lastSeenProductChangelogAt: "2026-10-15T12:00:00Z",
      }),
    });

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    await waitFor(() => {
      expect(result.current.isRevalidating).toBe(false);
    });

    expect(result.current.isSuperadmin).toBe(true);
    expect(result.current.adminRole).toBe("superadmin");
    expect(result.current.authUnavailable).toBe(false);
    expect(result.current.lastSeenProductChangelogAt).toBe(
      "2026-10-15T12:00:00Z"
    );
  });

  it("does NOT downgrade verified superadmin to sailor on 503 DB unavailable response", async () => {
    global.fetch = vi.fn().mockResolvedValue({
      ok: false,
      status: 503,
      json: async () => ({
        error: "Database temporarily unavailable",
        code: "DB_UNAVAILABLE",
      }),
    });

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    await waitFor(() => {
      expect(result.current.authUnavailable).toBe(true);
    });

    // Finding 2 fix: Role MUST NOT be downgraded to sailor during transient outages
    expect(result.current.isSuperadmin).toBe(true);
    expect(result.current.adminRole).toBe("superadmin");
    expect(result.current.user).toEqual({
      id: "admin-1",
      email: "admin@sailorpath.com",
    });
    expect(result.current.authUnavailable).toBe(true);
    expect(result.current.authError).toContain("Database temporarily unavailable");
  });

  it("does NOT downgrade verified superadmin to sailor on network failure", async () => {
    global.fetch = vi.fn().mockRejectedValue(new Error("Failed to fetch"));

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    await waitFor(() => {
      expect(result.current.authUnavailable).toBe(true);
    });

    expect(result.current.isSuperadmin).toBe(true);
    expect(result.current.adminRole).toBe("superadmin");
    expect(result.current.authUnavailable).toBe(true);
    expect(result.current.authError).toBe("Failed to fetch");
  });

  it("downgrades to sailor and clears user on verified 401 Unauthorized", async () => {
    global.fetch = vi.fn().mockResolvedValue({
      ok: false,
      status: 401,
      json: async () => ({ error: "Unauthorized" }),
    });

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    await waitFor(() => {
      expect(result.current.adminRole).toBe("sailor");
    });

    expect(result.current.isSuperadmin).toBe(false);
    expect(result.current.user).toBeNull();
    expect(result.current.authUnavailable).toBe(false);
  });

  it("downgrades to sailor on verified 403 Forbidden without setting authUnavailable", async () => {
    global.fetch = vi.fn().mockResolvedValue({
      ok: false,
      status: 403,
      json: async () => ({ error: "Forbidden" }),
    });

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    await waitFor(() => {
      expect(result.current.adminRole).toBe("sailor");
    });

    expect(result.current.isSuperadmin).toBe(false);
    expect(result.current.authUnavailable).toBe(false);
    expect(result.current.authError).toBe("Admin access required");
  });

  it("coalesces concurrent loadRole requests into a single in-flight fetch", async () => {
    let fetchCount = 0;
    global.fetch = vi.fn().mockImplementation(async () => {
      fetchCount++;
      await new Promise((resolve) => setTimeout(resolve, 50));
      return {
        ok: true,
        status: 200,
        json: async () => ({
          user: { id: "admin-1", email: "admin@sailorpath.com" },
          role: "superadmin",
        }),
      };
    });

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    // Call refreshAuth multiple times concurrently
    await act(async () => {
      await Promise.all([
        result.current.refreshAuth(),
        result.current.refreshAuth(),
        result.current.refreshAuth(),
      ]);
    });

    expect(fetchCount).toBe(1);
  });

  it("recovers authUnavailable state when refreshAuth succeeds after transient failure", async () => {
    let callCount = 0;
    global.fetch = vi.fn().mockImplementation(async () => {
      callCount++;
      if (callCount === 1) {
        return {
          ok: false,
          status: 503,
          json: async () => ({ error: "Unavailable" }),
        };
      }
      return {
        ok: true,
        status: 200,
        json: async () => ({
          user: { id: "admin-1", email: "admin@sailorpath.com" },
          role: "superadmin",
        }),
      };
    });

    const { result } = renderHook(() =>
      useAdminAuth({
        id: "admin-1",
        email: "admin@sailorpath.com",
        role: "superadmin",
      })
    );

    await waitFor(() => {
      expect(result.current.authUnavailable).toBe(true);
    });
    expect(result.current.isSuperadmin).toBe(true);

    // Retry after service recovers
    await act(async () => {
      await result.current.refreshAuth();
    });

    expect(result.current.authUnavailable).toBe(false);
    expect(result.current.isSuperadmin).toBe(true);
  });
});
