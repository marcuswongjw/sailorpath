/**
 * Admin editor form shapes (stringly typed for controlled inputs).
 */

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
    gender: "M",
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
  };
}

export type RegattaFormState = {
  id: string;
  name: string;
  date: string;
  /** Controlled number input may hold string while editing */
  totalFleetSize: number | string;
  division: string;
  raceCount: string | number;
  geography: string;
  boatClass: string;
  countsForRanking: boolean;
  slug?: string;
};

export function emptyRegattaForm(): RegattaFormState {
  return {
    id: "",
    name: "",
    date: "",
    totalFleetSize: 50,
    division: "Gold",
    raceCount: "",
    geography: "SGP",
    boatClass: "Optimist",
    countsForRanking: true,
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
