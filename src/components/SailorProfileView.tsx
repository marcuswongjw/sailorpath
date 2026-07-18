"use client";

import { useState } from "react";
import Link from "next/link";
import { getPercentileBadge } from "@/lib/ranking";
import {
  seriesFleetStatus,
  seriesStatusBadge,
} from "@/lib/seriesMembership";
import {
  Trophy,
  Compass,
  EyeOff,
  Settings,
  MapPin,
  TrendingUp,
  User,
  Link2,
  UserPlus,
} from "lucide-react";

interface SailorProfileViewProps {
  initialSailor: any;
  initialResults: any[];
  initialEquipment: any;
  canSeePrivate?: boolean;
  canClaim?: boolean;
  isOwner?: boolean;
  /** Product-tour mode on /sample — claim does not hit the live API */
  demoMode?: boolean;
  demoRole?: "public" | "sailor" | "parent" | "coach";
  onDemoClaim?: () => void;
}

function resolveDisplayFleet(sailor: any): {
  label: string;
  className: string;
} {
  return seriesStatusBadge(seriesFleetStatus(sailor));
}

function buildHonorTags(sailor: any): { text: string; className: string }[] {
  const tags: { text: string; className: string }[] = [];
  const squad =
    sailor.nationalSquadStatus ||
    sailor.natSquadStatusJul26 ||
    sailor.natSquadStatusJan26;
  if (squad) {
    tags.push({
      text: `Nat Squad: ${squad}`,
      className:
        "bg-orange-500/10 text-orange-300 border border-orange-500/25",
    });
  }
  if (sailor.worlds) {
    tags.push({
      text: `World Optimist Championships ${sailor.worlds}`,
      className: "bg-red-500/10 text-red-400 border border-red-500/20",
    });
  }
  if (sailor.european) {
    tags.push({
      text: `European Optimist Championships ${sailor.european}`,
      className: "bg-blue-500/10 text-blue-300 border border-blue-500/20",
    });
  }
  if (sailor.asian) {
    tags.push({
      text: `Asian Optimist Championships ${sailor.asian}`,
      className:
        "bg-emerald-500/10 text-emerald-400 border border-emerald-500/20",
    });
  }
  if (sailor.seaGames) {
    tags.push({
      text: `SEA Games ${sailor.seaGames}`,
      className: "bg-violet-500/10 text-violet-300 border border-violet-500/20",
    });
  }
  return tags;
}

function initials(name: string) {
  const parts = String(name || "")
    .trim()
    .split(/\s+/)
    .filter(Boolean);
  if (!parts.length) return "?";
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
  return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
}

