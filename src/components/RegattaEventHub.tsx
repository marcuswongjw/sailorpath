import Link from "next/link";
import { ExternalLink, FileText, MapPin } from "lucide-react";
import { DbOffline } from "@/components/DbOffline";
import { PublicRegattaResults } from "@/components/PublicRegattaResults";
import { RegattaPrizeWinners } from "@/components/RegattaPrizeWinners";
import { DbUnavailableError } from "@/db";
import {
  defaultEventFleetKey,
  eventHubHref,
  getStaticBoardRegatta,
  resolveEventSlices,
  type RegattaEventDef,
  type RegattaEventSliceDef,
  type ResolvedEventSlice,
} from "@/lib/regattaEvents";
import { fillUnlistedPrizeWinners } from "@/lib/prizeWinnersFromResults";
import { getPrizeFleetDefinitions, prizeNameKey, type PrizeWinner } from "@/lib/regattaPrizes";
import { getCachedPublicRegattas, getResultsForRegatta } from "@/lib/queries";
import type { RegattaRecord } from "@/lib/ranking";
import type { Techno293Regatta } from "@/lib/techno293";
import type { WingfoilRegatta } from "@/lib/wingfoil";

type Props = {
  event: RegattaEventDef;
  /** Requested ?fleet= value; falls back to the first slice with data. */
  activeFleet?: string | null;
};

function seriesPageHref(series: RegattaEventSliceDef["series"]): string | null {
  if (series === "wingfoil") return "/sg/wingfoil";
  if (series === "techno293") return "/sg/techno293";
  if (series === "ilca4") return "/sg/ilca4";
  if (series === "optimist") return "/sg/optimist/gold";
  return null;
}

function prizeViewForSlice(event: RegattaEventDef, slice: ResolvedEventSlice) {
  if (slice.regatta) {
    const fromRow = getPrizeFleetDefinitions(
      slice.regatta.slug,
      slice.def.prizeFleetName
    );
    if (fromRow) return fromRow;
  }
  if (!slice.def.prizeFleetName) return null;
  return getPrizeFleetDefinitions(event.slug, slice.def.prizeFleetName);
}

function sliceStatusText(slice: ResolvedEventSlice): string {
  if (slice.regatta) {
    const parts = [`Fleet ${slice.regatta.totalFleetSize}`];
    if (slice.regatta.raceCount != null) {
      parts.push(
        `${slice.regatta.raceCount} race${slice.regatta.raceCount === 1 ? "" : "s"}`
      );
    }
    return parts.join(" · ");
  }
  if (slice.def.slugIncludes?.length) return "Results not published yet";
  const board = getStaticBoardRegatta(slice.def);
  if (board?.results?.length) {
    return `${board.results.length} entries · ${board.format}`;
  }
  return "Results not published yet";
}

function EventLinkChip({
  href,
  label,
}: {
  href: string;
  label: string;
}) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-harbour-shadow)] bg-[var(--sp-warm-white)] px-3 py-1 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)] transition-colors"
    >
      <FileText className="h-3 w-3" aria-hidden />
      {label}
      <ExternalLink className="h-2.5 w-2.5" aria-hidden />
    </a>
  );
}

function profileHandlesForWinners(
  results: { sailorName: string; handle: string; sailNumber?: string | null }[],
  winners: PrizeWinner[]
): Record<string, string> {
  const byName = new Map<string, string>();
  const bySail = new Map<string, string>();
  for (const row of results) {
    if (row.handle) byName.set(prizeNameKey(row.sailorName), row.handle);
    const sail = String(row.sailNumber || "").replace(/\s+/g, "");
    if (sail && row.handle) bySail.set(sail, row.handle);
  }
  const handles: Record<string, string> = {};
  for (const winner of winners) {
    const sail = String(winner.sailNumber || "").replace(/\s+/g, "");
    const handle = byName.get(prizeNameKey(winner.sailorName)) || (sail ? bySail.get(sail) : undefined);
    if (handle) handles[prizeNameKey(winner.sailorName)] = handle;
  }
  return handles;
}

function BoardClassPanel({
  slice,
}: {
  slice: RegattaEventSliceDef;
}) {
  const board = getStaticBoardRegatta(slice) as
    | WingfoilRegatta
    | Techno293Regatta
    | null;
  const classHref = seriesPageHref(slice.series);

  if (!board || !board.results?.length) {
    return (
      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 text-center shadow-xs">
        <p className="text-sm font-semibold text-[var(--sp-charcoal-slate)]">
          No {slice.label} results published yet.
        </p>
      </div>
    );
  }

  return (
    <div className="space-y-3">
      <p className="text-[12px] sm:text-xs text-[var(--sp-charcoal-slate)] leading-relaxed">
        {board.dates} · {board.format} · {board.scoringSystem}
      </p>
      <BoardResultsTable results={board.results} />
      {classHref && (
        <p className="text-[13px] text-[var(--sp-slate-soft)]">
          Full {slice.label} series scorecards live on the{" "}
          <Link
            href={classHref}
            className="font-semibold text-[var(--sp-harbour-teal)] hover:underline"
          >
            {slice.label} page
          </Link>
          .
        </p>
      )}
    </div>
  );
}

