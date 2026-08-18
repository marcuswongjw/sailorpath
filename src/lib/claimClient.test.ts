import { describe, expect, it, vi } from "vitest";
import {
  buildClaimSubmitBody,
  CLAIM_NOTE_MIN,
  isClaimNoteReady,
  submitClaimRequest,
} from "./claimClient";

describe("claim client helpers", () => {
  it("requires a minimum note length", () => {
    expect(isClaimNoteReady("short")).toBe(false);
    expect(isClaimNoteReady("a".repeat(CLAIM_NOTE_MIN))).toBe(true);
    expect(isClaimNoteReady("  enough text here  ")).toBe(true);
  });

  it("builds a valid claim body for the happy path", () => {
    const body = buildClaimSubmitBody({
      sailorId: "  sailor-1  ",
      relation: "parent",
      note: "  Parent of Test Sailor  ",
      sessionId: "sess-1",
      vid: "vid-1",
      source: "Google",
      device: "mobile",
    });
    expect(body).toEqual({
      sailorId: "sailor-1",
      relation: "parent",
      note: "Parent of Test Sailor",
      sessionId: "sess-1",
      vid: "vid-1",
      source: "google",
      device: "mobile",
    });
  });

  it("rejects incomplete forms", () => {
    expect(
      buildClaimSubmitBody({
        sailorId: "",
        relation: "parent",
        note: "long enough note",
      })
    ).toBeNull();
    expect(
      buildClaimSubmitBody({
        sailorId: "s1",
        relation: "coach",
        note: "long enough note",
      })
    ).toBeNull();
    expect(
      buildClaimSubmitBody({
        sailorId: "s1",
        relation: "parent",
        note: "short",
      })
    ).toBeNull();
  });

  it("submitClaimRequest posts ensure-profile then claims on success", async () => {
    const fetchImpl = vi.fn(async (input: RequestInfo | URL) => {
      const url = String(input);
      if (url.includes("ensure-profile")) {
        return new Response("{}", { status: 200 });
      }
      return new Response(
        JSON.stringify({
          ok: true,
          message: "Claim submitted for Test.",
        }),
        { status: 200 }
      );
    });

    const result = await submitClaimRequest(
      {
        sailorId: "s1",
        relation: "parent",
        note: "Parent of Test Sailor",
      },
      fetchImpl as unknown as typeof fetch
    );

    expect(result).toEqual({
      ok: true,
      status: "pending",
      message: "Claim submitted for Test.",
    });
    expect(fetchImpl).toHaveBeenCalledTimes(2);
    expect(String(fetchImpl.mock.calls[0][0])).toContain("/api/auth/ensure-profile");
    expect(String(fetchImpl.mock.calls[1][0])).toContain("/api/claims");
  });

  it("surfaces API errors from submitClaimRequest", async () => {
    const fetchImpl = vi.fn(async (input: RequestInfo | URL) => {
      const url = String(input);
      if (url.includes("ensure-profile")) {
        return new Response("{}", { status: 200 });
      }
      return new Response(JSON.stringify({ error: "Already claimed" }), {
        status: 400,
      });
    });

    const result = await submitClaimRequest(
      {
        sailorId: "s1",
        relation: "parent",
        note: "Parent of Test Sailor",
      },
      fetchImpl as unknown as typeof fetch
    );
    expect(result).toEqual({
      ok: false,
      status: "error",
      message: "Already claimed",
    });
  });
});
