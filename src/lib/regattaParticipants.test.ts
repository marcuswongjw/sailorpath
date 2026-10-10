import { describe, expect, it } from "vitest";
import {
  crewRuleFromRegatta,
  normalizeResultParticipants,
  validateParticipantCount,
} from "./regattaParticipants";

describe("regatta result participants", () => {
  it("converts a legacy sailorId into a solo entry", () => {
    const result = normalizeResultParticipants(undefined, "sailor-1");
    expect(result).toEqual({
      ok: true,
      participants: [
        {
          sailorId: "sailor-1",
          sourceName: null,
          role: "solo",
          displayOrder: 1,
          rankingCredit: false,
        },
      ],
    });
  });

  it("keeps crew names separate and ordered", () => {
    const result = normalizeResultParticipants([
      { sailorId: "crew", role: "crew", displayOrder: 2, sourceName: "Amos Tham" },
      { sailorId: "helm", role: "helm", displayOrder: 1, sourceName: "Seth Low" },
    ]);
    expect(result).toMatchObject({ ok: true });
    if (!result.ok) return;
    expect(result.participants.map((member) => member.sailorId)).toEqual([
      "helm",
      "crew",
    ]);
  });

  it("rejects duplicate participant identities", () => {
    expect(
      normalizeResultParticipants([
        { sailorId: "same" },
        { sailorId: "same" },
      ])
    ).toEqual({ ok: false, error: "A sailor can only appear once in a result entry" });
  });

  it("enforces a two-person 29er crew", () => {
    const rule = crewRuleFromRegatta({
      entryType: "crew",
      minParticipants: 2,
      maxParticipants: 2,
    });
    const one = normalizeResultParticipants([{ sailorId: "sailor-1" }]);
    if (!one.ok) throw new Error(one.error);
    expect(validateParticipantCount(rule, one.participants)).toBe(
      "Crew entries need 2 participants"
    );
  });
});
