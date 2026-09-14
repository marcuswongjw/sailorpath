"use client";

import { useRef, useState, type ReactNode } from "react";
import Link from "next/link";
import {
  Share2,
  Check,
  UserPlus,
  Pencil,
  Camera,
  Eye,
  EyeOff,
  Anchor,
  Trophy,
  BadgeCheck,
  ShieldAlert,
  Medal,
  Sailboat,
} from "lucide-react";
import {
  PROFILE_CARD_CLASS as cardClass,
  nationalityFlag,
  nationalityLabel,
  initials,
} from "./helpers";
import type { SailorRecordProps, SeriesStandingProps } from "./types";

export interface HeroAthleteCardProps {
  displaySailor: SailorRecordProps;
  fleetBadge: { label: string; className: string };
  activeStanding: SeriesStandingProps | null;
  standingIsIlca: boolean;
  dualClass?: boolean;
  selectedBoatClass?: "optimist" | "ilca4";
  onSelectBoatClass?: (cls: "optimist" | "ilca4") => void;
  medals?: { gold: number; silver: number; bronze: number; show: boolean };
  profileClaimed?: boolean;
  profileVerified?: boolean;
  showUnclaimedBanner?: boolean;
  canClaim?: boolean;
  claimStatus?: string | null;
  claimMsg?: string | null;
  claimPanelOpen?: boolean;
  onToggleClaimPanel?: () => void;
  onDemoClaim?: () => void;
  demoMode?: boolean;
  isLoggedIn?: boolean;
  isOwner?: boolean;
  ownerView?: boolean;
  previewPublic?: boolean;
  onTogglePreviewPublic?: () => void;
  editing?: boolean;
  onToggleEditing?: () => void;
  avatarBusy?: boolean;
  avatarMsg?: string | null;
  onUploadAvatar?: (file: File) => void;
  showWeight?: boolean;
  bornYear?: string | null;
  fullDobLabel?: string | null;
  showFullDob?: boolean;
  leftOptimistYear?: number | null;
  sailDisplay?: string | null;
  sailIlca4?: string | null;
  noc?: string;
  totalRegattasCount?: number;
}

