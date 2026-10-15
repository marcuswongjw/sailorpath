import { birthYear } from "@/lib/age";
import type { SailorMapped } from "@/lib/queries";
import type {
  EquipmentProps,
  SailorRecordProps,
} from "@/components/sailor-profile/types";

export type PublicSailorOptions = {
  /** Owners and superadmins use the private, authorised projection. */
  canSeePrivate: boolean;
};

/**
 * Single allow-list for data that may cross a public server/component boundary.
 * Never add fields here because a client happens to hide them: this is the
 * projection shared by the public profile shell and fallback state.
 */
export function toPublicSailorProps(
  sailor: SailorMapped,
  opts: PublicSailorOptions
): SailorRecordProps {
  if (opts.canSeePrivate) {
    return {
      id: sailor.id,
      name: sailor.name,
      handle: sailor.handle,
      sailNumber: sailor.sailNumber,
      sailNumberIlca4: sailor.sailNumberIlca4,
      boardNumber: sailor.boardNumber,
      club: sailor.club,
      school: sailor.school,
      nationality: sailor.nationality,
      dob: sailor.dob ? String(sailor.dob).slice(0, 10) : null,
      birthYear: birthYear(sailor.dob),
      bio: sailor.bio,
      instagram: sailor.instagram,
      avatarUrl: sailor.avatarUrl,
      sailingJourney: sailor.sailingJourney,
      showSchoolOnPublicProfile: Boolean(sailor.showSchoolOnPublicProfile),
      showEquipmentOnPublicProfile: Boolean(sailor.showEquipmentOnPublicProfile),
      showProfilePhotoOnPublicProfile: Boolean(sailor.showProfilePhotoOnPublicProfile),
      showSocialLinksOnPublicProfile: Boolean(sailor.showSocialLinksOnPublicProfile),
      showSailingMilestonesOnPublicProfile: Boolean(
        sailor.showSailingMilestonesOnPublicProfile
      ),
      goldEntryDate: sailor.goldEntryDate
        ? String(sailor.goldEntryDate).slice(0, 10)
        : null,
      silverEntryDate: sailor.silverEntryDate
        ? String(sailor.silverEntryDate).slice(0, 10)
        : null,
      dropDate: sailor.dropDate ? String(sailor.dropDate).slice(0, 10) : null,
      currentFleet: sailor.currentFleet,
      weight: sailor.weight ?? null,
      ownerRelation: sailor.ownerRelation ?? null,
      hullBrand: sailor.hullBrand,
      sailMake: sailor.sailMake,
      foilBrand: sailor.foilBrand,
      mast: sailor.mast,
      equipmentNotes: sailor.equipmentNotes,
      hullBrandIlca4: sailor.hullBrandIlca4,
      sailMakeIlca4: sailor.sailMakeIlca4,
      foilBrandIlca4: sailor.foilBrandIlca4,
      mastIlca4: sailor.mastIlca4,
      equipmentNotesIlca4: sailor.equipmentNotesIlca4,
    };
  }

  return {
    id: sailor.id,
    name: sailor.name,
    handle: sailor.handle,
    sailNumber: sailor.sailNumber,
    sailNumberIlca4: sailor.sailNumberIlca4,
    boardNumber: sailor.boardNumber,
    club: sailor.club,
    nationality: sailor.nationality,
    birthYear: birthYear(sailor.dob),
    dob: null,
    bio: sailor.bio && sailor.bio.length <= 500 ? sailor.bio : null,
    school: sailor.showSchoolOnPublicProfile ? sailor.school : null,
    avatarUrl: sailor.showProfilePhotoOnPublicProfile ? sailor.avatarUrl : null,
    instagram: sailor.showSocialLinksOnPublicProfile ? sailor.instagram : null,
    sailingJourney: sailor.showSailingMilestonesOnPublicProfile
      ? sailor.sailingJourney
      : null,
  };
}

/**
 * Public equipment is an explicit brand/model-only projection. Notes, logs,
 * serials, effective dates and all history remain private in every state.
 */
export function toPublicEquipmentProps(
  sailor: SailorMapped,
  canSeePrivate: boolean
): EquipmentProps {
  const publicEquipment = Boolean(sailor.showEquipmentOnPublicProfile);
  if (!canSeePrivate && !publicEquipment) {
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
    notes: canSeePrivate ? sailor.equipmentNotes || null : null,
    // The alternate-class inventory stays inside the private workspace. The
    // public profile projects just the active-class brand/model set.
    hullBrandIlca4: canSeePrivate ? sailor.hullBrandIlca4 || null : null,
    sailMakeIlca4: canSeePrivate ? sailor.sailMakeIlca4 || null : null,
    foilBrandIlca4: canSeePrivate ? sailor.foilBrandIlca4 || null : null,
    mastIlca4: canSeePrivate ? sailor.mastIlca4 || null : null,
    notesIlca4: canSeePrivate ? sailor.equipmentNotesIlca4 || null : null,
  };
}
