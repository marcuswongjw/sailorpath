"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import {
  X,
  Lock,
  Globe2,
  Calendar,
  CheckCircle2,
  Trash2,
  Clock,
  Target,
  FileText,
  Trophy,
} from "lucide-react";
import { regattaResultsHref } from "@/lib/classPages";
import type { CoachSquadMember } from "@/lib/coachDashboard";
import { fleetPillClass } from "@/components/sailor-profile/helpers";

type AthleteDevelopmentDrawerProps = {
  sailor: CoachSquadMember;
  onClose: () => void;
  onSaveNote: (note: string, visibility: "coach_only" | "shared") => Promise<void>;
  onAddRecord: (payload: {
    type: "observation" | "goal" | "attendance";
    category: string | null;
    title: string;
    detail: string | null;
    recordDate: string;
    targetDate: string | null;
    status: string;
    visibility: "coach_only" | "shared";
    sentiment: "strength" | "focus" | "neutral";
  }) => Promise<void>;
  onUpdateRecordStatus?: (id: string, status: string) => Promise<void>;
  onDeleteRecord?: (id: string) => Promise<void>;
  busyId: string | null;
};

const OBSERVATION_CATEGORIES = [
  "Starts",
  "Upwind speed",
  "Tacking",
  "Downwind speed",
  "Gybing",
  "Mark rounding",
  "Tactics",
  "Rules",
  "Boat handling",
  "Confidence",
  "Mental focus",
];

const NESTED =
  "rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]";
const MUTED = "text-[var(--sp-slate-soft)]";
const INK = "text-[var(--sp-harbour-shadow)]";
const BODY = "text-[var(--sp-charcoal-slate)]";
const JUMP_PILL =
  "inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-3 py-1.5 text-[11px] font-semibold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition whitespace-nowrap";

function VisibilityToggle({
  value,
  onChange,
}: {
  value: "coach_only" | "shared";
  onChange: (next: "coach_only" | "shared") => void;
}) {
  return (
    <div className={`flex items-center gap-1 ${NESTED} p-0.5`}>
      <button
        type="button"
        onClick={() => onChange("coach_only")}
        className={`flex items-center gap-1.5 rounded-md px-2 py-1 text-[10px] font-bold transition ${
          value === "coach_only"
            ? "bg-harbour text-sailcloth shadow-xs"
            : `${MUTED} hover:text-[var(--sp-harbour-shadow)]`
        }`}
      >
        <Lock className="h-3 w-3" />
        <span>Coach Only</span>
      </button>
      <button
        type="button"
        onClick={() => onChange("shared")}
        className={`flex items-center gap-1.5 rounded-md px-2 py-1 text-[10px] font-bold transition ${
          value === "shared"
            ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] shadow-xs"
            : `${MUTED} hover:text-[var(--sp-harbour-shadow)]`
        }`}
      >
        <Globe2 className="h-3 w-3" />
        <span>Share with Family</span>
      </button>
    </div>
  );
}

