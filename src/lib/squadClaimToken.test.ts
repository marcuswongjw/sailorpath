import { describe, expect, it } from "vitest";
import { createSquadClaimToken, verifySquadClaimToken } from "./squadClaimToken";

describe("squadClaimToken", () => {
  it("creates and verifies a valid squad claim token", () => {
    const id = "11111111-2222-3333-4444-555555555555";
    const token = createSquadClaimToken(id);
    expect(verifySquadClaimToken(token)).toBe(id);
  });

  it("rejects tampered or malformed tokens", () => {
    const id = "11111111-2222-3333-4444-555555555555";
    const token = createSquadClaimToken(id);
    expect(verifySquadClaimToken(`${token}x`)).toBeNull();
    expect(verifySquadClaimToken("not-a-token")).toBeNull();
    expect(verifySquadClaimToken("")).toBeNull();
  });
});
