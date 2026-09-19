"use client";

import { useEffect, useMemo, useState } from "react";
import {
  type SailorRecord,
  type RegattaRecord,
  type RegattaResultRecord,
} from "@/lib/ranking";
import {
  ASIAN_OCEANIA_2026,
  PERTH_CAMP_2026,
  computeCombinedSelectionScores,
  getSelectionDataStatus,
  matchSelectionEvents,
  selectAsianOceaniaTeam,
  selectPerthCamp,
} from "@/lib/optimistEventSelection";
import {
  findGoldParticipationDrops,
  GOLD_MIN_RANKING_REGATTAS_PER_HALF,
  type GoldDropCandidate,
} from "@/lib/goldFleetDrop";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { Plane, Tent, Loader2, Trophy } from "lucide-react";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { fetchAdminResultsForRegatta } from "@/components/admin/adminFetch";

type Props = {
  sailors: SailorAdmin[];
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
  onSailorsChange?: (sailors: SailorAdmin[]) => void;
};

function toSailorRecords(rows: SailorAdmin[]): SailorRecord[] {
  return rows.map((s) => ({
    id: s.id,
    name: s.name,
    handle: s.handle,
    sailNumber: s.sailNumber,
    sailNumberIlca4: s.sailNumberIlca4,
    club: s.club,
    school: s.school,
    nationality: s.nationality,
    avatarUrl: s.avatarUrl,
    goldEntryDate: s.goldEntryDate
      ? String(s.goldEntryDate).slice(0, 10)
      : null,
    silverEntryDate: s.silverEntryDate
      ? String(s.silverEntryDate).slice(0, 10)
      : null,
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
}

function toRegattaRecords(rows: RegattaAdmin[]): RegattaRecord[] {
  return rows.map((r) => ({
    id: r.id,
    name: r.name,
    slug: r.slug,
    date: String(r.date).slice(0, 10),
    totalFleetSize: r.totalFleetSize,
    division: r.division ?? undefined,
    raceCount: r.raceCount ?? undefined,
    geography: r.geography ?? "SGP",
    boatClass: r.boatClass ?? "Optimist",
    countsForRanking: r.countsForRanking !== false,
  }));
}

function toResultRecords(rows: ResultAdmin[]): RegattaResultRecord[] {
  return rows.map((r) => ({
    sailorId: r.sailorId,
    regattaId: r.regattaId,
    rank: r.rank,
    nettScore: r.nettScore,
    totalScore: r.totalScore,
    isDns: Boolean(r.isDns || r.isDNS),
    isOverseasCommitment: Boolean(r.isOverseasCommitment),
    raceResults: r.raceResults,
  }));
}

export function AdminSelectionPanel({
  sailors,
  regattas,
  results,
  onSailorsChange,
}: Props) {
  const { confirm } = useFeedback();

  const [dropBusy, setDropBusy] = useState(false);
  const [dropMsg, setDropMsg] = useState<string | null>(null);
  const [dropReviewOpen, setDropReviewOpen] = useState(false);
  const [selectedDropIds, setSelectedDropIds] = useState<Set<string>>(
    new Set()
  );
  const [selectionResults, setSelectionResults] = useState<ResultAdmin[] | null>(null);
  const [selectionLoadError, setSelectionLoadError] = useState<string | null>(null);

  const sailorRecs = useMemo(() => toSailorRecords(sailors), [sailors]);
  const regattaRecs = useMemo(() => toRegattaRecords(regattas), [regattas]);
  const resultRecs = useMemo(() => toResultRecords(results), [results]);

  const asOfYmd = useMemo(
    () =>
      new Date().toLocaleDateString("en-CA", { timeZone: "Asia/Singapore" }),
    []
  );

  const participationDrops = useMemo(
    (): GoldDropCandidate[] =>
      findGoldParticipationDrops(
        sailorRecs,
        regattaRecs,
        resultRecs,
        asOfYmd
      ),
    [sailorRecs, regattaRecs, resultRecs, asOfYmd]
  );

  const openDropReview = () => {
    setSelectedDropIds(new Set(participationDrops.map((d) => d.sailorId)));
    setDropReviewOpen(true);
    setDropMsg(null);
  };

  const applyParticipationDrops = async (ids?: string[]) => {
    const targetIds =
      ids && ids.length > 0
        ? ids
        : [...selectedDropIds];
    if (targetIds.length === 0) {
      setDropMsg("Select at least one sailor to drop.");
      return;
    }
    const selected = participationDrops.filter((d) =>
      targetIds.includes(d.sailorId)
    );
    if (selected.length === 0) {
      setDropMsg("No matching drop candidates selected.");
      return;
    }
    const ok = await confirm({
      title: `Set gold drop date for ${selected.length} sailor(s)?`,
      message:
        "Only completed halves are evaluated (current half is excluded).\nThis cannot be undone from this panel.",
      confirmLabel: "Set drop date",
      tone: "danger",
    });
    if (!ok) return;
    setDropBusy(true);
    setDropMsg(null);
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "applyGoldParticipationDrops",
          asOf: asOfYmd,
          sailorIds: selected.map((d) => d.sailorId),
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Drop failed");
      setDropMsg(data.message || `Updated ${data.updated}`);
      setDropReviewOpen(false);
      setSelectedDropIds(new Set());
      if (onSailorsChange) {
        const listRes = await fetch("/api/admin/sailors?all=1", {
          credentials: "include",
        });
        const listData = await listRes.json();
        if (listRes.ok && listData.sailors) {
          onSailorsChange(listData.sailors);
        }
      }
    } catch (e) {
      setDropMsg(e instanceof Error ? e.message : "Drop failed");
    } finally {
      setDropBusy(false);
    }
  };

  // ── Asian + Perth selection (same events) ──────────────
  const selectionMatched = useMemo(
    () => matchSelectionEvents(regattaRecs, ASIAN_OCEANIA_2026.events),
    [regattaRecs]
  );
  const matchedRegattaKey = useMemo(
    () =>
      selectionMatched
        .map((match) => match.regatta?.id)
        .filter(Boolean)
        .join(","),
    [selectionMatched]
  );

  useEffect(() => {
    const ids = matchedRegattaKey ? matchedRegattaKey.split(",") : [];
    let cancelled = false;
    if (!ids.length) return;
    void Promise.all(ids.map((id) => fetchAdminResultsForRegatta(id, true)))
      .then((groups) => {
        if (!cancelled) setSelectionResults(groups.flat());
      })
      .catch((error: unknown) => {
        if (!cancelled) {
          setSelectionResults([]);
          setSelectionLoadError(
            error instanceof Error ? error.message : "Could not load published race scores."
          );
        }
      });
    return () => {
      cancelled = true;
    };
  }, [matchedRegattaKey]);

  const selectionResultRecs = useMemo(
    () => toResultRecords(selectionResults || []),
    [selectionResults]
  );
  const selectionLoading = Boolean(matchedRegattaKey) && selectionResults === null && !selectionLoadError;
  const selectionStatus = useMemo(
    () => getSelectionDataStatus(selectionMatched, selectionResultRecs),
    [selectionMatched, selectionResultRecs]
  );
  const combinedScores = useMemo(
    () =>
      computeCombinedSelectionScores(
        selectionMatched,
        sailorRecs,
        selectionResultRecs
      ),
    [selectionMatched, sailorRecs, selectionResultRecs]
  );
  const asianTeam = useMemo(
    () => selectAsianOceaniaTeam(combinedScores),
    [combinedScores]
  );
  const perth = useMemo(
    () => selectPerthCamp(combinedScores),
    [combinedScores]
  );

  return (
    <div className="w-full min-w-0 space-y-4 sm:space-y-6 overflow-x-clip">
      {/* ── Header ───────────────────────────────────────────── */}
      <div className="rounded-2xl sm:rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm p-4 sm:p-5 lg:p-6 space-y-3">
        <div className="flex items-start gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-violet-500/10">
            <Trophy className="h-5 w-5 text-violet-600" />
          </div>
          <div className="min-w-0 flex-1">
            <h2 className="text-base font-bold text-[var(--sp-charcoal)]">
              Optimist selection · campaigns
            </h2>
            <p className="text-[12px] text-[var(--sp-slate)] mt-1 max-w-3xl leading-relaxed">
              Asian Oceania and Perth Camp teams from shared 2026 selection
              events. The shortlist now combines every Gold Fleet race, then
              applies the policy discard table and Appendix A8 tie-breaks.
            </p>
            <p className="text-[11px] text-[var(--sp-muted)] mt-1 max-w-3xl">
              Participation rule: gold sailors need ≥
              {GOLD_MIN_RANKING_REGATTAS_PER_HALF} ranking gold regattas in each
              completed half (Jan–Jun / Jul–Dec) or they are dropped at the next
              half boundary.
            </p>
          </div>
        </div>

        {participationDrops.length > 0 && (
          <div className="rounded-xl border border-rose-200 bg-rose-50 px-4 py-3 space-y-3">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div className="min-w-0">
                <p className="text-xs font-semibold text-rose-800">
                  {participationDrops.length} gold sailor
                  {participationDrops.length === 1 ? "" : "s"} flagged for
                  participation drop
                </p>
                <p className="text-[11px] text-rose-700 mt-0.5">
                  Only completed halves are checked — the current half is
                  excluded until all ranking regattas have finished. Review
                  before applying.
                </p>
              </div>
              <button
                type="button"
                onClick={() => openDropReview()}
                className="inline-flex items-center gap-1.5 rounded-full border border-rose-300 bg-rose-100 px-3 py-1.5 text-[10px] font-bold text-rose-800 hover:bg-rose-200"
              >
                Review {participationDrops.length} sailor
                {participationDrops.length === 1 ? "" : "s"}
              </button>
            </div>
            {dropReviewOpen && (
              <div className="rounded-lg border border-[var(--sp-cool-veil)] bg-white overflow-hidden shadow-sm">
                <div className="px-3 py-2 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 flex flex-wrap items-center justify-between gap-2">
                  <label className="text-[11px] text-[var(--sp-charcoal)] flex items-center gap-2 font-medium">
                    <input
                      type="checkbox"
                      checked={
                        participationDrops.length > 0 &&
                        selectedDropIds.size === participationDrops.length
                      }
                      onChange={(e) => {
                        if (e.target.checked) {
                          setSelectedDropIds(
                            new Set(participationDrops.map((d) => d.sailorId))
                          );
                        } else {
                          setSelectedDropIds(new Set());
                        }
                      }}
                    />
                    Select all ({selectedDropIds.size}/
                    {participationDrops.length})
                  </label>
                  <div className="flex gap-2">
                    <button
                      type="button"
                      onClick={() => setDropReviewOpen(false)}
                      className="text-[10px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)]"
                    >
                      Close
                    </button>
                    <button
                      type="button"
                      disabled={dropBusy || selectedDropIds.size === 0}
                      onClick={() => void applyParticipationDrops()}
                      className="inline-flex items-center gap-1.5 rounded-full border border-rose-300 bg-rose-600 px-3 py-1.5 text-[10px] font-bold text-white hover:bg-rose-700 disabled:opacity-50"
                    >
                      {dropBusy ? (
                        <Loader2 className="h-3 w-3 animate-spin" />
                      ) : null}
                      Drop selected ({selectedDropIds.size})
                    </button>
                  </div>
                </div>
                <div className="max-h-64 overflow-y-auto overflow-x-auto">
                  <table className="w-full text-left text-[11px] min-w-[520px]">
                    <thead className="sticky top-0 bg-[var(--sp-sailcloth)] text-[var(--sp-slate)] uppercase tracking-wide text-[9px] border-b border-[var(--sp-cool-veil)]">
                      <tr>
                        <th className="px-3 py-2 w-8" />
                        <th className="px-3 py-2">Sailor</th>
                        <th className="px-3 py-2">Gold since</th>
                        <th className="px-3 py-2">Failed half</th>
                        <th className="px-3 py-2">Raced</th>
                        <th className="px-3 py-2">Drop date</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                      {participationDrops.map((d) => (
                        <tr key={d.sailorId} className="text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]/30">
                          <td className="px-3 py-2">
                            <input
                              type="checkbox"
                              checked={selectedDropIds.has(d.sailorId)}
                              onChange={(e) => {
                                setSelectedDropIds((prev) => {
                                  const next = new Set(prev);
                                  if (e.target.checked) next.add(d.sailorId);
                                  else next.delete(d.sailorId);
                                  return next;
                                });
                              }}
                            />
                          </td>
                          <td className="px-3 py-2 font-semibold text-[var(--sp-charcoal)]">
                            {d.name}
                          </td>
                          <td className="px-3 py-2 tabular-nums text-[var(--sp-slate)]">
                            {d.goldEntryDate}
                          </td>
                          <td className="px-3 py-2 text-[var(--sp-slate)]">
                            {d.failedPeriod.half} {d.failedPeriod.year}
                          </td>
                          <td className="px-3 py-2 tabular-nums text-[var(--sp-slate)]">
                            {d.participationCount} /{" "}
                            {GOLD_MIN_RANKING_REGATTAS_PER_HALF}
                          </td>
                          <td className="px-3 py-2 tabular-nums text-rose-700 font-semibold">
                            {d.dropDate}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}
          </div>
        )}
        {dropMsg && (
          <p className="text-[11px] text-emerald-700 font-medium">{dropMsg}</p>
        )}
      </div>

      {/* ── Selection event match status ─────────────────────── */}
      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm p-4 space-y-2">
        <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
          2026 selection events (shared by Asian Champs &amp; Perth Camp)
        </h3>
        <p className="text-[11px] text-[var(--sp-slate)]">
          Every non-medal race is combined. An absent sailor receives fleet
          size + 1 for each race in that event. Current combined series: {selectionStatus.usableRaceCount}{" "}
          races, {selectionStatus.discardCount} discard{selectionStatus.discardCount === 1 ? "" : "s"}.
        </p>
        {selectionLoading && (
          <p className="text-[11px] text-sky-700 inline-flex items-center gap-1.5">
            <Loader2 className="h-3 w-3 animate-spin" /> Loading published race scores…
          </p>
        )}
        {selectionLoadError && (
          <p className="text-[11px] text-rose-600">Race score load failed: {selectionLoadError}</p>
        )}
        {!selectionLoading && selectionStatus.warnings.length > 0 && (
          <div className="rounded-lg border border-amber-200 bg-amber-50 px-3 py-2 text-[11px] text-amber-800">
            <span className="font-bold">Provisional / incomplete:</span>{" "}
            {selectionStatus.warnings.join(" ")}
          </div>
        )}
        <ul className="space-y-1.5">
          {selectionMatched.map((m) => (
            <li
              key={m.def.id}
              className="flex flex-wrap items-center gap-2 text-xs"
            >
              <span
                className={`rounded-full px-2 py-0.5 text-[10px] font-bold border ${
                  m.matched
                    ? "bg-emerald-50 border-emerald-200 text-emerald-800"
                    : "bg-rose-50 border-rose-200 text-rose-800"
                }`}
              >
                {m.matched ? "Matched" : "Not found"}
              </span>
              <span className="text-[var(--sp-charcoal)] font-semibold">
                {m.def.label}
              </span>
              <span className="text-[var(--sp-muted)]">
                {m.def.dateFrom} → {m.def.dateTo}
              </span>
              {m.regatta && (
                <span className="text-[var(--sp-slate)]">
                  → {m.regatta.name} ({m.regatta.date})
                </span>
              )}
            </li>
          ))}
        </ul>
      </div>

      <div className="rounded-2xl border border-sky-200 bg-sky-50 p-4 text-[11px] text-sky-900 leading-relaxed">
        <span className="font-bold text-sky-950">Policy checks before confirmation:</span>{" "}
        this is a computational shortlist, not a final selection. The panel must
        verify Singapore citizenship, affiliated-club membership, regular 12–16
        weekly water hours, at least two weekly fitness sessions, athlete-agreement
        readiness, financial standing, fitness, attendance, attitude and coach input.
        The selection committee may alter team size, cancel selection or decline to select.
      </div>

      {/* ── Asian Oceania + Perth ────────────────────────────── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 flex items-start gap-2">
            <Plane className="h-4 w-4 text-violet-600 mt-0.5 shrink-0" />
            <div>
              <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                {ASIAN_OCEANIA_2026.title}
              </h3>
              <p className="text-[11px] text-[var(--sp-slate)] mt-0.5">
                {ASIAN_OCEANIA_2026.subtitle}
              </p>
              <p className="text-[10px] text-[var(--sp-muted)] mt-1">
                {ASIAN_OCEANIA_2026.notes}
              </p>
              <p className="text-[10px] text-violet-700 mt-1 font-medium">
                {ASIAN_OCEANIA_2026.funding}
              </p>
            </div>
          </div>
          <p className="px-4 py-2 text-[11px] text-violet-800 bg-violet-50/50 border-b border-[var(--sp-cool-veil)]">
            {asianTeam.reason}
          </p>
          {asianTeam.selected.length === 0 ? (
            <p className="p-4 text-xs text-[var(--sp-muted)]">
              Import Gold results for SSF Selection Trials (22–30 Aug 2026) and
              SNSC (11–13 Sep 2026) to populate.
            </p>
          ) : (
            <ol className="divide-y divide-[var(--sp-cool-veil)] max-h-[22rem] overflow-y-auto">
              {asianTeam.selected.map((s) => (
                <li
                  key={s.sailorId}
                  className="px-4 py-2 text-xs flex justify-between gap-2 hover:bg-[var(--sp-sailcloth)]/30"
                >
                  <span>
                    <span className="text-[var(--sp-muted)] tabular-nums mr-2">
                      #{s.teamRank}
                    </span>
                    <span className="font-semibold text-[var(--sp-charcoal)]">{s.name}</span>
                    <span className="block text-[10px] text-[var(--sp-slate)] mt-0.5">
                      {s.gender || "?"} · BY {s.birthYear ?? "—"} · net{" "}
                      {s.combinedScore} (gross {s.grossScore}; {s.discardCount}{" "}
                      discard{s.discardCount === 1 ? "" : "s"})
                      {s.eventScores
                        .map(
                          (e) =>
                            ` · ${e.missingEvent ? "miss" : e.grossScore}`
                        )
                        .join("")}
                    </span>
                  </span>
                </li>
              ))}
            </ol>
          )}
          {asianTeam.reserves.length > 0 && (
            <div className="border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/30 px-4 py-2 text-[10px] text-[var(--sp-slate)]">
              Additional-entry order: {asianTeam.reserves.slice(0, 5).map((s) => `${s.name} (${s.combinedScore})`).join(" · ")}
            </div>
          )}
        </div>

        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 flex items-start gap-2">
            <Tent className="h-4 w-4 text-emerald-600 mt-0.5 shrink-0" />
            <div>
              <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                {PERTH_CAMP_2026.title}
              </h3>
              <p className="text-[11px] text-[var(--sp-slate)] mt-0.5">
                {PERTH_CAMP_2026.subtitle}
              </p>
              <p className="text-[10px] text-[var(--sp-muted)] mt-1">
                {PERTH_CAMP_2026.notes}
              </p>
              <p className="text-[10px] text-emerald-700 mt-1 font-medium">
                {PERTH_CAMP_2026.funding}
              </p>
            </div>
          </div>
          {perth.notes.length > 0 && (
            <p className="px-4 py-2 text-[11px] text-amber-800 bg-amber-50/50 border-b border-[var(--sp-cool-veil)]">
              {perth.notes.join(" · ")}
            </p>
          )}
          {perth.picks.length === 0 ? (
            <p className="p-4 text-xs text-[var(--sp-muted)]">
              No birth-year matches yet. Need selection-event results and DOBs
              for 2013 / 2014 / 2015.
            </p>
          ) : (
            <ul className="divide-y divide-[var(--sp-cool-veil)] max-h-[22rem] overflow-y-auto">
              {(["by2013", "by2014", "by2015"] as const).map((bucket) => {
                const group = perth.picks.filter((p) => p.bucket === bucket);
                if (!group.length) return null;
                return (
                  <li key={bucket} className="px-4 py-2">
                    <p className="text-[10px] font-bold uppercase tracking-wider text-emerald-800 mb-1.5">
                      {group[0]?.bucketLabel}
                    </p>
                    <ul className="space-y-1">
                      {group.map((p) => (
                        <li
                          key={p.sailorId}
                          className="text-xs flex justify-between gap-2"
                        >
                          <span>
                            <span className="font-semibold text-[var(--sp-charcoal)]">
                              {p.name}
                            </span>
                            <span className="text-[var(--sp-slate)] ml-1.5">
                              {p.slot} · net {p.combinedScore} (gross {p.grossScore})
                            </span>
                          </span>
                        </li>
                      ))}
                    </ul>
                  </li>
                );
              })}
            </ul>
          )}
        </div>
      </div>

      {/* Full combined leaderboard for transparency */}
      {combinedScores.length > 0 && (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50">
            <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
              Selection events · combined race-score leaderboard
            </h3>
          </div>
          <div className="overflow-x-auto max-h-64 overflow-y-auto">
            <table className="w-full text-left text-xs">
              <thead className="sticky top-0 bg-[var(--sp-sailcloth)] text-[var(--sp-slate)] border-b border-[var(--sp-cool-veil)]">
                <tr className="text-[10px] uppercase">
                  <th className="px-3 py-2">#</th>
                  <th className="px-3 py-2">Sailor</th>
                  <th className="px-3 py-2">G</th>
                  <th className="px-3 py-2">BY</th>
                  {selectionMatched.map((m) => (
                    <th key={m.def.id} className="px-3 py-2">
                      {m.def.label.slice(0, 12)}…
                    </th>
                  ))}
                  <th className="px-3 py-2">Net</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                {combinedScores.slice(0, 40).map((s, i) => (
                  <tr key={s.sailorId} className="text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]/30">
                    <td className="px-3 py-1.5 tabular-nums text-[var(--sp-muted)]">
                      {i + 1}
                    </td>
                    <td className="px-3 py-1.5 font-semibold text-[var(--sp-charcoal)]">
                      {s.name}
                    </td>
                    <td className="px-3 py-1.5 text-[var(--sp-slate)]">{s.gender || "—"}</td>
                    <td className="px-3 py-1.5 tabular-nums text-[var(--sp-slate)]">
                      {s.birthYear ?? "—"}
                    </td>
                    {s.eventScores.map((e) => (
                      <td
                        key={e.regattaId}
                        className="px-3 py-1.5 tabular-nums text-[var(--sp-slate)]"
                      >
                        {e.missingEvent ? `Miss (${e.grossScore})` : e.grossScore}
                      </td>
                    ))}
                    <td className="px-3 py-1.5 tabular-nums font-bold text-[var(--sp-charcoal)]">
                      {s.combinedScore}
                      <span className="block text-[9px] font-normal text-[var(--sp-slate)]">
                        gross {s.grossScore} · {s.discardCount} discard{s.discardCount === 1 ? "" : "s"}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
