"use client";

import { useState, useEffect, useCallback, useMemo, useRef } from "react";
import Link from "next/link";
import Image from "next/image";
import { useRouter } from "next/navigation";
import {
  Trophy,
  User,
  Sailboat,
  FileText,
  ExternalLink,
  Plus,
  Edit2,
  Trash2,
  ShieldCheck,
  AlertCircle,
  Users,
  ImageIcon,
  Save,
  Loader2,
  Clock,
} from "lucide-react";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import {
  RegattaEvidenceModal,
  type RegattaResultItem,
} from "./RegattaEvidenceModal";
import { EquipmentInventory } from "@/components/equipment/EquipmentInventory";
import { GeographySelect } from "@/components/CountrySelect";

export type AthleteProfile = {
  id: string;
  name: string;
  handle: string;
  sailNumber?: string | null;
  sailNumberIlca4?: string | null;
  club?: string | null;
  school?: string | null;
  gender?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  currentFleet?: string | null;
  ownerRelation?: string | null;
  nationalSquadStatus?: string | null;
  dob?: string | Date | null;
  instagram?: string | null;
  hullBrand?: string | null;
  sailMake?: string | null;
  foilBrand?: string | null;
  mast?: string | null;
  equipmentNotes?: string | null;
};

type WorkspaceTab = "results" | "profile" | "equipment" | "documents";

function buildProfileForm(a: AthleteProfile) {
  return {
    sailNumber: a.sailNumber || "",
    sailNumberIlca4: a.sailNumberIlca4 || "",
    club: a.club || "",
    school: a.school || "",
    gender: a.gender || "M",
    nationality: a.nationality || "SGP",
    dob: a.dob ? String(a.dob).slice(0, 10) : "",
    instagram: a.instagram || "",
    avatarUrl: a.avatarUrl || "",
    hullBrand: a.hullBrand || "",
    sailMake: a.sailMake || "",
    foilBrand: a.foilBrand || "",
    mast: a.mast || "",
    equipmentNotes: a.equipmentNotes || "",
  };
}

interface AthleteWorkspaceProps {
  athlete: AthleteProfile;
  initialTab?: WorkspaceTab;
  initialAction?: string;
  onTabChange?: (tab: WorkspaceTab) => void;
  onDirtyChange?: (dirty: boolean) => void;
}

