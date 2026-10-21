import { afterEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ auth: vi.fn(), fetch: vi.fn() }));
vi.mock("@/lib/auth", () => ({ requireSuperadmin: mocks.auth, jsonError: (e: Error & { status?: number }) => Response.json({ error: e.message }, { status: e.status || 500 }) }));
vi.mock("@/lib/resultsWorkflow/fetchSource", async (original) => ({ ...await original<object>(), fetchResultsSource: mocks.fetch }));
import { POST } from "./route";
afterEach(() => { vi.resetAllMocks(); });
const request = (url: string) => new Request("https://admin.sailorpath.com/api/admin/event-url", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ url }) });
describe("event URL extraction endpoint", () => {
  it("requires admin access before fetching a page", async () => {
    mocks.auth.mockRejectedValue(Object.assign(new Error("Unauthorized"), { status: 401 }));
    expect((await POST(request("https://club.example"))).status).toBe(401);
    expect(mocks.fetch).not.toHaveBeenCalled();
  });
  it("rejects non-HTTPS sources", async () => {
    mocks.auth.mockResolvedValue({});
    expect((await POST(request("http://localhost"))).status).toBe(400);
    expect(mocks.fetch).not.toHaveBeenCalled();
  });
  it("returns extracted metadata for review without database writes", async () => {
    mocks.auth.mockResolvedValue({});
    mocks.fetch.mockResolvedValue({ url: "https://club.example/event", kind: "html", body: '<h1>Optimist Cup</h1><p>23–25 October 2026</p>' });
    const response = await POST(request("https://club.example/event"));
    expect(response.status).toBe(200);
    expect(await response.json()).toMatchObject({ draft: { name: "Optimist Cup", startDate: "2026-10-23" } });
  });
});
