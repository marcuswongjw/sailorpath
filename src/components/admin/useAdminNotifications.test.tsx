// @vitest-environment jsdom
import { renderHook, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { afterEach, describe, expect, it, vi } from "vitest";
import { useAdminNotifications } from "./useAdminNotifications";

afterEach(() => {
  vi.unstubAllGlobals();
});
describe("Inbox source status", () => {
  it("preserves known requests and marks failed sources unavailable", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(async (url: string) => {
        if (url.includes("regatta-suggestions"))
          return {
            ok: false,
            status: 503,
            json: async () => ({ error: "Unavailable" }),
          };
        return {
          ok: true,
          json: async () =>
            url.includes("claims")
              ? { claims: [{ status: "pending", createdAt: "2026-10-01" }] }
              : url.includes("coach-access")
                ? { requests: [], coaches: [] }
                : { messages: [] },
        };
      }),
    );
    const client = new QueryClient({
      defaultOptions: { queries: { retry: false, gcTime: 0 } },
    });
    const { result } = renderHook(() => useAdminNotifications(true), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={client}>{children}</QueryClientProvider>
      ),
    });
    await waitFor(() =>
      expect(result.current.inboxQueueStates.suggestions.status).toBe(
        "unavailable",
      ),
    );
    expect(result.current.inboxQueueStates.claims.status).toBe("ready");
    expect(result.current.inboxNotifCount).toBe(1);
    expect(result.current.inboxLandingView).toBe("claims");
  });

  it("does not mark loading queues as ready with zero work", () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() => new Promise(() => {})),
    );
    const client = new QueryClient({
      defaultOptions: { queries: { retry: false, gcTime: 0 } },
    });
    const { result } = renderHook(() => useAdminNotifications(true), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={client}>{children}</QueryClientProvider>
      ),
    });
    expect(
      Object.values(result.current.inboxQueueStates).every(
        (source) => source.status === "loading",
      ),
    ).toBe(true);
  });
});
