import { describe, expect, it } from "vitest";
import {
  toPublicEquipmentProps,
  toPublicSailorProps,
} from "./publicSailor";
import type { SailorMapped } from "./queries";

const base = {
  id: "s1",
  name: "Test Sailor",
  handle: "test-sailor",
  sailNumber: "SGP 1",
  sailNumberIlca4: null,
  ilca4NationalList: false,
  club: "CSC",
  school: null,
  nationality: "SGP",
  nationalityFromSail: false,
  avatarUrl: null,
  parentId: "auth-user-secret",
  ownerRelation: "parent",
  goldEntryDate: "2024-01-01",
  silverEntryDate: null,
  dropDate: null,
  currentFleet: "Series",
  dob: "2012-06-15",
  weight: 42,
  bio: "Hello",
  gender: "M",
  nationalSquadStatus: null,
  instagram: null,
  facebook: null,
  natSquadStatusJan25: null,
  natSquadStatusJul25: null,
  natSquadStatusJan26: null,
  natSquadStatusJul26: null,
  natSquadStatusJan27: null,
  natSquadStatusJul27: null,
  histRankingJun24: null,
  histRankingDec24: null,
  histRankingJun25: null,
  histRankingDec25: null,
  histRankingJun26: null,
  worlds: null,
  european: null,
  asian: null,
  seaGames: null,
  isPublicWeight: false,
  isPublicDob: false,
  isPublicEquipment: false,
  sailingJourney: null,
  hullBrand: "Secret Hull",
  sailMake: "Secret Sail",
  foilBrand: null,
  mast: null,
  equipmentNotes: "private note",
  hullBrandIlca4: null,
  sailMakeIlca4: null,
  foilBrandIlca4: null,
  mastIlca4: null,
  equipmentNotesIlca4: null,
} as SailorMapped;

describe("toPublicSailorProps", () => {
  it("strips parentId, full DOB, weight, and equipment for public viewers", () => {
    const pub = toPublicSailorProps(base, { canSeePrivate: false });
    expect(pub).not.toHaveProperty("parentId");
    expect(pub.dob).toBe("2012-01-01"); // year only
    expect(pub.weight).toBeNull();
    expect(pub.hullBrand).toBeUndefined();
    expect(pub.equipmentNotes).toBeUndefined();
    expect(pub.ownerRelation).toBeUndefined();
    expect(pub.name).toBe("Test Sailor");
  });

  it("includes private fields for owners", () => {
    const priv = toPublicSailorProps(base, { canSeePrivate: true });
    expect(priv.dob).toBe("2012-06-15");
    expect(priv.weight).toBe(42);
    expect(priv.hullBrand).toBe("Secret Hull");
    expect(priv.ownerRelation).toBe("parent");
    expect(priv).not.toHaveProperty("parentId");
  });

  it("respects isPublicDob / isPublicWeight flags", () => {
    const open = toPublicSailorProps(
      { ...base, isPublicDob: true, isPublicWeight: true },
      { canSeePrivate: false }
    );
    expect(open.dob).toBe("2012-06-15");
    expect(open.weight).toBe(42);
  });
});

describe("toPublicEquipmentProps", () => {
  it("returns nulls for public viewers", () => {
    const eq = toPublicEquipmentProps(base, false);
    expect(eq.hullBrand).toBeNull();
    expect(eq.notes).toBeNull();
  });

  it("returns legacy columns for private viewers", () => {
    const eq = toPublicEquipmentProps(base, true);
    expect(eq.hullBrand).toBe("Secret Hull");
    expect(eq.notes).toBe("private note");
  });
});
