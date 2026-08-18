/**
 * Client-side claim form helpers (testable without mounting React).
 */

import type { ClaimRelation } from "@/lib/claimRelation";
import { parseClaimRelation } from "@/lib/claimRelation";

export const CLAIM_NOTE_MIN = 8;

export function isClaimNoteReady(note: string): boolean {
  return note.trim().length >= CLAIM_NOTE_MIN;
}

export type ClaimSubmitInput = {
  sailorId: string;
  relation: ClaimRelation | string;
  note: string;
  sessionId?: string;
  vid?: string;
  source?: string;
  device?: string;
};

export type ClaimSubmitBody = {
  sailorId: string;
  relation: ClaimRelation;
  note: string;
  sessionId?: string;
  vid?: string;
  source?: string;
  device?: string;
};

/**
 * Build the JSON body for POST /api/claims.
 * Returns null when the form is not ready to submit.
 */
export function buildClaimSubmitBody(
  input: ClaimSubmitInput
): ClaimSubmitBody | null {
  const relation = parseClaimRelation(input.relation);
  const note = input.note.trim();
  if (!relation || !isClaimNoteReady(note)) return null;
  if (!input.sailorId.trim()) return null;

  const body: ClaimSubmitBody = {
    sailorId: input.sailorId.trim(),
    relation,
    note,
  };
  if (input.sessionId?.trim()) body.sessionId = input.sessionId.trim().slice(0, 64);
  if (input.vid?.trim()) body.vid = input.vid.trim().slice(0, 64);
  if (input.source?.trim()) body.source = input.source.trim().toLowerCase().slice(0, 40);
  if (input.device === "mobile" || input.device === "desktop") {
    body.device = input.device;
  }
  return body;
}

export type ClaimSubmitResult =
  | { ok: true; message: string; status: "pending" }
  | { ok: false; message: string; status: "error" };

/**
 * Happy-path claim submit used by ClaimPanel (and tests with a mocked fetch).
 */
export async function submitClaimRequest(
  input: ClaimSubmitInput,
  fetchImpl: typeof fetch = fetch
): Promise<ClaimSubmitResult> {
  const body = buildClaimSubmitBody(input);
  if (!body) {
    return {
      ok: false,
      status: "error",
      message: `Add a short note (at least ${CLAIM_NOTE_MIN} characters).`,
    };
  }

  try {
    await fetchImpl("/api/auth/ensure-profile", {
      method: "POST",
      credentials: "include",
    });
    const res = await fetchImpl("/api/claims", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify(body),
    });
    const data = (await res.json().catch(() => ({}))) as {
      error?: string;
      message?: string;
    };
    if (!res.ok) {
      return {
        ok: false,
        status: "error",
        message: data.error || "Claim failed",
      };
    }
    return {
      ok: true,
      status: "pending",
      message:
        data.message || "Claim submitted. Please wait for confirmation.",
    };
  } catch (e) {
    return {
      ok: false,
      status: "error",
      message: e instanceof Error ? e.message : "Error",
    };
  }
}
