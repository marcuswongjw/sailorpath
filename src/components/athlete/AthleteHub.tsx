"use client";

import { profilePhotoUrl } from "@/lib/profilePhoto";
import { sailingClassDisplayLabel } from "@/lib/classPresentation";
import { qualifyingParticipation } from "@/lib/qualifyingParticipation";

import { useState, useEffect, useCallback, useMemo } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Trophy,
  User,
  FileText,
  ExternalLink,
  Plus,
  Edit2,
  Trash2,
  ShieldCheck,
  AlertCircle,
  Users,
  ImageIcon,
  Loader2,
  Clock,
  BookOpen,
  Pencil,
} from "lucide-react";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import {
  RegattaEvidenceModal,
  type RegattaResultItem,
} from "./RegattaEvidenceModal";
import {
  RegattaReflectionModal,
  type LogbookReflection,
} from "./RegattaReflectionModal";
import { EquipmentInventory } from "@/components/equipment/EquipmentInventory";

export type AthleteProfile = {
  id: string;
  name: string;
  handle: string;
  sailNumber?: string | null;
  sailNumberIlca4?: string | null;
  boardNumber?: string | null;
  club?: string | null;
  school?: string | null;
  gender?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  currentFleet?: string | null;
  ownerRelation?: string | null;
  nationalSquadStatus?: string | null;
  dob?: string | Date | null;
  bio?: string | null;
  instagram?: string | null;
  hullBrand?: string | null;
  sailMake?: string | null;
  foilBrand?: string | null;
  mast?: string | null;
  equipmentNotes?: string | null;
};

type WorkspaceTab = "results" | "profile" | "equipment" | "documents";

interface AthleteWorkspaceProps {
  athlete: AthleteProfile;
  initialTab?: WorkspaceTab;
  initialAction?: string;
  onTabChange?: (tab: WorkspaceTab) => void;
}

