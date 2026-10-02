import { bestThreeSelectedIndexes } from "@/lib/bestThreeSelection";
import { toYmd } from "@/lib/datesSg";
import {
  isIlcaSeriesClass,
  type IlcaBoatClass,
  type IlcaRankedSailor,
} from "@/lib/ilcaRanking";
import {
  overallRankOnBoard,
  periodBounds,
  periodLabel,
  regattaCountsForRanking,
  regattaMatchesSeriesClass,
  sharedOverallRanks,
  type Period,
  type RankedSailor,
  type RegattaScoreSlot,
} from "@/lib/ranking";

export type PersonalSeasonFleet =
  | "Gold"
  | "Silver"
  | "Dropped"
  | "Guest"
  | "ILCA";

export type SeasonScoreInput = {
  regattaId: string;
  regattaName: string;
  score: number;
  isDNS?: boolean;
  isOverseasCommitment?: boolean;
  isCarryForward?: boolean;
  periodLabel?: string;
  regattaDate?: string | null;
  finishPlace?: number | null;
};

export type PersonalSeasonSlot = {
  index: number;
  regattaId: string | null;
  regattaName: string | null;
  score: number | null;
  finishPlace: number | null;
  periodLabel: string | null;
  counting: boolean;
  discarded: boolean;
  carryForward: boolean;
  dns: boolean;
  overseas: boolean;
  empty: boolean;
};

export type NextCountingEvent = {
  name: string;
  date: string;
  href: string | null;
  boatClass: string | null;
};

export type FollowedSailorSummary = {
  sailorId: string;
  name: string;
  handle: string;
  club: string;
  fleet: PersonalSeasonFleet;
  periodLabel: string;
  periodRank: number | null;
  fleetSize: number | null;
  lastResultDate: string | null;
  season: PersonalSeasonView;
};

export type PersonalSeasonView = {
  sailorId: string;
  sailorName: string;
  handle: string;
  periodLabel: string;
  fleet: PersonalSeasonFleet;
  ilcaClass: string | null;
  rank: number | null;
  fleetSize: number | null;
  best3: number | null;
  higherIsBetter: boolean;
  slots: PersonalSeasonSlot[];
  nextCountingEvent: NextCountingEvent | null;
  why: string[];
  resultsHref: string;
  lastResultDate: string | null;
  tiedWith: number;
};

export type CountingEventCandidate = {
  id: string;
  name: string;
  date: string;
  slug?: string | null;
  boatClass?: string | null;
  division?: string | null;
  countsForRanking?: boolean | null;
  raceCount?: number | null;
};

export type SeasonSailorInput = {
  id: string;
  name: string;
  handle: string;
  sailNumber?: string | null;
  club?: string | null;
  nationality?: string | null;
  currentFleet?: string | null;
  goldEntryDate?: string | Date | null;
  silverEntryDate?: string | Date | null;
  dropDate?: string | Date | null;
  sailNumberIlca4?: string | null;
  ilca4NationalList?: boolean | null;
  ilca6NationalList?: boolean | null;
};

const MONTHS = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

export function formatSeasonDate(ymd: string): string {
  const [year, month, day] = String(ymd || "").slice(0, 10).split("-");
  const monthIndex = Number(month) - 1;
  const dayNumber = Number(day);
  if (!year || monthIndex < 0 || monthIndex > 11 || !dayNumber) return ymd;
  return `${dayNumber} ${MONTHS[monthIndex]} ${year}`;
}

export function ordinalPlace(n: number): string {
  const mod100 = n % 100;
  if (mod100 >= 11 && mod100 <= 13) return `${n}th`;
  switch (n % 10) {
    case 1:
      return `${n}st`;
    case 2:
      return `${n}nd`;
    case 3:
      return `${n}rd`;
    default:
      return `${n}th`;
  }
}

function joinAnd(parts: string[]): string {
  if (parts.length <= 1) return parts[0] || "";
  if (parts.length === 2) return `${parts[0]} and ${parts[1]}`;
  return `${parts.slice(0, -1).join(", ")}, and ${parts[parts.length - 1]}`;
}

function fleetPhrase(fleet: PersonalSeasonFleet, ilcaClass: string | null): string {
  if (fleet === "ILCA") return ilcaClass || "ILCA";
  return fleet;
}

