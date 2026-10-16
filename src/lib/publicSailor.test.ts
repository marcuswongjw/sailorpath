import { describe, expect, it } from "vitest";
import { toPublicEquipmentProps, toPublicSailorProps } from "./publicSailor";
import type { SailorMapped } from "./queries";

const base = {
  id: "s1",
  name: "Test Sailor",
  handle: "test-sailor",
  sailNumber: "SGP 1",
  sailNumberIlca4: null,
  boardNumber: "S24",
  ilca4NationalList: false,
  club: "CSC",
  school: "Private School",
  nationality: "SGP",
  nationalityFromSail: false,
  avatarUrl: "https://images.example/sailor.jpg",
  parentId: "auth-user-secret",
  ownerRelation: "parent",
  goldEntryDate: "2024-01-01",
  silverEntryDate: null,
  dropDate: null,
  currentFleet: "Series",
  dob: "2012-06-15",
  weight: 42,
  bio: "Owner-written biography",
  gender: "M",
  nationalSquadStatus: "Nat A",
  instagram: "@private-sailor",
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
  isPublicWeight: true,
  isPublicDob: true,
  isPublicEquipment: true,
  showSchoolOnPublicProfile: false,
  showEquipmentOnPublicProfile: false,
  showProfilePhotoOnPublicProfile: false,
  showSocialLinksOnPublicProfile: false,
  showSailingMilestonesOnPublicProfile: false,
  sailingJourney: '[{"title":"Private draft"}]',
  hullBrand: "Safe Hull",
  sailMake: "Safe Sail",
  foilBrand: "Private Foil",
  mast: "Private Mast",
  equipmentNotes: "private note",
  hullBrandIlca4: null,
  sailMakeIlca4: null,
  foilBrandIlca4: null,
  mastIlca4: null,
  equipmentNotesIlca4: null,
} as SailorMapped;

describe("toPublicSailorProps", () => {
  it("uses an allow-list for an anonymous profile", () => {
    const pub = toPublicSailorProps(base, { canSeePrivate: false });
    expect(pub).toMatchObject({
      name: "Test Sailor",
      handle: "test-sailor",
      birthYear: 2012,
      dob: null,
      bio: "Owner-written biography",
      club: "CSC",
    });
    for (const field of [
      "parentId", "ownerRelation", "weight", "gender", "nationalSquadStatus",
      "equipmentNotes", "hullBrand", "currentFleet", "showSchoolOnPublicProfile",
      "showEquipmentOnPublicProfile", "showProfilePhotoOnPublicProfile",
      "showSocialLinksOnPublicProfile", "showSailingMilestonesOnPublicProfile",
    ]) {
      expect(pub[field]).toBeUndefined();
    }
    expect(pub.dob).toBeNull();
    expect(pub.school).toBeNull();
    expect(pub.avatarUrl).toBeNull();
    expect(pub.instagram).toBeNull();
    expect(pub.sailingJourney).toBeNull();
  });

  it("only includes explicit owner-approved optional profile fields", () => {
    const pub = toPublicSailorProps(
      {
        ...base,
        showSchoolOnPublicProfile: true,
        showProfilePhotoOnPublicProfile: true,
        showSocialLinksOnPublicProfile: true,
        showSailingMilestonesOnPublicProfile: true,
      },
      { canSeePrivate: false }
    );
    expect(pub.school).toBe("Private School");
    expect(pub.avatarUrl).toContain("images.example");
    expect(pub.instagram).toBe("@private-sailor");
    expect(pub.sailingJourney).toContain("Private draft");
    expect(pub.showSchoolOnPublicProfile).toBeUndefined();
  });

  it("never honors legacy full-DOB or weight public flags", () => {
    const pub = toPublicSailorProps(base, { canSeePrivate: false });
    expect(pub.dob).toBeNull();
    expect(pub.weight).toBeUndefined();
    expect(pub.birthYear).toBe(2012);
  });

  it("does not serialize consent controls or private relationship metadata", () => {
    const pub = toPublicSailorProps(
      {
        ...base,
        showSchoolOnPublicProfile: true,
        showEquipmentOnPublicProfile: true,
      },
      { canSeePrivate: false }
    );

    expect(JSON.stringify(pub)).not.toContain("auth-user-secret");
    expect(JSON.stringify(pub)).not.toContain("ownerRelation");
    expect(JSON.stringify(pub)).not.toContain("showEquipmentOnPublicProfile");
    expect(JSON.stringify(pub)).not.toContain("2012-06-15");
  });

  it("retains private data only for authorised viewers", () => {
    const priv = toPublicSailorProps(base, { canSeePrivate: true });
    expect(priv.dob).toBe("2012-06-15");
    expect(priv.weight).toBe(42);
    expect(priv.equipmentNotes).toBe("private note");
  });
});

describe("toPublicEquipmentProps", () => {
  it("omits equipment without explicit consent", () => {
    const eq = toPublicEquipmentProps(base, false);
    expect(eq.hullBrand).toBeNull();
    expect(eq.notes).toBeNull();
  });

  it("publishes safe brand/model fields but never notes", () => {
    const eq = toPublicEquipmentProps(
      { ...base, showEquipmentOnPublicProfile: true },
      false
    );
    expect(eq.hullBrand).toBe("Safe Hull");
    expect(eq.sailMake).toBe("Safe Sail");
    expect(eq.notes).toBeNull();
  });
});