type BoardResult = NonNullable<
  (WingfoilRegatta | Techno293Regatta)["results"]
>[number];

function BoardResultsTable({ results }: { results: BoardResult[] }) {
  const raceCount = results.reduce(
    (max, result) => Math.max(max, result.races.length),
    0
  );
  return (
    <div className="overflow-x-auto rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
      <table className="w-full min-w-[720px] text-left text-sm">
        <thead className="bg-[var(--sp-sailcloth)] text-xs uppercase text-[var(--sp-charcoal)] font-bold border-b border-[var(--sp-cool-veil)]">
          <tr>
            <th className="px-3 py-3 text-center">Rank</th>
            <th className="px-3 py-3">Name</th>
            <th className="px-3 py-3 text-center">Sail no.</th>
            <th className="px-3 py-3">School / Club</th>
            {Array.from({ length: raceCount }, (_, index) => (
              <th key={index} className="px-2 py-3 text-center">
                R{index + 1}
              </th>
            ))}
            <th className="px-3 py-3 text-center font-black text-[var(--sp-harbour-teal)]">
              Nett
            </th>
          </tr>
        </thead>
        <tbody>
          {results.map((result) => (
            <tr
              key={`${result.rank}-${result.sailNumber}-${result.name}`}
              className="border-t border-[var(--sp-cool-veil)] hover:bg-[var(--sp-sailcloth)]/50 transition-colors"
            >
              <td className="px-3 py-3 text-center font-black tabular-nums text-[var(--sp-harbour-teal)]">
                {result.rank}
              </td>
              <td className="px-3 py-3 font-bold text-[var(--sp-harbour-shadow)]">
                {result.name}
              </td>
              <td className="px-3 py-3 text-center font-mono text-[var(--sp-charcoal-slate)]">
                {result.sailNumber}
              </td>
              <td className="px-3 py-3 text-[var(--sp-charcoal-slate)]">
                {result.schoolName || result.club || "—"}
              </td>
              {Array.from({ length: raceCount }, (_, index) => {
                const race = result.races[index];
                return (
                  <td
                    key={index}
                    className={`px-2 py-3 text-center font-mono text-xs font-semibold tabular-nums ${
                      !race
                        ? "text-[var(--sp-charcoal-slate)]"
                        : race.isDiscarded
                          ? "text-[var(--sp-charcoal)] line-through"
                          : race.code
                            ? "text-[var(--sp-racing-deep)]"
                            : "text-[var(--sp-charcoal)]"
                    }`}
                    title={race?.isDiscarded ? "Discarded score" : race?.code}
                  >
                    {race ? race.code || race.score : "—"}
                  </td>
                );
              })}
              <td className="px-3 py-3 text-center font-mono font-bold tabular-nums text-[var(--sp-harbour-shadow)]">
                {result.nettScore}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

async function DbSlicePanel({
  regatta,
  def,
  prizeView,
}: {
  regatta: RegattaRecord;
  def: RegattaEventSliceDef;
  prizeView: ReturnType<typeof prizeViewForSlice>;
}) {
  let results;
  try {
    results = await getResultsForRegatta(regatta.id);
  } catch (error) {
    const message =
      error instanceof DbUnavailableError ? error.message : "DB error";
    return <DbOffline message={message} />;
  }
  const accent = def.series === "ilca4" ? "sky" : "orange";
  const eventYear = Number(String(regatta.date || "").slice(0, 4));
  const fleets = prizeView
    ? fillUnlistedPrizeWinners(prizeView.fleets, results, eventYear)
    : [];
  const winners = fleets.flatMap((fleet) =>
    fleet.categories.flatMap((category) => category.winners)
  );
  const profileHandles = profileHandlesForWinners(results, winners);
  return (
    <div className="space-y-3">
      {prizeView && fleets.length > 0 && (
        <RegattaPrizeWinners
          schedule={{ ...prizeView.schedule, fleets }}
          profileHandles={profileHandles}
        />
      )}
      <p className="text-[12px] sm:text-xs text-[var(--sp-charcoal)] leading-relaxed">
        {String(regatta.date)}
        {regatta.endDate ? ` – ${String(regatta.endDate)}` : ""}
        {" · "}
        {def.label}
        {regatta.countsForRanking === false ? " · non-ranking" : ""}
      </p>
      {results.length === 0 ? (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 text-center shadow-xs">
          <p className="text-sm font-semibold text-[var(--sp-charcoal-slate)]">
            No {def.label} results published yet.
          </p>
        </div>
      ) : (
        <PublicRegattaResults
          results={results}
          totalFleetSize={regatta.totalFleetSize}
          raceCount={regatta.raceCount}
          accent={accent}
        />
      )}
      <p className="text-[13px] text-[var(--sp-charcoal)]">
        Source: published regatta results reviewed before import · Parentheses
        indicate a discarded race score · * DNS · † Overseas commitment
      </p>
    </div>
  );
}

/**
 * Public event hub: one page per physical regatta with a tab per
 * class/division slice (pilot: SNSC 2026).
 */
export async function RegattaEventHub({ event, activeFleet }: Props) {
  let slices: ResolvedEventSlice[];
  try {
    const allRegattas = await getCachedPublicRegattas();
    slices = resolveEventSlices(event, allRegattas);
  } catch (error) {
    const message =
      error instanceof DbUnavailableError ? error.message : "DB error";
    return <DbOffline message={message} />;
  }

  const activeKey =
    activeFleet && event.slices.some((s) => s.key === activeFleet)
      ? activeFleet
      : defaultEventFleetKey(event, slices);
  const active = slices.find((s) => s.def.key === activeKey) ?? slices[0];
  if (!active) return null;
  const prizeView = prizeViewForSlice(event, active);

  return (
    <div className="mx-auto w-full min-w-0 max-w-7xl space-y-5 px-3 py-8 sm:space-y-6 sm:px-4 sm:py-10">
      <nav
        aria-label="Breadcrumb"
        className="flex flex-wrap items-center gap-x-2 gap-y-1 text-[11px] sm:text-xs font-bold"
      >
        <Link
          href="/calendar"
          className="text-[var(--sp-harbour-teal)] hover:underline"
        >
          Calendar
        </Link>
        <span className="text-[var(--sp-slate-soft)]" aria-hidden>
          /
        </span>
        <span className="text-[var(--sp-charcoal)] truncate max-w-[12rem] sm:max-w-xs font-medium">
          {event.shortName}
        </span>
      </nav>

      <header className="min-w-0 space-y-2">
        <div className="flex flex-wrap items-center gap-2">
          {event.officialNoticeBoardUrl && (
            <EventLinkChip
              href={event.officialNoticeBoardUrl}
              label="Official Notice Board"
            />
          )}
          {event.noticeOfRaceUrl &&
            event.noticeOfRaceUrl !== event.officialNoticeBoardUrl && (
              <EventLinkChip href={event.noticeOfRaceUrl} label="Notice of Race" />
            )}
        </div>
        <h1 className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] leading-snug break-words tracking-tight">
          {event.name}
        </h1>
        <p className="text-[12px] sm:text-xs text-[var(--sp-charcoal-slate)] leading-relaxed">
          {event.datesText}
          {" · "}
          <span className="inline-flex items-center gap-1">
            <MapPin className="h-3 w-3 text-[var(--sp-harbour-teal)]" aria-hidden />
            {event.venue}
          </span>
          {" · "}
          {event.organizer}
        </p>
        {event.scheduleSummary && (
          <p className="text-[12px] sm:text-xs text-[var(--sp-charcoal)] leading-relaxed max-w-3xl">
            {event.scheduleSummary}
          </p>
        )}
        {event.scoringRules && (
          <p className="text-[12px] sm:text-xs text-[var(--sp-charcoal)] leading-relaxed max-w-3xl">
            Scoring: {event.scoringRules}
          </p>
        )}
      </header>

      <nav
        aria-label="Classes at this event"
        className="flex flex-wrap gap-0 border-b border-[var(--sp-cool-veil)]"
        role="tablist"
      >
        {slices.map((slice) => {
          const isActive = slice.def.key === active.def.key;
          return (
            <Link
              key={slice.def.key}
              href={eventHubHref(event.slug, slice.def.key)}
              role="tab"
              aria-current={isActive ? "page" : undefined}
              aria-selected={isActive}
              className={`
                relative px-4 py-2.5 transition-colors mr-1 last:mr-0
                border-b-2 -mb-px
                focus-visible:outline-2 focus-visible:outline-[#2D6A6F] focus-visible:rounded
                ${isActive
                  ? "border-b-[#2D6A6F] text-[#2D6A6F]"
                  : "border-b-transparent text-[var(--sp-charcoal)] hover:text-[#2D6A6F] hover:bg-[var(--sp-sailcloth)]"
                }
              `}
            >
              <span className={`block text-[13px] leading-tight ${isActive ? "font-black" : "font-semibold"}`}>
                {slice.def.label}
              </span>
              <span className={`block text-[10px] font-semibold leading-tight mt-0.5 ${isActive ? "text-[#2D6A6F]/80" : "text-[var(--sp-charcoal)]"}`}>
                {sliceStatusText(slice)}
              </span>
            </Link>
          );
        })}
      </nav>

      {!active.regatta && prizeView && (
        <RegattaPrizeWinners
          schedule={{ ...prizeView.schedule, fleets: prizeView.fleets }}
        />
      )}

      {active.regatta ? (
        <DbSlicePanel regatta={active.regatta} def={active.def} prizeView={prizeView} />
      ) : (
        <BoardClassPanel slice={active.def} />
      )}
    </div>
  );
}
