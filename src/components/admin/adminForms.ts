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
  boardNumber: string;
  club: string;
  school?: string;
  nationality: string;
  gender: string;
  nationalSquadStatus: string;
  /** Guest | Series (form control; legacy Gold/Silver treated as Series) */
  currentFleet: string;
  /** SG ILCA 4 national ranking list */
  ilca4NationalList: boolean;
  /**
   * SG ILCA 6 national ranking list.
   * null = not saved; the checkbox follows the official name seed.
   */
  ilca6NationalList: boolean | null;
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
    boardNumber: "",
    club: "",
    nationality: "",
    gender: "",
    nationalSquadStatus: "",
    currentFleet: "",
    ilca4NationalList: false,
    ilca6NationalList: null,
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
    boardNumber: sailor.boardNumber || "",
    club: sailor.club || "",
    school: sailor.school || "",
    nationality: sailor.nationality || "",
    gender: sailor.gender || "",
    currentFleet: sailor.currentFleet || "",
    ilca4NationalList: sailor.ilca4NationalList === true,
    ilca6NationalList:
      sailor.ilca6NationalList === true
        ? true
        : sailor.ilca6NationalList === false
          ? false
          : null,
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
  /** Weekend selected for a new or explicitly linked class sheet. */
  eventId?: string;
  name: string;
  date: string;
  endDate?: string;
  venue?: string;
  organizer?: string;
  norUrl?: string;
  registrationUrl?: string;
  isSelectionTrial?: boolean;
  /** Catalog id for the selection event this class counts toward. */
  selectionEventId?: string;
  scheduleNotes?: string;
  /** Controlled number input may hold string while editing */
  totalFleetSize: number | string;
  division: string;
  raceCount: string | number;
  geography: string;
  boatClass: string;
  entryType?: "individual" | "crew";
  minParticipants?: number | string;
  maxParticipants?: number | string;
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
    selectionEventId: "",
    scheduleNotes: "",
    totalFleetSize: 50,
    division: "Gold",
    raceCount: "",
    geography: "SGP",
    boatClass: "Optimist",
    entryType: "individual",
    minParticipants: 1,
    maxParticipants: 1,
    countsForRanking: true,
    status: "published",
  };
}

/** Same shape for the open snapshot and the form written back after a save. */
export function regattaToClassForm(r: {
  id: string;
  eventId?: string | null;
  name?: string | null;
  date?: string | Date | null;
  slug?: string | null;
  division?: string | null;
  raceCount?: number | string | null;
  totalFleetSize?: number | string | null;
  geography?: string | null;
  boatClass?: string | null;
  entryType?: "individual" | "crew" | null;
  minParticipants?: number | string | null;
  maxParticipants?: number | string | null;
  countsForRanking?: boolean | null;
  endDate?: string | Date | null;
  venue?: string | null;
  organizer?: string | null;
  norUrl?: string | null;
  registrationUrl?: string | null;
  isSelectionTrial?: boolean | null;
  selectionEventId?: string | null;
  scheduleNotes?: string | null;
  status?: string | null;
}): RegattaFormState {
  const trial = Boolean(r.isSelectionTrial);
  return {
    id: r.id,
    eventId: r.eventId || "",
    name: r.name || "",
    date: String(r.date || "").slice(0, 10),
    slug: r.slug || undefined,
    division: r.division || "",
    raceCount: r.raceCount != null && r.raceCount !== "" ? String(r.raceCount) : "",
    totalFleetSize:
      r.totalFleetSize != null && r.totalFleetSize !== ""
        ? String(r.totalFleetSize)
        : "",
    geography: r.geography || "SGP",
    boatClass: r.boatClass || "Optimist",
    entryType: r.entryType || "individual",
    minParticipants: r.minParticipants ?? 1,
    maxParticipants: r.maxParticipants ?? 1,
    countsForRanking: r.countsForRanking !== false,
    endDate: r.endDate ? String(r.endDate).slice(0, 10) : "",
    venue: r.venue || "",
    organizer: r.organizer || "",
    norUrl: r.norUrl || "",
    registrationUrl: r.registrationUrl || "",
    isSelectionTrial: trial,
    selectionEventId: trial ? r.selectionEventId || "" : "",
    scheduleNotes: r.scheduleNotes || "",
    status: r.status || "published",
  };
}

export type ResultFormState = {
  id: string;
  regattaId: string;
  sailorId: string;
  /** Second crew member when the selected regatta sheet is a crew entry. */
  crewSailorId?: string;
  firstParticipantRole?: "solo" | "helm" | "crew" | "member" | "unknown";
  secondParticipantRole?: "solo" | "helm" | "crew" | "member" | "unknown";
  entryLabel?: string;
  entrySailNumber?: string;
  entryBoardNumber?: string;
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
    crewSailorId: "",
    firstParticipantRole: "unknown",
    secondParticipantRole: "unknown",
    entryLabel: "",
    entrySailNumber: "",
    entryBoardNumber: "",
    rank: 1,
    nettScore: "",
    totalScore: "",
    isDNS: false,
    isOverseasCommitment: false,
  };
}
