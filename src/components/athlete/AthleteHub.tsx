"use client";

import { useState, useEffect, useCallback } from "react";
import Link from "next/link";
import Image from "next/image";
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

interface AthleteWorkspaceProps {
  athlete: AthleteProfile;
  initialTab?: "results" | "profile" | "equipment" | "documents";
  initialAction?: string;
}

function AthleteWorkspace({
  athlete,
  initialTab = "results",
  initialAction,
}: AthleteWorkspaceProps) {
  const { toast, confirm } = useFeedback();

  // Active tab: "results" | "profile" | "equipment" | "documents"
  const [activeTab, setActiveTab] = useState<
    "results" | "profile" | "equipment" | "documents"
  >(initialTab);

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
    "all" | "verified" | "pending" | "self"
  >("all");

  // Profile edit form state
  const [profileForm, setProfileForm] = useState({
    sailNumber: athlete.sailNumber || "",
    sailNumberIlca4: athlete.sailNumberIlca4 || "",
    club: athlete.club || "",
    school: athlete.school || "",
    gender: athlete.gender || "M",
    nationality: athlete.nationality || "SGP",
    dob: athlete.dob ? String(athlete.dob).slice(0, 10) : "",
    instagram: athlete.instagram || "",
    avatarUrl: athlete.avatarUrl || "",
    hullBrand: athlete.hullBrand || "",
    sailMake: athlete.sailMake || "",
    foilBrand: athlete.foilBrand || "",
    mast: athlete.mast || "",
    equipmentNotes: athlete.equipmentNotes || "",
  });
  const [savingProfile, setSavingProfile] = useState(false);

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
      toast.success("Athlete profile details updated!");
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

  const filteredResults = results.filter((r) => {
    if (resultFilter === "verified") return r.verificationStatus === "verified";
    if (resultFilter === "pending") return r.verificationStatus === "pending_review";
    if (resultFilter === "self")
      return r.verificationStatus === "self_reported" || !r.verificationStatus;
    return true;
  });

  return (
    <div className="space-y-6">
      {/* Athlete Header Card */}
      <div className="glass-panel rounded-3xl border border-white/10 p-6 sm:p-8 relative overflow-hidden bg-gradient-to-br from-[#121622] via-[#0d1017] to-[#090b10]">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-6">
          <div className="flex items-center gap-5">
            {/* Avatar */}
            <div className="relative h-16 w-16 sm:h-20 sm:w-20 rounded-2xl overflow-hidden bg-slate-800 border border-white/10 shrink-0">
              {athlete.avatarUrl ? (
                <Image
                  src={athlete.avatarUrl}
                  alt={athlete.name}
                  fill
                  className="object-cover"
                />
              ) : (
                <div className="h-full w-full flex items-center justify-center text-slate-400">
                  <User className="h-8 w-8" />
                </div>
              )}
            </div>

            {/* Identity Info */}
            <div className="space-y-1">
              <div className="flex flex-wrap items-center gap-2">
                <h1 className="text-xl sm:text-2xl font-black text-white tracking-tight">
                  {athlete.name}
                </h1>
                {athlete.currentFleet && (
                  <span className="px-2.5 py-0.5 rounded-full text-[10px] font-black uppercase tracking-wider bg-amber-500/15 text-amber-300 border border-amber-500/30">
                    {athlete.currentFleet} Fleet
                  </span>
                )}
                {athlete.nationalSquadStatus && (
                  <span className="px-2.5 py-0.5 rounded-full text-[10px] font-black uppercase tracking-wider bg-rose-500/15 text-rose-300 border border-rose-500/30">
                    National Squad
                  </span>
                )}
              </div>

              <div className="flex flex-wrap items-center gap-3 text-xs text-slate-400">
                {athlete.sailNumber && (
                  <span className="font-mono font-semibold text-slate-300">
                    Sail: SIN {athlete.sailNumber}
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
              className="inline-flex items-center gap-1.5 rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 text-slate-200 px-3.5 py-2 text-xs font-bold transition-colors"
            >
              <span>View Public Profile</span>
              <ExternalLink className="h-3.5 w-3.5 text-slate-400" />
            </Link>
            <button
              type="button"
              onClick={() => {
                setEditingResult(null);
                setEvidenceModalOpen(true);
              }}
              className="inline-flex items-center gap-1.5 rounded-xl bg-orange-600 hover:bg-orange-500 text-white px-4 py-2 text-xs font-bold transition-colors shadow-lg shadow-orange-600/20"
            >
              <Plus className="h-4 w-4" />
              <span>Log Score</span>
            </button>
          </div>
        </div>

        {/* Tab Navigation */}
        <div className="mt-8 pt-4 border-t border-white/10 flex gap-2 overflow-x-auto scrollbar-thin">
          <button
            type="button"
            onClick={() => setActiveTab("results")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "results"
                ? "bg-white/10 text-white border border-white/10"
                : "text-slate-400 hover:text-slate-200 hover:bg-white/5"
            }`}
          >
            <Trophy className="h-4 w-4 text-orange-400" />
            <span>Regattas & Evidence Logbook</span>
            <span className="ml-1 rounded-full bg-white/10 px-1.5 py-0.2 text-[10px] text-slate-300">
              {results.length}
            </span>
          </button>

          <button
            type="button"
            onClick={() => setActiveTab("profile")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "profile"
                ? "bg-white/10 text-white border border-white/10"
                : "text-slate-400 hover:text-slate-200 hover:bg-white/5"
            }`}
          >
            <User className="h-4 w-4 text-sky-400" />
            <span>Athlete Profile</span>
          </button>

          <button
            type="button"
            onClick={() => setActiveTab("equipment")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "equipment"
                ? "bg-white/10 text-white border border-white/10"
                : "text-slate-400 hover:text-slate-200 hover:bg-white/5"
            }`}
          >
            <Sailboat className="h-4 w-4 text-emerald-400" />
            <span>Equipment Locker</span>
          </button>

          <button
            type="button"
            onClick={() => setActiveTab("documents")}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "documents"
                ? "bg-white/10 text-white border border-white/10"
                : "text-slate-400 hover:text-slate-200 hover:bg-white/5"
            }`}
          >
            <FileText className="h-4 w-4 text-violet-400" />
            <span>Evidence Documents</span>
          </button>
        </div>
      </div>

      {/* Tab 1: Regattas & Evidence Logbook */}
      {activeTab === "results" && (
        <div className="space-y-4">
          {/* Action & Filter Bar */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-[#11141e] border border-white/5 p-4 rounded-2xl">
            <div className="flex flex-wrap items-center gap-2">
              <button
                type="button"
                onClick={() => setResultFilter("all")}
                className={`px-3 py-1 rounded-xl text-xs font-bold transition-colors ${
                  resultFilter === "all"
                    ? "bg-white/15 text-white"
                    : "text-slate-400 hover:text-white"
                }`}
              >
                All ({results.length})
              </button>
              <button
                type="button"
                onClick={() => setResultFilter("verified")}
                className={`px-3 py-1 rounded-xl text-xs font-bold transition-colors ${
                  resultFilter === "verified"
                    ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/30"
                    : "text-slate-400 hover:text-emerald-400"
                }`}
              >
                Verified ✓ (
                {results.filter((r) => r.verificationStatus === "verified").length}
                )
              </button>
              <button
                type="button"
                onClick={() => setResultFilter("pending")}
                className={`px-3 py-1 rounded-xl text-xs font-bold transition-colors ${
                  resultFilter === "pending"
                    ? "bg-sky-500/20 text-sky-300 border border-sky-500/30"
                    : "text-slate-400 hover:text-sky-400"
                }`}
              >
                Evidence Pending (
                {
                  results.filter((r) => r.verificationStatus === "pending_review")
                    .length
                }
                )
              </button>
              <button
                type="button"
                onClick={() => setResultFilter("self")}
                className={`px-3 py-1 rounded-xl text-xs font-bold transition-colors ${
                  resultFilter === "self"
                    ? "bg-amber-500/20 text-amber-300 border border-amber-500/30"
                    : "text-slate-400 hover:text-amber-400"
                }`}
              >
                Self-Reported (
                {
                  results.filter(
                    (r) =>
                      r.verificationStatus === "self_reported" ||
                      !r.verificationStatus
                  ).length
                }
                )
              </button>
            </div>

            <button
              type="button"
              onClick={() => {
                setEditingResult(null);
                setEvidenceModalOpen(true);
              }}
              className="inline-flex items-center justify-center gap-2 rounded-xl bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white transition-colors shadow-sm"
            >
              <Plus className="h-4 w-4" />
              <span>Log Regatta Score & Evidence</span>
            </button>
          </div>

          {/* Results List */}
          {loadingResults ? (
            <div className="p-12 text-center text-slate-400 flex items-center justify-center gap-2">
              <Loader2 className="h-5 w-5 animate-spin text-orange-500" />
              <span>Loading regatta logbook...</span>
            </div>
          ) : filteredResults.length === 0 ? (
            results.length === 0 ? (
              /* First-run: logbook is completely empty */
              <div className="rounded-3xl border border-white/5 bg-[#11141e] p-12 text-center space-y-4">
                <div className="mx-auto h-12 w-12 rounded-2xl bg-orange-500/10 text-orange-400 flex items-center justify-center border border-orange-500/20">
                  <Trophy className="h-6 w-6" />
                </div>
                <div className="space-y-1">
                  <h3 className="text-base font-bold text-white">
                    Log your first regatta
                  </h3>
                  <p className="text-xs text-slate-400 max-w-sm mx-auto">
                    Log personal, club, or overseas regattas to track performance — attach official evidence to earn a Verified ✓ badge.
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    setEditingResult(null);
                    setEvidenceModalOpen(true);
                  }}
                  className="inline-flex items-center gap-2 rounded-xl bg-orange-600 hover:bg-orange-500 text-white px-5 py-2.5 text-xs font-bold transition-colors"
                >
                  <Plus className="h-4 w-4" />
                  <span>Log Regatta Score</span>
                </button>
              </div>
            ) : (
              /* Logbook has results, but the active filter hides them all */
              <div className="rounded-3xl border border-white/5 bg-[#11141e] p-12 text-center space-y-4">
                <div className="mx-auto h-12 w-12 rounded-2xl bg-sky-500/10 text-sky-400 flex items-center justify-center border border-sky-500/20">
                  <Trophy className="h-6 w-6" />
                </div>
                <div className="space-y-1">
                  <h3 className="text-base font-bold text-white">
                    No regatta scores match this filter
                  </h3>
                  <p className="text-xs text-slate-400 max-w-sm mx-auto">
                    You have {results.length} logged {results.length === 1 ? "result" : "results"} — try a different filter to see them.
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => setResultFilter("all")}
                  className="inline-flex items-center gap-2 rounded-xl border border-white/15 bg-white/5 hover:bg-white/10 text-white px-5 py-2.5 text-xs font-bold transition-colors"
                >
                  <span>Show All Results</span>
                </button>
              </div>
            )
          ) : (
            <div className="space-y-3">
              {filteredResults.map((r) => (
                <div
                  key={r.id}
                  className="rounded-2xl border border-white/5 bg-[#121520] p-4 sm:p-5 hover:border-white/10 transition-colors space-y-3"
                >
                  <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div className="space-y-1">
                      <div className="flex flex-wrap items-center gap-2">
                        <span className="font-bold text-white text-sm sm:text-base">
                          {r.regattaName}
                        </span>
                        {r.countsForRanking ? (
                          <span className="rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2 py-0.5 text-[9px] font-black uppercase text-emerald-300">
                            Singapore Series Ranking
                          </span>
                        ) : (
                          <span className="rounded-full bg-sky-500/15 border border-sky-500/30 px-2 py-0.5 text-[9px] font-black uppercase text-sky-300">
                            Non-Ranking / Overseas Logbook
                          </span>
                        )}
                      </div>

                      <p className="text-xs text-slate-400">
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
                        <div className="font-mono text-base font-black text-white">
                          Place {r.rank}
                          {r.totalFleetSize ? (
                            <span className="text-xs font-normal text-slate-400">
                              {" "}
                              / {r.totalFleetSize}
                            </span>
                          ) : null}
                        </div>
                        {r.nettScore != null && (
                          <div className="text-[11px] font-mono text-slate-400">
                            nett {r.nettScore} pts
                          </div>
                        )}
                      </div>

                      {/* Verification Status Badge */}
                      <div>
                        {r.verificationStatus === "verified" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2.5 py-1 text-[11px] font-bold text-emerald-300">
                            <ShieldCheck className="h-3.5 w-3.5" />
                            Verified ✓
                          </span>
                        ) : r.verificationStatus === "pending_review" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-sky-500/15 border border-sky-500/30 px-2.5 py-1 text-[11px] font-bold text-sky-300">
                            <FileText className="h-3.5 w-3.5" />
                            Evidence Attached
                          </span>
                        ) : r.verificationStatus === "rejected" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-rose-500/15 border border-rose-500/30 px-2.5 py-1 text-[11px] font-bold text-rose-300">
                            <AlertCircle className="h-3.5 w-3.5" />
                            Rejected
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 rounded-full bg-amber-500/15 border border-amber-500/30 px-2.5 py-1 text-[11px] font-bold text-amber-300">
                            Self-Reported
                          </span>
                        )}
                      </div>
                    </div>
                  </div>

                  {/* Evidence Row */}
                  {(r.evidenceUrl || r.officialUrl || r.evidenceNotes) && (
                    <div className="flex flex-wrap items-center gap-3 p-2.5 rounded-xl bg-white/[0.02] border border-white/5 text-xs">
                      {r.evidenceUrl && (
                        <a
                          href={r.evidenceUrl}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1.5 text-sky-400 hover:text-sky-300 font-semibold underline underline-offset-2"
                        >
                          {r.evidenceType === "image" ? (
                            <ImageIcon className="h-3.5 w-3.5" />
                          ) : (
                            <FileText className="h-3.5 w-3.5" />
                          )}
                          <span>
                            {r.evidenceName || "View Uploaded Evidence"}
                          </span>
                        </a>
                      )}
                      {r.officialUrl && (
                        <a
                          href={r.officialUrl}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1.5 text-indigo-400 hover:text-indigo-300 font-semibold underline underline-offset-2"
                        >
                          <ExternalLink className="h-3.5 w-3.5" />
                          <span>Official Online Results</span>
                        </a>
                      )}
                      {r.evidenceNotes && (
                        <span className="text-slate-400 italic">
                          “{r.evidenceNotes}”
                        </span>
                      )}
                    </div>
                  )}

                  {/* Actions on non-ranking results */}
                  {!r.countsForRanking && (
                    <div className="flex items-center justify-end gap-2 pt-1 border-t border-white/5">
                      <button
                        type="button"
                        onClick={() => {
                          setEditingResult(r);
                          setEvidenceModalOpen(true);
                        }}
                        className="inline-flex items-center gap-1 rounded-lg border border-white/10 bg-white/5 hover:bg-white/10 px-2.5 py-1 text-[11px] font-bold text-slate-300 hover:text-white transition-colors"
                      >
                        <Edit2 className="h-3 w-3" />
                        <span>Edit / Attach Evidence</span>
                      </button>
                      <button
                        type="button"
                        onClick={() => handleDeleteResult(r.id, r.regattaName)}
                        className="inline-flex items-center gap-1 rounded-lg border border-rose-500/20 bg-rose-500/5 hover:bg-rose-500/15 px-2.5 py-1 text-[11px] font-bold text-rose-400 transition-colors"
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
          className="glass-panel rounded-3xl border border-white/10 p-6 sm:p-8 space-y-6 bg-[#121520]"
        >
          <div className="flex items-center justify-between">
            <h3 className="text-base font-bold text-white flex items-center gap-2">
              <User className="h-5 w-5 text-sky-400" />
              Athlete Personal & Equipment Details
            </h3>
            <button
              type="submit"
              disabled={savingProfile}
              className="inline-flex items-center gap-2 rounded-xl bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white transition-colors disabled:opacity-50"
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
              <label className="block text-xs font-medium text-slate-300 mb-1">
                Optimist Sail Number
              </label>
              <input
                type="text"
                value={profileForm.sailNumber}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, sailNumber: e.target.value })
                }
                placeholder="e.g. 711"
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white font-mono focus:border-orange-500 focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1">
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
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white font-mono focus:border-orange-500 focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1">
                Sailing Club
              </label>
              <input
                type="text"
                value={profileForm.club}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, club: e.target.value })
                }
                placeholder="e.g. Changi Sailing Club (CSC)"
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1">
                School
              </label>
              <input
                type="text"
                value={profileForm.school}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, school: e.target.value })
                }
                placeholder="e.g. Raffles Institution"
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1">
                Gender
              </label>
              <select
                value={profileForm.gender}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, gender: e.target.value })
                }
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
              >
                <option value="M">Male (M)</option>
                <option value="F">Female (F)</option>
              </select>
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1">
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
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1">
                Date of Birth
              </label>
              <input
                type="date"
                value={profileForm.dob}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, dob: e.target.value })
                }
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1">
                Instagram Handle
              </label>
              <input
                type="text"
                value={profileForm.instagram}
                onChange={(e) =>
                  setProfileForm({ ...profileForm, instagram: e.target.value })
                }
                placeholder="e.g. sailor_alex"
                className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
              />
            </div>
          </div>

          <div className="pt-4 border-t border-white/10">
            <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-3">
              Standard Boat Gear & Rig Configuration
            </h4>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-medium text-slate-300 mb-1">
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
                  className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-medium text-slate-300 mb-1">
                  Sail Make & Model
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
                  className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-medium text-slate-300 mb-1">
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
                  className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-medium text-slate-300 mb-1">
                  Spar / Mast System
                </label>
                <input
                  type="text"
                  value={profileForm.mast}
                  onChange={(e) =>
                    setProfileForm({ ...profileForm, mast: e.target.value })
                  }
                  placeholder="e.g. Optimax MK4, Blackgold"
                  className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
                />
              </div>
            </div>
          </div>

          <div className="flex justify-end pt-2">
            <button
              type="submit"
              disabled={savingProfile}
              className="inline-flex items-center gap-2 rounded-xl bg-orange-600 hover:bg-orange-500 px-5 py-2.5 text-xs font-bold text-white transition-colors disabled:opacity-50"
            >
              {savingProfile ? (
                <>
                  <Loader2 className="h-4 w-4 animate-spin" />
                  <span>Saving...</span>
                </>
              ) : (
                <>
                  <Save className="h-4 w-4" />
                  <span>Save Athlete Profile</span>
                </>
              )}
            </button>
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
        <div className="glass-panel rounded-3xl border border-white/10 p-6 sm:p-8 space-y-6 bg-[#121520]">
          <div>
            <h3 className="text-base font-bold text-white flex items-center gap-2">
              <FileText className="h-5 w-5 text-violet-400" />
              Evidence Documents & Official Results Sheets
            </h3>
            <p className="text-xs text-slate-400 mt-1">
              Official scorecards, noticeboards, and race committee results sheets attached to {athlete.name}&apos;s profile.
            </p>
          </div>

          {results.filter((r) => r.evidenceUrl || r.officialUrl).length === 0 ? (
            <div className="rounded-2xl border border-white/5 bg-slate-950/40 p-8 text-center text-xs text-slate-500">
              No evidence documents uploaded yet. When you log non-ranking regattas and attach PDFs or photos, they appear in this library.
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {results
                .filter((r) => r.evidenceUrl || r.officialUrl)
                .map((r) => (
                  <div
                    key={r.id}
                    className="rounded-2xl border border-white/10 bg-slate-900/60 p-4 space-y-2 hover:border-white/20 transition-colors"
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <p className="font-bold text-white text-xs">
                          {r.regattaName}
                        </p>
                        <p className="text-[11px] text-slate-400">
                          {String(r.regattaDate).slice(0, 10)} · Place {r.rank}
                          {r.totalFleetSize ? ` / ${r.totalFleetSize}` : ""}
                        </p>
                      </div>
                      <div>
                        {r.verificationStatus === "verified" ? (
                          <span className="inline-flex items-center gap-1 rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2 py-0.5 text-[9px] font-bold text-emerald-300">
                            Verified ✓
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 rounded-full bg-sky-500/15 border border-sky-500/30 px-2 py-0.5 text-[9px] font-bold text-sky-300">
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
                          className="inline-flex items-center gap-1.5 rounded-lg bg-sky-500/10 hover:bg-sky-500/20 text-sky-300 border border-sky-500/20 px-3 py-1.5 font-semibold text-[11px] transition-colors"
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
                          className="inline-flex items-center gap-1.5 rounded-lg bg-indigo-500/10 hover:bg-indigo-500/20 text-indigo-300 border border-indigo-500/20 px-3 py-1.5 font-semibold text-[11px] transition-colors"
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
  initialSailorId?: string;
  initialTab?: "results" | "profile" | "equipment" | "documents";
  initialAction?: string;
}

export function AthleteHub({
  athletes,
  initialSailorId,
  initialTab = "results",
  initialAction,
}: AthleteHubProps) {
  // Active athlete selection
  const [activeAthleteId, setActiveAthleteId] = useState<string>(
    () =>
      initialSailorId && athletes.some((a) => a.id === initialSailorId)
        ? initialSailorId
        : athletes[0]?.id || ""
  );

  const activeAthlete =
    athletes.find((a) => a.id === activeAthleteId) || athletes[0];

  if (!activeAthlete) {
    return (
      <div className="p-12 text-center text-slate-400">
        No claimed athlete profile found.
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-6xl px-4 sm:px-6 py-8 space-y-6">
      {/* Top Banner: Parent / Multi-Athlete Switcher */}
      {athletes.length > 1 && (
        <div className="flex flex-wrap items-center gap-2 p-1.5 rounded-2xl bg-white/[0.03] border border-white/10">
          <span className="px-3 text-xs font-bold text-slate-400 uppercase tracking-wider flex items-center gap-1.5">
            <Users className="h-3.5 w-3.5 text-emerald-400" />
            Switch Athlete:
          </span>
          {athletes.map((ath) => (
            <button
              key={ath.id}
              type="button"
              onClick={() => setActiveAthleteId(ath.id)}
              className={`inline-flex items-center gap-2 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all ${
                ath.id === activeAthlete.id
                  ? "bg-orange-600 text-white shadow-md shadow-orange-600/20"
                  : "bg-white/5 text-slate-300 hover:bg-white/10 hover:text-white"
              }`}
            >
              <span>{ath.name}</span>
              {ath.sailNumber && (
                <span className="font-mono text-[11px] opacity-75">
                  SIN {ath.sailNumber}
                </span>
              )}
            </button>
          ))}
        </div>
      )}

      {/* Athlete Workspace (remounts cleanly on athlete switch) */}
      <AthleteWorkspace
        key={activeAthlete.id}
        athlete={activeAthlete}
        initialTab={initialTab}
        initialAction={initialAction}
      />
    </div>
  );
}
