"use client";

import Link from "next/link";
import {
  ChevronDown,
  ChevronRight,
  StickyNote,
  Trophy,
  FileText,
  ImageIcon,
  CheckCircle2,
  ExternalLink,
  BookOpen,
} from "lucide-react";
import { formatEventWhen } from "@/lib/profileUi";
import {
  buildResultTags,
  fleetLabelForResult,
  ilcaHighPointsForResult,
  profileBoatClassGroup,
  type ProfileResult,
} from "@/lib/profileAnalytics";
import { regattaCountsForRanking } from "@/lib/ranking";
import { fleetPillClass } from "./helpers";
import { RaceObservationForm, type RaceObservationForm as RaceObservationFormType } from "./RaceObservationForm";
import type { ObservationItem } from "./types";

export type ProfileRegattaRowProps = {
  res: ProfileResult;
  idx: number;
  expandedRegattaId: string | null;
  primaryIsIlca: boolean;
  ownerView: boolean;
  awards: unknown[];
  showEquipment: boolean;
  gearByRegatta: Record<string, { category: string; brand: string | null; label: string | null }[]>;
  cardClass: string;
  goldEntryDate: string | null;
  demoMode: boolean;
  personalBusy: boolean;
  personalMsg: string | null;
  hasPrivateAccess: boolean;
  observations: ObservationItem[];
  obsForm: RaceObservationFormType;
  editingObsId: string | null;
  obsBusy: boolean;
  obsMsg: string | null;
  onToggle: (regattaId: string) => void;
  onDeleteResult: (res: ProfileResult) => void;
  setExpandedRegattaId: (id: string | null) => void;
  onObsFormChange: (form: RaceObservationFormType) => void;
  onObsSave: (regattaId: string) => void;
  onObsCancel: () => void;
  onObsDelete: (o: ObservationItem) => void;
  onObsEdit: (o: ObservationItem, regattaId: string) => void;
  onObsDemoDelete: (regattaId: string, raceNumber: number) => void;
};

/**
 * A single regatta result row in the profile results table, with expandable
 * evidence, published race scores, and race observation sections.
 */
