"use client";

import { profilePhotoUrl } from "@/lib/profilePhoto";

import { isProfileIlcaClass, profileIlcaClassOf, profileIlcaLabel } from "@/lib/profileClasses";
import type { ProfileBoatClass } from "./rankBasis";
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
  Loader2,
} from "lucide-react";
import {
  PROFILE_CARD_CLASS as cardClass,
  nationalityFlag,
  nationalityLabel,
  initials,
} from "./helpers";
import { describeProfileRank, shouldShowProfileRankSection } from "./rankBasis";
import { FollowSailorButton } from "@/components/FollowSailorButton";
import { knownBirthYearLabel } from "@/lib/age";
import { formatSailNumber } from "@/lib/countries";
import type { SailorRecordProps, SeriesStandingProps } from "./types";

export interface HeroAthleteCardProps {
  displaySailor: SailorRecordProps;
  activeStanding: SeriesStandingProps | null;
  standingIsIlca: boolean;
  dualClass?: boolean;
  selectedBoatClass?: ProfileBoatClass;
  onSelectBoatClass?: (cls: ProfileBoatClass) => void;
  /**
   * Classes that actually have results. When set, this replaces the
   * Optimist / ILCA selector, including board disciplines.
   */
  classChoices?: Array<{ id: string; label: string; count: number }>;
  selectedClassId?: string;
  onSelectClass?: (id: string) => void;
  /**
   * Board-class summary replaces dinghy ranking with event-based highlights.
   * Absent national rank is left off rather than invented.
   */
  boardSummary?: {
    label: string;
    seasonYear: number;
    seasonEventCount: number;
    bestFinishLabel: string | null;
    bestFinishEvent: string | null;
    sharedDivision?: string | null;
  } | null;
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
  onRequestAccess?: () => void;
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
  avatarStatus?: "ok" | "error" | null;
  onUploadAvatar?: (file: File) => void;
  onRemoveAvatar?: () => void;
  onSaveBio?: (bio: string) => Promise<boolean> | boolean | void;
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
    nextPath?: string;
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
  activeStanding,
  standingIsIlca,
  dualClass = false,
  selectedBoatClass = "optimist",
  onSelectBoatClass,
  classChoices,
  selectedClassId,
  onSelectClass,
  boardSummary = null,
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
  onRequestAccess,
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
  avatarStatus = null,
  onUploadAvatar,
  onRemoveAvatar,
  onSaveBio,
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
  const [failedPhotoUrl, setFailedPhotoUrl] = useState<string | null>(null);
  const [editingBio, setEditingBio] = useState(false);
  const [bioDraft, setBioDraft] = useState("");
  const [bioSaving, setBioSaving] = useState(false);