export function AthleteDevelopmentDrawer({
  sailor,
  onClose,
  onSaveNote,
  onAddRecord,
  onUpdateRecordStatus,
  onDeleteRecord,
  busyId,
}: AthleteDevelopmentDrawerProps) {
  const [noteDraft, setNoteDraft] = useState(sailor.coachNote || "");
  const [noteVisibility, setNoteVisibility] = useState<"coach_only" | "shared">(
    sailor.coachNoteVisibility || "coach_only"
  );
  const [feedback, setFeedback] = useState<{ type: "success" | "error"; text: string } | null>(null);

  const [recordType, setRecordType] = useState<"observation" | "goal" | "attendance">("observation");
  const [recordCategory, setRecordCategory] = useState("Starts");
  const [recordSentiment, setRecordSentiment] = useState<"strength" | "focus" | "neutral">("strength");
  const [recordVisibility, setRecordVisibility] = useState<"coach_only" | "shared">("coach_only");
  const [recordTitle, setRecordTitle] = useState("");
  const [recordDetail, setRecordDetail] = useState("");
  const [recordDate, setRecordDate] = useState(() => new Date().toISOString().slice(0, 10));
  const [targetDate, setTargetDate] = useState("");
  const [recordStatus, setRecordStatus] = useState("present");

  const [prevNote, setPrevNote] = useState(sailor.coachNote);
  const [prevVisibility, setPrevVisibility] = useState(sailor.coachNoteVisibility);
  if (sailor.coachNote !== prevNote || sailor.coachNoteVisibility !== prevVisibility) {
    setPrevNote(sailor.coachNote);
    setPrevVisibility(sailor.coachNoteVisibility);
    setNoteDraft(sailor.coachNote || "");
    setNoteVisibility(sailor.coachNoteVisibility || "coach_only");
  }

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };
    document.addEventListener("keydown", onKey);
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prevOverflow;
    };
  }, [onClose]);

  async function handleAddRecord(e: React.FormEvent) {
    e.preventDefault();
    if (!recordTitle.trim()) return;
    setFeedback(null);

    try {
      await onAddRecord({
        type: recordType,
        category: recordType === "observation" ? recordCategory : null,
        title: recordTitle.trim(),
        detail: recordDetail.trim() || null,
        recordDate,
        targetDate: recordType === "goal" && targetDate ? targetDate : null,
        status: recordType === "attendance" ? recordStatus : "active",
        visibility: recordVisibility,
        sentiment: recordType === "observation" ? recordSentiment : "neutral",
      });

      setRecordTitle("");
      setRecordDetail("");
      setTargetDate("");
      setFeedback({
        type: "success",
        text: `${recordType === "goal" ? "Goal" : recordType === "attendance" ? "Attendance" : "Observation"} saved successfully.`,
      });
    } catch (err) {
      setFeedback({
        type: "error",
        text: err instanceof Error ? err.message : "Could not add coaching record.",
      });
    }
  }

  async function handleSaveNote(e: React.FormEvent) {
    e.preventDefault();
    setFeedback(null);
    try {
      await onSaveNote(noteDraft, noteVisibility);
      setFeedback({
        type: "success",
        text: noteVisibility === "shared" ? "Coach note shared with family." : "Private coach note saved.",
      });
    } catch (err) {
      setFeedback({
        type: "error",
        text: err instanceof Error ? err.message : "Could not save coach note.",
      });
    }
  }

  function scrollToSection(id: string) {
    const el = document.getElementById(id);
    if (el) {
      el.scrollIntoView({ behavior: "smooth" });
    }
  }

  return (
    <div
      className="fixed inset-0 z-50 flex justify-end bg-black/60 backdrop-blur-xs transition-opacity"
      role="dialog"
      aria-modal="true"
      aria-label={`${sailor.name} coach details`}
      onMouseDown={(e) => {
        if (e.target === e.currentTarget) onClose();
      }}
    >
      <div className="flex h-full w-full max-w-xl flex-col border-l border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] text-[var(--sp-harbour-shadow)] shadow-2xl">
        <div className="flex items-start justify-between border-b border-[var(--sp-cool-veil)] p-5 sm:p-6 bg-[var(--sp-warm-white)] shrink-0">
          <div className="min-w-0 pr-4">
            <div className="flex flex-wrap items-center gap-2">
              <span className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-racing-orange)]">
                Coach Workspace
              </span>
              {sailor.fleet && (
                <span
                  className={`rounded-full border px-2 py-0.5 text-[10px] font-bold ${fleetPillClass(sailor.fleet)}`}
                >
                  {sailor.fleet} #{sailor.ranking}
                </span>
              )}
              {sailor.squadStatus && (
                <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-charcoal-slate)]">
                  {sailor.squadStatus}
                </span>
              )}
            </div>
            <h2 className={`mt-1 truncate text-2xl font-black ${INK}`}>{sailor.name}</h2>
            <p className={`mt-0.5 truncate text-xs ${MUTED}`}>
              {sailor.sailNumber} · {sailor.club}
            </p>
            <Link
              href={`/${sailor.handle}`}
              className="mt-1.5 inline-flex items-center gap-1 text-[11px] font-semibold text-[var(--sp-harbour-teal)] hover:text-[var(--sp-racing-orange)] transition"
            >
              View public profile &rarr;
            </Link>
          </div>

          <button
            type="button"
            onClick={onClose}
            aria-label="Close sailor details"
            className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)] transition`}
          >
            <X className="h-5 w-5" />
          </button>
        </div>

        {feedback && (
          <div
            aria-live="polite"
            className={`mx-5 sm:mx-6 mt-4 flex items-center justify-between rounded-xl px-4 py-2.5 text-xs font-semibold ${
              feedback.type === "success"
                ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/20"
                : "bg-rose-50 text-rose-700 border border-rose-200"
            }`}
          >
            <span>{feedback.text}</span>
            <button
              type="button"
              onClick={() => setFeedback(null)}
              className="ml-2 text-current opacity-70 hover:opacity-100"
              aria-label="Dismiss message"
            >
              <X className="h-3.5 w-3.5" />
            </button>
          </div>
        )}

        <div className="flex items-center gap-2 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-4 py-2.5 sm:px-6 overflow-x-auto shrink-0">
          <button type="button" onClick={() => scrollToSection("drawer-scores")} className={JUMP_PILL}>
            <Trophy className="h-3 w-3 text-[var(--sp-racing-orange)]" /> Scores & Races
          </button>
          <button type="button" onClick={() => scrollToSection("drawer-coaching-log")} className={JUMP_PILL}>
            <Target className="h-3 w-3 text-[var(--sp-harbour-teal)]" /> Coaching Log ({sailor.developmentRecords.length})
          </button>
          <button type="button" onClick={() => scrollToSection("drawer-note")} className={JUMP_PILL}>
            <FileText className="h-3 w-3 text-[var(--sp-harbour-teal)]" /> Coach Note
          </button>
        </div>

        <div className="flex-1 overflow-y-auto p-5 sm:p-6 space-y-8">
          <div id="drawer-scores" className="space-y-6">
            <div className={`${NESTED} p-4`}>
              <h3 className={`text-xs font-bold uppercase tracking-wider ${MUTED}`}>
                Selection readiness
              </h3>
              <p className={`mt-2 text-sm font-bold ${INK}`}>
                {sailor.selectionReadiness.label}
              </p>
              <p className={`mt-1 text-xs leading-relaxed ${MUTED}`}>
                {sailor.selectionReadiness.detail}
              </p>
            </div>

            <div>
              <div className="flex items-center justify-between mb-3">
                <h3 className={`text-xs font-bold uppercase tracking-wider ${MUTED}`}>
                  Best 3 of 5
                </h3>
                {sailor.bestThreeOfFive != null && (
                  <span className="text-[11px] font-semibold text-[var(--sp-racing-orange)]">
                    Total: {sailor.bestThreeOfFive} pts
                  </span>
                )}
              </div>
              {sailor.scoringEvents.length > 0 ? (
                <div className="grid grid-cols-2 gap-2 sm:grid-cols-3">
                  {sailor.scoringEvents.map((event) => (
                    <div
                      key={event.regattaId}
                      className={`rounded-xl border p-3 ${
                        event.selected
                          ? "border-[var(--sp-racing-orange)]/40 bg-[var(--sp-racing-mist)]/40"
                          : NESTED
                      }`}
                    >
                      <p className={`truncate text-[10px] font-bold ${MUTED}`}>
                        {event.regattaName}
                      </p>
                      <p
                        className={`mt-1 text-xl font-black ${
                          event.selected ? "text-[var(--sp-racing-orange)]" : INK
                        }`}
                      >
                        {event.score}
                        {event.isDns ? "*" : event.isOverseas ? "†" : ""}
                      </p>
                      {event.selected && (
                        <p className="mt-1 text-[9px] font-bold uppercase text-[var(--sp-racing-orange)]">
                          Counting
                        </p>
                      )}
                    </div>
                  ))}
                </div>
              ) : (
                <p className={`rounded-xl border border-dashed border-[var(--sp-cool-veil)] px-3 py-4 text-center text-[11px] ${MUTED}`}>
                  No ranking scoring events recorded yet.
                </p>
              )}
            </div>

            <div>
              <h3 className={`text-xs font-bold uppercase tracking-wider ${MUTED} mb-3`}>
                Recent regattas & race scores
              </h3>
              {sailor.recentResults.length > 0 ? (
                <div className="space-y-3">
                  {sailor.recentResults.map((result) => {
                    const regattaHref = regattaResultsHref(
                      result.boatClass,
                      result.regattaSlug
                    );

                    return (
                      <div key={result.resultId} className={`${NESTED} p-4`}>
                        <div className="flex justify-between gap-3">
                          <div>
                            <Link
                              href={regattaHref}
                              className={`text-sm font-bold ${INK} hover:text-[var(--sp-racing-orange)] transition`}
                            >
                              {result.regattaName}
                            </Link>
                            <p className={`mt-0.5 text-[10px] ${MUTED}`}>{result.date}</p>
                          </div>
                          <p className={`text-sm font-black ${INK}`}>
                            #{result.rank}
                            {result.nettScore != null ? (
                              <span className={`ml-1 text-[10px] font-medium ${MUTED}`}>
                                · {result.nettScore} net
                              </span>
                            ) : null}
                          </p>
                        </div>

                        {result.races.length ? (
                          <div className="mt-3 flex flex-wrap gap-1.5">
                            {result.races.map((race) => (
                              <span
                                key={race.raceNumber}
                                title={race.rawValue}
                                className={`rounded-md border px-2 py-1 text-[10px] ${
                                  race.discarded
                                    ? "border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)] line-through"
                                    : "border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
                                }`}
                              >
                                R{race.raceNumber}: {race.code || race.score}
                              </span>
                            ))}
                          </div>
                        ) : (
                          <p className={`mt-3 text-[10px] ${MUTED}`}>
                            No official race-by-race scores imported.
                          </p>
                        )}
                      </div>
                    );
                  })}
                </div>
              ) : (
                <p className={`rounded-xl border border-dashed border-[var(--sp-cool-veil)] px-3 py-4 text-center text-[11px] ${MUTED}`}>
                  No regatta results on file yet.
                </p>
              )}
            </div>
          </div>

          <hr className="border-[var(--sp-cool-veil)]" />

          <div id="drawer-coaching-log" className="space-y-6">
            <div className="flex items-center justify-between">
              <div>
                <h3 className={`text-xs font-bold uppercase tracking-wider ${MUTED}`}>
                  Coaching history
                </h3>
                <p className={`mt-0.5 text-[11px] ${MUTED}`}>
                  Track observations, goals, and training milestones.
                </p>
              </div>
              <span className={`text-[11px] font-semibold ${MUTED}`}>
                {sailor.developmentRecords.length} records
              </span>
            </div>

            {sailor.developmentRecords.length ? (
              <div className="space-y-3">
                {sailor.developmentRecords.map((record) => {
                  const isShared = record.visibility === "shared";
                  const isGoal = record.type === "goal";
                  const isObservation = record.type === "observation";
                  const isAttendance = record.type === "attendance";

                  return (
                    <div
                      key={record.id}
                      className={`group relative ${NESTED} p-4 transition hover:border-[var(--sp-harbour-teal)]`}
                    >
                      <div className="flex items-start justify-between gap-3">
                        <div className="flex flex-wrap items-center gap-2">
                          <span className="rounded-full bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] px-2 py-0.5 text-[9px] font-extrabold uppercase tracking-wide text-[var(--sp-charcoal-slate)]">
                            {record.type}
                          </span>

                          {isAttendance && (
                            <span
                              className={`rounded-full px-2 py-0.5 text-[9px] font-bold ${
                                record.status === "present"
                                  ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
                                  : record.status === "absent"
                                  ? "bg-rose-50 text-rose-700 border border-rose-200"
                                  : "bg-amber-50 text-amber-700 border border-amber-200"
                              }`}
                            >
                              {record.status === "present"
                                ? "Present"
                                : record.status === "absent"
                                ? "Absent"
                                : "Planned absence"}
                            </span>
                          )}

                          <span
                            className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[9px] font-bold border ${
                              isShared
                                ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border-[var(--sp-harbour-teal)]/25"
                                : "bg-[var(--sp-warm-white)] text-[var(--sp-slate-soft)] border-[var(--sp-cool-veil)]"
                            }`}
                          >
                            {isShared ? (
                              <>
                                <Globe2 className="h-2.5 w-2.5" /> Shared with Family
                              </>
                            ) : (
                              <>
                                <Lock className="h-2.5 w-2.5" /> Coach Only
                              </>
                            )}
                          </span>

                          {isObservation && record.category && (
                            <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2 py-0.5 text-[9px] font-bold text-[var(--sp-harbour-teal)]">
                              {record.category}
                            </span>
                          )}

                          {isObservation && record.sentiment && record.sentiment !== "neutral" && (
                            <span
                              className={`rounded-full px-2 py-0.5 text-[9px] font-bold ${
                                record.sentiment === "strength"
                                  ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
                                  : "bg-[var(--sp-racing-mist)]/50 text-[var(--sp-racing-deep)]"
                              }`}
                            >
                              {record.sentiment === "strength" ? "Strength" : "Focus Area"}
                            </span>
                          )}
                        </div>

                        <div className={`flex items-center gap-2 text-[10px] ${MUTED} shrink-0`}>
                          <Calendar className="h-3 w-3" />
                          <span>{record.recordDate}</span>
                          {onDeleteRecord && (
                            <button
                              type="button"
                              onClick={() => onDeleteRecord(record.id)}
                              title="Delete record"
                              className={`opacity-80 sm:opacity-0 sm:group-hover:opacity-100 rounded p-1.5 ${MUTED} hover:text-rose-600 transition`}
                            >
                              <Trash2 className="h-3 w-3" />
                            </button>
                          )}
                        </div>
                      </div>

                      <p className={`mt-2 text-xs font-bold ${INK}`}>{record.title}</p>

                      {record.detail && (
                        <p className={`mt-1 text-[11px] leading-relaxed ${BODY}`}>
                          {record.detail}
                        </p>
                      )}

                      {isGoal && (
                        <div className="mt-3 flex items-center justify-between border-t border-[var(--sp-cool-veil)] pt-2">
                          <span className={`inline-flex items-center gap-1 text-[11px] ${MUTED}`}>
                            <Clock className="h-3 w-3 text-[var(--sp-racing-orange)]" />
                            Target: {record.targetDate || "Ongoing"}
                          </span>
                          {onUpdateRecordStatus && (
                            <button
                              type="button"
                              onClick={() =>
                                onUpdateRecordStatus(
                                  record.id,
                                  record.status === "completed" ? "active" : "completed"
                                )
                              }
                              className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[10px] font-bold transition ${
                                record.status === "completed"
                                  ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
                                  : "bg-[var(--sp-warm-white)] text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                              }`}
                            >
                              <CheckCircle2 className="h-3 w-3" />
                              {record.status === "completed" ? "Completed" : "Mark Complete"}
                            </button>
                          )}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            ) : (
              <p className={`rounded-xl border border-dashed border-[var(--sp-cool-veil)] px-3 py-5 text-center text-[11px] ${MUTED}`}>
                No structured coaching records yet.
              </p>
            )}

            <div className={`${NESTED} p-4 sm:p-5`}>
              <div className="flex items-center justify-between pb-3 border-b border-[var(--sp-cool-veil)]">
                <h4 className={`text-xs font-bold uppercase tracking-wider ${INK}`}>
                  New Coaching Record
                </h4>
                <VisibilityToggle value={recordVisibility} onChange={setRecordVisibility} />
              </div>

              <form onSubmit={handleAddRecord} className="mt-4 space-y-3">
                <div className="grid grid-cols-2 gap-2">
                  <select
                    aria-label="Record type"
                    value={recordType}
                    onChange={(e) => setRecordType(e.target.value as typeof recordType)}
                    className="sp-select text-xs"
                  >
                    <option value="observation">Observation</option>
                    <option value="goal">Development goal</option>
                    <option value="attendance">Attendance</option>
                  </select>

                  <input
                    aria-label="Record date"
                    type="date"
                    value={recordDate}
                    onChange={(e) => setRecordDate(e.target.value)}
                    className="sp-input text-xs"
                  />
                </div>

                {recordType === "observation" && (
                  <div className="space-y-2">
                    <select
                      aria-label="Skill category"
                      value={recordCategory}
                      onChange={(e) => setRecordCategory(e.target.value)}
                      className="sp-select w-full text-xs"
                    >
                      {OBSERVATION_CATEGORIES.map((c) => (
                        <option key={c} value={c}>
                          {c}
                        </option>
                      ))}
                    </select>

                    <div className="flex gap-1.5">
                      <button
                        type="button"
                        onClick={() => setRecordSentiment("strength")}
                        className={`flex-1 rounded-lg border py-1.5 text-[10px] font-bold transition ${
                          recordSentiment === "strength"
                            ? "border-[var(--sp-harbour-teal)]/40 bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]"
                            : `${NESTED} ${MUTED} hover:text-[var(--sp-harbour-shadow)]`
                        }`}
                      >
                        Strength
                      </button>
                      <button
                        type="button"
                        onClick={() => setRecordSentiment("focus")}
                        className={`flex-1 rounded-lg border py-1.5 text-[10px] font-bold transition ${
                          recordSentiment === "focus"
                            ? "border-[var(--sp-racing-orange)]/40 bg-[var(--sp-racing-mist)]/50 text-[var(--sp-racing-deep)]"
                            : `${NESTED} ${MUTED} hover:text-[var(--sp-harbour-shadow)]`
                        }`}
                      >
                        Focus Area
                      </button>
                    </div>
                  </div>
                )}

                {recordType === "goal" && (
                  <input
                    aria-label="Target date"
                    type="date"
                    value={targetDate}
                    onChange={(e) => setTargetDate(e.target.value)}
                    className="sp-input w-full text-xs"
                  />
                )}

                {recordType === "attendance" && (
                  <select
                    aria-label="Attendance status"
                    value={recordStatus}
                    onChange={(e) => setRecordStatus(e.target.value)}
                    className="sp-select w-full text-xs"
                  >
                    <option value="present">Present</option>
                    <option value="absent">Absent</option>
                    <option value="planned">Planned absence</option>
                  </select>
                )}

                <input
                  aria-label="Record title"
                  value={recordTitle}
                  onChange={(e) => setRecordTitle(e.target.value)}
                  maxLength={160}
                  placeholder={
                    recordType === "attendance"
                      ? "Session or reason"
                      : recordType === "goal"
                      ? "Measurable development goal"
                      : "What did you observe?"
                  }
                  className="sp-input w-full text-xs"
                />

                <textarea
                  aria-label="Record detail"
                  value={recordDetail}
                  onChange={(e) => setRecordDetail(e.target.value)}
                  maxLength={4000}
                  rows={3}
                  placeholder="Context, success measure, or follow-up"
                  className="sp-input w-full text-xs"
                />

                <button
                  type="submit"
                  disabled={!recordTitle.trim() || busyId === "development"}
                  className="w-full sp-btn-primary py-2.5 disabled:opacity-40"
                >
                  {busyId === "development" ? "Saving…" : "Add coaching record"}
                </button>
              </form>
            </div>
          </div>

          <hr className="border-[var(--sp-cool-veil)]" />

          <div id="drawer-note" className="space-y-3">
            <div className="flex items-center justify-between">
              <div>
                <label
                  htmlFor="coach-note"
                  className={`text-xs font-bold uppercase tracking-wider ${MUTED}`}
                >
                  Private coach note
                </label>
                <p className={`mt-0.5 text-[10px] ${MUTED}`}>
                  Visible only in your coach account unless shared.
                </p>
              </div>

              <VisibilityToggle value={noteVisibility} onChange={setNoteVisibility} />
            </div>

            <textarea
              id="coach-note"
              aria-label="Private coach note"
              value={noteDraft}
              onChange={(e) => setNoteDraft(e.target.value)}
              maxLength={4000}
              rows={5}
              placeholder="Focus areas, training observations, or follow-up…"
              className="sp-input w-full text-sm"
            />

            <div className="flex items-center justify-between">
              <span className={`text-[10px] ${MUTED}`}>
                {noteDraft.length}/4000
              </span>
              <button
                type="button"
                onClick={handleSaveNote}
                disabled={busyId === "note"}
                className="sp-btn-primary disabled:opacity-50"
              >
                {busyId === "note" ? "Saving…" : "Save note"}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
