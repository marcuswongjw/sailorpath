import { unstable_cache } from "next/cache";
import {
  CACHE_TAG_FLEET_RANKINGS,
  CACHE_TAG_PUBLIC_REGATTAS,
} from "@/lib/cacheTags";
import {
  ASIAN_OCEANIA_2026,
  PERTH_CAMP_2026,
  computeCombinedSelectionScores,
  getSelectionDataStatus,
  matchSelectionEvents,
  selectAsianOceaniaTeam,
  selectPerthCamp,
  type CampaignDef,
  type CombinedSelectionRow,
  type MatchedSelectionEvent,
  type PerthPick,
  type SelectionDataStatus,
} from "@/lib/optimistEventSelection";
import {
  listRegattas,
  listSailorsFull,
  getResultsForRegatta,
} from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import type { RegattaResultRecord, SailorRecord } from "@/lib/ranking";

export type OptimistSelectionPayload = {
  matched: MatchedSelectionEvent[];
  selectionStatus: SelectionDataStatus;
  combinedScores: CombinedSelectionRow[];
  asianTeam: {
    selected: (CombinedSelectionRow & { teamRank: number })[];
    reserves: CombinedSelectionRow[];
    reason: string;
  };
  perthCamp: {
    picks: PerthPick[];
    notes: string[];
  };
  campaigns: {
    asianOceania: CampaignDef;
    perthCamp: CampaignDef;
  };
};

export async function computeOptimistSelectionData(): Promise<OptimistSelectionPayload> {
  try {
    const allRegattas = await listRegattas();
    const matched = matchSelectionEvents(allRegattas, ASIAN_OCEANIA_2026.events);

    const matchedRegattaIds = matched
      .map((m) => m.regatta?.id)
      .filter((id): id is string => Boolean(id));

    let allResults: RegattaResultRecord[] = [];
    if (matchedRegattaIds.length > 0) {
      const resultGroups = await Promise.all(
        matchedRegattaIds.map((regattaId) => getResultsForRegatta(regattaId))
      );
      allResults = resultGroups.flat().map((r) => ({
        sailorId: r.sailorId,
        regattaId: r.regattaId,
        rank: r.rank,
        nettScore: r.nettScore,
        totalScore: r.totalScore,
        isDns: Boolean(r.isDns),
        isOverseasCommitment: Boolean(r.isOverseasCommitment),
        raceResults: r.raceResults?.map((race) => ({
          raceNumber: race.raceNumber,
          score: race.score,
          scoringCode: race.scoringCode,
          discarded: race.discarded,
          rawValue: race.rawValue,
        })),
      }));
    }

    const rawSailors = await listSailorsFull();
    const sailors: SailorRecord[] = rawSailors.map((s) => ({
      id: s.id,
      name: s.name,
      handle: s.handle,
      sailNumber: s.sailNumber,
      sailNumberIlca4: s.sailNumberIlca4,
      club: s.club,
      school: s.school,
      nationality: s.nationality,
      avatarUrl: s.avatarUrl,
      goldEntryDate: s.goldEntryDate ? String(s.goldEntryDate).slice(0, 10) : null,
      silverEntryDate: s.silverEntryDate ? String(s.silverEntryDate).slice(0, 10) : null,
      dropDate: s.dropDate ? String(s.dropDate).slice(0, 10) : null,
      currentFleet: s.currentFleet,
      dob: s.dob ? String(s.dob).slice(0, 10) : null,
      gender: s.gender,
      nationalSquadStatus: s.nationalSquadStatus,
      natSquadStatusJan25: s.natSquadStatusJan25,
      natSquadStatusJul25: s.natSquadStatusJul25,
      natSquadStatusJan26: s.natSquadStatusJan26,
      natSquadStatusJul26: s.natSquadStatusJul26,
      natSquadStatusJan27: s.natSquadStatusJan27,
      natSquadStatusJul27: s.natSquadStatusJul27,
    }));

    const selectionStatus = getSelectionDataStatus(matched, allResults);
    const combinedScores = computeCombinedSelectionScores(
      matched,
      sailors,
      allResults
    );
    const asianTeam = selectAsianOceaniaTeam(combinedScores);
    const perthCamp = selectPerthCamp(combinedScores);

    return {
      matched,
      selectionStatus,
      combinedScores,
      asianTeam,
      perthCamp,
      campaigns: {
        asianOceania: ASIAN_OCEANIA_2026,
        perthCamp: PERTH_CAMP_2026,
      },
    };
  } catch (error) {
    if (error instanceof DbUnavailableError) {
      return {
        matched: ASIAN_OCEANIA_2026.events.map((def) => ({
          def,
          regatta: null,
          matched: false,
        })),
        selectionStatus: {
          usableRaceCount: 0,
          discardCount: 0,
          complete: false,
          warnings: ["Database is currently unavailable."],
        },
        combinedScores: [],
        asianTeam: {
          selected: [],
          reserves: [],
          reason: "Database unavailable.",
        },
        perthCamp: { picks: [], notes: ["Database unavailable."] },
        campaigns: {
          asianOceania: ASIAN_OCEANIA_2026,
          perthCamp: PERTH_CAMP_2026,
        },
      };
    }
    throw error;
  }
}

export async function getCachedOptimistSelectionData(): Promise<OptimistSelectionPayload> {
  return unstable_cache(
    async () => computeOptimistSelectionData(),
    ["optimist-selection-2026"],
    {
      tags: [CACHE_TAG_FLEET_RANKINGS, CACHE_TAG_PUBLIC_REGATTAS],
      revalidate: 60,
    }
  )();
}
