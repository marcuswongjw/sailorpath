import { describe, expect, it } from "vitest";
import { POST } from "@/app/api/usage/route";
import { sanitizeUsageMeta } from "@/lib/usage";

describe("POST /api/usage", () => {
  it("rejects custom event names before any analytics write", async () => {
    const response = await POST(
      new Request("https://sailorpath.com/api/usage", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ eventType: "invented_event" }),
      })
    );

    expect(response.status).toBe(400);
    await expect(response.json()).resolves.toEqual({
      error: "Unsupported eventType",
    });
  });

  it("rejects oversized analytics payloads", async () => {
    const response = await POST(
      new Request("https://sailorpath.com/api/usage", {
        method: "POST",
        headers: {
          "content-type": "application/json",
          "content-length": "4097",
        },
        body: JSON.stringify({ eventType: "page_view" }),
      })
    );

    expect(response.status).toBe(413);
  });
});

describe("sanitizeUsageMeta", () => {
  it("keeps allowlisted keys and drops PII-like extras", () => {
    expect(
      sanitizeUsageMeta({
        vid: "abc",
        source: "google",
        device: "mobile",
        email: "leak@example.com",
        name: "Secret Sailor",
        note: "private",
        fleet: "gold",
        year: 2026,
      })
    ).toEqual({
      vid: "abc",
      source: "google",
      device: "mobile",
      fleet: "gold",
      year: 2026,
    });
  });

  it("returns null for empty / non-objects", () => {
    expect(sanitizeUsageMeta(null)).toBeNull();
    expect(sanitizeUsageMeta({ email: "x" })).toBeNull();
  });
});
