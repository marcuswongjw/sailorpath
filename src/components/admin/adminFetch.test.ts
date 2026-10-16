import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  adminJson,
  fetchAdminSailors,
  fetchAdminRegattas,
  fetchAdminOverview,
} from "./adminFetch";
import { AdminRequestError } from "@/lib/adminRequestPolicy";

describe("adminFetch", () => {
  beforeEach(() => {
    vi.useRealTimers();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("returns parsed json on 200 ok", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: true,
        status: 200,
        json: async () => ({ sailors: [{ id: "s-1", name: "Sailor One" }] }),
      })
    );

    const sailors = await fetchAdminSailors();
    expect(sailors).toEqual([{ id: "s-1", name: "Sailor One" }]);
  });

  it("throws with error message on 400 failure", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: false,
        status: 400,
        json: async () => ({ error: "Bad Request", detail: "Invalid sheet id" }),
      })
    );

    await expect(fetchAdminOverview()).rejects.toThrow("Bad Request: Invalid sheet id");
  });

  it("aborts when caller signal triggers abort", async () => {
    const controller = new AbortController();
    vi.stubGlobal(
      "fetch",
      vi.fn().mockImplementation((_url, init) => {
        return new Promise((_, reject) => {
          init.signal?.addEventListener("abort", () => {
            const err = new Error("Aborted by signal");
            err.name = "AbortError";
            reject(err);
          });
        });
      })
    );

    const promise = fetchAdminRegattas({ signal: controller.signal });
    controller.abort();

    await expect(promise).rejects.toThrow();
  });

  it("times out if request exceeds timeoutMs", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockImplementation((_url, init) => {
        return new Promise((_, reject) => {
          init.signal?.addEventListener("abort", () => {
            reject(init.signal.reason);
          });
        });
      })
    );

    await expect(
      adminJson("/api/admin/slow", { timeoutMs: 50 })
    ).rejects.toThrow(/timed out after 50ms/);
  });

  it("preserves HTTP status for the retry policy", async () => {
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue({
      ok: false, status: 503, json: async () => ({ error: "Please retry later" }),
    }));
    const error = await adminJson("/api/admin/overview").catch((error) => error);
    expect(error).toBeInstanceOf(AdminRequestError);
    expect((error as AdminRequestError).status).toBe(503);
  });

  it("cleans up the caller abort listener after success", async () => {
    const controller = new AbortController();
    const remove = vi.spyOn(controller.signal, "removeEventListener");
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue({ ok: true, json: async () => ({}) }));
    await adminJson("/api/admin/me", { signal: controller.signal });
    expect(remove).toHaveBeenCalledWith("abort", expect.any(Function));
  });
});