export function HeroAthleteCard({
  displaySailor,
  fleetBadge,
  activeStanding,
  standingIsIlca,
  dualClass = false,
  selectedBoatClass = "optimist",
  onSelectBoatClass,
  medals,
  profileClaimed = false,
  profileVerified = false,
  showUnclaimedBanner = false,
  canClaim = false,
  claimStatus = null,
  claimMsg = null,
  claimPanelOpen = false,
  onToggleClaimPanel,
  onDemoClaim,
  demoMode = false,
  isLoggedIn = false,
  isOwner = false,
  ownerView = false,
  previewPublic = false,
  onTogglePreviewPublic,
  editing = false,
  onToggleEditing,
  avatarBusy = false,
  avatarMsg = null,
  onUploadAvatar,
  showWeight = false,
  bornYear,
  fullDobLabel,
  showFullDob = false,
  leftOptimistYear,
  sailDisplay,
  sailIlca4,
  noc = "SGP",
  totalRegattasCount = 0,
}: HeroAthleteCardProps) {
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [copied, setCopied] = useState(false);

  const handleShare = async () => {
    const url = typeof window !== "undefined" ? window.location.href : "";
    const title = `${displaySailor.name} · Sailor Profile | SailorPath`;
    const text = `Check out ${displaySailor.name}'s sailing profile on SailorPath!`;

    if (typeof navigator !== "undefined" && navigator.share) {
      try {
        await navigator.share({ title, text, url });
        return;
      } catch {
        // Fallback to clipboard if user dismissed or share aborted
      }
    }

    try {
      await navigator.clipboard.writeText(url);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      // ignore clipboard error
    }
  };

  const hasMedals = Boolean(
    medals && medals.show && (medals.gold > 0 || medals.silver > 0 || medals.bronze > 0)
  );

  return (
    <header className={`${cardClass} p-5 sm:p-6 overflow-hidden relative shadow-xl`}>
      {/* Background ambient gradient glow */}
      <div
        className="pointer-events-none absolute -top-24 -right-24 h-72 w-72 rounded-full bg-gradient-to-br from-orange-500/10 via-amber-500/5 to-transparent blur-3xl"
        aria-hidden
      />

      <div className="relative z-10 flex flex-col gap-5">
        {/* Top identity row: Avatar + Name/Badges + Class Switcher */}
        <div className="flex flex-col sm:flex-row items-start justify-between gap-4">
          <div className="flex items-start gap-3.5 sm:gap-4.5 min-w-0">
            {/* Avatar */}
            <div className="relative shrink-0">
              <div className="h-16 w-16 sm:h-20 sm:w-20 rounded-2xl bg-gradient-to-br from-orange-500/90 via-amber-600/80 to-sky-700/70 border-2 border-white/20 text-white flex items-center justify-center overflow-hidden shadow-lg shadow-black/40">
                {displaySailor.avatarUrl ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    src={displaySailor.avatarUrl}
                    alt={displaySailor.name}
                    className="h-full w-full object-cover"
                  />
                ) : (
                  <span className="flex flex-col items-center justify-center leading-none">
                    <Anchor
                      className="h-5 w-5 sm:h-6 sm:w-6 opacity-90 mb-0.5"
                      aria-hidden
                    />
                    <span className="text-xs sm:text-sm font-black tracking-wide">
                      {initials(displaySailor.name)}
                    </span>
                  </span>
                )}
              </div>

              {ownerView && !demoMode && onUploadAvatar && (
                <>
                  <button
                    type="button"
                    disabled={avatarBusy}
                    onClick={() => fileInputRef.current?.click()}
                    className="absolute inset-0 rounded-2xl bg-black/60 opacity-0 hover:opacity-100 focus:opacity-100 transition-opacity flex items-center justify-center text-white"
                    title="Upload athlete photo"
                  >
                    <Camera className="h-5 w-5" />
                  </button>
                  <input
                    ref={fileInputRef}
                    type="file"
                    accept="image/jpeg,image/png,image/webp,image/gif"
                    className="hidden"
                    onChange={(e) => {
                      const f = e.target.files?.[0];
                      if (f) onUploadAvatar(f);
                      e.target.value = "";
                    }}
                  />
                </>
              )}
            </div>

            {/* Name + Badges + Passport Metadata */}
            <div className="min-w-0 flex-1">
              <div className="flex flex-wrap items-center gap-2">
                <h1 className="text-xl sm:text-2xl font-black text-white tracking-tight">
                  {displaySailor.name}
                </h1>

                <span
                  className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-[11px] font-bold ${fleetBadge.className}`}
                >
                  {fleetBadge.label}
                </span>

                {profileClaimed || profileVerified ? (
                  <span className="inline-flex items-center gap-1 rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2 py-0.5 text-[10px] font-bold text-emerald-300">
                    <BadgeCheck className="h-3 w-3" />
                    Claimed
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1 rounded-full bg-amber-500/10 border border-amber-500/25 px-2 py-0.5 text-[10px] font-bold text-amber-200/90">
                    <ShieldAlert className="h-3 w-3" />
                    Unclaimed
                  </span>
                )}
              </div>

              {/* Identity passport: sail numbers · club · nation · age · weight */}
              <div className="mt-1.5 flex flex-wrap items-center gap-x-2 gap-y-1 text-[12px] sm:text-[13px] text-neutral-400">
                {(() => {
                  const parts: ReactNode[] = [];
                  const push = (node: ReactNode, key: string) => {
                    if (parts.length > 0) {
                      parts.push(
                        <span
                          key={`sep-${key}`}
                          className="text-neutral-600"
                          aria-hidden
                        >
                          ·
                        </span>
                      );
                    }
                    parts.push(<span key={key}>{node}</span>);
                  };

                  // Optimist Sail Number
                  if (
                    !leftOptimistYear &&
                    sailDisplay &&
                    sailDisplay !== "—" &&
                    !/^SGP\s*0+$/i.test(sailDisplay)
                  ) {
                    push(
                      <span className="tabular-nums font-bold text-neutral-200">
                        {sailDisplay.includes(" ")
                          ? sailDisplay
                          : `${noc} ${sailDisplay}`}
                      </span>,
                      "opt-sail"
                    );
                  }

                  // ILCA Sail Number
                  if (sailIlca4) {
                    push(
                      <span className="tabular-nums font-bold text-sky-300">
                        ILCA{" "}
                        {sailIlca4.includes(" ")
                          ? sailIlca4
                          : `${noc} ${sailIlca4}`}
                      </span>,
                      "ilca-sail"
                    );
                  }

                  // Club
                  if (displaySailor.club) {
                    push(
                      <span className="text-neutral-300 font-medium">
                        {String(displaySailor.club)}
                      </span>,
                      "club"
                    );
                  }

                  // School
                  if (displaySailor.school) {
                    push(
                      <span className="text-neutral-400">
                        {String(displaySailor.school)}
                      </span>,
                      "school"
                    );
                  }

                  // Nationality
                  push(
                    <span className="inline-flex items-center gap-1 text-neutral-300">
                      <span aria-hidden>
                        {nationalityFlag(displaySailor.nationality)}
                      </span>
                      {nationalityLabel(displaySailor.nationality)}
                    </span>,
                    "nat"
                  );

                  // Age / Born Year
                  if (bornYear) {
                    push(
                      showFullDob && fullDobLabel ? (
                        <>
                          Born{" "}
                          <span className="text-neutral-300 font-medium">
                            {fullDobLabel}
                          </span>
                        </>
                      ) : (
                        <>
                          Born{" "}
                          <span className="text-neutral-300 font-medium">
                            {bornYear}
                          </span>
                        </>
                      ),
                      "born"
                    );
                  }

                  // Weight
                  if (showWeight && displaySailor.weight != null) {
                    push(
                      <>
                        <span className="text-neutral-300 font-medium">
                          {displaySailor.weight} kg
                        </span>
                      </>,
                      "weight"
                    );
                  }

                  // Drop label
                  const dropYmd = displaySailor.dropDate
                    ? String(displaySailor.dropDate).slice(0, 10)
                    : "";
                  if (/^\d{4}-\d{2}-\d{2}$/.test(dropYmd)) {
                    const dropLabel = (() => {
                      try {
                        return new Date(`${dropYmd}T12:00:00+08:00`).toLocaleDateString(
                          "en-SG",
                          {
                            month: "short",
                            year: "numeric",
                            timeZone: "Asia/Singapore",
                          }
                        );
                      } catch {
                        return dropYmd.slice(0, 7);
                      }
                    })();
                    push(
                      <span className="text-amber-200/90 font-medium">
                        Left series {dropLabel}
                      </span>,
                      "drop"
                    );
                  }

                  return parts;
                })()}
              </div>
            </div>
          </div>

          {/* Dual-Class Boat Selector (if dualClass) */}
          {dualClass && onSelectBoatClass && (
            <div className="w-full sm:w-auto shrink-0 flex sm:flex-col items-end gap-1.5 pt-1 sm:pt-0">
              <div
                className="inline-flex rounded-xl bg-black/40 border border-white/10 p-1 w-full sm:w-auto"
                role="tablist"
                aria-label="Boat Class Switcher"
              >
                <button
                  type="button"
                  onClick={() => onSelectBoatClass("optimist")}
                  className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 rounded-lg px-3 py-1.5 text-[11px] font-bold transition ${
                    selectedBoatClass === "optimist"
                      ? "bg-orange-500 text-white shadow-sm"
                      : "text-neutral-400 hover:text-white"
                  }`}
                >
                  <Sailboat className="h-3 w-3" />
                  Optimist
                </button>
                <button
                  type="button"
                  onClick={() => onSelectBoatClass("ilca4")}
                  className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 rounded-lg px-3 py-1.5 text-[11px] font-bold transition ${
                    selectedBoatClass === "ilca4"
                      ? "bg-sky-600 text-white shadow-sm"
                      : "text-neutral-400 hover:text-white"
                  }`}
                >
                  <Sailboat className="h-3 w-3" />
                  ILCA 4
                </button>
              </div>
              <span className="text-[10px] text-neutral-500 hidden sm:inline">
                Dual-class athlete
              </span>
            </div>
          )}
        </div>

        {/* Bio */}
        {displaySailor.bio && (
          <p className="text-[13px] sm:text-sm leading-relaxed text-neutral-300 max-w-2xl bg-white/[0.02] border-l-2 border-orange-500/50 pl-3 py-0.5 rounded-r-lg">
            {displaySailor.bio}
          </p>
        )}

        {/* Hero Athlete Metrics Strip */}
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5 sm:gap-3 pt-1">
          {/* Metric 1: National Ranking */}
          <div className="rounded-xl border border-white/[0.08] bg-black/30 p-3 flex flex-col justify-between">
            <div className="flex items-center justify-between text-neutral-400 text-[10px] font-bold uppercase tracking-wider">
              <span>{standingIsIlca ? "ILCA 4 Rank" : "National Rank"}</span>
              <Trophy
                className={`h-3.5 w-3.5 ${
                  standingIsIlca ? "text-sky-400" : "text-orange-400"
                }`}
              />
            </div>
            <div className="mt-1.5 flex items-baseline gap-2">
              <span
                className={`text-2xl sm:text-3xl font-black tabular-nums tracking-tight ${
                  activeStanding?.overallRank != null
                    ? standingIsIlca
                      ? "text-sky-300"
                      : "text-orange-400"
                    : "text-neutral-400"
                }`}
              >
                {activeStanding?.overallRank != null
                  ? `#${activeStanding.overallRank}`
                  : "—"}
              </span>
              {activeStanding?.fleetSize ? (
                <span className="text-[11px] text-neutral-500 tabular-nums">
                  of {activeStanding.fleetSize}
                </span>
              ) : null}
            </div>
            <p className="text-[10px] text-neutral-400 mt-1 truncate">
              {activeStanding?.best3of5 != null
                ? `Best 3 of 5: ${activeStanding.best3of5} pts`
                : activeStanding?.periodLabel || "2026 Series"}
            </p>
          </div>

          {/* Metric 2: Fleet Qualification / Standing */}
          <div className="rounded-xl border border-white/[0.08] bg-black/30 p-3 flex flex-col justify-between">
            <div className="flex items-center justify-between text-neutral-400 text-[10px] font-bold uppercase tracking-wider">
              <span>Status</span>
              <BadgeCheck className="h-3.5 w-3.5 text-emerald-400" />
            </div>
            <div className="mt-1.5 flex items-baseline gap-1.5">
              <span className="text-base sm:text-lg font-black text-white truncate">
                {standingIsIlca
                  ? activeStanding?.fleet || "Open Fleet"
                  : fleetBadge.label}
              </span>
            </div>
            <p className="text-[10px] text-emerald-300/90 mt-1 truncate font-medium">
              {activeStanding?.trendNote ||
                (fleetBadge.label === "Gold fleet"
                  ? "Selection Trial Eligible"
                  : "Active National Competitor")}
            </p>
          </div>

          {/* Metric 3: Medals or Regatta Experience */}
          <div className="col-span-2 sm:col-span-1 rounded-xl border border-white/[0.08] bg-black/30 p-3 flex flex-col justify-between">
            <div className="flex items-center justify-between text-neutral-400 text-[10px] font-bold uppercase tracking-wider">
              <span>{hasMedals ? "Career Medals" : "Regatta Record"}</span>
              {hasMedals ? (
                <Medal className="h-3.5 w-3.5 text-amber-400" />
              ) : (
                <Sailboat className="h-3.5 w-3.5 text-neutral-400" />
              )}
            </div>
            <div className="mt-1.5 flex items-baseline gap-2">
              {hasMedals && medals ? (
                <div className="flex items-center gap-2 text-base sm:text-lg font-black tabular-nums text-white">
                  {medals.gold > 0 && <span>🥇 {medals.gold}</span>}
                  {medals.silver > 0 && <span>🥈 {medals.silver}</span>}
                  {medals.bronze > 0 && <span>🥉 {medals.bronze}</span>}
                </div>
              ) : (
                <span className="text-2xl sm:text-3xl font-black tabular-nums text-white">
                  {totalRegattasCount}
                </span>
              )}
            </div>
            <p className="text-[10px] text-neutral-400 mt-1 truncate">
              {hasMedals
                ? `${totalRegattasCount} logged regattas`
                : "Official registered regattas"}
            </p>
          </div>
        </div>

        {/* Action Toolbar */}
        <div className="flex flex-wrap items-center justify-between gap-2.5 pt-1 border-t border-white/[0.05]">
          <div className="flex flex-wrap items-center gap-2">
            {/* Share Profile button */}
            <button
              type="button"
              onClick={handleShare}
              className="inline-flex items-center gap-1.5 rounded-lg border border-white/10 bg-white/[0.03] px-3 py-1.5 text-[11px] font-bold text-neutral-300 hover:text-white hover:bg-white/[0.08] transition touch-manipulation cursor-pointer"
            >
              {copied ? (
                <>
                  <Check className="h-3.5 w-3.5 text-emerald-400" />
                  <span className="text-emerald-300">Copied link</span>
                </>
              ) : (
                <>
                  <Share2 className="h-3.5 w-3.5 text-orange-400" />
                  <span>Share profile</span>
                </>
              )}
            </button>

            {/* Claim CTA when banner is not shown */}
            {!showUnclaimedBanner &&
              !demoMode &&
              !isLoggedIn &&
              !profileClaimed && (
                <Link
                  href={`/login?next=${encodeURIComponent(
                    `/${displaySailor.handle || ""}`
                  )}`}
                  className="inline-flex items-center gap-1.5 rounded-lg bg-white text-neutral-900 px-3 py-1.5 text-[11px] font-bold hover:bg-neutral-100 transition touch-manipulation"
                >
                  <UserPlus className="h-3.5 w-3.5 text-orange-600" />
                  Claim this profile
                </Link>
              )}

            {!showUnclaimedBanner &&
              canClaim &&
              claimStatus !== "pending" &&
              onToggleClaimPanel && (
                <button
                  type="button"
                  disabled={demoMode && !onDemoClaim}
                  onClick={() => {
                    if (demoMode) {
                      onDemoClaim?.();
                      return;
                    }
                    onToggleClaimPanel();
                  }}
                  className="inline-flex items-center gap-1.5 rounded-lg bg-white text-neutral-900 px-3 py-1.5 text-[11px] font-bold disabled:opacity-50 hover:bg-neutral-100 transition touch-manipulation cursor-pointer"
                >
                  <UserPlus className="h-3.5 w-3.5 text-orange-600" />
                  {demoMode
                    ? "Claim profile (demo)"
                    : claimPanelOpen
                      ? "Cancel"
                      : "Claim this profile"}
                </button>
              )}

            {canClaim && claimStatus === "pending" && (
              <span className="text-[11px] font-semibold text-amber-300/90 px-2 py-1 bg-amber-500/10 rounded-lg border border-amber-500/20">
                Claim pending review
              </span>
            )}
          </div>

          {/* Owner controls: Edit & Preview Public */}
          {isOwner && (
            <div className="flex items-center gap-2">
              {onTogglePreviewPublic && (
                <button
                  type="button"
                  onClick={onTogglePreviewPublic}
                  className={`inline-flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-[11px] font-bold transition touch-manipulation cursor-pointer ${
                    previewPublic
                      ? "border-sky-500/40 bg-sky-500/15 text-sky-200"
                      : "border-white/10 bg-white/[0.03] text-neutral-300 hover:text-white"
                  }`}
                >
                  {previewPublic ? (
                    <EyeOff className="h-3.5 w-3.5 text-sky-300" />
                  ) : (
                    <Eye className="h-3.5 w-3.5 text-neutral-400" />
                  )}
                  {previewPublic ? "Exit preview" : "Preview public"}
                </button>
              )}

              {!previewPublic && onToggleEditing && (
                <button
                  type="button"
                  onClick={onToggleEditing}
                  className={`inline-flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-[11px] font-bold transition touch-manipulation cursor-pointer ${
                    editing
                      ? "border-orange-500/40 bg-orange-500/15 text-orange-200"
                      : "border-white/10 bg-white/[0.03] text-neutral-300 hover:text-white"
                  }`}
                >
                  <Pencil className="h-3.5 w-3.5 text-orange-400" />
                  {editing ? "Close editor" : "Edit profile"}
                </button>
              )}
            </div>
          )}
        </div>

        {/* Feedback messages */}
        {avatarMsg && (
          <p className="text-[11px] font-medium text-emerald-400">{avatarMsg}</p>
        )}
        {claimMsg && (
          <p
            className={`text-[11px] font-medium ${
              claimStatus === "error" ? "text-rose-300" : "text-emerald-300"
            }`}
          >
            {claimMsg}{" "}
            {claimStatus === "pending" && !demoMode && (
              <Link href="/account" className="underline font-bold">
                My account
              </Link>
            )}
          </p>
        )}
      </div>
    </header>
  );
}
