import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";
import {
  preferredDuplicateResultUpdate,
  SAILOR_RELATIONSHIP_MERGE_PLAN,
  splitSourceRowsByTargetConflict,
} from "@/lib/mergeSailors";

describe("preferredDuplicateResultUpdate", () => {
  const dns = {
    rank: 81,
    nettScore: 90,
    totalScore: 90,
    isDns: true,
    isOverseasCommitment: false,
  };
  const finish = {
    rank: 4,
    nettScore: 12,
    totalScore: 18,
    isDns: false,
    isOverseasCommitment: false,
  };

  it("clears isDns when the duplicate has the better finish", () => {
    expect(preferredDuplicateResultUpdate(dns, finish)).toEqual({
      rank: 4,
      nettScore: 12,
      totalScore: 18,
      isDns: false,
      isOverseasCommitment: false,
    });
  });

  it("keeps the survivor when its place is already better", () => {
    expect(preferredDuplicateResultUpdate(finish, dns)).toBeNull();
  });

  it("copies an overseas flag together with a better place", () => {
    expect(
      preferredDuplicateResultUpdate(finish, {
        rank: 2,
        nettScore: 8,
        totalScore: null,
        isDns: false,
        isOverseasCommitment: true,
      })
    ).toEqual({
      rank: 2,
      nettScore: 8,
      totalScore: 18,
      isDns: false,
      isOverseasCommitment: true,
    });
  });

  it("fills a missing total without changing a DNS flag", () => {
    expect(
      preferredDuplicateResultUpdate(
        { ...dns, rank: 10, totalScore: null },
        { ...dns, rank: 20, totalScore: 40 }
      )
    ).toEqual({ totalScore: 40 });
  });
});

describe("sailor relationship merge planning", () => {
  it("moves non-conflicting source rows and deterministically drops target conflicts", () => {
    const source = [
      { id: "source-conflict", ownerId: "coach-1" },
      { id: "source-move", ownerId: "coach-2" },
    ];
    const target = [{ id: "target-canonical", ownerId: "coach-1" }];

    expect(
      splitSourceRowsByTargetConflict(source, target, (row) => row.ownerId)
    ).toEqual({
      moveIds: ["source-move"],
      conflictIds: ["source-conflict"],
    });
  });

  it("covers every direct sailor FK and the dependent official race scores", () => {
    const planned = new Set(
      SAILOR_RELATIONSHIP_MERGE_PLAN.map(({ table }) => table)
    );

    const schema = readFileSync(
      new URL("../db/schema.ts", import.meta.url),
      "utf8"
    );
    const declarations = Array.from(
      schema.matchAll(/export const (\w+) = pgTable/g)
    );
    const directSailorFkTables = declarations
      .filter((match, index) => {
        const start = match.index ?? 0;
        const end = declarations[index + 1]?.index ?? schema.length;
        return schema
          .slice(start, end)
          .includes("references(() => sailors.id");
      })
      .map(([, table]) => table);

    expect(planned).toEqual(
      new Set([...directSailorFkTables, "regattaRaceResults"])
    );
    for (const coachTable of [
      "coachSquadMembers",
      "coachFollowedSailors",
      "coachSailorNotes",
      "coachDevelopmentRecords",
      "coachActionReviews",
    ]) {
      expect(planned).toContain(coachTable);
    }
  });

  it("keeps transaction ownership in the service and both entry points delegate to it", () => {
    const service = readFileSync(
      new URL("./mergeSailors.ts", import.meta.url),
      "utf8"
    );
    const route = readFileSync(
      new URL("../app/api/admin/sailors/merge/route.ts", import.meta.url),
      "utf8"
    );
    const adminActions = readFileSync(
      new URL("./adminSailorActions.ts", import.meta.url),
      "utf8"
    );

    expect(service).toContain("return db.transaction(async (tx) =>");
    expect(route).toContain("txResult = await mergeSailors({");
    expect(adminActions).toContain("await mergeSailors({ keepId, mergeId, forceOwnershipConflict: true });");
    expect(route).not.toContain("db.transaction(");
  });
});
