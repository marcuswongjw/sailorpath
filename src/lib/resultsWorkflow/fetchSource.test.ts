import { EventEmitter } from "node:events";
import { afterEach, describe, expect, it, vi } from "vitest";
const state = vi.hoisted(() => ({ lookup: vi.fn(), request: vi.fn() }));
vi.mock("node:dns/promises", () => ({ lookup: state.lookup }));
vi.mock("node:https", () => ({ request: state.request }));
import { fetchResultsSource } from "./fetchSource";
afterEach(() => { vi.clearAllMocks(); });

function response(statusCode: number, headers: Record<string, string>, body = "") {
  state.request.mockImplementationOnce((_url, _options, callback) => {
    const req = Object.assign(new EventEmitter(), { destroy: vi.fn(), end() {
      queueMicrotask(() => {
        const res = Object.assign(new EventEmitter(), { statusCode, headers, resume: vi.fn(), destroy: vi.fn() });
        callback(res);
        res.emit("data", Buffer.from(body)); res.emit("end"); req.emit("close");
      });
    } });
    return req;
  });
}

describe("bounded source download", () => {
  it("pins the verified public address into the HTTPS connection", async () => {
    state.lookup.mockResolvedValue([{ address: "8.8.8.8", family: 4 }]);
    response(200, { "content-type": "text/html" }, "<h1>Results</h1>");
    expect((await fetchResultsSource("https://club.example/")).body).toContain("Results");
    const options = state.request.mock.calls[0][1];
    const callback = vi.fn(); options.lookup("club.example", {}, callback);
    expect(callback).toHaveBeenCalledWith(null, "8.8.8.8", 4);
  });
  it("revalidates redirected destinations and refuses internal addresses", async () => {
    state.lookup.mockResolvedValueOnce([{ address: "8.8.8.8", family: 4 }]).mockResolvedValueOnce([{ address: "169.254.169.254", family: 4 }]);
    response(302, { location: "https://internal.example/metadata" });
    await expect(fetchResultsSource("https://club.example/")).rejects.toThrow("public address");
    expect(state.request).toHaveBeenCalledTimes(1);
  });
  it("downloads PDF bytes only when requested for the authenticated reader", async () => {
    state.lookup.mockResolvedValue([{ address: "8.8.8.8", family: 4 }]);
    response(200, { "content-type": "application/pdf" }, "%PDF-example");
    const source = await fetchResultsSource("https://club.example/final.pdf", 0, true);
    expect(source.kind).toBe("pdf");
    expect(Buffer.from(source.body, "base64").toString()).toBe("%PDF-example");
  });
});