function AthleteWorkspace({
  athlete: initialAthlete,
  initialTab = "results",
  initialAction,
  onTabChange,
}: AthleteWorkspaceProps) {
  const router = useRouter();
  const { toast, confirm } = useFeedback();

  const [athlete, setAthlete] = useState<AthleteProfile>(initialAthlete);
  const [activeTab, setActiveTab] = useState<WorkspaceTab>(initialTab);

  const changeTab = (tab: WorkspaceTab) => {
    setActiveTab(tab);
    onTabChange?.(tab);
    const url = new URL(window.location.href);
    url.searchParams.set("tab", tab);
    window.history.replaceState(null, "", url.toString());
  };

  // Evidence / result modal state
  const [evidenceModalOpen, setEvidenceModalOpen] = useState(
    initialAction === "new"
  );
  const [editingResult, setEditingResult] = useState<RegattaResultItem | null>(
    null
  );

  // Reflection modal state
  const [reflectionTarget, setReflectionTarget] = useState<{
    regattaId: string;
    regattaName: string;
  } | null>(null);

  // Results & reflections state
  const [results, setResults] = useState<RegattaResultItem[]>([]);
  const [reflections, setReflections] = useState<LogbookReflection[]>([]);
  const [loadingResults, setLoadingResults] = useState(true);
  const [resultFilter, setResultFilter] = useState<
    "all" | "verified" | "under_review" | "self" | "rejected"
  >("all");
  const [removingAvatar, setRemovingAvatar] = useState(false);

  const fetchResults = useCallback(async () => {
    setLoadingResults(true);
    try {
      const [resRes, obsRes] = await Promise.all([
        fetch(`/api/account/results?sailorId=${athlete.id}`),
        fetch(`/api/account/observations?sailorId=${athlete.id}`),
      ]);
      const data = await resRes.json();
      if (!resRes.ok) throw new Error(data.error || "Failed to load results");
      setResults(data.results || []);

      if (obsRes.ok) {
        const obsData = await obsRes.json().catch(() => ({}));
        setReflections(Array.isArray(obsData.observations) ? obsData.observations : []);
      }
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Error fetching results");
    } finally {
      setLoadingResults(false);
    }
  }, [athlete.id, toast]);

  useEffect(() => {
    let ignore = false;
    async function load() {
      setLoadingResults(true);
      try {
        const [resRes, obsRes] = await Promise.all([
          fetch(`/api/account/results?sailorId=${athlete.id}`),
          fetch(`/api/account/observations?sailorId=${athlete.id}`),
        ]);
        const data = await resRes.json();
        if (!ignore) {
          if (!resRes.ok) throw new Error(data.error || "Failed to load results");
          setResults(data.results || []);
          if (obsRes.ok) {
            const obsData = await obsRes.json().catch(() => ({}));
            if (!ignore) {
              setReflections(
                Array.isArray(obsData.observations) ? obsData.observations : []
              );
            }
          }
        }
      } catch (err) {
        if (!ignore) {
          toast.error(err instanceof Error ? err.message : "Error fetching results");
        }
      } finally {
        if (!ignore) {
          setLoadingResults(false);
        }
      }
    }
    void load();
    return () => {
      ignore = true;
    };
  }, [athlete.id, toast]);

  const handleRemovePhoto = async () => {
    const ok = await confirm({
      title: "Remove profile photo",
      message: "Your profile photo is public. Removing it deletes the image from your profile.",
      confirmLabel: "Remove photo",
      tone: "danger",
    });
    if (!ok) return;

    setRemovingAvatar(true);
    try {
      const res = await fetch("/api/account/sailor", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorId: athlete.id,
          avatarUrl: null,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to remove photo");
      setAthlete((prev) => ({ ...prev, avatarUrl: null }));
      toast.success("Profile photo removed.");
      router.refresh();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Failed to remove photo");
    } finally {
      setRemovingAvatar(false);
    }
  };

  const handleDeleteResult = async (resultId: string, eventName: string) => {
    const ok = await confirm({
      title: "Delete Regatta Result",
      message: `Are you sure you want to remove ${eventName} from your athlete logbook?`,
      confirmLabel: "Delete Result",
      tone: "danger",
    });
    if (!ok) return;

    try {
      const res = await fetch("/api/account/results", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ resultId }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to delete result");
      toast.success("Result removed from logbook.");
      void fetchResults();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Delete failed");
    }
  };

  const isResultVerified = (r: RegattaResultItem) => {
    if (r.countsForRanking) return true;
    const slug = r.regattaSlug ?? r.slug ?? "";
    const stored = r.verificationStatus;
    if (slug.startsWith("log-")) return stored === "verified";
    if (
      stored === "pending_review" ||
      stored === "self_reported" ||
      stored === "rejected"
    ) {
      return false;
    }
    return stored === "verified" || stored == null;
  };

  const verifiedCount = results.filter(isResultVerified).length;
  const underReviewCount = results.filter(
    (r) => !isResultVerified(r) && r.verificationStatus === "pending_review"
  ).length;
  const selfCount = results.filter(
    (r) =>
      !isResultVerified(r) &&
      (r.verificationStatus === "self_reported" || !r.verificationStatus)
  ).length;
  const rejectedCount = results.filter(
    (r) => !isResultVerified(r) && r.verificationStatus === "rejected"
  ).length;

  const filteredResults = results.filter((r) => {
    if (resultFilter === "verified") return isResultVerified(r);
    if (resultFilter === "under_review")
      return !isResultVerified(r) && r.verificationStatus === "pending_review";
    if (resultFilter === "self")
      return (
        !isResultVerified(r) &&
        (r.verificationStatus === "self_reported" || !r.verificationStatus)
      );
    if (resultFilter === "rejected")
      return !isResultVerified(r) && r.verificationStatus === "rejected";
    return true;
  });

  const evidenceDocs = useMemo(
    () => results.filter((r) => r.evidenceUrl || r.officialUrl),
    [results]
  );

  const reflectionsByRegatta = useMemo(() => {
    const map = new Map<string, LogbookReflection[]>();
    for (const item of reflections) {
      const list = map.get(item.regattaId) || [];
      list.push(item);
      map.set(item.regattaId, list);
    }
    return map;
  }, [reflections]);

  const handleReflectionSaved = (saved: LogbookReflection) => {
    setReflections((prev) => {
      const rest = prev.filter(
        (item) =>
          !(
            item.regattaId === saved.regattaId &&
            item.raceNumber === saved.raceNumber
          ) && item.id !== saved.id
      );
      return [...rest, saved].sort((a, b) => a.raceNumber - b.raceNumber);
    });
  };

  const handleReflectionDeleted = (id: string) => {
    setReflections((prev) => prev.filter((item) => item.id !== id));
  };

  return (
    <div className="space-y-5">
      {/* Compact Header & 3 Focused Underline Tabs */}
      <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs overflow-hidden">
        <div className="p-5 sm:p-6 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-center gap-4 min-w-0">
            <div className="flex flex-col items-center gap-1 shrink-0">
              <div className="relative h-14 w-14 sm:h-16 sm:w-16 rounded-full overflow-hidden bg-[var(--sp-sailcloth)] border-2 border-[var(--sp-cool-veil)] shadow-2xs">
                {athlete.avatarUrl ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    src={profilePhotoUrl(athlete.id, athlete.avatarUrl) || "/avatar-demo.png"}
                    alt={athlete.name}
                    className="h-full w-full object-cover object-top"
                  />
                ) : (
                  <div className="h-full w-full flex items-center justify-center text-[var(--sp-slate-soft)]">
                    <User className="h-7 w-7" />
                  </div>
                )}
              </div>
              {athlete.avatarUrl && (
                <button
                  type="button"
                  disabled={removingAvatar}
                  onClick={() => void handleRemovePhoto()}
                  className="text-[11px] font-semibold text-[var(--sp-slate-soft)] hover:text-rose-600 transition-colors cursor-pointer disabled:opacity-50"
                >
                  {removingAvatar ? "Removing…" : "Remove photo"}
                </button>
              )}
            </div>

            <div className="min-w-0 space-y-1">
              <h1 className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] tracking-tight truncate">
                {athlete.name}
              </h1>
              <p className="text-xs text-[var(--sp-slate-soft)] truncate">
                {[
                  athlete.sailNumber
                    ? `${athlete.nationality || "SGP"} ${athlete.sailNumber}`
                    : null,
                  athlete.club || null,
                  athlete.currentFleet ? `${athlete.currentFleet} Fleet` : null,
                ]
                  .filter(Boolean)
                  .join(" · ") || "Sailor logbook"}
              </p>
            </div>
          </div>

          <div className="flex flex-wrap items-center gap-2 shrink-0">
            <Link
              href={`/sailors/${athlete.handle}`}
              className="inline-flex min-h-11 items-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] px-4 py-2 text-xs font-bold transition-colors shadow-2xs"
            >
              <span>Public profile</span>
              <ExternalLink className="h-3.5 w-3.5 text-[var(--sp-slate-soft)]" aria-hidden="true" />
            </Link>
            <Link
              href={`/sailors/${athlete.handle}?edit=1`}
              className="inline-flex min-h-11 items-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] px-4 py-2 text-xs font-bold transition-colors shadow-2xs"
            >
              <Pencil className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" aria-hidden="true" />
              <span>Edit profile</span>
            </Link>
            <button
              type="button"
              onClick={() => {
                setEditingResult(null);
                setEvidenceModalOpen(true);
              }}
              className="inline-flex min-h-11 items-center gap-1.5 rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] active:scale-[0.98] text-white px-5 py-2 text-xs sm:text-sm font-bold transition-all shadow-xs cursor-pointer"
            >
              <Plus className="h-4 w-4" aria-hidden="true" />
              <span>Log regatta</span>
            </button>
          </div>
        </div>

        <nav
          aria-label="Logbook sections"
          role="tablist"
          className="border-t border-[var(--sp-cool-veil)] px-5 sm:px-6 flex gap-6 overflow-x-auto scrollbar-thin"
        >
          {(
            [
              { id: "results", label: "Logbook", count: results.length },
              { id: "equipment", label: "Equipment" },
              { id: "documents", label: "Documents", count: evidenceDocs.length },
            ] as Array<{ id: WorkspaceTab; label: string; count?: number }>
          ).map((tab) => {
            const selected = activeTab === tab.id;
            return (
              <button
                key={tab.id}
                type="button"
                role="tab"
                aria-selected={selected}
                onClick={() => changeTab(tab.id)}
                className={`inline-flex min-h-11 items-center gap-2 border-b-2 py-3 text-xs sm:text-[13px] font-bold transition-colors whitespace-nowrap cursor-pointer ${
                  selected
                    ? "border-[var(--sp-harbour-teal)] text-[var(--sp-harbour-teal)]"
                    : "border-transparent text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)]"
                }`}
              >
                <span>{tab.label}</span>
                {typeof tab.count === "number" && (
                  <span
                    className={`rounded-full px-2 py-0.5 text-[11px] font-bold tabular-nums ${
                      selected
                        ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
                        : "bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)]"
                    }`}
                  >
                    {tab.count}
                  </span>
                )}
              </button>
            );
          })}
        </nav>
      </div>

      {/* Tab 1: Regattas Logbook & Reflections */}
      {activeTab === "results" && (
        <div className="space-y-4">
          {results.length > 0 && (
            <div className="flex flex-wrap items-center gap-1.5">
              {(
                [
                  { id: "all", label: "All", count: results.length },
                  { id: "verified", label: "Verified", count: verifiedCount },
                  { id: "under_review", label: "Under review", count: underReviewCount },
                  { id: "self", label: "Self-reported", count: selfCount },
                  ...(rejectedCount > 0
                    ? [{ id: "rejected" as const, label: "Rejected", count: rejectedCount }]
                    : []),
                ] as Array<{
                  id: "all" | "verified" | "under_review" | "self" | "rejected";
                  label: string;
                  count: number;
                }>
              ).map((chip) => {
                const active = resultFilter === chip.id;
                return (
                  <button
                    key={chip.id}
                    type="button"
                    onClick={() => setResultFilter(chip.id)}
                    className={`min-h-9 rounded-full border px-3.5 py-1.5 text-xs font-bold transition-colors cursor-pointer ${
                      active
                        ? "border-[var(--sp-harbour-teal)] bg-[var(--sp-harbour-teal)] text-white shadow-2xs"
                        : "border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]"
                    }`}
                  >
                    {chip.label} ({chip.count})
                  </button>
                );
              })}
            </div>
          )}

          {loadingResults ? (
            <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-12 text-center text-sm text-[var(--sp-slate-soft)] flex items-center justify-center gap-2">
              <Loader2 className="h-4 w-4 animate-spin text-[var(--sp-harbour-teal)]" />
              <span>Loading regatta logbook…</span>
            </div>
          ) : filteredResults.length === 0 ? (
            results.length === 0 ? (
              <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-10 text-center space-y-4 shadow-xs">
                <div className="mx-auto h-11 w-11 rounded-2xl bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] flex items-center justify-center">
                  <Trophy className="h-5 w-5" />
                </div>
                <div className="space-y-1">
                  <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)]">
                    No regattas logged yet
                  </h2>
                  <p className="text-xs text-[var(--sp-slate-soft)] max-w-sm mx-auto leading-relaxed">
                    Add overseas, club, or non-ranking regattas and attach official results to earn a Verified badge.
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    setEditingResult(null);
                    setEvidenceModalOpen(true);
                  }}
                  className="inline-flex min-h-11 items-center gap-2 rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] text-white px-5 py-2.5 text-sm font-semibold transition-colors shadow-xs cursor-pointer"
                >
                  <Plus className="h-4 w-4" />
                  <span>Log your first regatta</span>
                </button>
              </div>
            ) : (
              <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 text-center text-xs text-[var(--sp-slate-soft)] shadow-xs">
                No regattas match this filter.
              </div>
            )
          ) : (
            <ul className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] divide-y divide-[var(--sp-cool-veil)] shadow-xs overflow-hidden">
              {filteredResults.map((r) => {
                const verified = isResultVerified(r);
                const regSlug = r.regattaSlug ?? r.slug ?? "";
                const isPersonalLog = regSlug.startsWith("log-");
                const showUserEvidenceNotes = Boolean(
                  r.evidenceNotes &&
                    r.verificationStatus !== "rejected" &&
                    (isPersonalLog || !verified)
                );
                const effectiveFleetSize =
                  qualifyingParticipation(regSlug) ?? r.totalFleetSize;
                const rowReflections =
                  reflectionsByRegatta.get(r.regattaId) || [];

                return (
                  <li key={r.id} className="p-4 sm:px-6 sm:py-4 space-y-2.5">
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2.5">
                      <div className="min-w-0 space-y-0.5">
                        <div className="flex flex-wrap items-center gap-2">
                          <h3 className="text-sm sm:text-base font-bold text-[var(--sp-charcoal)]">
                            {r.regattaName}
                          </h3>
                          {!r.countsForRanking && (
                            <span className="rounded-full bg-[var(--sp-sailcloth)] px-2 py-0.5 text-[11px] font-semibold text-[var(--sp-slate-soft)]">
                              Personal log
                            </span>
                          )}
                        </div>
                        <p className="text-xs text-[var(--sp-slate-soft)]">
                          {String(r.regattaDate).slice(0, 10)}
                          {r.regattaEndDate
                            ? ` – ${String(r.regattaEndDate).slice(0, 10)}`
                            : ""}
                          {r.venue ? ` · ${r.venue}` : ""}
                          {r.boatClass ? ` · ${sailingClassDisplayLabel(r.boatClass)}` : ""}
                          {r.division ? ` · ${r.division}` : ""}
                        </p>
                      </div>

                      <div className="flex items-center justify-between sm:justify-end gap-3 shrink-0">
                        <div className="sm:text-right">
                          <p className="text-sm font-semibold text-[var(--sp-charcoal)] tabular-nums">
                            Place{" "}
                            <span className="text-base font-black text-[var(--sp-harbour-shadow)]">
                              {r.rank}
                            </span>
                            {effectiveFleetSize ? (
                              <span className="text-xs font-normal text-[var(--sp-slate-soft)]">
                                {" "}
                                / {effectiveFleetSize}
                              </span>
                            ) : null}
                          </p>
                          {r.nettScore != null && (
                            <p className="text-[11px] font-mono text-[var(--sp-slate-soft)]">
                              nett {r.nettScore} pts
                            </p>
                          )}
                        </div>

                        {verified ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-emerald-50 border border-emerald-200 px-2.5 py-1 text-[11px] font-bold text-emerald-800">
                            <ShieldCheck className="h-3.5 w-3.5 text-emerald-600" aria-hidden="true" />
                            Verified
                          </span>
                        ) : r.verificationStatus === "pending_review" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-sky-50 border border-sky-200 px-2.5 py-1 text-[11px] font-bold text-sky-800">
                            <Clock className="h-3.5 w-3.5 text-sky-600" aria-hidden="true" />
                            Under review
                          </span>
                        ) : r.verificationStatus === "rejected" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-rose-50 border border-rose-200 px-2.5 py-1 text-[11px] font-bold text-rose-800">
                            <AlertCircle className="h-3.5 w-3.5 text-rose-600" aria-hidden="true" />
                            Rejected
                          </span>
                        ) : (
                          <span className="inline-flex items-center rounded-full bg-amber-50 border border-amber-200 px-2.5 py-1 text-[11px] font-bold text-amber-800">
                            Self-reported
                          </span>
                        )}
                      </div>
                    </div>

                    {r.verificationStatus === "rejected" && (
                      <div className="rounded-xl border border-rose-200 bg-rose-50/90 px-3 py-2 flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs text-rose-900">
                        <span>
                          <strong>Review note:</strong>{" "}
                          {r.evidenceNotes ||
                            "Official score documentation or results URL is required."}
                        </span>
                        <button
                          type="button"
                          onClick={() => {
                            setEditingResult(r);
                            setEvidenceModalOpen(true);
                          }}
                          className="shrink-0 font-bold text-rose-700 hover:underline text-left sm:text-right cursor-pointer"
                        >
                          Re-submit evidence →
                        </button>
                      </div>
                    )}

                    {/* Reflection snippet if saved */}
                    {rowReflections.length > 0 && rowReflections[0]?.note && (
                      <p className="text-xs text-[var(--sp-charcoal)] bg-[var(--sp-sailcloth)]/60 rounded-xl px-3 py-2 leading-relaxed">
                        <span className="font-semibold text-[var(--sp-harbour-teal)]">
                          Reflection{rowReflections.length > 1 ? ` (${rowReflections.length})` : ""}:
                        </span>{" "}
                        {rowReflections[0].note}
                      </p>
                    )}

                    <div className="flex flex-wrap items-center justify-between gap-2 pt-0.5 text-xs">
                      <div className="flex flex-wrap items-center gap-3 text-[var(--sp-slate-soft)]">
                        {r.evidenceUrl && (
                          <a
                            href={r.evidenceUrl}
                            target="_blank"
                            rel="noreferrer"
                            className="inline-flex items-center gap-1 font-semibold text-[var(--sp-harbour-teal)] hover:underline"
                          >
                            {r.evidenceType === "image" ? (
                              <ImageIcon className="h-3.5 w-3.5" aria-hidden="true" />
                            ) : (
                              <FileText className="h-3.5 w-3.5" aria-hidden="true" />
                            )}
                            <span>{r.evidenceName || "Evidence document"}</span>
                          </a>
                        )}
                        {r.officialUrl && (
                          <a
                            href={r.officialUrl}
                            target="_blank"
                            rel="noreferrer"
                            className="inline-flex items-center gap-1 font-semibold text-[var(--sp-harbour-teal)] hover:underline"
                          >
                            <ExternalLink className="h-3.5 w-3.5" aria-hidden="true" />
                            <span>Official results</span>
                          </a>
                        )}
                        {showUserEvidenceNotes && (
                          <span className="italic">“{r.evidenceNotes}”</span>
                        )}
                      </div>

                      <div className="flex flex-wrap items-center gap-3 ml-auto">
                        <button
                          type="button"
                          onClick={() =>
                            setReflectionTarget({
                              regattaId: r.regattaId,
                              regattaName: r.regattaName,
                            })
                          }
                          className="inline-flex min-h-9 items-center gap-1 font-semibold text-[var(--sp-harbour-teal)] hover:underline cursor-pointer"
                        >
                          <BookOpen className="h-3.5 w-3.5" aria-hidden="true" />
                          <span>
                            {rowReflections.length > 0
                              ? `Reflections (${rowReflections.length})`
                              : "+ Add reflection"}
                          </span>
                        </button>

                        {!verified && (
                          <>
                            <button
                              type="button"
                              onClick={() => {
                                setEditingResult(r);
                                setEvidenceModalOpen(true);
                              }}
                              className="inline-flex min-h-9 items-center gap-1 font-semibold text-[var(--sp-charcoal)] hover:underline cursor-pointer"
                            >
                              <Edit2 className="h-3 w-3" aria-hidden="true" />
                              <span>Edit / Evidence</span>
                            </button>
                            <button
                              type="button"
                              onClick={() => handleDeleteResult(r.id, r.regattaName)}
                              className="inline-flex min-h-9 items-center gap-1 font-semibold text-rose-700 hover:underline cursor-pointer"
                            >
                              <Trash2 className="h-3 w-3" aria-hidden="true" />
                              <span>Delete</span>
                            </button>
                          </>
                        )}
                      </div>
                    </div>
                  </li>
                );
              })}
            </ul>
          )}
        </div>
      )}

      {/* Fallback card if navigated directly via ?tab=profile */}
      {activeTab === "profile" && (
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 sm:p-8 text-center space-y-3 shadow-xs">
          <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)]">
            Profile editing is now on your public profile
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] max-w-md mx-auto leading-relaxed">
            Update your bio, sail numbers, club, school, and privacy settings in one place with Edit profile.
          </p>
          <div className="pt-1">
            <Link
              href={`/sailors/${athlete.handle}?edit=1`}
              className="inline-flex min-h-11 items-center gap-2 rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] px-5 py-2.5 text-sm font-bold text-white shadow-xs transition-colors"
            >
              <Pencil className="h-4 w-4" aria-hidden="true" />
              <span>Edit profile</span>
            </Link>
          </div>
        </div>
      )}

      {/* Tab 2: Equipment Locker */}
      {activeTab === "equipment" && (
        <EquipmentInventory
          sailorId={athlete.id}
          isOwner={true}
          canSeeEquipment={true}
          mayHaveIlca={Boolean(athlete.sailNumberIlca4)}
        />
      )}

      {/* Tab 3: Evidence Documents */}
      {activeTab === "documents" && (
        evidenceDocs.length === 0 ? (
          <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-10 text-center space-y-2 shadow-xs">
            <p className="text-sm font-bold text-[var(--sp-charcoal)]">
              No evidence documents yet
            </p>
            <p className="text-xs text-[var(--sp-slate-soft)] max-w-sm mx-auto">
              Attach scorecards, noticeboards, or official result links when logging a regatta to view them here.
            </p>
          </div>
        ) : (
          <ul className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] divide-y divide-[var(--sp-cool-veil)] shadow-xs overflow-hidden">
            {evidenceDocs.map((r) => {
              const effectiveFleetSize =
                qualifyingParticipation(r.regattaSlug ?? r.slug ?? "") ??
                r.totalFleetSize;
              return (
                <li
                  key={r.id}
                  className="p-4 sm:px-6 sm:py-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3"
                >
                  <div className="min-w-0">
                    <p className="text-sm font-bold text-[var(--sp-charcoal)] truncate">
                      {r.regattaName}
                    </p>
                    <p className="text-xs text-[var(--sp-slate-soft)] mt-0.5">
                      {String(r.regattaDate).slice(0, 10)} · Place {r.rank}
                      {effectiveFleetSize ? ` / ${effectiveFleetSize}` : ""}
                    </p>
                  </div>

                  <div className="flex flex-wrap items-center gap-2 shrink-0">
                    {r.evidenceUrl && (
                      <a
                        href={r.evidenceUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="inline-flex min-h-9 items-center gap-1.5 rounded-full border border-sky-200 bg-sky-50 hover:bg-sky-100 text-sky-800 px-3 py-1 text-xs font-semibold transition-colors"
                      >
                        {r.evidenceType === "image" ? (
                          <ImageIcon className="h-3.5 w-3.5" aria-hidden="true" />
                        ) : (
                          <FileText className="h-3.5 w-3.5" aria-hidden="true" />
                        )}
                        <span>{r.evidenceName || "Evidence"}</span>
                      </a>
                    )}
                    {r.officialUrl && (
                      <a
                        href={r.officialUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="inline-flex min-h-9 items-center gap-1.5 rounded-full border border-teal-200 bg-teal-50 hover:bg-teal-100 text-[var(--sp-harbour-teal)] px-3 py-1 text-xs font-semibold transition-colors"
                      >
                        <ExternalLink className="h-3.5 w-3.5" aria-hidden="true" />
                        <span>Official link</span>
                      </a>
                    )}
                  </div>
                </li>
              );
            })}
          </ul>
        )
      )}

      {/* Regatta Evidence Modal */}
      <RegattaEvidenceModal
        isOpen={evidenceModalOpen}
        onClose={() => {
          setEvidenceModalOpen(false);
          setEditingResult(null);
        }}
        sailorId={athlete.id}
        sailorName={athlete.name}
        initialResult={editingResult}
        onSuccess={() => void fetchResults()}
      />

      {/* Post-Regatta Reflections Modal */}
      {reflectionTarget && (
        <RegattaReflectionModal
          isOpen={Boolean(reflectionTarget)}
          onClose={() => setReflectionTarget(null)}
          sailorId={athlete.id}
          regattaId={reflectionTarget.regattaId}
          regattaName={reflectionTarget.regattaName}
          reflections={reflectionsByRegatta.get(reflectionTarget.regattaId) || []}
          onSaved={handleReflectionSaved}
          onDeleted={handleReflectionDeleted}
        />
      )}
    </div>
  );
}

