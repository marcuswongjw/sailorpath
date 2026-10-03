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
  Info,
} from "lucide-react";
import {
  PROFILE_CARD_CLASS as cardClass,
  nationalityFlag,
  nationalityLabel,
  initials,
} from "./helpers";
import { describeProfileRank } from "./rankBasis";
import { FollowSailorButton } from "@/components/FollowSailorButton";
import type { SailorRecordProps, SeriesStandingProps } from "./types";

export interface HeroAthleteCardProps {
  displaySailor: SailorRecordProps;
  fleetBadge: { label: string; className: string };
  activeStanding: SeriesStandingProps | null;
  standingIsIlca: boolean;
  dualClass?: boolean;
  selectedBoatClass?: "optimist" | "ilca4";
  onSelectBoatClass?: (cls: "optimist" | "ilca4") => void;
  optimistCount?: number;
  ilcaCount?: number;
  /** Put ILCA 4 first when that is the sailor’s primary class. */
  preferIlcaFirst?: boolean;
  onViewAwards?: () => void;
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
  boardNumber?: string | null;
  noc?: string;
  totalRegattasCount?: number;
  currentNatSquad?: string | null;
  followControl?: {
    sailorId: string;
    following: boolean;
    disabled: boolean;
  } | null;
}

function natSquadBadgeClass(label: string): string {
  const s = label.trim().toLowerCase();
  if (s === "nat a" || s === "national a" || s === "a") {
    return "bg-amber-50 border border-amber-200 text-amber-900";
  }
  if (s === "nat b" || s === "national b" || s === "b") {
    return "bg-sky-50 border border-sky-200 text-sky-900";
  }
  if (s.includes("dev") || s === "ds") {
    return "bg-violet-50 border border-violet-200 text-violet-900";
  }
  return "bg-blue-50 border border-blue-200 text-blue-900";
}