/** Five Best 3 slots, using the same selected-index rule as the fleet table. */
export function decorateSeasonSlots(
  scores: readonly SeasonScoreInput[],
  higherIsBetter = false
): PersonalSeasonSlot[] {
  const filled = scores.slice(0, 5);
  const selected = bestThreeSelectedIndexes(
    filled.map((score) => score.score),
    { higherIsBetter }
  );
  const slots: PersonalSeasonSlot[] = filled.map((score, index) => {
    const counting = selected.has(index);
    const empty = false;
    return {
      index,
      regattaId: score.regattaId,
      regattaName: score.regattaName,
      score: Number.isFinite(score.score) ? score.score : null,
      finishPlace: score.finishPlace ?? null,
      periodLabel: score.periodLabel ?? null,
      counting,
      discarded: !counting && Number.isFinite(score.score),
      carryForward: Boolean(score.isCarryForward),
      dns: Boolean(score.isDNS),
      overseas: Boolean(score.isOverseasCommitment),
      empty,
    };
  });
  while (slots.length < 5) {
    const index = slots.length;
    slots.push({
      index,
      regattaId: null,
      regattaName: null,
      score: null,
      finishPlace: null,
      periodLabel: null,
      counting: false,
      discarded: false,
      carryForward: false,
      dns: false,
      overseas: false,
      empty: true,
    });
  }
  return slots;
}

function slotMark(slot: PersonalSeasonSlot): string {
  const marks: string[] = [];
  if (slot.dns) marks.push("DNS");
  if (slot.overseas) marks.push("overseas");
  if (slot.carryForward) marks.push("carry-forward");
  return marks.length ? ` (${marks.join(", ")})` : "";
}

export function explainSeasonPlace(input: {
  sailorName: string;
  periodLabel: string;
  fleet: PersonalSeasonFleet;
  ilcaClass: string | null;
  rank: number | null;
  fleetSize: number | null;
  best3: number | null;
  higherIsBetter: boolean;
  slots: PersonalSeasonSlot[];
  nextCountingEvent: { name: string; date: string } | null;
  tiedWith: number;
}): string[] {
  const fleet = fleetPhrase(input.fleet, input.ilcaClass);
  const counting = input.slots.filter((slot) => slot.counting && slot.score != null);
  const lines: string[] = [];

  if (input.rank != null && input.fleetSize != null) {
    const listed = counting.map((slot) => String(slot.score));
    const countingClause = listed.length
      ? `, counting ${input.higherIsBetter ? "high points" : "places"} ${joinAnd(listed)}`
      : "";
    const best =
      input.best3 == null ? "" : ` with a Best 3 of 5 of ${input.best3}${countingClause}`;
    lines.push(
      `${input.sailorName} is ${ordinalPlace(input.rank)} of ${input.fleetSize} in ${fleet} for ${input.periodLabel}${best}.`
    );
  } else {
    lines.push(
      `${input.sailorName} is ${fleet} for ${input.periodLabel}, so this half’s ranking board does not include a place for them.`
    );
  }

  const parts: string[] = [];
  if (input.rank != null && input.tiedWith > 1) {
    const others = input.tiedWith - 1;
    parts.push(
      `the place is shared with ${others} other sailor${others === 1 ? "" : "s"} on the same scores`
    );
  }
  if (input.rank != null && counting.length < 3) {
    parts.push(
      input.higherIsBetter
        ? "open scores count as 0 because fewer than three results are in the window"
        : "open scores count as 9999 because fewer than three results are in the window"
    );
  }
  const discarded = input.slots.filter((slot) => slot.discarded && slot.regattaName);
  if (discarded.length) {
    const listed = discarded.map(
      (slot) => `${slot.score} at ${slot.regattaName}${slotMark(slot)}`
    );
    parts.push(`${joinAnd(listed)} ${discarded.length === 1 ? "sits" : "sit"} outside the Best 3`);
  }
  const carry = input.slots.filter(
    (slot) => slot.carryForward && slot.counting && slot.regattaName
  );
  if (carry.length) {
    parts.push(
      `${joinAnd(carry.map((slot) => slot.regattaName!))} ${carry.length === 1 ? "carries" : "carry"} forward from the previous half`
    );
  }
  const countingSpecial = counting.filter((slot) => slot.dns || slot.overseas);
  if (countingSpecial.length) {
    const listed = countingSpecial.map(
      (slot) => `${slot.regattaName}${slotMark(slot)}`
    );
    parts.push(`${joinAnd(listed)} still ${countingSpecial.length === 1 ? "counts" : "count"}`);
  }
  if (input.nextCountingEvent) {
    parts.push(
      `the next counting event is ${input.nextCountingEvent.name} on ${formatSeasonDate(input.nextCountingEvent.date)}`
    );
  }
  if (parts.length) {
    const sentence = joinAnd(parts).replace(/^./, (c) => c.toUpperCase());
    lines.push(`${sentence}.`);
  }
  return lines.slice(0, 2);
}

