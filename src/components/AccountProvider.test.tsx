/** @vitest-environment jsdom */
import { beforeEach, describe, expect, it, vi } from "vitest";
import { act, render, screen, waitFor } from "@testing-library/react";
import { AccountProvider, useAccount } from "./AccountProvider";
import { createBrowserSupabase } from "@/lib/supabase/browser";

vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), refresh: vi.fn() }),
}));

vi.mock("@/lib/supabase/browser", () => ({
  createBrowserSupabase: vi.fn(),
}));

function Consumer() {
  const { role, isSuperadmin, ready } = useAccount();
  return (
    <div>
      <div data-testid="ready">{ready ? "yes" : "no"}</div>
      <div data-testid="role">{role ?? "none"}</div>
      <div data-testid="superadmin">{isSuperadmin ? "true" : "false"}</div>
    </div>
  );
}

describe("AccountProvider", () => {
  let authCallback: ((event: string, session: unknown) => void) | undefined;

  beforeEach(() => {
    vi.clearAllMocks();
    document.cookie = "sb-auth-token=test-session; path=/";

    vi.mocked(createBrowserSupabase).mockReturnValue({
      auth: {
        getSession: vi.fn().mockResolvedValue({
          data: {
            session: { user: { email: "admin@sailorpath.com" } },
          },
        }),
        onAuthStateChange: vi.fn().mockImplementation((cb) => {
          authCallback = cb;
          return { data: { subscription: { unsubscribe: vi.fn() } } };
        }),
      },
    } as unknown as ReturnType<typeof createBrowserSupabase>);
  });

  it("loads superadmin role on 200 OK from /api/account", async () => {
    global.fetch = vi.fn().mockResolvedValue({
      ok: true,
      status: 200,
      json: async () => ({
        role: "superadmin",
        isSuperadmin: true,
        email: "admin@sailorpath.com",
        owned: [],
      }),
    });

    render(
      <AccountProvider>
        <Consumer />
      </AccountProvider>
    );

    await waitFor(() => {
      expect(screen.getByTestId("ready").textContent).toBe("yes");
      expect(screen.getByTestId("role").textContent).toBe("superadmin");
      expect(screen.getByTestId("superadmin").textContent).toBe("true");
    });
  });

  it("preserves superadmin role when revalidation encounters a 503 database unavailable error", async () => {
    let callCount = 0;
    global.fetch = vi.fn().mockImplementation(async () => {
      callCount++;
      if (callCount === 1) {
        return {
          ok: true,
          status: 200,
          json: async () => ({
            role: "superadmin",
            isSuperadmin: true,
            email: "admin@sailorpath.com",
            owned: [],
          }),
        };
      }
      return {
        ok: false,
        status: 503,
        json: async () => ({ error: "Unavailable" }),
      };
    });

    render(
      <AccountProvider>
        <Consumer />
      </AccountProvider>
    );

    await waitFor(() => {
      expect(screen.getByTestId("role").textContent).toBe("superadmin");
    });

    // Simulate auth state change event triggering revalidation during a 503 outage
    await act(async () => {
      authCallback?.("USER_UPDATED", {
        user: { email: "admin@sailorpath.com" },
      });
    });

    // Role MUST NOT be wiped to null / false on transient 503
    expect(screen.getByTestId("role").textContent).toBe("superadmin");
    expect(screen.getByTestId("superadmin").textContent).toBe("true");
  });

  it("clears role when /api/account explicitly responds with 401 Unauthorized", async () => {
    let callCount = 0;
    global.fetch = vi.fn().mockImplementation(async () => {
      callCount++;
      if (callCount === 1) {
        return {
          ok: true,
          status: 200,
          json: async () => ({
            role: "superadmin",
            isSuperadmin: true,
            email: "admin@sailorpath.com",
            owned: [],
          }),
        };
      }
      return {
        ok: false,
        status: 401,
        json: async () => ({ error: "Unauthorized" }),
      };
    });

    render(
      <AccountProvider>
        <Consumer />
      </AccountProvider>
    );

    await waitFor(() => {
      expect(screen.getByTestId("role").textContent).toBe("superadmin");
    });

    await act(async () => {
      authCallback?.("TOKEN_REFRESHED", {
        user: { email: "admin@sailorpath.com" },
      });
    });

    // Confirmed 401 clears the role
    expect(screen.getByTestId("role").textContent).toBe("none");
    expect(screen.getByTestId("superadmin").textContent).toBe("false");
  });
});