function AthleteWorkspace({
  athlete: initialAthlete,
  initialTab = "results",
  initialAction,
  onTabChange,
  onDirtyChange,
}: AthleteWorkspaceProps) {
  const router = useRouter();
  const { toast, confirm } = useFeedback();

  // Local athlete state so profile saves instantly refresh the header card
  const [athlete, setAthlete] = useState<AthleteProfile>(initialAthlete);

  // Active tab
  const [activeTab, setActiveTab] = useState<WorkspaceTab>(initialTab);

  const changeTab = (tab: WorkspaceTab) => {
    setActiveTab(tab);
    onTabChange?.(tab);
    // Keep the URL shareable/deep-linkable without a server roundtrip
    const url = new URL(window.location.href);
    url.searchParams.set("tab", tab);
    window.history.replaceState(null, "", url.toString());
  };

  // Evidence modal state
  const [evidenceModalOpen, setEvidenceModalOpen] = useState(
    initialAction === "new"
  );
  const [editingResult, setEditingResult] = useState<RegattaResultItem | null>(
    null
  );

  // Results state
  const [results, setResults] = useState<RegattaResultItem[]>([]);
  const [loadingResults, setLoadingResults] = useState(true);
  const [resultFilter, setResultFilter] = useState<
    "all" | "verified" | "under_review" | "self" | "rejected"
  >("all");

  // Profile edit form state
  const [profileForm, setProfileForm] = useState(() =>
    buildProfileForm(athlete)
  );
  const [savingProfile, setSavingProfile] = useState(false);

  // Dirty tracking: notify parent when the profile form diverges from the
  // saved athlete record (baseline recomputes automatically after save)
  const profileBaseline = useMemo(() => JSON.stringify(buildProfileForm(athlete)), [athlete]);
  useEffect(() => {
    onDirtyChange?.(JSON.stringify(profileForm) !== profileBaseline);
  }, [profileForm, profileBaseline, onDirtyChange]);

  const fetchResults = useCallback(async () => {
    setLoadingResults(true);
    try {
      const res = await fetch(`/api/account/results?sailorId=${athlete.id}`);
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load results");
      setResults(data.results || []);
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
        const res = await fetch(`/api/account/results?sailorId=${athlete.id}`);
        const data = await res.json();
        if (!ignore) {
          if (!res.ok) throw new Error(data.error || "Failed to load results");
          setResults(data.results || []);
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

  const handleSaveProfile = async (e: React.FormEvent) => {
    e.preventDefault();
    setSavingProfile(true);
    try {
      const res = await fetch("/api/account/sailor", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorId: athlete.id,
          ...profileForm,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to update profile");

      // Synchronize local athlete state immediately
      setAthlete((prev) => ({
        ...prev,
        sailNumber: profileForm.sailNumber,
        sailNumberIlca4: profileForm.sailNumberIlca4,
        club: profileForm.club,
        school: profileForm.school,
        gender: profileForm.gender,
        nationality: profileForm.nationality,
        dob: profileForm.dob,
        instagram: profileForm.instagram,
        hullBrand: profileForm.hullBrand,
        sailMake: profileForm.sailMake,
        foilBrand: profileForm.foilBrand,
        mast: profileForm.mast,
        equipmentNotes: profileForm.equipmentNotes,
      }));

      toast.success("Athlete profile details updated!");
      router.refresh();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Update failed");
    } finally {
      setSavingProfile(false);
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

  const isResultVerified = (r: RegattaResultItem) =>
    r.verificationStatus === "verified" ||
    Boolean(r.countsForRanking) ||
    (r.regattaSlug ? !r.regattaSlug.startsWith("log-") : false);

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

  return (
    <div className="space-y-6">
      {/* Athlete Header Card */}
      <div className="rounded-3xl border border-[var(--sp-cool-veil)] p-6 sm:p-8 bg-[var(--sp-warm-white)] shadow-xs relative overflow-hidden">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-6">
          <div className="flex items-center gap-5">
            {/* Avatar */}
            <div className="relative h-16 w-16 sm:h-20 sm:w-20 rounded-2xl overflow-hidden bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] shrink-0 shadow-2xs">
              {athlete.avatarUrl ? (
                <Image
                  src={athlete.avatarUrl}
                  alt={athlete.name}
                  fill
                  className="object-cover"
                />
              ) : (
                <div className="h-full w-full flex items-center justify-center text-[var(--sp-slate-soft)]">
                  <User className="h-8 w-8" />
                </div>
              )}
            </div>

            {/* Identity Info */}
            <div className="space-y-1">
              <div className="flex flex-wrap items-center gap-2">
                <h1 className="text-xl sm:text-2xl font-black text-[var(--sp-charcoal)] tracking-tight">
                  {athlete.name}
                </h1>
                {athlete.currentFleet && (
                  <span className="px-2.5 py-0.5 rounded-full text-[11px] font-black uppercase tracking-wider bg-amber-50 text-amber-800 border border-amber-200">
                    {athlete.currentFleet} Fleet
                  </span>
                )}
                {athlete.nationalSquadStatus && (
                  <span className="px-2.5 py-0.5 rounded-full text-[11px] font-black uppercase tracking-wider bg-rose-50 text-rose-700 border border-rose-200">
                    National Squad
                  </span>
                )}
              </div>

              <div className="flex flex-wrap items-center gap-3 text-xs text-[var(--sp-slate-soft)]">
                {athlete.sailNumber && (
                  <span className="font-mono font-bold text-[var(--sp-charcoal)]">
                    Sail: {athlete.nationality || "SIN"} {athlete.sailNumber}
                  </span>
                )}
                {athlete.club && <span>· Club: {athlete.club}</span>}
                {athlete.school && <span>· School: {athlete.school}</span>}
              </div>
            </div>
          </div>

          {/* Quick Actions */}
          <div className="flex items-center gap-2 sm:self-start">
            <Link
              href={`/${athlete.handle}`}
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1.5 rounded-xl border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] px-3.5 py-2 text-xs font-bold transition-all shadow-2xs"
            >
              <span>View Public Profile</span>
              <ExternalLink className="h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
            </Link>
            <button
              type="button"
              onClick={() => {
                setEditingResult(null);
                setEvidenceModalOpen(true);
              }}
              className="inline-flex items-center gap-1.5 rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] active:scale-[0.98] text-white px-4 py-2 text-[15px] font-semibold transition-all shadow-xs"
            >
              <Plus className="h-4 w-4" />
              <span>Log Score</span>
            </button>
          </div>
        </div>

        {/* Tab Navigation */}
        <div className="mt-8 pt-4 border-t border-[var(--sp-cool-veil)] flex gap-2 overflow-x-auto scrollbar-thin">
          <button
            type="button"
            onClick={() => changeTab("results")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
              activeTab === "results"
                ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]"
            }`}
          >
            <Trophy className="h-4 w-4 text-[var(--sp-racing-orange)]" />
            <span>Regattas &amp; Evidence Logbook</span>
            <span className={`ml-1 rounded-full px-2 py-0.5 text-[11px] font-bold ${
              activeTab === "results" ? "bg-white/20 text-white" : "bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] border border-[var(--sp-cool-veil)]"
            }`}>
              {results.length}
            </span>
          </button>

          <button
            type="button"
            onClick={() => changeTab("profile")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
              activeTab === "profile"
                ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]"
            }`}
          >
            <User className="h-4 w-4" />
            <span>Athlete Profile</span>
          </button>

          <button
            type="button"
            onClick={() => changeTab("equipment")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
              activeTab === "equipment"
                ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]"
            }`}
          >
            <Sailboat className="h-4 w-4" />
            <span>Equipment Locker</span>
          </button>

          <button
            type="button"
            onClick={() => changeTab("documents")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
              activeTab === "documents"
                ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]"
            }`}
          >
            <FileText className="h-4 w-4" />
            <span>Evidence Documents</span>
            <span className={`ml-1 rounded-full px-2 py-0.5 text-[11px] font-bold ${
              activeTab === "documents" ? "bg-white/20 text-white" : "bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] border border-[var(--sp-cool-veil)]"
            }`}>
              {results.filter((r) => r.evidenceUrl || r.officialUrl).length}
            </span>
          </button>
        </div>
      </div>

      {/* Tab 1: Regattas & Results Logbook */}
      {activeTab === "results" && (
        <div className="space-y-4">
          {/* Filter Bar */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-2 rounded-2xl">
            <div className="flex flex-wrap items-center gap-1.5">
              <button
                type="button"
                onClick={() => setResultFilter("all")}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
                  resultFilter === "all"
                    ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                    : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-white"
                }`}
              >
                All ({results.length})
              </button>
              <button
                type="button"
                onClick={() => setResultFilter("verified")}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
                  resultFilter === "verified"
                    ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                    : "text-[var(--sp-slate-soft)] hover:text-emerald-700 hover:bg-emerald-50"
                }`}
              >
                Verified ✓ ({verifiedCount})
              </button>
              <button
                type="button"
                onClick={() => setResultFilter("under_review")}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
                  resultFilter === "under_review"
                    ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                    : "text-[var(--sp-slate-soft)] hover:text-sky-700 hover:bg-sky-50"
                }`}
              >
                Under Review ({underReviewCount})
              </button>
              <button
                type="button"
                onClick={() => setResultFilter("self")}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
                  resultFilter === "self"
                    ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                    : "text-[var(--sp-slate-soft)] hover:text-amber-800 hover:bg-amber-50"
                }`}
              >
                Self-Reported ({selfCount})
              </button>
              {rejectedCount > 0 && (
                <button
                  type="button"
                  onClick={() => setResultFilter("rejected")}
                  className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all ${
                    resultFilter === "rejected"
                      ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                      : "text-[var(--sp-slate-soft)] hover:text-rose-700 hover:bg-rose-50"
                  }`}
                >
                  Rejected ✕ ({rejectedCount})
                </button>
              )}
            </div>

            <button
              type="button"
              onClick={() => {
                setEditingResult(null);
                setEvidenceModalOpen(true);
              }}
              className="inline-flex items-center justify-center gap-2 rounded-xl border border-[var(--sp-harbour-teal)]/40 bg-white hover:bg-[var(--sp-sailcloth)] active:scale-[0.98] px-4 py-2 text-[15px] font-semibold text-[var(--sp-harbour-teal)] transition-all shadow-2xs"
            >
              <Plus className="h-4 w-4" />
              <span>Log Regatta Score &amp; Evidence</span>
            </button>
          </div>

          {/* Results List */}
          {loadingResults ? (
            <div className="p-12 text-center text-[var(--sp-slate-soft)] flex items-center justify-center gap-2">
              <Loader2 className="h-5 w-5 animate-spin text-[var(--sp-racing-orange)]" />
              <span>Loading regatta logbook...</span>
            </div>
          ) : filteredResults.length === 0 ? (
            results.length === 0 ? (
              <div className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-12 text-center space-y-4 shadow-xs">
                <div className="mx-auto h-12 w-12 rounded-2xl bg-[var(--sp-racing-mist)]/30 text-[var(--sp-racing-orange)] flex items-center justify-center border border-[var(--sp-racing-orange)]/30">
                  <Trophy className="h-6 w-6" />
                </div>
                <div className="space-y-1">
                  <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)]">
                    Log your first regatta
                  </h3>
                  <p className="text-xs text-[var(--sp-slate-soft)] max-w-sm mx-auto">
                    Log personal, club, or overseas regattas to track performance — attach official evidence to earn a Verified ✓ badge.
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    setEditingResult(null);
                    setEvidenceModalOpen(true);
                  }}
                  className="inline-flex items-center gap-2 rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] text-white px-5 py-2.5 text-[15px] font-semibold transition-all shadow-xs"
                >
                  <Plus className="h-4 w-4" />
                  <span>Log Regatta Score</span>
                </button>
              </div>
            ) : (
              <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 text-center text-xs text-[var(--sp-slate-soft)] shadow-xs">
                No regattas match the selected filter.
              </div>
            )
          ) : (
            <div className="space-y-3">
              {filteredResults.map((r) => (
                <div
                  key={r.id}
                  className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs transition-all hover:border-[var(--sp-aqua-deep)]/40 hover:shadow-sm space-y-3"
                >
                  <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div className="space-y-1">
                      <div className="flex flex-wrap items-center gap-2">
                        <h4 className="text-base font-bold text-[var(--sp-charcoal)]">
                          {r.regattaName}
                        </h4>
                        {r.countsForRanking ? (
                          <span className="rounded-full bg-teal-50 border border-teal-200 px-2.5 py-0.5 text-[11px] font-black uppercase text-[var(--sp-harbour-teal)]">
                            Singapore Series Ranking
                          </span>
                        ) : (
                          <span className="rounded-full bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2.5 py-0.5 text-[11px] font-black uppercase text-[var(--sp-slate-soft)]">
                            Non-Ranking / Overseas Logbook
                          </span>
                        )}
                      </div>

                      <p className="text-xs text-[var(--sp-slate-soft)] font-medium">
                        {String(r.regattaDate).slice(0, 10)}
                        {r.regattaEndDate
                          ? ` to ${String(r.regattaEndDate).slice(0, 10)}`
                          : ""}
                        {r.venue ? ` · ${r.venue}` : ""}
                        {r.boatClass ? ` · ${r.boatClass}` : ""}
                        {r.division ? ` · ${r.division}` : ""}
                      </p>
                    </div>

                    {/* Finish Position & Badges */}
                    <div className="flex items-center gap-3 self-start sm:self-center">
                      <div className="text-right">
                        <div className="text-sm font-semibold text-[var(--sp-charcoal)]">
                          Place{" "}
                          <span className="font-mono text-lg font-black text-[var(--sp-harbour-shadow)]">
                            {r.rank}
                          </span>
                          {r.totalFleetSize ? (
                            <span className="text-xs font-normal text-[var(--sp-slate-soft)]">
                              {" "}
                              / {r.totalFleetSize}
                            </span>
                          ) : null}
                        </div>
                        {r.nettScore != null && (
                          <div className="text-[13px] font-mono text-[var(--sp-slate-soft)]">
                            nett {r.nettScore} pts
                          </div>
                        )}
                      </div>

                      {/* Verification Status Badge */}
                      <div>
                        {isResultVerified(r) ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-emerald-50 border border-emerald-200 px-3 py-1 text-xs font-bold text-emerald-800">
                            <ShieldCheck className="h-3.5 w-3.5 text-emerald-600" />
                            Verified ✓
                          </span>
                        ) : r.verificationStatus === "pending_review" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-sky-50 border border-sky-200 px-3 py-1 text-xs font-bold text-sky-800">
                            <Clock className="h-3.5 w-3.5 text-sky-600" />
                            Under Review
                          </span>
                        ) : r.verificationStatus === "rejected" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-rose-50 border border-rose-200 px-3 py-1 text-xs font-bold text-rose-800">
                            <AlertCircle className="h-3.5 w-3.5 text-rose-600" />
                            Rejected ✕
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 rounded-full bg-amber-50 border border-amber-200 px-3 py-1 text-xs font-bold text-amber-800">
                            Self-Reported
                          </span>
                        )}
                      </div>
                    </div>
                  </div>

                  {/* Rejected Alert Notice with Re-submit callout */}
                  {r.verificationStatus === "rejected" && (
                    <div className="rounded-xl border border-rose-200 bg-rose-50/90 p-3 flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs text-rose-950">
                      <div className="flex items-start gap-2">
                        <AlertCircle className="h-4 w-4 text-rose-600 shrink-0 mt-0.5" />
                        <div>
                          <span className="font-bold text-rose-950">Review Note: </span>
                          <span className="text-rose-800">
                            {r.evidenceNotes || "Official score documentation or official results URL is required for verification."}
                          </span>
                        </div>
                      </div>
                      <button
                        type="button"
                        onClick={() => {
                          setEditingResult(r);
                          setEvidenceModalOpen(true);
                        }}
                        className="shrink-0 inline-flex items-center gap-1 font-bold text-rose-700 hover:text-rose-900 hover:underline text-[11px]"
                      >
                        <span>Why? / Re-submit evidence</span>
                        <ExternalLink className="h-3 w-3" />
                      </button>
                    </div>
                  )}

                  {/* Evidence Row */}
                  {(r.evidenceUrl || r.officialUrl || r.evidenceNotes) && (
                    <div className="flex flex-wrap items-center gap-3 p-3 rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] text-xs text-[var(--sp-charcoal)]">
                      {r.evidenceUrl && (
                        <a
                          href={r.evidenceUrl}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1.5 text-[var(--sp-harbour-teal)] hover:underline font-bold"
                        >
                          {r.evidenceType === "image" ? (
                            <ImageIcon className="h-3.5 w-3.5" />
                          ) : (
                            <FileText className="h-3.5 w-3.5" />
                          )}
                          <span>
                            {r.evidenceName || "View Evidence Document"}
                          </span>
                        </a>
                      )}
                      {r.officialUrl && (
                        <a
                          href={r.officialUrl}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1.5 text-[var(--sp-harbour-teal)] hover:underline font-bold"
                        >
                          <ExternalLink className="h-3.5 w-3.5" />
                          <span>Official Online Results</span>
                        </a>
                      )}
                      {r.evidenceNotes && r.verificationStatus !== "rejected" && (
                        <span className="text-[var(--sp-slate-soft)] italic">
                          “{r.evidenceNotes}”
                        </span>
                      )}
                    </div>
                  )}

                  {/* Actions on unverified / self-logged results vs Official regatta notice */}
                  {isResultVerified(r) ? (
                    <div className="flex items-center justify-between gap-2 pt-2.5 border-t border-[var(--sp-cool-veil)] text-xs text-[var(--sp-slate-soft)]">
                      <span className="inline-flex items-center gap-1.5 font-semibold text-emerald-800">
                        <ShieldCheck className="h-3.5 w-3.5 text-emerald-600" />
                        Verified Official Result
                      </span>
                      <span className="text-[13px] text-[var(--sp-slate-soft)] font-medium">
                        {r.countsForRanking ? "National Ranking Series" : "Official Event Record"}
                      </span>
                    </div>
                  ) : (
                    <div className="flex items-center justify-end gap-2 pt-2 border-t border-[var(--sp-cool-veil)]">
                      <button
                        type="button"
                        onClick={() => {
                          setEditingResult(r);
                          setEvidenceModalOpen(true);
                        }}
                        className="inline-flex items-center gap-1.5 rounded-xl border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-3 py-1.5 text-xs font-bold text-[var(--sp-charcoal)] transition-all shadow-2xs"
                      >
                        <Edit2 className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                        <span>Edit / Attach Evidence</span>
                      </button>
                      <button
                        type="button"
                        onClick={() => handleDeleteResult(r.id, r.regattaName)}
                        className="inline-flex items-center gap-1.5 rounded-xl border border-rose-200 bg-rose-50/50 hover:bg-rose-100 px-3 py-1.5 text-xs font-bold text-rose-700 transition-all"
                      >
                        <Trash2 className="h-3 w-3" />
                        <span>Delete</span>
                      </button>
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {/* Tab 2: Athlete Profile Editor */}
      {activeTab === "profile" && (
        <form
          onSubmit={handleSaveProfile}
          className="rounded-3xl border border-[var(--sp-cool-veil)] p-6 sm:p-8 space-y-6 bg-[var(--sp-warm-white)] shadow-xs"
        >
          <div className="flex items-center justify-between border-b border-[var(--sp-cool-veil)] pb-4">
            <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)] flex items-center gap-2">
              <User className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
              Athlete Personal &amp; Equipment Details
            </h3>
            <button
              type="submit"
              disabled={savingProfile}
              className="inline-flex items-center gap-2 rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] active:scale-[0.98] px-5 py-2 text-[15px] font-semibold text-white transition-all disabled:opacity-50 shadow-xs"
            >
              {savingProfile ? (
                <>
                  <Loader2 className="h-4 w-4 animate-spin" />
                  <span>Saving...</span>
                </>
              ) : (
                <>
                  <Save className="h-4 w-4" />
                  <span>Save Changes</span>
                </>
              )}
            </button>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Optimist Sail Number
              </label>
              <input
                type="text"
                value={profileForm.sailNumber}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, sailNumber: e.target.value })
                }
                placeholder="e.g. 711"
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                ILCA 4 Sail Number
              </label>
              <input
                type="text"
                value={profileForm.sailNumberIlca4}
                onChange={(e) =>
                  setProfileForm({
                    ...profileForm,
                    sailNumberIlca4: e.target.value,
                  })
                }
                placeholder="e.g. 219111"
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Sailing Club
              </label>
              <input
                type="text"
                value={profileForm.club}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, club: e.target.value })
                }
                placeholder="e.g. Changi Sailing Club (CSC)"
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                School
              </label>
              <input
                type="text"
                value={profileForm.school}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, school: e.target.value })
                }
                placeholder="e.g. Raffles Institution"
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Gender
              </label>
              <select
                value={profileForm.gender}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, gender: e.target.value })
                }
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              >
                <option value="M">Male (Boy)</option>
                <option value="F">Female (Girl)</option>
              </select>
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Nationality (NOC)
              </label>
              <GeographySelect
                value={profileForm.nationality}
                onChange={(val) =>
                  setProfileForm({
                    ...profileForm,
                    nationality: val || "SGP",
                  })
                }
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Date of Birth
              </label>
              <input
                type="date"
                value={profileForm.dob}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, dob: e.target.value })
                }
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Instagram Handle
              </label>
              <input
                type="text"
                value={profileForm.instagram}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, instagram: e.target.value })
                }
                placeholder="e.g. sailor_alex"
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>
          </div>

          <div className="pt-4 border-t border-[var(--sp-cool-veil)]">
            <h4 className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-teal)] mb-3">
              Standard Boat Gear &amp; Rig Configuration
            </h4>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                  Hull Brand
                </label>
                <input
                  type="text"
                  value={profileForm.hullBrand}
                  onChange={(e) =>
                    setProfileForm({
                      ...profileForm,
                      hullBrand: e.target.value,
                    })
                  }
                  placeholder="e.g. Winner 3D Star, Devoti, Far East"
                  className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                  Sail Make &amp; Model
                </label>
                <input
                  type="text"
                  value={profileForm.sailMake}
                  onChange={(e) =>
                    setProfileForm({
                      ...profileForm,
                      sailMake: e.target.value,
                    })
                  }
                  placeholder="e.g. North Sails P-5, Olimpic, J-Sails"
                  className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                  Foils (Daggerboard / Rudder)
                </label>
                <input
                  type="text"
                  value={profileForm.foilBrand}
                  onChange={(e) =>
                    setProfileForm({
                      ...profileForm,
                      foilBrand: e.target.value,
                    })
                  }
                  placeholder="e.g. DSK Flashtep, Optiparts"
                  className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                  Spar / Mast System
                </label>
                <input
                  type="text"
                  value={profileForm.mast}
                  onChange={(e) =>
                    setProfileForm({ ...profileForm, mast: e.target.value })
                  }
                  placeholder="e.g. Optimax MK4, Blackgold"
                  className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
                />
              </div>
            </div>
          </div>

          <div className="pt-4 border-t border-[var(--sp-cool-veil)] flex flex-col sm:flex-row sm:items-center justify-between gap-4 p-4 rounded-2xl bg-[var(--sp-sailcloth)]/70 border border-[var(--sp-cool-veil)]">
            <div>
              <h4 className="text-xs font-bold text-[var(--sp-charcoal)]">
                Career Milestones &amp; Sailing Journey
              </h4>
              <p className="text-[13px] text-[var(--sp-slate-soft)] mt-0.5">
                Key moments, breakthroughs, and campaigns. Athletes and parents can add, edit, or customize any milestone.
              </p>
            </div>
            <Link
              href={`/sailor/${athlete.id}#profile-journey`}
              className="inline-flex items-center gap-1.5 shrink-0 rounded-xl border border-[var(--sp-harbour-teal)]/40 bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-bold text-[var(--sp-harbour-teal)] transition-all shadow-2xs"
            >
              <span>Edit Milestones</span>
              <ExternalLink className="h-3.5 w-3.5" />
            </Link>
          </div>
        </form>
      )}

      {/* Tab 3: Equipment Locker */}
      {activeTab === "equipment" && (
        <div className="space-y-4">
          <EquipmentInventory
            sailorId={athlete.id}
            isOwner={true}
            canSeeEquipment={true}
            mayHaveIlca={Boolean(athlete.sailNumberIlca4)}
          />
        </div>
      )}

      {/* Tab 4: Verified Documents & Evidence Library */}
      {activeTab === "documents" && (
        <div className="rounded-3xl border border-[var(--sp-cool-veil)] p-6 sm:p-8 space-y-6 bg-[var(--sp-warm-white)] shadow-xs">
          <div>
            <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)] flex items-center gap-2">
              <FileText className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
              Evidence Documents &amp; Official Results Sheets
            </h3>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1">
              Official scorecards, noticeboards, and race committee results sheets attached to {athlete.name}&apos;s profile.
            </p>
          </div>

          {results.filter((r) => r.evidenceUrl || r.officialUrl).length === 0 ? (
            <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-8 text-center text-xs text-[var(--sp-slate-soft)]">
              No evidence documents uploaded yet. When you log non-ranking regattas and attach PDFs or photos, they appear in this library.
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {results
                .filter((r) => r.evidenceUrl || r.officialUrl)
                .map((r) => (
                  <div
                    key={r.id}
                    className="rounded-2xl border border-[var(--sp-cool-veil)] bg-white p-4 space-y-2 hover:border-[var(--sp-aqua-deep)]/50 transition-all shadow-2xs"
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <p className="font-bold text-[var(--sp-charcoal)] text-xs">
                          {r.regattaName}
                        </p>
                        <p className="text-[13px] text-[var(--sp-slate-soft)]">
                          {String(r.regattaDate).slice(0, 10)} · Place {r.rank}
                          {r.totalFleetSize ? ` / ${r.totalFleetSize}` : ""}
                        </p>
                      </div>
                      <div>
                        {isResultVerified(r) ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-emerald-50 border border-emerald-200 px-2.5 py-0.5 text-[11px] font-bold text-emerald-800">
                            Verified ✓
                          </span>
                        ) : r.verificationStatus === "rejected" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-rose-50 border border-rose-200 px-2.5 py-0.5 text-[11px] font-bold text-rose-800">
                            Rejected ✕
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 rounded-full bg-sky-50 border border-sky-200 px-2.5 py-0.5 text-[11px] font-bold text-sky-800">
                            Under Review
                          </span>
                        )}
                      </div>
                    </div>

                    <div className="pt-2 flex flex-wrap gap-2 text-xs">
                      {r.evidenceUrl && (
                        <a
                          href={r.evidenceUrl}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1.5 rounded-xl bg-sky-50 hover:bg-sky-100 text-sky-800 border border-sky-200 px-3 py-1.5 font-bold text-[11px] transition-colors"
                        >
                          {r.evidenceType === "image" ? (
                            <ImageIcon className="h-3.5 w-3.5 text-sky-700" />
                          ) : (
                            <FileText className="h-3.5 w-3.5 text-sky-700" />
                          )}
                          <span>
                            {r.evidenceName || "View Evidence Document"}
                          </span>
                        </a>
                      )}
                      {r.officialUrl && (
                        <a
                          href={r.officialUrl}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1.5 rounded-xl bg-teal-50 hover:bg-teal-100 text-[var(--sp-harbour-teal)] border border-teal-200 px-3 py-1.5 font-bold text-[11px] transition-colors"
                        >
                          <ExternalLink className="h-3.5 w-3.5" />
                          <span>Official URL</span>
                        </a>
                      )}
                    </div>
                  </div>
                ))}
            </div>
          )}
        </div>
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
  const { confirm } = useFeedback();
  const [selectedId, setSelectedId] = useState<string>(() => {
    if (currentSailorId && athletes.some((a) => a.id === currentSailorId)) {
      return currentSailorId;
    }
    return athletes[0]?.id || "";
  });
  // Tab state lives here so it survives athlete switches (workspace remounts)
  const [activeTab, setActiveTab] = useState<WorkspaceTab>(initialTab);
  // Set by the workspace when its profile form has unsaved edits
  const dirtyRef = useRef(false);
  const handleDirtyChange = useCallback((dirty: boolean) => {
    dirtyRef.current = dirty;
  }, []);

  const handleSelectAthlete = async (id: string) => {
    if (id === selectedId) return;
    if (dirtyRef.current) {
      const ok = await confirm({
        title: "Discard Unsaved Changes?",
        message:
          "You have unsaved edits on the athlete profile. Switching athlete will discard them.",
        confirmLabel: "Discard & Switch",
        tone: "danger",
      });
      if (!ok) return;
      dirtyRef.current = false;
    }
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
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-2.5 flex items-center justify-between gap-4 overflow-x-auto">
          <div className="flex items-center gap-2">
            <span className="text-xs font-bold text-[var(--sp-slate-soft)] flex items-center gap-1.5 pl-2 shrink-0">
              <Users className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
              <span>Select Athlete:</span>
            </span>
            <div className="flex items-center gap-1.5">
              {athletes.map((ath) => (
                <button
                  key={ath.id}
                  type="button"
                  onClick={() => void handleSelectAthlete(ath.id)}
                  className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
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

          <Link
            href="/claim-profile"
            className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline whitespace-nowrap pr-2"
          >
            + Link Another Sailor
          </Link>
        </div>
      )}

      {/* Active Athlete Workspace */}
      <AthleteWorkspace
        key={activeAthlete.id}
        athlete={activeAthlete}
        initialTab={activeTab}
        initialAction={initialAction}
        onTabChange={setActiveTab}
        onDirtyChange={handleDirtyChange}
      />
    </div>
  );
}