export function SailorProfileView({
  initialSailor,
  initialResults,
  initialEquipment,
  canSeePrivate = false,
  canClaim = false,
  isOwner = false,
  demoMode = false,
  demoRole,
  onDemoClaim,
}: SailorProfileViewProps) {
  const [isPublicWeight, setIsPublicWeight] = useState(
    initialSailor.isPublicWeight || false
  );
  const [isPublicDob, setIsPublicDob] = useState(
    initialSailor.isPublicDob || false
  );
  const [isPublicEquipment, setIsPublicEquipment] = useState(
    initialSailor.isPublicEquipment ?? true
  );
  const [visibleCount, setVisibleCount] = useState(15);
  const [claimStatus, setClaimStatus] = useState<string | null>(null);
  const [claimBusy, setClaimBusy] = useState(false);
  const [copyMsg, setCopyMsg] = useState<string | null>(null);

  const hasPrivateAccess = canSeePrivate;
  const showWeight = isPublicWeight || hasPrivateAccess;
  const showEquipment = isPublicEquipment || hasPrivateAccess;

  const fleetBadge = resolveDisplayFleet(initialSailor);
  const honors = buildHonorTags(initialSailor);

  const calculateAge = (dobString: string) => {
    if (!dobString) return "N/A";
    const today = new Date();
    const birthDate = new Date(dobString);
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age;
  };

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 flex-1 flex flex-col gap-8">
      {/* Header */}
      <div className="glass-panel rounded-3xl p-6 md:p-8 border border-white/5 relative overflow-hidden flex flex-col md:flex-row items-center md:items-start justify-between gap-6">
        <div className="absolute top-0 right-0 w-64 h-64 bg-orange-600/5 rounded-full blur-3xl -z-10" />

        <div className="flex flex-col md:flex-row items-center gap-6 min-w-0">
          {/* Avatar: photo if set, else initials */}
          <div className="relative h-28 w-28 md:h-32 md:w-32 rounded-full border-2 border-orange-500/25 shadow-xl bg-gradient-to-br from-orange-600/30 to-slate-900 flex items-center justify-center shrink-0 overflow-hidden">
            {initialSailor.avatarUrl ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={initialSailor.avatarUrl}
                alt={initialSailor.name}
                className="h-full w-full object-cover"
              />
            ) : (
              <span className="text-3xl md:text-4xl font-black text-orange-300 tracking-tight">
                {initials(initialSailor.name)}
              </span>
            )}
            <span className="absolute -bottom-1 -right-1 h-8 w-8 rounded-full bg-slate-900 border border-white/10 flex items-center justify-center">
              <User className="h-4 w-4 text-slate-400" />
            </span>
          </div>

          <div className="text-center md:text-left min-w-0">
            <div className="flex flex-col md:flex-row md:items-center gap-2 md:gap-3">
              <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
                {initialSailor.name}
              </h1>
              <span
                className={`self-center inline-flex items-center rounded-full px-3 py-0.5 text-xs font-bold border ${fleetBadge.className}`}
              >
                {fleetBadge.label}
              </span>
            </div>

            <p className="mt-2 text-slate-400 flex flex-wrap items-center justify-center md:justify-start gap-x-3 gap-y-1.5 text-sm font-medium">
              <span className="flex items-center gap-1">
                <MapPin className="h-4 w-4 text-orange-500" />
                {initialSailor.club}
                {initialSailor.school ? ` · ${initialSailor.school}` : ""}
                {initialSailor.nationality
                  ? ` · ${initialSailor.nationality}`
                  : ""}
              </span>
            </p>

            {initialSailor.bio && (
              <p className="mt-3 text-xs md:text-sm text-slate-300 italic max-w-md bg-white/5 px-3 py-2 rounded-xl border border-white/5">
                &ldquo;{initialSailor.bio}&rdquo;
              </p>
            )}

            <div className="mt-4 flex flex-wrap justify-center md:justify-start gap-2">
              {honors.length === 0 ? (
                <span className="text-[11px] text-slate-600">
                  No squad / campaign tags yet
                </span>
              ) : (
                honors.map((h, idx) => (
                  <span
                    key={idx}
                    className={`rounded-full px-3 py-0.5 text-xs font-semibold ${h.className}`}
                  >
                    {h.text}
                  </span>
                ))
              )}
            </div>

            <div className="mt-4 flex flex-wrap justify-center md:justify-start gap-2">
              <button
                type="button"
                onClick={async () => {
                  try {
                    const url = typeof window !== "undefined" ? window.location.href : "";
                    await navigator.clipboard.writeText(url);
                    setCopyMsg("Link copied");
                    setTimeout(() => setCopyMsg(null), 2000);
                  } catch {
                    setCopyMsg("Could not copy");
                  }
                }}
                className="inline-flex items-center gap-1.5 rounded-full bg-white/5 border border-white/10 px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white"
              >
                <Link2 className="h-3.5 w-3.5" />
                {copyMsg || "Copy profile link"}
              </button>
              {canClaim && (
                <button
                  type="button"
                  disabled={
                    claimBusy ||
                    Boolean(claimStatus) ||
                    (demoMode && !onDemoClaim)
                  }
                  onClick={async () => {
                    if (demoMode) {
                      onDemoClaim?.();
                      return;
                    }
                    setClaimBusy(true);
                    try {
                      const res = await fetch("/api/claims", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ sailorId: initialSailor.id }),
                      });
                      const data = await res.json();
                      if (!res.ok) throw new Error(data.error || "Claim failed");
                      setClaimStatus("pending");
                    } catch (e: any) {
                      setClaimStatus(e.message || "Error");
                    } finally {
                      setClaimBusy(false);
                    }
                  }}
                  className="inline-flex items-center gap-1.5 rounded-full bg-orange-600/90 hover:bg-orange-500 disabled:opacity-50 px-3 py-1.5 text-[11px] font-bold text-white"
                >
                  <UserPlus className="h-3.5 w-3.5" />
                  {claimStatus === "pending"
                    ? "Claim pending"
                    : claimBusy
                      ? "Submitting…"
                      : demoMode
                        ? "Claim this profile (demo)"
                        : "Claim this profile"}
                </button>
              )}
              {isOwner && (
                <span className="text-[11px] font-bold text-emerald-400/90 self-center">
                  {demoMode
                    ? demoRole === "parent"
                      ? "Parent view · linked guardian"
                      : "You manage this profile"
                    : "You manage this profile"}
                </span>
              )}
            </div>
            {claimStatus && claimStatus !== "pending" && (
              <p className="mt-2 text-[11px] text-rose-300 text-center md:text-left">
                {claimStatus}
              </p>
            )}
          </div>
        </div>

        <div className="text-center md:text-right border-t md:border-t-0 border-white/5 pt-4 md:pt-0 w-full md:w-auto shrink-0">
          <span className="block text-xs font-bold text-slate-500 tracking-widest uppercase">
            Sail number
          </span>
          <span className="block text-3xl md:text-5xl font-black text-orange-500 tracking-tight mt-1 font-mono">
            {initialSailor.sailNumber || "—"}
          </span>
        </div>
      </div>

      {/* Equal-width Athlete Stats + Equipment */}
      <div
        className={`grid grid-cols-1 gap-6 ${
          canSeePrivate ? "lg:grid-cols-3" : "lg:grid-cols-2"
        }`}
      >
        <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col h-full min-h-[220px]">
          <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
            <TrendingUp className="h-4 w-4 text-orange-500" />
            Athlete Statistics
          </h2>
          <div className="grid grid-cols-2 gap-4 flex-1">
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Age
              </span>
              <span className="block text-2xl font-extrabold text-white mt-1">
                {calculateAge(initialSailor.dob)}
                {initialSailor.dob ? " yrs" : ""}
              </span>
            </div>
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Weight
              </span>
              <span className="block text-2xl font-extrabold text-white mt-1 font-mono">
                {showWeight && initialSailor.weight != null
                  ? `${initialSailor.weight} kg`
                  : "Private"}
              </span>
              {!showWeight && (
                <span className="text-[10px] text-slate-500 mt-1 flex items-center justify-center gap-0.5">
                  <EyeOff className="h-3 w-3" /> Locked
                </span>
              )}
            </div>
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Regattas
              </span>
              <span className="block text-2xl font-extrabold text-orange-500 mt-1">
                {initialResults.length}
              </span>
            </div>
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Gender
              </span>
              <span className="block text-2xl font-extrabold text-white mt-1">
                {initialSailor.gender || "—"}
              </span>
            </div>
          </div>
        </div>

        <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col h-full min-h-[220px]">
          <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
            <Compass className="h-4 w-4 text-orange-500" />
            Equipment &amp; Rig Log
          </h2>
          {showEquipment && initialEquipment ? (
            <div className="space-y-4 font-medium text-sm flex-1">
              <div className="flex justify-between border-b border-white/5 pb-2">
                <span className="text-slate-500">Hull Brand</span>
                <span className="text-white font-bold">
                  {initialEquipment.hullBrand}
                </span>
              </div>
              <div className="flex justify-between border-b border-white/5 pb-2">
                <span className="text-slate-500">Sail Make</span>
                <span className="text-white font-bold">
                  {initialEquipment.sailMake}
                </span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-500">Foil Brand</span>
                <span className="text-white font-bold">
                  {initialEquipment.foilBrand}
                </span>
              </div>
            </div>
          ) : (
            <div className="flex-1 flex flex-col items-center justify-center text-center p-4">
              <EyeOff className="h-8 w-8 text-slate-600 mb-2" />
              <p className="text-xs text-slate-400">
                {initialEquipment
                  ? "Equipment log is private."
                  : "No equipment logged yet."}
              </p>
            </div>
          )}
        </div>

        {canSeePrivate && (
          <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col h-full min-h-[220px]">
            <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
              <Settings className="h-4 w-4 text-orange-500" />
              Privacy Toggles
            </h2>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <label className="text-xs font-semibold text-slate-300">
                  Share Weight
                </label>
                <input
                  type="checkbox"
                  checked={isPublicWeight}
                  onChange={(e) => setIsPublicWeight(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                />
              </div>
              <div className="flex items-center justify-between border-t border-white/5 pt-3">
                <label className="text-xs font-semibold text-slate-300">
                  Share Equipment Log
                </label>
                <input
                  type="checkbox"
                  checked={isPublicEquipment}
                  onChange={(e) => setIsPublicEquipment(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                />
              </div>
              <div className="flex items-center justify-between border-t border-white/5 pt-3">
                <label className="text-xs font-semibold text-slate-300">
                  Share DOB
                </label>
                <input
                  type="checkbox"
                  checked={isPublicDob}
                  onChange={(e) => setIsPublicDob(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                />
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Logbook */}
      <div className="glass-panel rounded-3xl p-6 md:p-8 border border-white/5">
        <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
          <div>
            <h2 className="text-xl font-bold text-white flex items-center gap-2">
              <Trophy className="h-5 w-5 text-orange-500" />
              Regatta Logbook
            </h2>
            <p className="text-xs text-slate-400 mt-1">
              Historical racing records and percentile badges.
            </p>
          </div>
          <span className="text-xs text-slate-500 font-bold uppercase">
            {initialResults.length} Regattas Tracked
          </span>
        </div>

        {initialResults.length === 0 ? (
          <p className="text-sm text-slate-500">No regatta results yet.</p>
        ) : (
          <div className="space-y-3">
            {initialResults.slice(0, visibleCount).map((res: any, idx: number) => {
              const fleetSize = res.totalFleetSize ?? res.fleetSize ?? 50;
              const rowKey =
                res.id || res.regattaId || res.regattaSlug || `r-${idx}`;
              const { label, className } = getPercentileBadge(
                res.rank,
                fleetSize
              );
              const overseas = Boolean(res.isOverseasCommitment);
              const dns = Boolean(res.isDns || res.isDNS) && !overseas;
              const slug = res.regattaSlug || res.id;
              const nameNode =
                slug && String(slug).length > 2 ? (
                  <Link
                    href={`/sg/optimist/regattas/${slug}`}
                    className="text-base font-bold text-white truncate hover:text-orange-400"
                  >
                    {res.regattaName}
                  </Link>
                ) : (
                  <h3 className="text-base font-bold text-white truncate">
                    {res.regattaName}
                  </h3>
                );
              return (
                <div
                  key={rowKey}
                  className={`glass-card rounded-2xl border border-white/5 p-5 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 ${
                    overseas
                      ? "border-sky-500/20"
                      : dns
                        ? "border-rose-500/15"
                        : ""
                  }`}
                >
                  <div className="flex-1 min-w-0">
                    {nameNode}
                    <p className="text-xs text-slate-500 mt-1 font-semibold">
                      {res.regattaDate}
                      {res.division ? ` · ${res.division}` : ""}
                    </p>
                    <div className="mt-2 flex flex-wrap gap-1.5">
                      {overseas && (
                        <span className="rounded-full bg-sky-500/10 border border-sky-500/25 px-2 py-0.5 text-[10px] font-bold text-sky-300">
                          Overseas†
                        </span>
                      )}
                      {dns && (
                        <span className="rounded-full bg-rose-500/10 border border-rose-500/25 px-2 py-0.5 text-[10px] font-bold text-rose-400">
                          DNS*
                        </span>
                      )}
                    </div>
                  </div>
                  <div className="flex items-center gap-4 w-full sm:w-auto justify-between sm:justify-end">
                    <div className="text-left sm:text-right font-semibold text-sm">
                      <span className="block text-xs text-slate-500 uppercase">
                        Points
                      </span>
                      <span className="text-white text-lg font-black">
                        {res.rank}
                        {overseas ? "†" : dns ? "*" : ""}
                      </span>
                      <span className="text-slate-400 text-xs">
                        {" "}
                        / {fleetSize}
                      </span>
                    </div>
                    <div className="text-left sm:text-right font-semibold text-sm">
                      <span className="block text-xs text-slate-500 uppercase">
                        Total
                      </span>
                      <span className="text-white text-lg font-black">
                        {res.totalScore != null ? res.totalScore : "—"}
                      </span>
                    </div>
                    <div className="text-left sm:text-right font-semibold text-sm">
                      <span className="block text-xs text-slate-500 uppercase">
                        Nett
                      </span>
                      <span className="text-white text-lg font-black">{res.nettScore != null ? res.nettScore : "—"}</span>
                    </div>
                    <span
                      className={`rounded-full px-2.5 py-0.5 text-xs font-bold ${className}`}
                    >
                      {label}
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {initialResults.length > visibleCount && (
          <div className="mt-8 text-center">
            <button
              type="button"
              onClick={() => setVisibleCount((prev) => prev + 15)}
              className="rounded-full bg-slate-800 px-6 py-2.5 text-sm font-semibold text-slate-200 hover:bg-slate-700 hover:text-white transition-all border border-white/5"
            >
              Load More
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
