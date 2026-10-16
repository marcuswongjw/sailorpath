import { afterEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ getUser: vi.fn(), select: vi.fn() }));
vi.mock("@/lib/supabase/server", () => ({
  createServerSupabase: async () => ({ auth: { getUser: mocks.getUser } }),
}));
vi.mock("@/db", async (importOriginal) => ({
  ...await importOriginal<typeof import("@/db")>(),
  db: { select: mocks.select },
}));
import { AUTH_CONTEXT_TIMEOUT_MS, getAuthContext } from "./auth";

afterEach(() => { vi.useRealTimers(); vi.clearAllMocks(); });

describe("authorization deadline", () => {
  it("bounds provider retries and fails closed instead of assigning a role", async () => {
    vi.useFakeTimers();
    mocks.getUser.mockImplementation(() => new Promise(() => undefined));
    const result = getAuthContext().catch((error: Error) => error);
    await vi.advanceTimersByTimeAsync(AUTH_CONTEXT_TIMEOUT_MS);
    expect(await result).toMatchObject({ status: 503 });
    expect(mocks.select).not.toHaveBeenCalled();
    await vi.advanceTimersByTimeAsync(5_000);
  });
  it("retains a database-verified superadmin role", async () => {
    mocks.getUser.mockResolvedValue({ data: { user: { id: "admin-1", email: "admin@example.com" } } });
    mocks.select.mockReturnValue({ from: () => ({ where: () => ({ limit: async () => [{ role: "superadmin", lastSeenProductChangelogAt: null }] }) }) });
    await expect(getAuthContext()).resolves.toMatchObject({ userId: "admin-1", role: "superadmin" });
  });
});
