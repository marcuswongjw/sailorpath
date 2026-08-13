/**
 * Shared types for the sailor profile UI.
 */

export interface SailorRecordProps {
  id: string;
  name: string;
  handle: string;
  sailNumber?: string | null;
  /** ILCA 4 sail number (optional dual number under 15) */
  sailNumberIlca4?: string | null;
  club?: string | null;
  school?: string | null;
  nationality?: string | null;
  dob?: string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
  dropDate?: string | null;
  bio?: string | null;
  instagram?: string | null;
  weight?: string | number | null;
  boatHull?: string | null;
  boatSail?: string | null;
  boatSpars?: string | null;
  boatFoil?: string | null;
  avatarUrl?: string | null;
  [key: string]: unknown;
}

export interface RegattaResultItem {
  id: string;
  regattaId: string;
  regattaName?: string;
  rank?: number | null;
  nettScore?: number | null;
  isDns?: boolean;
  notes?: string | null;
  [key: string]: unknown;
}

export interface ObservationItem {
  id: string;
  regattaId?: string | null;
  raceNumber?: number | null;
  note?: string | null;
  createdAt?: string | null;
  position?: number | null;
  wind?: string | null;
  isPrivate?: boolean;
  [key: string]: unknown;
}

export interface SeriesStandingProps {
  periodLabel: string;
  fleet: string;
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  rScores: {
    regattaId: string;
    regattaName: string;
    score: number;
    isDNS?: boolean;
    isOverseasCommitment?: boolean;
    isCarryForward?: boolean;
    /** Finishing place for ILCA events (shown next to high points) */
    finishPlace?: number | null;
  }[];
  trendNote: string;
  /** When set, standing card is styled for ILCA vs Optimist */
  boatClass?: string | null;
}

export type EquipmentProps = {
  hullBrand?: string | null;
  sailMake?: string | null;
  foilBrand?: string | null;
  mast?: string | null;
  notes?: string | null;
  hullBrandIlca4?: string | null;
  sailMakeIlca4?: string | null;
  foilBrandIlca4?: string | null;
  mastIlca4?: string | null;
  notesIlca4?: string | null;
};

export interface SailorProfileViewProps {
  initialSailor: SailorRecordProps;
  initialResults: RegattaResultItem[];
  initialEquipment: EquipmentProps;
  initialSeriesStanding?: SeriesStandingProps | null;
  /** ILCA 4 national ranking strip (shown when viewing ILCA tab / ILCA-only) */
  initialIlcaStanding?: SeriesStandingProps | null;
  initialObservations?: ObservationItem[];
  initialEquipmentHistory?: Record<string, unknown>[];
  canSeePrivate?: boolean;
  canClaim?: boolean;
  isOwner?: boolean;
  isLoggedIn?: boolean;
  profileClaimed?: boolean;
  demoMode?: boolean;
  demoRole?: "public" | "sailor" | "parent" | "coach";
  onDemoClaim?: () => void;
  /** Hide bottom privacy card (e.g. moved to Settings modal in demo) */
  hidePrivacySection?: boolean;
  /** Show "Verified" vs "Unclaimed" badge in header */
  profileVerified?: boolean;
}