  const activeBoatClass: ProfileBoatClass = selectedBoatClass ||
    (standingIsIlca ? profileIlcaClassOf(activeStanding?.boatClass) || "ilca4" : "optimist");
  const activeIsIlca = isProfileIlcaClass(activeBoatClass);
  const activeClassLabel = activeIsIlca ? profileIlcaLabel(activeBoatClass) : "Optimist";
  const bioParagraph = String(displaySailor.bio || "").trim();
  const resolvedOptimistCount =
    optimistCount ??
    (activeBoatClass === "optimist" ? totalRegattasCount : 0);
  const resolvedIlcaCount =
    ilcaCount ?? (activeIsIlca ? totalRegattasCount : 0);
  const rank = describeProfileRank({
    standing: activeStanding,
    boatClass: activeBoatClass,
  });
  const showRankSection = shouldShowProfileRankSection({
    nationality: displaySailor.nationality,
    boatClass: activeBoatClass,
    standing: activeStanding,
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
  const displayChoices = classChoices?.length
    ? classChoices
    : classOptions.map(([id, label, count]) => ({ id, label, count }));
  const selectedChoice =
    displayChoices.find((choice) =>
      choice.id === (classChoices?.length ? selectedClassId : activeBoatClass)
    );
  const showClassSelector = classChoices?.length
    ? classChoices.length > 1 && Boolean(onSelectClass)
    : Boolean(dualClass && onSelectBoatClass);
  const fallbackCount =
    activeIsIlca ? resolvedIlcaCount : resolvedOptimistCount;
  const singleClass: [string, string, number] = [
    selectedChoice?.id ?? activeBoatClass,
    selectedChoice?.label ?? (activeClassLabel),
    selectedChoice?.count ?? fallbackCount,
  ];

  const awardTotal = medals
    ? medals.gold + medals.silver + medals.bronze
    : 0;
  const awardParts = [
    medals && medals.gold > 0 ? `${medals.gold} gold` : null,
    medals && medals.silver > 0 ? `${medals.silver} silver` : null,
    medals && medals.bronze > 0 ? `${medals.bronze} bronze` : null,
  ].filter((part): part is string => Boolean(part));
  const classRegattaCount = selectedChoice?.count ?? fallbackCount;

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
            {/* Avatar & Owner Controls */}
            <div className="flex flex-col items-center gap-1.5 shrink-0">
              <div className="relative">
                <div className="h-16 w-16 sm:h-20 sm:w-20 rounded-2xl bg-harbour border-2 border-cool-veil text-sailcloth flex items-center justify-center overflow-hidden shadow-sm">
                  {(() => {
                    const photoSrc = profilePhotoUrl(displaySailor.id, displaySailor.avatarUrl);
                    return displaySailor.avatarUrl && (!photoSrc || failedPhotoUrl !== photoSrc) ? (
                      // eslint-disable-next-line @next/next/no-img-element
                      <img
                        src={photoSrc || undefined}
                        alt={displaySailor.name}
                        onError={() => {
                          if (photoSrc) setFailedPhotoUrl(photoSrc);
                        }}
                        className="h-full w-full object-cover object-top"
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
                    );
                  })()}
                  {avatarBusy && (
                    <span
                      aria-label="Updating photo"
                      className="absolute inset-0 bg-charcoal/60 flex items-center justify-center text-sailcloth"
                    >
                      <Loader2 className="h-5 w-5 animate-spin" />
                    </span>
                  )}
                </div>

                {ownerView && !demoMode && onUploadAvatar && (
                  <>
                    <button
                      type="button"
                      disabled={avatarBusy}
                      onClick={() => fileInputRef.current?.click()}
                      className="group absolute inset-0 rounded-2xl transition-colors hover:bg-charcoal/55 focus-visible:bg-charcoal/55 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour flex items-center justify-center text-sailcloth cursor-pointer"
                      aria-label="Upload athlete photo"
                    >
                      <Camera className="h-5 w-5 opacity-0 group-hover:opacity-100 group-focus-visible:opacity-100 transition-opacity" aria-hidden />
                      <span
                        aria-hidden
                        className="absolute -bottom-1 -right-1 rounded-full bg-harbour border-2 border-warm-white p-1.5 text-sailcloth shadow-xs group-hover:bg-harbour-shadow transition flex items-center justify-center"
                      >
                        <Camera className="h-3.5 w-3.5" />
                      </span>
                    </button>
                    <input
                      ref={fileInputRef}
                      type="file"
                      accept="image/jpeg,image/png,image/webp"
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
              {ownerView && !demoMode && displaySailor.avatarUrl && onRemoveAvatar && (
                <button
                  type="button"
                  disabled={avatarBusy}
                  onClick={onRemoveAvatar}
                  className="text-[11px] font-semibold text-slate-soft hover:text-rose-600 transition-colors cursor-pointer disabled:opacity-50"
                >
                  Remove photo
                </button>
              )}
            </div>

            {/* Name + Badges + Passport Metadata */}
            <div className="min-w-0 flex-1">
              <div className="flex flex-wrap items-center gap-2">
                <h1 className="text-xl sm:text-2xl font-black text-harbour-shadow tracking-tight">
                  {displaySailor.name}
                </h1>

                {!boardSummary && resolvedNatSquad && (
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

                  // Optimist sail stays off a board-class view.
                  if (
                    !boardSummary &&
                    !leftOptimistYear &&
                    sailDisplay &&
                    sailDisplay !== "—" &&
                    !/^SGP\s*0+$/i.test(sailDisplay)
                  ) {
                    push(
                      <span className="tabular-nums font-bold text-harbour-shadow">
                        {formatSailNumber(sailDisplay, displaySailor.nationality) ||
                          (sailDisplay.includes(" ")
                            ? sailDisplay
                            : `${noc} ${sailDisplay}`)}
                      </span>,
                      "opt-sail"
                    );
                  }

                  // ILCA sail stays off a board-class view.
                  if (!boardSummary && sailIlca4) {
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
                  if (displaySailor.school && (!previewPublic || displaySailor.showSchoolOnPublicProfile)) {
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

                  // Age / Born Year. Unknown years stay off the card entirely.
                  const yearLabel = knownBirthYearLabel(bornYear);
                  const dobText = String(fullDobLabel || "").trim();
                  const dobLabel =
                    showFullDob && dobText && dobText !== "—" && dobText !== "-"
                      ? dobText
                      : null;
                  if (yearLabel || dobLabel) {
                    push(
                      dobLabel ? (
                        <>
                          Born{" "}
                          <span className="text-charcoal font-semibold">
                            {dobLabel}
                          </span>
                        </>
                      ) : (
                        <>
                          Born{" "}
                          <span className="text-charcoal font-semibold">
                            {yearLabel}
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
                  const dropYmd = boardSummary
                    ? ""
                    : displaySailor.dropDate
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
            {showClassSelector ? (
              <div
                className="flex rounded-xl bg-sailcloth border border-cool-veil p-1 w-full sm:w-auto"
                role="tablist"
                aria-label="Sailing class"
              >
                {displayChoices.map((choice) => {
                  const selected = choice.id === singleClass[0];
                  return (
                    <button
                      key={choice.id}
                      type="button"
                      role="tab"
                      aria-selected={selected}
                      onClick={() => {
                        if (classChoices?.length) onSelectClass?.(choice.id);
                        else if (choice.id === "optimist" || isProfileIlcaClass(choice.id)) {
                          onSelectBoatClass?.(choice.id);
                        }
                      }}
                      aria-label={choice.label}
                      className={`flex-1 sm:flex-none rounded-lg px-3 py-2 text-[13px] font-bold transition min-h-[40px] ${
                        selected
                          ? "bg-harbour text-sailcloth shadow-xs"
                          : "text-slate-soft hover:text-charcoal"
                      }`}
                    >
                      {choice.label}
                    </button>
                  );
                })}
              </div>
            ) : (
              <p
                aria-label={singleClass[1]}
                className="inline-flex items-center rounded-xl bg-harbour px-3 py-2 text-[13px] font-bold text-sailcloth min-h-[40px]"
              >
                {singleClass[1]}
              </p>
            )}
            {boardSummary?.sharedDivision && (
              <p className="mt-1 text-[12px] font-semibold text-slate-soft sm:text-right">
                {boardSummary.sharedDivision}
              </p>
            )}
          </div>
        </div>

        <section
          aria-label="Bio"
          className="rounded-xl border border-cool-veil bg-sailcloth/60 p-3.5 sm:p-4"
        >
          <div className="flex items-center justify-between gap-3">
            <p className="text-[11px] font-bold uppercase tracking-wider text-slate-soft">
              Bio
            </p>
            {ownerView && !editingBio && (onSaveBio || (!demoMode && onToggleEditing)) && (
              <button
                type="button"
                onClick={() => {
                  if (onSaveBio) {
                    setBioDraft(bioParagraph);
                    setEditingBio(true);
                  } else {
                    onToggleEditing?.();
                  }
                }}
                className="inline-flex items-center gap-1 text-[12px] font-bold text-harbour hover:underline cursor-pointer"
              >
                <Pencil className="h-3 w-3" aria-hidden />
                {bioParagraph ? "Edit bio" : "Add bio"}
              </button>
            )}
          </div>
          {editingBio && ownerView && onSaveBio ? (
            <div className="mt-2 space-y-2">
              <textarea
                aria-label="Edit bio"
                value={bioDraft}
                onChange={(e) => setBioDraft(e.target.value)}
                maxLength={500}
                rows={3}
                placeholder="Share a short public bio about this sailor (max 500 characters)..."
                className="w-full rounded-lg border border-cool-veil bg-warm-white px-3 py-2 text-[13px] sm:text-sm text-charcoal focus:border-harbour focus:outline-none"
              />
              <div className="flex flex-wrap items-center justify-between gap-2">
                <span className="text-[11px] text-slate-soft tabular-nums">
                  {bioDraft.trim().length}/500
                </span>
                <div className="flex items-center gap-2">
                  <button
                    type="button"
                    disabled={bioSaving}
                    onClick={() => setEditingBio(false)}
                    className="rounded-lg border border-cool-veil bg-warm-white px-3 py-1.5 text-[12px] font-semibold text-charcoal hover:bg-sailcloth cursor-pointer disabled:opacity-50"
                  >
                    Cancel
                  </button>
                  <button
                    type="button"
                    disabled={bioSaving}
                    onClick={async () => {
                      setBioSaving(true);
                      try {
                        const result = await onSaveBio(bioDraft);
                        if (result !== false) setEditingBio(false);
                      } finally {
                        setBioSaving(false);
                      }
                    }}
                    className="rounded-lg bg-harbour px-3.5 py-1.5 text-[12px] font-bold text-sailcloth hover:bg-harbour-shadow cursor-pointer disabled:opacity-50"
                  >
                    {bioSaving ? "Saving…" : "Save bio"}
                  </button>
                </div>
              </div>
            </div>
          ) : bioParagraph ? (
            <p className="mt-1.5 text-[13px] sm:text-sm leading-relaxed text-charcoal max-w-3xl">
              {bioParagraph}
            </p>
          ) : (
            <p className="mt-1.5 text-[13px] text-slate-soft">
              No bio added yet.
            </p>
          )}
        </section>

        <div className="space-y-2.5 pt-1">
          {boardSummary ? (
            <BoardSummaryCards
              summary={boardSummary}
              awardTotal={awardTotal}
              awardParts={awardParts}
              onViewAwards={onViewAwards}
            />
          ) : (
          <>
          {showRankSection && (
          <div className="rounded-2xl border border-cool-veil bg-sailcloth/70 p-4 sm:p-5">
            <div className="flex items-center justify-between gap-3 text-slate-soft text-[12px] font-bold uppercase tracking-wider">
              <span>
                {`${activeClassLabel} rank`}
              </span>
              <Trophy
                className={`h-4 w-4 ${
                  activeIsIlca
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
            </div>
            {rank.hasRank && rank.basisDetail && (
              <p className="mt-2 text-[13px] leading-relaxed text-charcoal">{rank.basisDetail}</p>
            )}
          </div>
          )}

          <div
            className={`grid grid-cols-1 gap-2.5 ${
              hasMedals && medals && awardTotal > 0 ? "sm:grid-cols-2" : ""
            }`}
          >
            <div
              role="group"
              aria-label={`${classRegattaCount} ${
                activeClassLabel
              } regattas`}
              className="rounded-xl border border-cool-veil bg-warm-white p-3.5"
            >
              <div className="flex items-center justify-between text-slate-soft text-[11px] font-bold uppercase tracking-wider">
                <span>Regattas</span>
                <Trophy className="h-3.5 w-3.5 text-slate-soft" />
              </div>
              <p className="mt-1.5 text-base font-black text-harbour-shadow tabular-nums leading-tight">
                {classRegattaCount}
              </p>
              <p className="mt-1 text-[13px] font-medium text-slate-soft truncate">
                {activeClassLabel} {activeIsIlca ? "logged" : "regattas logged"}
              </p>
            </div>

            {hasMedals && medals && awardTotal > 0 && (
              <button
                type="button"
                onClick={() => onViewAwards?.()}
                className="rounded-xl border border-cool-veil bg-warm-white p-3.5 text-left hover:border-harbour/30 hover:bg-aqua-mist/40 transition-colors"
              >
                <div className="flex items-center justify-between text-slate-soft text-[11px] font-bold uppercase tracking-wider">
                  <span>Career awards</span>
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
            )}
          </div>
          </>
          )}
        </div>

        {/* Action Toolbar */}
        <div className="flex flex-wrap items-center justify-between gap-2.5 pt-3 border-t border-cool-veil">
          <div className="flex flex-wrap items-center gap-2">
            {/* Share Profile button */}
            {followControl ? (
              <FollowSailorButton
                sailorId={followControl.sailorId}
                initiallyFollowing={followControl.following}
                disabled={followControl.disabled}
                disabledReason="You already manage this sailor"
                nextPath={followControl.nextPath || (displaySailor.handle ? `/sailors/${displaySailor.handle}` : "/following")}
              />
            ) : null}
            <button
              type="button"
              onClick={handleShare}
              className="inline-flex min-h-11 items-center gap-1.5 rounded-lg border border-cool-veil bg-warm-white px-3 py-1.5 text-[13px] font-bold text-charcoal hover:bg-sailcloth transition touch-manipulation cursor-pointer shadow-2xs"
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

            {/* Single unified claim / access request action */}
            {showUnclaimedBanner && onRequestAccess && (
              <button
                type="button"
                onClick={onRequestAccess}
                className="sp-secondary inline-flex min-h-11 items-center gap-1.5 px-4 py-2 text-[13px] font-bold touch-manipulation cursor-pointer"
              >
                <UserPlus className="h-3.5 w-3.5" aria-hidden />
                Request profile access
              </button>
            )}

            {!showUnclaimedBanner &&
              !demoMode &&
              !isLoggedIn &&
              !profileClaimed && (
                <Link
                  href={`/login?next=${encodeURIComponent(
                    `/sailors/${displaySailor.handle || ""}`
                  )}`}
                  className="sp-primary inline-flex min-h-11 items-center gap-1.5 px-3.5 py-2 text-[13px] font-bold text-white shadow-xs"
                >
                  <UserPlus className="h-3.5 w-3.5" aria-hidden />
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
                  className={
                    profileClaimed && !demoMode
                      ? "sp-secondary inline-flex min-h-11 items-center gap-1.5 px-3.5 py-2 text-[13px] font-bold touch-manipulation disabled:opacity-50 cursor-pointer"
                      : "sp-primary inline-flex min-h-11 items-center gap-1.5 px-3.5 py-2 text-[13px] font-bold text-white shadow-xs touch-manipulation disabled:opacity-50 cursor-pointer"
                  }
                >
                  <UserPlus className="h-3.5 w-3.5" aria-hidden />
                  {demoMode
                    ? "Claim profile (demo)"
                    : claimPanelOpen
                      ? "Cancel"
                      : profileClaimed
                        ? "Request access"
                        : "Claim this profile"}
                </button>
              )}

            {canClaim && claimStatus === "pending" && (
              <span className="text-[12px] font-semibold text-amber-800 px-2.5 py-1.5 bg-amber-50 rounded-lg border border-amber-200">
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
                  className={`inline-flex min-h-11 items-center gap-1.5 rounded-lg border px-3 py-1.5 text-[13px] font-bold transition touch-manipulation cursor-pointer ${
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
                  className={`inline-flex min-h-11 items-center gap-1.5 rounded-lg border px-3 py-1.5 text-[13px] font-bold transition touch-manipulation cursor-pointer ${
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

        {(followControl || showUnclaimedBanner) && (
          <div className="space-y-1 text-xs leading-5 text-slate-soft">
            {followControl && (
              <p>
                {followControl.disabled
                  ? "You already manage this sailor. Your account has links to the sailing workspace."
                  : `Follow to keep this sailor’s results in your Following feed.${isLoggedIn ? "" : " Sign in to save your follows."}`}
              </p>
            )}
            {showUnclaimedBanner && (
              <p>
                <span className="font-semibold text-charcoal">
                  Your profile or your child’s?
                </span>{" "}
                We review requests before granting access.
              </p>
            )}
          </div>
        )}

        {/* Feedback messages */}
        {avatarMsg && (
          <p
            role={avatarStatus === "error" ? "alert" : "status"}
            className={`text-[13px] font-medium ${
              avatarStatus === "error" ? "text-rose-600" : "text-emerald-600"
            }`}
          >
            {avatarMsg}
          </p>
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

function BoardSummaryCards({
  summary,
  awardTotal,
  awardParts,
  onViewAwards,
}: {
  summary: NonNullable<HeroAthleteCardProps["boardSummary"]>;
  awardTotal: number;
  awardParts: string[];
  onViewAwards?: () => void;
}) {
  return (
    <div className="flex flex-col gap-2.5">
      <div className="rounded-2xl border border-cool-veil bg-sailcloth/70 p-4 sm:p-5">
        <div className="flex items-center justify-between gap-3 text-slate-soft text-[12px] font-bold uppercase tracking-wider">
          <span>Best finish</span>
          <Trophy className="h-4 w-4 text-harbour" />
        </div>
        {summary.bestFinishLabel ? (
          <>
            <p className="mt-2 text-4xl sm:text-5xl font-black tabular-nums tracking-tight text-harbour-shadow">
              {summary.bestFinishLabel}
            </p>
            {summary.bestFinishEvent && (
              <p className="mt-2 text-[13px] font-medium text-slate-soft">
                {summary.bestFinishEvent}
              </p>
            )}
          </>
        ) : (
          <p className="mt-3 text-[15px] font-semibold text-charcoal leading-snug">
            No recorded finish yet.
          </p>
        )}
      </div>

      <div
        className={`grid grid-cols-1 gap-2.5 ${
          awardTotal > 0 ? "sm:grid-cols-2" : ""
        }`}
      >
        <div className="rounded-xl border border-cool-veil bg-warm-white p-3.5">
          <p className="text-slate-soft text-[11px] font-bold uppercase tracking-wider">
            Season events
          </p>
          <p className="mt-1.5 text-2xl font-black text-harbour-shadow tabular-nums leading-tight">
            {summary.seasonEventCount}
          </p>
          <p className="mt-1 text-[13px] font-medium text-slate-soft">
            {summary.seasonYear} {summary.label}
          </p>
        </div>

        {awardTotal > 0 && (
          <button
            type="button"
            onClick={() => onViewAwards?.()}
            className="rounded-xl border border-cool-veil bg-warm-white p-3.5 text-left hover:border-harbour/30 hover:bg-aqua-mist/40 transition-colors"
          >
            <div className="flex items-center justify-between text-slate-soft text-[11px] font-bold uppercase tracking-wider">
              <span>Career awards</span>
              <Medal className="h-3.5 w-3.5 text-racing-orange" />
            </div>
            <p className="mt-1.5 text-2xl font-black text-harbour-shadow tabular-nums leading-tight">
              {awardTotal}
            </p>
            <p className="mt-1 text-[13px] font-medium text-slate-soft truncate">
              {awardParts.join(" · ")}
            </p>
          </button>
        )}
      </div>
    </div>
  );
}