interface AthleteHubProps {
  athletes: AthleteProfile[];
  currentSailorId?: string;
  initialTab?: "results" | "profile" | "equipment" | "documents";
  initialAction?: string;
}

export function AthleteHub({
  athletes,
  currentSailorId,
  initialTab = "results",
  initialAction,
}: AthleteHubProps) {
  const [selectedId, setSelectedId] = useState<string>(() => {
    if (currentSailorId && athletes.some((a) => a.id === currentSailorId)) {
      return currentSailorId;
    }
    return athletes[0]?.id || "";
  });
  const [activeTab, setActiveTab] = useState<WorkspaceTab>(initialTab);

  const handleSelectAthlete = (id: string) => {
    if (id === selectedId) return;
    setSelectedId(id);
    const url = new URL(window.location.href);
    url.searchParams.set("id", id);
    window.history.replaceState(null, "", url.toString());
  };

  const activeAthlete = athletes.find((a) => a.id === selectedId) || athletes[0];

  if (!activeAthlete) {
    return (
      <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-12 text-center space-y-4 shadow-xs">
        <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-2xl bg-[var(--sp-racing-mist)]/30 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/30">
          <AlertCircle className="h-6 w-6" />
        </div>
        <div className="space-y-1">
          <h2 className="text-lg font-bold text-[var(--sp-charcoal)]">
            No Claimed Sailor Profiles Found
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] max-w-sm mx-auto">
            You don&apos;t have any active sailor profiles claimed yet. Search for your sailor profile to claim ownership and manage regattas.
          </p>
        </div>
        <Link
          href="/claim-profile"
          className="inline-flex items-center gap-2 rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] text-white px-5 py-2.5 text-[15px] font-semibold transition-all shadow-xs"
        >
          <Plus className="h-4 w-4" />
          <span>Claim Sailor Profile</span>
        </Link>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Athlete Switcher (for parents managing multiple children) */}
      {athletes.length > 1 && (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-2.5 flex items-center gap-2 overflow-x-auto">
          <span className="text-xs font-bold text-[var(--sp-slate-soft)] flex items-center gap-1.5 pl-2 shrink-0">
            <Users className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
            <span>Select Athlete:</span>
          </span>
          <div className="flex items-center gap-1.5">
            {athletes.map((ath) => (
              <button
                key={ath.id}
                type="button"
                onClick={() => handleSelectAthlete(ath.id)}
                className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap cursor-pointer ${
                  ath.id === selectedId
                    ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                    : "bg-white text-[var(--sp-charcoal)] hover:bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)]"
                }`}
              >
                {ath.name}
                {ath.ownerRelation ? ` (${ath.ownerRelation})` : ""}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* Active Athlete Workspace */}
      <AthleteWorkspace
        key={activeAthlete.id}
        athlete={activeAthlete}
        initialTab={activeTab}
        initialAction={initialAction}
        onTabChange={setActiveTab}
      />
    </div>
  );
}