function divisionMatchesFleet(
  division: string | null | undefined,
  fleet: "Gold" | "Silver" | null
): boolean {
  if (!fleet) {
    const div = division || "";
    return div !== "Open" && div !== "Fleet";
  }
  const div = division || "Gold";
  if (div === "Open" || div === "Fleet") return false;
  if (fleet === "Gold") return div === "Gold" || div === "Both";
  return div === "Silver" || div === "Both";
}

function classMatches(boatClass: string | null | undefined, seriesClass: string): boolean {
  if (seriesClass.toUpperCase().startsWith("ILCA")) {
    return isIlcaSeriesClass(boatClass, seriesClass as IlcaBoatClass);
  }
  return regattaMatchesSeriesClass({ boatClass }, seriesClass);
}

/** Soonest future sheet that counts for this sailor’s class (and fleet, when ranked). */
export function pickNextCountingEvent(
  events: readonly CountingEventCandidate[],
  opts: {
    today: string;
    seriesClass: string;
    fleet: "Gold" | "Silver" | null;
  }
): NextCountingEvent | null {
  const today = String(opts.today || "").slice(0, 10);
  const matches = events
    .filter((event) => {
      const date = String(event.date || "").slice(0, 10);
      if (!/^\d{4}-\d{2}-\d{2}$/.test(date) || date < today) return false;
      if (
        !regattaCountsForRanking({
          countsForRanking: event.countsForRanking,
          raceCount: event.raceCount,
        })
      ) {
        return false;
      }
      if (!classMatches(event.boatClass, opts.seriesClass)) return false;
      if (opts.seriesClass.toUpperCase().startsWith("ILCA")) return true;
      return divisionMatchesFleet(event.division, opts.fleet);
    })
    .sort((a, b) => String(a.date).slice(0, 10).localeCompare(String(b.date).slice(0, 10)));
  const next = matches[0];
  if (!next) return null;
  return {
    name: next.name,
    date: String(next.date).slice(0, 10),
    href: next.slug ? `/regattas/${next.slug}` : null,
    boatClass: next.boatClass ?? null,
  };
}

function resultsHref(handle: string): string {
  return `/${handle}#results`;
}

function tiedCount(
  rows: { overallScore: number; regattaScores: RegattaScoreSlot[] }[],
  rank: number
): number {
  const ranks = sharedOverallRanks(rows);
  return ranks.filter((value) => value === rank).length;
}

function fromOptimistBoard(input: {
  sailor: SeasonSailorInput;
  periodLabel: string;
  fleet: "Gold" | "Silver";
  board: RankedSailor[];
  me: RankedSailor;
  events: readonly CountingEventCandidate[];
  today: string;
  lastResultDate: string | null;
}): PersonalSeasonView {
  const rank = overallRankOnBoard(input.board, input.sailor.id);
  const slots = decorateSeasonSlots(input.me.regattaScores || [], false);
  const nextCountingEvent = pickNextCountingEvent(input.events, {
    today: input.today,
    seriesClass: "Optimist",
    fleet: input.fleet,
  });
  const tiedWith =
    rank == null ? 1 : Math.max(1, tiedCount(input.board, rank));
  const viewBase = {
    sailorName: input.sailor.name,
    periodLabel: input.periodLabel,
    fleet: input.fleet,
    ilcaClass: null,
    rank,
    fleetSize: input.board.length,
    best3: input.me.overallScore,
    higherIsBetter: false,
    slots,
    nextCountingEvent,
    tiedWith,
  };
  return {
    sailorId: input.sailor.id,
    handle: input.sailor.handle,
    ...viewBase,
    why: explainSeasonPlace(viewBase),
    resultsHref: resultsHref(input.sailor.handle),
    lastResultDate: input.lastResultDate,
  };
}

function fromIlcaBoard(input: {
  sailor: SeasonSailorInput;
  periodLabel: string;
  boatClass: IlcaBoatClass;
  board: IlcaRankedSailor[];
  me: IlcaRankedSailor;
  events: readonly CountingEventCandidate[];
  today: string;
  lastResultDate: string | null;
}): PersonalSeasonView {
  const slots = decorateSeasonSlots(
    input.me.eventScores.map((event) => ({
      regattaId: event.regattaId,
      regattaName: event.regattaName,
      score: event.points,
      isDNS: event.isDns,
      finishPlace: event.place > 0 ? event.place : null,
      regattaDate: event.date,
    })),
    true
  );
  const sameRank = input.board.filter((row) => row.rank === input.me.rank).length;
  const nextCountingEvent = pickNextCountingEvent(input.events, {
    today: input.today,
    seriesClass: input.boatClass,
    fleet: null,
  });
  const viewBase = {
    sailorName: input.sailor.name,
    periodLabel: input.periodLabel,
    fleet: "ILCA" as const,
    ilcaClass: input.boatClass,
    rank: input.me.rank,
    fleetSize: input.board.length,
    best3: input.me.totalPoints,
    higherIsBetter: true,
    slots,
    nextCountingEvent,
    tiedWith: Math.max(1, sameRank),
  };
  return {
    sailorId: input.sailor.id,
    handle: input.sailor.handle,
    ...viewBase,
    why: explainSeasonPlace(viewBase),
    resultsHref: resultsHref(input.sailor.handle),
    lastResultDate: input.lastResultDate,
  };
}

