/**
 * Admin editor form shapes (stringly typed for controlled inputs).
 */

import type { SailorAdmin } from "@/types/sailor";

export type SailorFormState = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4: string;
  club: string;
  school?: string;
  nationality: string;
  gender: string;
  nationalSquadStatus: string;
  /** Guest | Series (form control; legacy Gold/Silver treated as Series) */
  currentFleet: string;
  instagram: string;
  avatarUrl: string;
  dob: string;
  weight: string;
  bio: string;
  goldEntryDate: string;
  silverEntryDate: string;
  dropDate: string;
  natSquadStatusJan25: string;
  natSquadStatusJul25: string;
  natSquadStatusJan26: string;
  natSquadStatusJul26: string;
  natSquadStatusJan27: string;
  natSquadStatusJul27: string;
  histRankingJun24: string;
  histRankingDec24: string;
  histRankingJun25: string;
  histRankingDec25: string;
  histRankingJun26: string;
  worlds: string;
  european: string;
  asian: string;
  seaGames: string;
  sailingJourney: string;
};

export function emptySailorForm(): SailorFormState {
  return {
    id: "",
    name: "",
    handle: "",
    sailNumber: "",
    sailNumberIlca4: "",
    club: "",
    nationality: "",
    gender: "",
    nationalSquadStatus: "",
    currentFleet: "",
    instagram: "",
    avatarUrl: "",
    dob: "",
    weight: "",
    bio: "",
    goldEntryDate: "",
    silverEntryDate: "",
    dropDate: "",
    natSquadStatusJan25: "",
    natSquadStatusJul25: "",
    natSquadStatusJan26: "",
    natSquadStatusJul26: "",
    natSquadStatusJan27: "",
    natSquadStatusJul27: "",
    histRankingJun24: "",
    histRankingDec24: "",
    histRankingJun25: "",
    histRankingDec25: "",
    histRankingJun26: "",
    worlds: "",
    european: "",
    asian: "",
    seaGames: "",
    sailingJourney: "",
  };
}

export function sailorFormFromAdmin(sailor: SailorAdmin): SailorFormState {
  const date = (value: unknown) => (value ? String(value).slice(0, 10) : "");
  return {
    ...emptySailorForm(),
    id: sailor.id,
    name: sailor.name || "",
    handle: sailor.handle || "",
    sailNumber: sailor.sailNumber || "",
    sailNumberIlca4: sailor.sailNumberIlca4 || "",
    club: sailor.club || "",
    school: sailor.school || "",
    nationality: sailor.nationality || "",
    gender: sailor.gender || "",
    currentFleet: sailor.currentFleet || "",
    nationalSquadStatus:
      sailor.natSquadStatusJan27 ||
      sailor.natSquadStatusJul26 ||
      sailor.nationalSquadStatus ||
      "",
    natSquadStatusJan25: sailor.natSquadStatusJan25 || "",
    natSquadStatusJul25: sailor.natSquadStatusJul25 || "",
    natSquadStatusJan26: sailor.natSquadStatusJan26 || "",
    natSquadStatusJul26:
      sailor.natSquadStatusJul26 || sailor.nationalSquadStatus || "",
    natSquadStatusJan27: sailor.natSquadStatusJan27 || "",
    natSquadStatusJul27: sailor.natSquadStatusJul27 || "",
    histRankingJun24:
      sailor.histRankingJun24 != null ? String(sailor.histRankingJun24) : "",
    histRankingDec24:
      sailor.histRankingDec24 != null ? String(sailor.histRankingDec24) : "",
    histRankingJun25:
      sailor.histRankingJun25 != null ? String(sailor.histRankingJun25) : "",
    histRankingDec25:
      sailor.histRankingDec25 != null ? String(sailor.histRankingDec25) : "",
    histRankingJun26:
      sailor.histRankingJun26 != null ? String(sailor.histRankingJun26) : "",
    instagram: sailor.instagram || "",
    avatarUrl: sailor.avatarUrl || "",
    dob: date(sailor.dob),
    weight: sailor.weight != null ? String(sailor.weight) : "",
    bio: sailor.bio || "",
    goldEntryDate: date(sailor.goldEntryDate),
    silverEntryDate: date(sailor.silverEntryDate),
    dropDate: date(sailor.dropDate),
    worlds: sailor.worlds != null ? String(sailor.worlds) : "",
    european: sailor.european != null ? String(sailor.european) : "",
    asian: sailor.asian != null ? String(sailor.asian) : "",
    seaGames: sailor.seaGames != null ? String(sailor.seaGames) : "",
    sailingJourney: sailor.sailingJourney ? String(sailor.sailingJourney) : "",
  };
}

export type RegattaFormState = {
  id: string;
  name: string;
  date: string;
  endDate?: string;
  venue?: string;
  organizer?: string;
  norUrl?: string;
  registrationUrl?: string;
  isSelectionTrial?: boolean;
  scheduleNotes?: string;
  /** Controlled number input may hold string while editing */
  totalFleetSize: number | string;
  division: string;
  raceCount: string | number;
  geography: string;
  boatClass: string;
  countsForRanking: boolean;
  slug?: string;
  status?: string;
};

export function emptyRegattaForm(): RegattaFormState {
  return {
    id: "",
    name: "",
    date: "",
    endDate: "",
    venue: "",
    organizer: "",
    norUrl: "",
    registrationUrl: "",
    isSelectionTrial: false,
    scheduleNotes: "",
    totalFleetSize: 50,
    division: "Gold",
    raceCount: "",
    geography: "SGP",
    boatClass: "Optimist",
    countsForRanking: true,
    status: "published",
  };
}

export type ResultFormState = {
  id: string;
  regattaId: string;
  sailorId: string;
  rank: number | string;
  nettScore: string | number;
  totalScore: string | number;
  isDNS: boolean;
  isDns?: boolean;
  isOverseasCommitment: boolean;
};

export function emptyResultForm(): ResultFormState {
  return {
    id: "",
    regattaId: "",
    sailorId: "",
    rank: 1,
    nettScore: "",
    totalScore: "",
    isDNS: false,
    isOverseasCommitment: false,
  };
}