export function HeroAthleteCard({
  displaySailor,
  fleetBadge,
  activeStanding,
  standingIsIlca,
  dualClass = false,
  selectedBoatClass = "optimist",
  onSelectBoatClass,
  optimistCount,
  ilcaCount,
  preferIlcaFirst = false,
  onViewAwards,
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
  boardNumber,
  noc = "SGP",
  totalRegattasCount = 0,
  currentNatSquad,
  followControl = null,
}: HeroAthleteCardProps) {
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [copied, setCopied] = useState(false);
  const [basisOpen, setBasisOpen] = useState(false);

  const activeBoatClass: "optimist" | "ilca4" =
    selectedBoatClass === "ilca4" || standingIsIlca ? "ilca4" : "optimist";
  const resolvedOptimistCount =
    optimistCount ??
    (activeBoatClass === "optimist" ? totalRegattasCount : 0);
  const resolvedIlcaCount =
    ilcaCount ?? (activeBoatClass === "ilca4" ? totalRegattasCount : 0);
  const rank = describeProfileRank({
    standing: activeStanding,
    boatClass: activeBoatClass,
  });
  const classOptions = (
    preferIlcaFirst
      ? [
          ["ilca4", "ILCA 4", resolvedIlcaCount],
          ["optimist", "Optimist", resolvedOptimistCount],
        ]
      : [
          ["optimist", "Optimist", resolvedOptimistCount],
          ["ilca4", "ILCA 4", resolvedIlcaCount],
        ]
  ) as Array<["optimist" | "ilca4", string, number]>;
  const singleClass =
    classOptions.find((option) => option[0] === activeBoatClass) ??
    classOptions[0];

  const awardTotal = medals
    ? medals.gold + medals.silver + medals.bronze
    : 0;
  const awardParts = [
    medals && medals.gold > 0 ? `${medals.gold} gold` : null,
    medals && medals.silver > 0 ? `${medals.silver} silver` : null,
    medals && medals.bronze > 0 ? `${medals.bronze} bronze` : null,
  ].filter(Boolean);
  const classRegattaCount =
    activeBoatClass === "ilca4" ? resolvedIlcaCount : resolvedOptimistCount;
  const dropped = fleetBadge.label === "Dropped";
  const statusTitle = dropped ? "Dropped" : "Active competitor";
  const statusDetail =
    activeBoatClass === "ilca4" ? "ILCA 4" : fleetBadge.label;

  const resolvedNatSquad =
    currentNatSquad ||
    (() => {
      const raw =
        displaySailor.natSquadStatusJul26 ||
        displaySailor.natSquadStatusJan26 ||
        displaySailor.nationalSquadStatus ||
        displaySailor.natSquadStatusJul25 ||
        displaySailor.natSquadStatusJan25;
      if (!raw || typeof raw !== "string") return null;
      const trimmed = raw.trim();
      return trimmed || null;
    })();

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
    <header className={`${cardClass} p-5 sm:p-6 overflow-hidden relative shadow-xs`}>
      <div className="relative z-10 flex flex-col gap-5">
        {/* Top identity row: Avatar + Name/Badges + Class Switcher */}
        <div className="flex flex-col sm:flex-row items-start justify-between gap-4">
          <div className="flex items-start gap-3.5 sm:gap-4.5 min-w-0">
            {/* Avatar */}
            <div className="relative shrink-0">
              <div className="h-16 w-16 sm:h-20 sm:w-20 rounded-2xl bg-gradient-to-br from-harbour to-harbour-shadow border-2 border-cool-veil text-sailcloth flex items-center justify-center overflow-hidden shadow-sm">
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
                      className="h-5 w-5 sm:h-6 sm:w-6 opacity-90 mb-0.5 text-soft-aqua"
                      aria-hidden
                    />
                    <span className="text-xs sm:text-sm font-black tracking-wide text-sailcloth">
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
                    className="absolute inset-0 rounded-2xl bg-charcoal/60 opacity-0 hover:opacity-100 focus:opacity-100 transition-opacity flex items-center justify-center text-sailcloth"
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
                <h1 className="text-xl sm:text-2xl font-black text-harbour-shadow tracking-tight">
                  {displaySailor.name}
                </h1>

                {resolvedNatSquad && (
                  <span
                    className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-[13px] font-bold ${natSquadBadgeClass(
                      resolvedNatSquad
                    )}`}
                  >
                    {resolvedNatSquad}
                  </span>
                )}

                {profileClaimed || profileVerified ? (
                  <span className="inline-flex items-center gap-1 rounded-full bg-emerald-50 border border-emerald-200 px-2 py-0.5 text-[11px] font-bold text-emerald-800">
                    <BadgeCheck className="h-3 w-3 text-emerald-600" />
                    Claimed
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1 rounded-full bg-amber-50 border border-amber-200 px-2 py-0.5 text-[11px] font-bold text-amber-800">
                    <ShieldAlert className="h-3 w-3 text-amber-600" />
                    Unclaimed
                  </span>
                )}
              </div>

              {/* Identity passport: sail numbers · club · nation · age · weight */}
              <div className="mt-1.5 flex flex-wrap items-center gap-x-2 gap-y-1 text-[12px] sm:text-[13px] text-slate-soft">
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
                      <span className="tabular-nums font-bold text-harbour-shadow">
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
                      <span className="tabular-nums font-bold text-harbour">
                        ILCA{" "}
                        {sailIlca4.includes(" ")
                          ? sailIlca4
                          : `${noc} ${sailIlca4}`}
                      </span>,
                      "ilca-sail"
                    );
                  }

                  if (boardNumber && boardNumber !== "0") {
                    push(
                      <span className="tabular-nums font-bold text-harbour-shadow">
                        Board {boardNumber}
                      </span>,
                      "board-number"
                    );
                  }

                  // Club
                  if (displaySailor.club) {
                    push(
                      <span className="text-charcoal font-semibold">
                        {String(displaySailor.club)}
                      </span>,
                      "club"
                    );
                  }

                  // School
                  if (displaySailor.school) {
                    push(
                      <span className="text-slate-soft">
                        {String(displaySailor.school)}
                      </span>,
                      "school"
                    );
                  }

                  // Nationality
                  push(
                    <span className="inline-flex items-center gap-1 text-charcoal">
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
                          <span className="text-charcoal font-semibold">
                            {fullDobLabel}
                          </span>
                        </>
                      ) : (
                        <>
                          Born{" "}
                          <span className="text-charcoal font-semibold">
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
                        <span className="text-charcoal font-semibold">
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
                      <span className="text-racing-orange font-semibold">
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

          <div className="w-full sm:w-auto shrink-0 sm:pt-1">
            {dualClass && onSelectBoatClass ? (
              <div
                className="flex rounded-xl bg-sailcloth border border-cool-veil p-1 w-full sm:w-auto"
                role="tablist"
                aria-label="Sailing class"
              >
                {classOptions.map(([id, label, count]) => {
                  const selected = activeBoatClass === id;
                  return (
                    <button
                      key={id}
                      type="button"
                      role="tab"
                      aria-selected={selected}
                      onClick={() => onSelectBoatClass(id)}
                      aria-label={`${label}, ${count} regattas`}
                      className={`flex-1 sm:flex-none rounded-lg px-3 py-2 text-[13px] font-bold transition min-h-[40px] ${
                        selected
                          ? "bg-harbour text-sailcloth shadow-xs"
                          : "text-slate-soft hover:text-charcoal"
                      }`}
                    >
                      {label}
                      <span className="mx-1.5">·</span>
                      <span className="tabular-nums">{count}</span>
                    </button>
                  );
                })}
              </div>
            ) : (
              <p
                aria-label={`${singleClass[1]}, ${singleClass[2]} regattas`}
                className="inline-flex items-center rounded-xl bg-harbour px-3 py-2 text-[13px] font-bold text-sailcloth min-h-[40px]"
              >
                {singleClass[1]}
                <span className="mx-1.5 text-sailcloth/80">·</span>
                <span className="tabular-nums">{singleClass[2]}</span>
                <span className="sr-only"> regattas</span>
              </p>
            )}
          </div>
        </div>

        {/* Bio */}
        {displaySailor.bio && (
          <p className="text-[13px] sm:text-sm leading-relaxed text-charcoal max-w-2xl bg-sailcloth/60 border-l-2 border-harbour pl-3 py-1 rounded-r-lg">
            {displaySailor.bio}
          </p>
        )}

        <div className="space-y-2.5 pt-1">
          <div className="rounded-2xl border border-cool-veil bg-sailcloth/70 p-4 sm:p-5">
            <div className="flex items-center justify-between gap-3 text-slate-soft text-[12px] font-bold uppercase tracking-wider">
              <span>
                {activeBoatClass === "ilca4" ? "ILCA 4 rank" : "Optimist rank"}
              </span>
              <Trophy
                className={`h-4 w-4 ${
                  activeBoatClass === "ilca4"
                    ? "text-harbour"
                    : "text-racing-orange"
                }`}
              />
            </div>
            {rank.hasRank ? (
              <p
                className="mt-2 text-harbour-shadow"
                aria-label={rank.rankLabel}
              >
                <span className="text-4xl sm:text-5xl font-black tabular-nums tracking-tight">
                  {rank.rank}
                </span>
                <span className="mx-1.5 text-2xl font-bold text-slate-soft">
                  of
                </span>
                <span className="text-4xl sm:text-5xl font-black tabular-nums tracking-tight">
                  {rank.fleetSize}
                </span>
              </p>
            ) : (
              <p className="mt-3 text-[15px] font-semibold text-charcoal leading-snug">
                {rank.emptyMessage}
              </p>
            )}
            <div className="mt-2 flex flex-wrap items-center gap-x-2 gap-y-1">
              {rank.hasRank && (
              <p className="text-[13px] text-slate-soft font-medium">
                <span className="font-bold text-charcoal">
                  {rank.basisLabel}
                </span>
                <span aria-hidden> · </span>
                <span>{rank.cycleLabel}</span>
              </p>
              )}
              {rank.hasRank && (
                <button
                  type="button"
                  aria-expanded={basisOpen}
                  aria-controls="profile-rank-basis"
                  onClick={() => setBasisOpen((open) => !open)}
                  className="inline-flex items-center gap-1 rounded-full border border-cool-veil bg-warm-white px-2 py-0.5 text-[12px] font-bold text-harbour hover:bg-aqua-mist"
                >
                  <Info className="h-3 w-3" aria-hidden />
                  What this rank means
                </button>
              )}
            </div>
            {basisOpen && rank.hasRank && (
              <p
                id="profile-rank-basis"
                className="mt-2 text-[13px] leading-relaxed text-charcoal"
              >
                {rank.basisDetail}
              </p>
            )}
          </div>

          <div className="grid grid-cols-2 gap-2.5">
            <div className="rounded-xl border border-cool-veil bg-warm-white p-3.5">
              <div className="flex items-center justify-between text-slate-soft text-[11px] font-bold uppercase tracking-wider">
                <span>Status</span>
                <BadgeCheck className="h-3.5 w-3.5 text-harbour" />
              </div>
              <p className="mt-1.5 text-base font-black text-harbour-shadow leading-tight">
                {statusTitle}
              </p>
              <p className="mt-1 text-[13px] font-medium text-slate-soft truncate">
                {statusDetail}
              </p>
            </div>

            {hasMedals && medals && awardTotal > 0 ? (
              <button
                type="button"
                onClick={() => onViewAwards?.()}
                className="rounded-xl border border-cool-veil bg-warm-white p-3.5 text-left hover:border-harbour/30 hover:bg-aqua-mist/40 transition-colors"
              >
                <div className="flex items-center justify-between text-slate-soft text-[11px] font-bold uppercase tracking-wider">
                  <span>Career</span>
                  <Medal className="h-3.5 w-3.5 text-racing-orange" />
                </div>
                <p className="mt-1.5 text-base font-black text-harbour-shadow tabular-nums leading-tight">
                  {awardTotal} {awardTotal === 1 ? "award" : "awards"}
                </p>
                <p className="mt-1 text-[13px] font-medium text-slate-soft truncate">
                  {awardParts.join(" · ")}
                </p>
                <p className="mt-1 text-[12px] font-bold text-racing-orange">
                  View awards
                </p>
              </button>
            ) : (
              <div className="rounded-xl border border-cool-veil bg-warm-white p-3.5">
                <div className="flex items-center justify-between text-slate-soft text-[11px] font-bold uppercase tracking-wider">
                  <span>Regattas</span>
                  <Trophy className="h-3.5 w-3.5 text-slate-soft" />
                </div>
                <p className="mt-1.5 text-base font-black text-harbour-shadow tabular-nums leading-tight">
                  {classRegattaCount || totalRegattasCount}
                </p>
                <p className="mt-1 text-[13px] font-medium text-slate-soft truncate">
                  {activeBoatClass === "ilca4" ? "ILCA 4" : "Optimist"} logged
                </p>
              </div>
            )}
          </div>
        </div>

        {/* Action Toolbar */}
        <div className="flex flex-wrap items-center justify-between gap-2.5 pt-3 border-t border-cool-veil">
          <div className="flex flex-wrap items-center gap-2">
            {/* Share Profile button */}
            {isLoggedIn && followControl ? (
              <FollowSailorButton
                sailorId={followControl.sailorId}
                initiallyFollowing={followControl.following}
                disabled={followControl.disabled}
                disabledReason="You already manage this sailor"
              />
            ) : null}
            <button
              type="button"
              onClick={handleShare}
              className="inline-flex items-center gap-1.5 rounded-lg border border-cool-veil bg-warm-white px-3 py-1.5 text-[13px] font-bold text-charcoal hover:bg-sailcloth transition touch-manipulation cursor-pointer shadow-2xs"
            >
              {copied ? (
                <>
                  <Check className="h-3.5 w-3.5 text-emerald-600" />
                  <span className="text-emerald-700">Copied link</span>
                </>
              ) : (
                <>
                  <Share2 className="h-3.5 w-3.5 text-harbour" />
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
                  className="sp-primary inline-flex items-center gap-1.5 px-3 py-1.5 text-[11px] font-bold text-white shadow-xs"
                >
                  <UserPlus className="h-3.5 w-3.5" />
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
                  className="sp-primary inline-flex items-center gap-1.5 px-3 py-1.5 text-[11px] font-bold text-white shadow-xs disabled:opacity-50 cursor-pointer"
                >
                  <UserPlus className="h-3.5 w-3.5" />
                  {demoMode
                    ? "Claim profile (demo)"
                    : claimPanelOpen
                      ? "Cancel"
                      : "Claim this profile"}
                </button>
              )}

            {canClaim && claimStatus === "pending" && (
              <span className="text-[11px] font-semibold text-amber-800 px-2 py-1 bg-amber-50 rounded-lg border border-amber-200">
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
                  className={`inline-flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-[13px] font-bold transition touch-manipulation cursor-pointer ${
                    previewPublic
                      ? "border-harbour/40 bg-aqua-mist text-harbour"
                      : "border-cool-veil bg-warm-white text-charcoal hover:bg-sailcloth"
                  }`}
                >
                  {previewPublic ? (
                    <EyeOff className="h-3.5 w-3.5 text-harbour" />
                  ) : (
                    <Eye className="h-3.5 w-3.5 text-slate-soft" />
                  )}
                  {previewPublic ? "Exit preview" : "Preview public"}
                </button>
              )}

              {!previewPublic && onToggleEditing && (
                <button
                  type="button"
                  onClick={onToggleEditing}
                  className={`inline-flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-[13px] font-bold transition touch-manipulation cursor-pointer ${
                    editing
                      ? "border-harbour/40 bg-aqua-mist text-harbour"
                      : "border-cool-veil bg-warm-white text-charcoal hover:bg-sailcloth"
                  }`}
                >
                  <Pencil className="h-3.5 w-3.5 text-harbour" />
                  {editing ? "Close editor" : "Edit profile"}
                </button>
              )}
            </div>
          )}
        </div>

        {/* Feedback messages */}
        {avatarMsg && (
          <p className="text-[13px] font-medium text-emerald-600">{avatarMsg}</p>
        )}
        {claimMsg && (
          <p
            className={`text-[13px] font-medium ${
              claimStatus === "error" ? "text-rose-600" : "text-emerald-600"
            }`}
          >
            {claimMsg}{" "}
            {claimStatus === "pending" && !demoMode && (
              <Link href="/account" className="underline font-bold text-harbour">
                My account
              </Link>
            )}
          </p>
        )}
      </div>
    </header>
  );
}