function unrankedFleet(
  sailor: SeasonSailorInput,
  period: Period
): "Dropped" | "Guest" {
  const drop = toYmd(sailor.dropDate);
  const { end } = periodBounds(period);
  if (drop && drop <= end) return "Dropped";
  return "Guest";
}

function nextSeriesClass(
  sailor: SeasonSailorInput,
  fleet: PersonalSeasonFleet
): string {
  const looksIlca = Boolean(
    sailor.ilca4NationalList ||
      sailor.sailNumberIlca4 ||
      sailor.ilca6NationalList
  );
  const hasOptimistEntry = Boolean(sailor.goldEntryDate || sailor.silverEntryDate);
  if (looksIlca && fleet === "Guest" && !hasOptimistEntry) {
    return sailor.ilca6NationalList ? "ILCA 6" : "ILCA 4";
  }
  return "Optimist";
}

export function buildPersonalSeasonView(input: {
  sailor: SeasonSailorInput;
  period: Period;
  goldBoard: RankedSailor[];
  silverBoard: RankedSailor[];
  ilcaBoards: {
    boatClass: IlcaBoatClass;
    ranked: IlcaRankedSailor[];
    label: string;
  }[];
  events: readonly CountingEventCandidate[];
  today: string;
  lastResultDate: string | null;
}): PersonalSeasonView {
  const label = periodLabel(input.period);
  const goldMe = input.goldBoard.find((row) => row.id === input.sailor.id);
  if (goldMe) {
    return fromOptimistBoard({
      sailor: input.sailor,
      periodLabel: label,
      fleet: "Gold",
      board: input.goldBoard,
      me: goldMe,
      events: input.events,
      today: input.today,
      lastResultDate: input.lastResultDate,
    });
  }
  const silverMe = input.silverBoard.find((row) => row.id === input.sailor.id);
  if (silverMe) {
    return fromOptimistBoard({
      sailor: input.sailor,
      periodLabel: label,
      fleet: "Silver",
      board: input.silverBoard,
      me: silverMe,
      events: input.events,
      today: input.today,
      lastResultDate: input.lastResultDate,
    });
  }

  const preferred: IlcaBoatClass[] = [];
  if (input.sailor.ilca6NationalList) preferred.push("ILCA 6");
  if (input.sailor.ilca4NationalList || input.sailor.sailNumberIlca4) {
    preferred.push("ILCA 4");
  }
  if (preferred.length === 0) preferred.push("ILCA 4", "ILCA 6");
  for (const boatClass of preferred) {
    const board = input.ilcaBoards.find((item) => item.boatClass === boatClass);
    const me = board?.ranked.find((row) => row.sailorId === input.sailor.id);
    if (board && me) {
      return fromIlcaBoard({
        sailor: input.sailor,
        periodLabel: board.label || label,
        boatClass,
        board: board.ranked,
        me,
        events: input.events,
        today: input.today,
        lastResultDate: input.lastResultDate,
      });
    }
  }

  const fleet = unrankedFleet(input.sailor, input.period);
  const seriesClass = nextSeriesClass(input.sailor, fleet);
  const slots = decorateSeasonSlots([], false);
  const nextCountingEvent = pickNextCountingEvent(input.events, {
    today: input.today,
    seriesClass,
    fleet: null,
  });
  const viewBase = {
    sailorName: input.sailor.name,
    periodLabel: label,
    fleet,
    ilcaClass: null,
    rank: null,
    fleetSize: null,
    best3: null,
    higherIsBetter: false,
    slots,
    nextCountingEvent,
    tiedWith: 1,
  };
  return {
    sailorId: input.sailor.id,
    handle: input.sailor.handle,
    ...viewBase,
    why: explainSeasonPlace(viewBase),
    resultsHref: resultsHref(input.sailor.handle),
    lastResultDate: input.lastResultDate,
  };
}
