/**
 * Build the sailor object that may be serialized to the browser.
 * Private fields must never reach anonymous / non-owner clients via RSC props.
 */

import { birthYear } from "@/lib/age";
import type { SailorMapped } from "@/lib/queries";
import type { EquipmentProps, SailorRecordProps } from "@/components/sailor-profile/types";

export type PublicSailorOptions = {
  /** Owner or superadmin — may receive private fields. */
  canSeePrivate: boolean;
};

/**
 * Public-safe profile props. Always omits `parentId` (use `profileClaimed` instead).
 * Full DOB / weight / legacy equipment only when `canSeePrivate`.
 */
export function toPublicSailorProps(
  sailor: SailorMapped,
  opts: PublicSailorOptions
): SailorRecordProps {
  const canSee = opts.canSeePrivate;
  const isPublicDob = Boolean(sailor.isPublicDob);
  const isPublicWeight = Boolean(sailor.isPublicWeight);

  const dobRaw = sailor.dob ? String(sailor.dob).slice(0, 10) : null;
  // Public viewers: full DOB only if the sailor opted in; otherwise birth year only.
  let dobOut: string | null = null;
  if (canSee || isPublicDob) {
    dobOut = dobRaw;
  } else if (dobRaw) {
    const y = birthYear(dobRaw);
    dobOut = y != null ? `${y}-01-01` : null; // year-only signal; UI shows year
  }

  const base: SailorRecordProps = {
    id: sailor.id,
    name: sailor.name,
    handle: sailor.handle,
    sailNumber: sailor.sailNumber,
    sailNumberIlca4: sailor.sailNumberIlca4,
    ilca4NationalList: sailor.ilca4NationalList,
    club: sailor.club,
    school: sailor.school,
    nationality: sailor.nationality,
    avatarUrl: sailor.avatarUrl,
    bio: sailor.bio,
    gender: sailor.gender,
    goldEntryDate: sailor.goldEntryDate
      ? String(sailor.goldEntryDate).slice(0, 10)
      : null,
    silverEntryDate: sailor.silverEntryDate
      ? String(sailor.silverEntryDate).slice(0, 10)
      : null,
    dropDate: sailor.dropDate ? String(sailor.dropDate).slice(0, 10) : null,
    currentFleet: sailor.currentFleet,
    instagram: sailor.instagram,
    facebook: sailor.facebook,
    nationalSquadStatus: sailor.nationalSquadStatus,
    natSquadStatusJan25: sailor.natSquadStatusJan25,
    natSquadStatusJul25: sailor.natSquadStatusJul25,
    natSquadStatusJan26: sailor.natSquadStatusJan26,
    natSquadStatusJul26: sailor.natSquadStatusJul26,
    natSquadStatusJan27: sailor.natSquadStatusJan27,
    natSquadStatusJul27: sailor.natSquadStatusJul27,
    histRankingJun24: sailor.histRankingJun24,
    histRankingDec24: sailor.histRankingDec24,
    histRankingJun25: sailor.histRankingJun25,
    histRankingDec25: sailor.histRankingDec25,
    histRankingJun26: sailor.histRankingJun26,
    worlds: sailor.worlds,
    european: sailor.european,
    asian: sailor.asian,
    seaGames: sailor.seaGames,
    sailingJourney: sailor.sailingJourney,
    isPublicWeight,
    isPublicDob,
    isPublicEquipment: Boolean(sailor.isPublicEquipment),
    dob: dobOut,
    // Never expose owner auth id to the client payload
    // (profileClaimed / profileVerified cover the public need)
    weight: canSee || isPublicWeight ? sailor.weight ?? null : null,
  };

  if (canSee) {
    base.ownerRelation = sailor.ownerRelation ?? null;
    base.hullBrand = sailor.hullBrand;
    base.sailMake = sailor.sailMake;
    base.foilBrand = sailor.foilBrand;
    base.mast = sailor.mast;
    base.equipmentNotes = sailor.equipmentNotes;
    base.hullBrandIlca4 = sailor.hullBrandIlca4;
    base.sailMakeIlca4 = sailor.sailMakeIlca4;
    base.foilBrandIlca4 = sailor.foilBrandIlca4;
    base.mastIlca4 = sailor.mastIlca4;
    base.equipmentNotesIlca4 = sailor.equipmentNotesIlca4;
  }

  return base;
}

/** Legacy equipment blob for the profile — empty for public viewers. */
export function toPublicEquipmentProps(
  sailor: SailorMapped,
  canSeePrivate: boolean
): EquipmentProps {
  if (!canSeePrivate) {
    return {
      hullBrand: null,
      sailMake: null,
      foilBrand: null,
      mast: null,
      notes: null,
      hullBrandIlca4: null,
      sailMakeIlca4: null,
      foilBrandIlca4: null,
      mastIlca4: null,
      notesIlca4: null,
    };
  }
  return {
    hullBrand: sailor.hullBrand || null,
    sailMake: sailor.sailMake || null,
    foilBrand: sailor.foilBrand || null,
    mast: sailor.mast || null,
    notes: sailor.equipmentNotes || null,
    hullBrandIlca4: sailor.hullBrandIlca4 || null,
    sailMakeIlca4: sailor.sailMakeIlca4 || null,
    foilBrandIlca4: sailor.foilBrandIlca4 || null,
    mastIlca4: sailor.mastIlca4 || null,
    notesIlca4: sailor.equipmentNotesIlca4 || null,
  };
}
