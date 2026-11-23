import { describe, expect, it } from "vitest";
import {
  ILCA4_2027_SELECTION_POLICY,
  ILCA6_2027_SELECTION_POLICY,
  OPTIMIST_2027_SELECTION_POLICY,
  SELECTION_POLICIES_2027,
} from "./selectionPolicies2027";
import {
  isKnownSelectionEventId,
  selectionEventsForBoatClass,
} from "./selectionEventCatalog";

describe("2027 SSF selection policies", () => {
  it("contains all 15 campaigns across Optimist (6), ILCA 4 (4), and ILCA 6 (5)", () => {
    expect(OPTIMIST_2027_SELECTION_POLICY.campaigns).toHaveLength(6);
    expect(ILCA4_2027_SELECTION_POLICY.campaigns).toHaveLength(4);
    expect(ILCA6_2027_SELECTION_POLICY.campaigns).toHaveLength(5);

    const total = Object.values(SELECTION_POLICIES_2027).reduce(
      (sum, policy) => sum + policy.campaigns.length,
      0
    );
    expect(total).toBe(15);
  });

  it("references only valid selectionEventId values registered in selectionEventCatalog", () => {
    for (const policy of Object.values(SELECTION_POLICIES_2027)) {
      for (const item of policy.keyTrialSchedule) {
        if (item.selectionEventId) {
          expect(isKnownSelectionEventId(item.selectionEventId)).toBe(true);
        }
      }
      for (const campaign of policy.campaigns) {
        for (const pathway of campaign.pathways) {
          for (const ev of pathway.events) {
            if (ev.selectionEventId) {
              expect(isKnownSelectionEventId(ev.selectionEventId)).toBe(true);
            }
          }
        }
      }
    }
  });

  it("exposes class-specific selection event options in selectionEventsForBoatClass", () => {
    const ilca6 = selectionEventsForBoatClass("ILCA 6");
    expect(ilca6.map((e) => e.id)).toEqual([
      "ilca6-safyc-2027",
      "ilca6-csc-2027",
      "ilca6-pulau-ujong-2027",
      "ilca6-sysc-2027",
      "ilca6-kieler-woche-2027",
      "ilca6-pesta-2027",
      "ilca6-snsc-2027",
    ]);

    const ilca4 = selectionEventsForBoatClass("ILCA 4");
    expect(ilca4.some((e) => e.id === "ilca4-pesta-2026")).toBe(true);
    expect(ilca4.some((e) => e.id === "ilca4-safyc-2027")).toBe(true);
    expect(ilca4.some((e) => e.id === "ilca4-langkawi-2027")).toBe(true);

    const opti = selectionEventsForBoatClass("Optimist");
    expect(opti.some((e) => e.id === "ssf-trials-2026")).toBe(true);
    expect(opti.some((e) => e.id === "opti-csc-2027")).toBe(true);
    expect(opti.some((e) => e.id === "opti-bodrum-2027")).toBe(true);

    expect(selectionEventsForBoatClass("ILCA 7")).toEqual([]);
  });

  it("captures critical split dates, Part A/B rules, ranking floors, and cutoffs accurately", () => {
    // 23rd SAFYC split weekends
    const ilca4Safyc = ILCA4_2027_SELECTION_POLICY.keyTrialSchedule.find(
      (i) => i.selectionEventId === "ilca4-safyc-2027"
    );
    const ilca6Safyc = ILCA6_2027_SELECTION_POLICY.keyTrialSchedule.find(
      (i) => i.selectionEventId === "ilca6-safyc-2027"
    );
    const optiSafyc = OPTIMIST_2027_SELECTION_POLICY.keyTrialSchedule.find(
      (i) => i.selectionEventId === "opti-safyc-2027"
    );
    expect(ilca4Safyc?.dates).toBe("30–31 January 2027");
    expect(ilca6Safyc?.dates).toBe("30–31 January 2027");
    expect(optiSafyc?.dates).toBe("13–14 February 2027");

    // ILCA 4 Youth Worlds Part A / Part B, top 15 floor, 30 Mar fallback
    const ilca4Worlds = ILCA4_2027_SELECTION_POLICY.campaigns.find(
      (c) => c.id === "ilca4-youth-worlds-2027-campaign"
    );
    expect(ilca4Worlds?.pathways).toHaveLength(2);
    expect(ilca4Worlds?.pathways[0].rankingRequirement).toContain("top 15");
    expect(ilca4Worlds?.pathways[1].restrictionNote).toContain("30 March 2027");

    // ILCA 6 Youth Worlds ranked by Kieler Woche final position
    const ilca6Worlds = ILCA6_2027_SELECTION_POLICY.campaigns.find(
      (c) => c.id === "ilca6-youth-worlds-2027-campaign"
    );
    expect(ilca6Worlds?.pathways[0].scoringRule).toBe(
      "Ranked by final overall position at Kieler Woche 2027"
    );

    // ILCA 6 Eastern Seaboard born 2011+ and 12th or higher floor
    const ilca6Eastern = ILCA6_2027_SELECTION_POLICY.campaigns.find(
      (c) => c.id === "ilca6-eastern-seaboard-2027-campaign"
    );
    expect(ilca6Eastern?.pathways[0].quotas[0].ageRule).toBe("Born in 2011 or later");
    expect(ilca6Eastern?.pathways[0].rankingRequirement).toContain("12th or higher");

    // Optimist Worlds Part A / Part B + 30 Mar fallback
    const optiWorlds = OPTIMIST_2027_SELECTION_POLICY.campaigns.find(
      (c) => c.id === "opti-worlds-2027-campaign"
    );
    expect(optiWorlds?.pathways).toHaveLength(2);
    expect(optiWorlds?.pathways[1].restrictionNote).toContain("30 March 2027");

    // Optimist Perth Camp 2027 ranking date & birth years 2014/2015/2016
    const optiPerth = OPTIMIST_2027_SELECTION_POLICY.campaigns.find(
      (c) => c.id === "opti-perth-camp-2027-campaign"
    );
    expect(optiPerth?.pathways[0].scoringRule).toBe(
      "Optimist Gold National Ranking as of 20 September 2027"
    );
    expect(
      optiPerth?.pathways[0].quotas.map((q) => q.birthYearLabel)
    ).toEqual(["2014", "2015", "2016"]);
  });
});
