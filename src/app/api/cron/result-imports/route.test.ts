import { afterEach, describe, expect, it, vi } from "vitest";
const run = vi.hoisted(() => vi.fn());
vi.mock("@/lib/resultsWorkflow/storage", () => ({ runResultsScan: run }));
import { GET } from "./route";
afterEach(() => { vi.unstubAllEnvs(); vi.clearAllMocks(); });
describe("scheduled results monitor", () => {
  it("fails closed without the configured scheduler secret", async () => {
    vi.stubEnv("CRON_SECRET", "");
    expect((await GET(new Request("https://sailorpath.com/api/cron/result-imports"))).status).toBe(401);
    expect(run).not.toHaveBeenCalled();
  });
  it("does no work until explicitly enabled", async () => {
    vi.stubEnv("CRON_SECRET", "test-secret"); vi.stubEnv("RESULTS_MONITOR_ENABLED", "false");
    const res = await GET(new Request("https://sailorpath.com/api/cron/result-imports", { headers: { authorization: "Bearer test-secret" } }));
    expect(await res.json()).toMatchObject({ skipped: true });
    expect(run).not.toHaveBeenCalled();
  });
  it("dispatches an authenticated enabled check", async () => {
    vi.stubEnv("CRON_SECRET", "test-secret"); vi.stubEnv("RESULTS_MONITOR_ENABLED", "true");
    run.mockResolvedValue({ outcomes: [{ eventId: "a", report: { status: "needs_review" } }] });
    const res = await GET(new Request("https://sailorpath.com/api/cron/result-imports", { headers: { authorization: "Bearer test-secret" } }));
    expect(await res.json()).toEqual({ checked: [{ eventId: "a", status: "needs_review" }] });
    expect(run).toHaveBeenCalledOnce();
  });
});
