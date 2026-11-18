import { describe, expect, it } from "vitest";
import { POST } from "@/app/api/usage/route";
import { extractRefFromUrl } from "@/lib/clientUsage";
import { sanitizeUsageMeta, USAGE_EVENT_TYPES } from "@/lib/usage";

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

  it("keeps ref and supports funnel event types", () => {
    expect(sanitizeUsageMeta({ ref: "pattaya-2026" })).toEqual({
      ref: "pattaya-2026",
    });
    expect(USAGE_EVENT_TYPES).toContain("claim_cta_click");
    expect(USAGE_EVENT_TYPES).toContain("claim_form_open");
    expect(USAGE_EVENT_TYPES).toContain("login_start");
    expect(extractRefFromUrl("/sailors/alex?claim=1&ref=pattaya-2026")).toBe(
      "pattaya-2026"
    );
    expect(extractRefFromUrl("/sailors/alex")).toBeNull();
  });
});