export function ProfileRegattaRow({
  res,
  idx,
  expandedRegattaId,
  primaryIsIlca,
  ownerView,
  awards,
  showEquipment,
  gearByRegatta,
  cardClass,
  goldEntryDate,
  demoMode,
  personalBusy,
  hasPrivateAccess,
  observations,
  obsForm,
  editingObsId,
  obsBusy,
  obsMsg,
  onToggle,
  onDeleteResult,
  setExpandedRegattaId,
  onObsFormChange,
  onObsSave,
  onObsCancel,
  onObsDelete,
  onObsEdit,
  onObsDemoDelete,
}: ProfileRegattaRowProps) {
  const regattaId = String(res.regattaId || res.id || idx);
  const rank = res.rank != null ? Number(res.rank) : null;
  const dns = Boolean(res.isDns || res.isDNS);
  const boatGroup = profileBoatClassGroup(
    (res as ProfileResult).boatClass
  );
  const isIlcaRow = primaryIsIlca || boatGroup === "ilca4";
  const fleet = isIlcaRow
    ? "ILCA 4"
    : fleetLabelForResult(res, goldEntryDate);
  const slug = res.regattaSlug || res.id;
  const expanded = expandedRegattaId === regattaId;
  const raceNotes: ObservationItem[] = observations
    .filter((o) => {
      if (o.regattaId !== regattaId) return false;
      if (!ownerView && !hasPrivateAccess && o.isPrivate !== false) return false;
      return true;
    })
    .sort((a, b) => Number(a.raceNumber ?? 0) - Number(b.raceNumber ?? 0));
  const officialRaces = (res.raceResults || []).slice().sort(
    (a, b) => a.raceNumber - b.raceNumber
  );
  const fleetSize = res.totalFleetSize ?? res.fleetSize;
  const nonRanking = !regattaCountsForRanking(res);
  const canExpand =
    officialRaces.length > 0 ||
    raceNotes.length > 0 ||
    Boolean(res.evidenceUrl || res.officialUrl || res.evidenceNotes) ||
    ownerView;
  const canLink =
    slug &&
    String(slug).length > 2 &&
    !String(slug).startsWith("log-");
  const regattaHref = isIlcaRow
    ? `/sg/ilca/regattas/${slug}`
    : `/sg/optimist/regattas/${slug}`;
  const nett =
    res.nettScore != null &&
    Number.isFinite(Number(res.nettScore))
      ? Number(res.nettScore)
      : null;
  const ilcaPts = isIlcaRow
    ? ilcaHighPointsForResult(res as ProfileResult)
    : null;
  const leftValue = isIlcaRow
    ? dns
      ? "0"
      : ilcaPts != null
        ? String(ilcaPts)
        : "—"
    : dns
      ? "DNS"
      : rank != null
        ? String(rank)
        : "—";
  const midValue = isIlcaRow
    ? dns
      ? "DNS"
      : rank != null
        ? String(rank)
        : "—"
    : nett != null
      ? String(nett)
      : "—";
  const tags = buildResultTags(res, goldEntryDate);
  const showFleetSizeUnderPlace =
    fleetSize != null &&
    Number(fleetSize) > 0 &&
    leftValue !== "—";

  return (
    <div key={regattaId + String(idx)}>
      <div
        role={canExpand ? "button" : undefined}
        tabIndex={canExpand ? 0 : undefined}
        onClick={
          canExpand
            ? () => onToggle(regattaId)
            : undefined
        }
        onKeyDown={
          canExpand
            ? (e) => {
                if (e.key === "Enter" || e.key === " ") {
                  e.preventDefault();
                  onToggle(regattaId);
                }
              }
            : undefined
        }
        className={`grid gap-2 items-start px-4 sm:px-5 py-3.5 grid-cols-[1.25rem_2.75rem_1fr_auto] ${
          canExpand
            ? "cursor-pointer hover:bg-sailcloth/60 transition-colors"
            : "cursor-default"
        } ${
          isIlcaRow
            ? "sm:grid-cols-[1.25rem_2.75rem_1fr_2.5rem_4.25rem]"
            : "sm:grid-cols-[1.25rem_2.75rem_1fr_4.5rem_4.25rem]"
        }`}
      >
        <span
          className={`pt-1 ${
            canExpand ? "text-slate-soft" : "text-transparent"
          }`}
          aria-hidden
        >
          {canExpand ? (
            expanded ? (
              <ChevronDown className="h-3.5 w-3.5" />
            ) : (
              <ChevronRight className="h-3.5 w-3.5" />
            )
          ) : (
            <span className="inline-block h-3.5 w-3.5" />
          )}
        </span>
        <span
          className={`tabular-nums pt-0.5 flex flex-col items-start leading-tight ${
            dns && !isIlcaRow
              ? "text-racing-orange font-black"
              : isIlcaRow
                ? "text-harbour font-black"
                : "text-harbour-shadow font-black"
          }`}
          title={
            isIlcaRow
              ? "High Ranking Points (1st = fleet size)"
              : fleetSize
                ? `Place ${leftValue} of ${fleetSize} sailors`
                : "Finishing place"
          }
        >
          <span className="text-[15px] font-black">
            {isIlcaRow ? leftValue : leftValue === "DNS" ? "DNS" : leftValue === "—" ? "—" : `#${leftValue}`}
          </span>
          {showFleetSizeUnderPlace && (
              <span className="text-[13px] font-medium text-slate-soft mt-0.5">
                /{fleetSize}
              </span>
            )}
        </span>
        <div className="min-w-0">
          {canLink ? (
            <Link
              href={regattaHref}
              onClick={(e) => e.stopPropagation()}
              className="text-[13px] font-bold text-harbour-shadow truncate block hover:text-harbour"
            >
              {res.regattaName}
            </Link>
          ) : (
            <p className="text-[13px] font-bold text-harbour-shadow truncate">
              {res.regattaName}
            </p>
          )}
          <p className="text-[13px] text-slate-soft truncate mt-0.5 font-medium">
            {[
              res.geography,
              formatEventWhen(res.regattaDate as string),
              !showFleetSizeUnderPlace && fleetSize
                ? `${fleetSize} boats`
                : null,
            ]
              .filter(Boolean)
              .join(" · ")}
          </p>
          {/* Mobile: complementary score only */}
          {(() => {
            const mobileSecondary = isIlcaRow
              ? midValue !== "—" && midValue !== "DNS"
                ? `Rank #${midValue}`
                : midValue === "DNS"
                  ? "DNS"
                  : null
              : `Nett ${midValue}`;
            return mobileSecondary ? (
              <p className="sm:hidden text-[13px] text-slate-soft mt-1 tabular-nums font-semibold">
                {mobileSecondary}
              </p>
            ) : null;
          })()}
          {tags.length > 0 && (
            <div className="mt-1.5 flex flex-wrap gap-1">
              {tags.map((t) => (
                <span
                  key={t.label}
                  className={`rounded-md px-1.5 py-px text-[11px] font-bold border ${t.className}`}
                >
                  {t.label}
                </span>
              ))}
            </div>
          )}
          {(() => {
            const regAwards = (awards as Record<string, unknown>[]).filter(
              (a) =>
                a.regattaSlug === res.regattaSlug ||
                (res.regattaName &&
                  String(a.regattaName || "").toLowerCase().trim() ===
                    String(res.regattaName).toLowerCase().trim())
            );
            if (!regAwards.length) return null;
            return (
              <div className="mt-1.5 flex flex-wrap gap-1.5">
                {regAwards.map((a) => (
                  <span
                    key={String(a.id)}
                    className="inline-flex items-center gap-1 rounded-md border border-amber-300 bg-amber-50 px-2 py-0.5 text-[11px] font-bold text-amber-900 shadow-2xs"
                    title={`Official Prize: ${String(a.prizeTitle)} (${String(a.categoryName)})`}
                  >
                    <Trophy className="h-3 w-3 text-amber-600" />
                    <span>{String(a.prizeTitle)}</span>
                    <span className="text-amber-700">· {String(a.categoryName)}</span>
                  </span>
                ))}
              </div>
            );
          })()}
          {(() => {
            if (!showEquipment) return null;
            const gear = gearByRegatta[regattaId] || [];
            const compact = gear
              .filter(
                (g) =>
                  g.category === "hull" || g.category === "sail"
              )
              .slice(0, 3);
            if (!compact.length) return null;
            return (
              <p
                className="mt-1.5 text-[13px] text-slate-soft flex flex-wrap items-center gap-x-2 gap-y-0.5 font-medium"
                title="Equipment used at this regatta"
              >
                {compact.map((g, i) => {
                  const icon =
                    g.category === "hull" ? "🛶" : "⛵";
                  const name =
                    g.category === "sail"
                      ? [
                          g.brand || "Sail",
                          g.label ? `#${g.label}` : null,
                        ]
                          .filter(Boolean)
                          .join(" ")
                      : [g.brand, g.label]
                          .filter(Boolean)
                          .join(" · ") || "Hull";
                  return (
                    <span key={`${g.category}-${i}`}>
                      {icon} {name}
                    </span>
                  );
                })}
              </p>
            );
          })()}
          {raceNotes.length > 0 && (
            <span className="mt-1.5 inline-flex items-center gap-1 rounded-md border border-harbour/30 bg-aqua-mist px-2 py-0.5 text-[11px] font-bold text-harbour">
              <StickyNote className="h-3 w-3" />
              {raceNotes.length} note
              {raceNotes.length === 1 ? "" : "s"}
            </span>
          )}
          {officialRaces.length > 0 && (
            <span className="mt-1.5 inline-flex items-center gap-1 rounded-md border border-emerald-300 bg-emerald-50 px-2 py-0.5 text-[11px] font-bold text-emerald-800">
              <Trophy className="h-3 w-3 text-emerald-600" />
              {officialRaces.length} race score
              {officialRaces.length === 1 ? "" : "s"}
            </span>
          )}
          {ownerView && (
            <button
              type="button"
              onClick={(e) => {
                e.stopPropagation();
                setExpandedRegattaId(regattaId);
              }}
              className={`mt-1.5 inline-flex items-center gap-1 rounded-md border px-2 py-0.5 text-[13px] font-bold cursor-pointer ${
                raceNotes.length > 0
                  ? "border-cool-veil bg-warm-white text-charcoal hover:bg-sailcloth"
                  : "border-racing-orange/30 bg-racing-mist/30 text-racing-orange hover:bg-racing-mist/50"
              }`}
            >
              <StickyNote className="h-3 w-3" />
              {raceNotes.length > 0 ? "View notes" : "Add note"}
            </button>
          )}
        </div>
        <span
          className={`hidden sm:flex flex-col items-end text-right tabular-nums pt-0.5 leading-tight ${
            isIlcaRow ? "text-charcoal font-bold" : "text-slate-soft font-semibold"
          }`}
        >
          <span className="text-[13px]">
            {isIlcaRow && midValue !== "—" && midValue !== "DNS"
              ? `#${midValue}`
              : midValue}
          </span>
          {isIlcaRow &&
            fleetSize != null &&
            Number(fleetSize) > 0 &&
            midValue !== "—" && (
              <span className="text-[13px] font-medium text-slate-soft mt-0.5">
                /{fleetSize}
              </span>
            )}
        </span>
        <span className="flex items-center justify-end pt-0.5">
          <span
            className={`rounded-full px-2 py-0.5 text-[13px] font-bold ${fleetPillClass(fleet)}`}
          >
            {fleet === "—" ? "—" : fleet}
          </span>
        </span>
      </div>

      {ownerView && !demoMode && nonRanking && res.resultId && (
          <button
            type="button"
            disabled={personalBusy}
            onClick={() => onDeleteResult(res)}
            className="ml-14 mb-2 text-[10px] font-medium text-rose-600"
          >
            Remove
          </button>
        )}

      {expanded && canExpand && (
        <div className="px-4 sm:px-5 pb-4 space-y-3 border-t border-cool-veil bg-sailcloth/50">
          {/* Official Evidence & Results Document Block */}
          {(res.evidenceUrl || res.officialUrl || res.evidenceNotes) && (
            <div className="mt-3 rounded-xl border border-cool-veil bg-warm-white p-3.5 space-y-2 shadow-2xs">
              <div className="flex flex-wrap items-center justify-between gap-2">
                <span className="text-[12px] font-bold text-slate-soft uppercase tracking-wider flex items-center gap-1.5">
                  <FileText className="h-3.5 w-3.5 text-harbour" />
                  Official Evidence & Score Verification
                </span>
                {res.verificationStatus === "verified" ? (
                  <span className="inline-flex items-center gap-1 text-[11px] font-bold text-emerald-700 bg-emerald-50 border border-emerald-200 rounded-full px-2 py-0.5">
                    <CheckCircle2 className="h-3 w-3" />
                    Verified Score
                  </span>
                ) : res.verificationStatus === "pending_review" ? (
                  <span className="inline-flex items-center gap-1 text-[11px] font-bold text-sky-700 bg-sky-50 border border-sky-200 rounded-full px-2 py-0.5">
                    <FileText className="h-3 w-3" />
                    Evidence Attached · Awaiting Review
                  </span>
                ) : (
                  <span className="text-[11px] font-bold text-amber-700 bg-amber-50 border border-amber-200 rounded-full px-2 py-0.5">
                    Self-Reported Score
                  </span>
                )}
              </div>

              <div className="flex flex-wrap items-center gap-3 text-xs pt-1">
                {res.evidenceUrl && (
                  <a
                    href={res.evidenceUrl}
                    target="_blank"
                    rel="noreferrer"
                    className="inline-flex items-center gap-1.5 text-harbour hover:underline font-bold text-[11px]"
                  >
                    {res.evidenceType === "image" ? (
                      <ImageIcon className="h-3.5 w-3.5" />
                    ) : (
                      <FileText className="h-3.5 w-3.5" />
                    )}
                    <span>{res.evidenceName || "View Uploaded Evidence"}</span>
                  </a>
                )}
                {res.officialUrl && (
                  <a
                    href={res.officialUrl}
                    target="_blank"
                    rel="noreferrer"
                    className="inline-flex items-center gap-1.5 text-indigo-600 hover:underline font-bold text-[11px]"
                  >
                    <ExternalLink className="h-3.5 w-3.5" />
                    <span>Official Results Webpage</span>
                  </a>
                )}
              </div>

              {res.evidenceNotes && (
                <p className="text-xs text-charcoal italic border-t border-cool-veil pt-1.5 mt-1">
                  &ldquo;{res.evidenceNotes}&rdquo;
                </p>
              )}
            </div>
          )}

          {officialRaces.length > 0 && (
            <div className="pt-3 space-y-2">
              <div className="flex items-center gap-2 text-[12px] font-bold text-slate-soft uppercase tracking-wider">
                <Trophy className="h-3.5 w-3.5 text-harbour" />
                Published race scores
              </div>
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                {officialRaces.map((race) => (
                  <div
                    key={race.raceNumber}
                    className="rounded-lg border border-cool-veil bg-warm-white px-3 py-2 shadow-2xs"
                  >
                    <p className="text-[13px] text-slate-soft font-medium">Race {race.raceNumber}</p>
                    <p className="text-sm font-black text-harbour-shadow tabular-nums">
                      {race.rawValue || race.score}
                    </p>
                    {race.scoringCode && (
                      <p className="text-[13px] font-bold text-racing-orange">
                        {race.scoringCode}
                      </p>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
          <div className="flex items-center gap-2 pt-3 text-[12px] font-bold text-slate-soft uppercase tracking-wider">
            <BookOpen className="h-3.5 w-3.5 text-racing-orange" />
            Race observations
          </div>
          {raceNotes.length === 0 ? (
            <p className="text-xs text-slate-soft font-medium">
              {ownerView
                ? "No notes yet — add wind, place, and takeaways below."
                : "No public race notes for this event."}
            </p>
          ) : (
            <ul className="space-y-2">
              {raceNotes.map((o) => (
                <li
                  key={String(
                    o.id || `${o.regattaId}-${o.raceNumber}`
                  )}
                  className="rounded-lg border border-cool-veil bg-warm-white px-3 py-2 shadow-2xs"
                >
                  <div className="flex items-center justify-between gap-2">
                    <span className="text-xs font-bold text-harbour-shadow">
                      Race {String(o.raceNumber)}
                    </span>
                    <span className="text-[13px] font-mono text-slate-soft">
                      {o.position != null
                        ? `Score ${o.position}`
                        : "—"}
                      {o.wind ? ` · ${o.wind}` : ""}
                      {o.isPrivate ? " · private" : ""}
                    </span>
                  </div>
                  {o.note ? (
                    <p className="text-xs text-charcoal mt-1 leading-relaxed">
                      {String(o.note)}
                    </p>
                  ) : null}
                  {ownerView && (
                    <div className="mt-1.5 flex gap-2">
                      <button
                        type="button"
                        onClick={() =>
                          onObsEdit(o, regattaId)
                        }
                        className="text-[10px] font-bold text-harbour hover:underline"
                      >
                        Edit
                      </button>
                      {(o.id || demoMode) ? (
                        <button
                          type="button"
                          disabled={obsBusy}
                          onClick={() => {
                            if (demoMode) {
                              onObsDemoDelete(regattaId, Number(o.raceNumber));
                              return;
                            }
                            onObsDelete(o);
                          }}
                          className="text-[10px] font-bold text-rose-600 hover:underline"
                        >
                          Delete
                        </button>
                      ) : null}
                    </div>
                  )}
                </li>
              ))}
            </ul>
          )}
          <RaceObservationForm
            form={obsForm}
            editingObsId={editingObsId}
            obsBusy={obsBusy}
            obsMsg={obsMsg}
            ownerView={ownerView}
            demoMode={demoMode}
            regattaId={regattaId}
            onFormChange={onObsFormChange}
            onSave={onObsSave}
            onCancel={onObsCancel}
          />
        </div>
      )}
    </div>
  );
}
