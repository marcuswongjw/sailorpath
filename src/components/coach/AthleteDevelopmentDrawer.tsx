"use client";

import Link from "next/link";
import { useState } from "react";
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
import type { CoachSquadMember } from "@/lib/coachDashboard";

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

export function AthleteDevelopmentDrawer({
  sailor,
  onClose,
  onSaveNote,
  onAddRecord,
  onUpdateRecordStatus,
  onDeleteRecord,
  busyId,
}: AthleteDevelopmentDrawerProps) {
  // Private note state
  const [noteDraft, setNoteDraft] = useState(sailor.coachNote || "");
  const [noteVisibility, setNoteVisibility] = useState<"coach_only" | "shared">(
    sailor.coachNoteVisibility || "coach_only"
  );

  // New development record state
  const [recordType, setRecordType] = useState<"observation" | "goal" | "attendance">("observation");
  const [recordCategory, setRecordCategory] = useState("Starts");
  const [recordSentiment, setRecordSentiment] = useState<"strength" | "focus" | "neutral">("strength");
  const [recordVisibility, setRecordVisibility] = useState<"coach_only" | "shared">("coach_only");
  const [recordTitle, setRecordTitle] = useState("");
  const [recordDetail, setRecordDetail] = useState("");
  const [recordDate, setRecordDate] = useState(() => new Date().toISOString().slice(0, 10));
  const [targetDate, setTargetDate] = useState("");
  const [recordStatus, setRecordStatus] = useState("active");

  async function handleAddRecord(e: React.FormEvent) {
    e.preventDefault();
    if (!recordTitle.trim()) return;

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
  }

  async function handleSaveNote(e: React.FormEvent) {
    e.preventDefault();
    await onSaveNote(noteDraft, noteVisibility);
  }

  function scrollToSection(id: string) {
    const el = document.getElementById(id);
    if (el) {
      el.scrollIntoView({ behavior: "smooth" });
    }
  }

  return (
    <div
      className="fixed inset-0 z-50 flex justify-end bg-black/75 backdrop-blur-sm transition-opacity"
      role="dialog"
      aria-modal="true"
      aria-label={`${sailor.name} coach details`}
      onMouseDown={(e) => {
        if (e.target === e.currentTarget) onClose();
      }}
    >
      <div className="flex h-full w-full max-w-xl flex-col border-l border-white/10 bg-[#0c0d14] text-white shadow-2xl">
        {/* Drawer Header (Sticky) */}
        <div className="flex items-start justify-between border-b border-white/10 p-5 sm:p-6 bg-[#0c0d14]/95 backdrop-blur shrink-0">
          <div className="min-w-0 pr-4">
            <div className="flex flex-wrap items-center gap-2">
              <span className="text-[10px] font-bold uppercase tracking-[0.16em] text-orange-400">
                Coach Workspace
              </span>
              {sailor.fleet && (
                <span className="rounded-full border border-orange-500/30 bg-orange-500/10 px-2 py-0.5 text-[10px] font-bold text-orange-300">
                  {sailor.fleet} #{sailor.ranking}
                </span>
              )}
              {sailor.squadStatus && (
                <span className="rounded-full border border-sky-500/25 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300">
                  {sailor.squadStatus}
                </span>
              )}
            </div>
            <h2 className="mt-1 truncate text-2xl font-black text-white">{sailor.name}</h2>
            <p className="mt-0.5 truncate text-xs text-slate-400">
              {sailor.sailNumber} · {sailor.club}
            </p>
          </div>

          <button
            type="button"
            onClick={onClose}
            aria-label="Close sailor details"
            className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl border border-white/10 bg-white/5 text-slate-400 hover:bg-white/10 hover:text-white transition"
          >
            <X className="h-5 w-5" />
          </button>
        </div>

        {/* Quick Jump Bar */}
        <div className="flex items-center gap-2 border-b border-white/10 bg-black/40 px-4 py-2.5 sm:px-6 overflow-x-auto shrink-0">
          <button
            type="button"
            onClick={() => scrollToSection("drawer-scores")}
            className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-semibold text-slate-300 hover:bg-white/10 hover:text-white transition whitespace-nowrap"
          >
            <Trophy className="h-3 w-3 text-orange-400" /> Scores & Races
          </button>
          <button
            type="button"
            onClick={() => scrollToSection("drawer-coaching-log")}
            className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-semibold text-slate-300 hover:bg-white/10 hover:text-white transition whitespace-nowrap"
          >
            <Target className="h-3 w-3 text-sky-400" /> Coaching Log ({sailor.developmentRecords.length})
          </button>
          <button
            type="button"
            onClick={() => scrollToSection("drawer-note")}
            className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-semibold text-slate-300 hover:bg-white/10 hover:text-white transition whitespace-nowrap"
          >
            <FileText className="h-3 w-3 text-emerald-400" /> Coach Note
          </button>
        </div>

        {/* Drawer Scrollable Body */}
        <div className="flex-1 overflow-y-auto p-5 sm:p-6 space-y-8">
          {/* SECTION 1: SCORES & REGATTAS */}
          <div id="drawer-scores" className="space-y-6">
            {/* Selection Readiness Banner */}
            <div className="rounded-2xl border border-white/[0.08] bg-white/[0.025] p-4">
              <h3 className="text-xs font-bold uppercase tracking-wider text-slate-400">
                Selection readiness
              </h3>
              <p className="mt-2 text-sm font-bold text-white">
                {sailor.selectionReadiness.label}
              </p>
              <p className="mt-1 text-xs leading-relaxed text-slate-400">
                {sailor.selectionReadiness.detail}
              </p>
            </div>

            {/* Best 3 of 5 Cards */}
            <div>
              <div className="flex items-center justify-between mb-3">
                <h3 className="text-xs font-bold uppercase tracking-wider text-slate-400">
                  Best 3 of 5
                </h3>
                {sailor.bestThreeOfFive != null && (
                  <span className="text-[11px] font-semibold text-orange-400">
                    Total: {sailor.bestThreeOfFive} pts
                  </span>
                )}
              </div>
              <div className="grid grid-cols-2 gap-2 sm:grid-cols-3">
                {sailor.scoringEvents.map((event) => (
                  <div
                    key={event.regattaId}
                    className={`rounded-xl border p-3 ${
                      event.selected
                        ? "border-orange-500/50 bg-orange-500/10"
                        : "border-white/[0.07] bg-white/[0.02]"
                    }`}
                  >
                    <p className="truncate text-[10px] font-bold text-slate-400">
                      {event.regattaName}
                    </p>
                    <p
                      className={`mt-1 text-xl font-black ${
                        event.selected ? "text-orange-300" : "text-white"
                      }`}
                    >
                      {event.score}
                      {event.isDns ? "*" : event.isOverseas ? "†" : ""}
                    </p>
                    {event.selected && (
                      <p className="mt-1 text-[9px] font-bold uppercase text-orange-400">
                        Counting
                      </p>
                    )}
                  </div>
                ))}
              </div>
            </div>

            {/* Recent Regattas & Race Breakdown */}
            <div>
              <h3 className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-3">
                Recent regattas & race scores
              </h3>
              <div className="space-y-3">
                {sailor.recentResults.map((result) => (
                  <div
                    key={result.resultId}
                    className="rounded-xl border border-white/[0.08] bg-white/[0.02] p-4"
                  >
                    <div className="flex justify-between gap-3">
                      <div>
                        <Link
                          href={`/regattas/${result.regattaSlug}`}
                          className="text-sm font-bold text-white hover:text-orange-400 transition"
                        >
                          {result.regattaName}
                        </Link>
                        <p className="mt-0.5 text-[10px] text-slate-500">{result.date}</p>
                      </div>
                      <p className="text-sm font-black text-white">
                        #{result.rank}
                        {result.nettScore != null ? (
                          <span className="ml-1 text-[10px] font-medium text-slate-500">
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
                                ? "border-slate-700 text-slate-600 line-through"
                                : "border-sky-500/20 bg-sky-500/5 text-sky-300"
                            }`}
                          >
                            R{race.raceNumber}: {race.code || race.score}
                          </span>
                        ))}
                      </div>
                    ) : (
                      <p className="mt-3 text-[10px] text-slate-600">
                        No official race-by-race scores imported.
                      </p>
                    )}
                  </div>
                ))}
              </div>
            </div>
          </div>

          <hr className="border-white/10" />

          {/* SECTION 2: COACHING LOG & OBSERVATIONS */}
          <div id="drawer-coaching-log" className="space-y-6">
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-xs font-bold uppercase tracking-wider text-slate-400">
                  Coaching history
                </h3>
                <p className="mt-0.5 text-[11px] text-slate-500">
                  Track observations, goals, and training milestones.
                </p>
              </div>
              <span className="text-[11px] font-semibold text-slate-500">
                {sailor.developmentRecords.length} records
              </span>
            </div>

            {/* Existing Records List */}
            {sailor.developmentRecords.length ? (
              <div className="space-y-3">
                {sailor.developmentRecords.map((record) => {
                  const isShared = record.visibility === "shared";
                  const isGoal = record.type === "goal";
                  const isObservation = record.type === "observation";

                  return (
                    <div
                      key={record.id}
                      className="group relative rounded-2xl border border-white/[0.08] bg-white/[0.02] p-4 transition hover:border-white/15"
                    >
                      <div className="flex items-start justify-between gap-3">
                        <div className="flex flex-wrap items-center gap-2">
                          <span className="rounded-full bg-white/10 px-2 py-0.5 text-[9px] font-extrabold uppercase tracking-wide text-slate-300">
                            {record.type}
                          </span>

                          {/* Visibility Badge */}
                          <span
                            className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[9px] font-bold ${
                              isShared
                                ? "bg-emerald-500/15 text-emerald-300 border border-emerald-500/25"
                                : "bg-white/5 text-slate-400 border border-white/10"
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

                          {/* Category / Sentiment */}
                          {isObservation && record.category && (
                            <span className="rounded-full border border-sky-500/20 bg-sky-500/10 px-2 py-0.5 text-[9px] font-bold text-sky-300">
                              {record.category}
                            </span>
                          )}

                          {isObservation && record.sentiment && record.sentiment !== "neutral" && (
                            <span
                              className={`rounded-full px-2 py-0.5 text-[9px] font-bold ${
                                record.sentiment === "strength"
                                  ? "bg-emerald-500/10 text-emerald-400"
                                  : "bg-amber-500/10 text-amber-400"
                              }`}
                            >
                              {record.sentiment === "strength" ? "Strength" : "Focus Area"}
                            </span>
                          )}
                        </div>

                        <div className="flex items-center gap-2 text-[10px] text-slate-500 shrink-0">
                          <Calendar className="h-3 w-3" />
                          <span>{record.recordDate}</span>
                          {onDeleteRecord && (
                            <button
                              type="button"
                              onClick={() => onDeleteRecord(record.id)}
                              title="Delete record"
                              className="opacity-0 group-hover:opacity-100 rounded p-1 text-slate-500 hover:text-rose-400 transition"
                            >
                              <Trash2 className="h-3 w-3" />
                            </button>
                          )}
                        </div>
                      </div>

                      <p className="mt-2 text-xs font-bold text-white">{record.title}</p>

                      {record.detail && (
                        <p className="mt-1 text-[11px] leading-relaxed text-slate-300">
                          {record.detail}
                        </p>
                      )}

                      {isGoal && (
                        <div className="mt-3 flex items-center justify-between border-t border-white/[0.06] pt-2">
                          <span className="inline-flex items-center gap-1 text-[11px] text-slate-400">
                            <Clock className="h-3 w-3 text-orange-400" />
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
                                  ? "bg-emerald-500/20 text-emerald-300"
                                  : "bg-white/5 text-slate-400 hover:bg-white/10"
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
              <p className="rounded-xl border border-dashed border-white/10 px-3 py-5 text-center text-[11px] text-slate-600">
                No structured coaching records yet.
              </p>
            )}

            {/* Add New Record Form Card */}
            <div className="rounded-2xl border border-white/10 bg-black/20 p-4 sm:p-5">
              <div className="flex items-center justify-between pb-3 border-b border-white/[0.08]">
                <h4 className="text-xs font-bold uppercase tracking-wider text-slate-300">
                  New Coaching Record
                </h4>
                {/* Selective Sharing Switch */}
                <div className="flex items-center gap-1 rounded-lg border border-white/10 bg-black/40 p-0.5">
                  <button
                    type="button"
                    onClick={() => setRecordVisibility("coach_only")}
                    className={`flex items-center gap-1.5 rounded-md px-2 py-1 text-[10px] font-bold transition ${
                      recordVisibility === "coach_only"
                        ? "bg-white/15 text-white shadow-sm"
                        : "text-slate-400 hover:text-slate-200"
                    }`}
                  >
                    <Lock className="h-3 w-3" />
                    <span>Coach Only</span>
                  </button>
                  <button
                    type="button"
                    onClick={() => setRecordVisibility("shared")}
                    className={`flex items-center gap-1.5 rounded-md px-2 py-1 text-[10px] font-bold transition ${
                      recordVisibility === "shared"
                        ? "bg-emerald-500/20 text-emerald-300 shadow-sm"
                        : "text-slate-400 hover:text-slate-200"
                    }`}
                  >
                    <Globe2 className="h-3 w-3" />
                    <span>Share with Family</span>
                  </button>
                </div>
              </div>

              <form onSubmit={handleAddRecord} className="mt-4 space-y-3">
                {/* Type and Date Row */}
                <div className="grid grid-cols-2 gap-2">
                  <select
                    aria-label="Record type"
                    value={recordType}
                    onChange={(e) => setRecordType(e.target.value as typeof recordType)}
                    className="rounded-lg border border-white/10 bg-black/30 px-2 py-2 text-xs text-white outline-none focus:border-orange-500/50"
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
                    className="rounded-lg border border-white/10 bg-black/30 px-2 py-2 text-xs text-white outline-none focus:border-orange-500/50"
                  />
                </div>

                {/* Observation Category and Sentiment */}
                {recordType === "observation" && (
                  <div className="space-y-2">
                    <select
                      aria-label="Skill category"
                      value={recordCategory}
                      onChange={(e) => setRecordCategory(e.target.value)}
                      className="w-full rounded-lg border border-white/10 bg-black/30 px-2 py-2 text-xs text-white outline-none focus:border-orange-500/50"
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
                            ? "border-emerald-500/40 bg-emerald-500/15 text-emerald-300"
                            : "border-white/10 bg-black/30 text-slate-400 hover:text-white"
                        }`}
                      >
                        🟢 Strength
                      </button>
                      <button
                        type="button"
                        onClick={() => setRecordSentiment("focus")}
                        className={`flex-1 rounded-lg border py-1.5 text-[10px] font-bold transition ${
                          recordSentiment === "focus"
                            ? "border-amber-500/40 bg-amber-500/15 text-amber-300"
                            : "border-white/10 bg-black/30 text-slate-400 hover:text-white"
                        }`}
                      >
                        🟠 Focus Area
                      </button>
                    </div>
                  </div>
                )}

                {/* Goal Target Date */}
                {recordType === "goal" && (
                  <input
                    aria-label="Target date"
                    type="date"
                    value={targetDate}
                    onChange={(e) => setTargetDate(e.target.value)}
                    className="w-full rounded-lg border border-white/10 bg-black/30 px-2 py-2 text-xs text-white outline-none focus:border-orange-500/50"
                  />
                )}

                {/* Attendance Status */}
                {recordType === "attendance" && (
                  <select
                    aria-label="Attendance status"
                    value={recordStatus}
                    onChange={(e) => setRecordStatus(e.target.value)}
                    className="w-full rounded-lg border border-white/10 bg-black/30 px-2 py-2 text-xs text-white outline-none focus:border-orange-500/50"
                  >
                    <option value="present">Present</option>
                    <option value="absent">Absent</option>
                    <option value="planned">Planned absence</option>
                  </select>
                )}

                {/* Title */}
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
                  className="w-full rounded-lg border border-white/10 bg-black/30 px-3 py-2 text-xs text-white outline-none focus:border-orange-500/50"
                />

                {/* Detail */}
                <textarea
                  aria-label="Record detail"
                  value={recordDetail}
                  onChange={(e) => setRecordDetail(e.target.value)}
                  maxLength={4000}
                  rows={3}
                  placeholder="Context, success measure, or follow-up"
                  className="w-full rounded-lg border border-white/10 bg-black/30 p-3 text-xs text-white outline-none focus:border-orange-500/50"
                />

                <button
                  type="submit"
                  disabled={!recordTitle.trim() || busyId === "development"}
                  className="w-full rounded-lg bg-sky-600 px-3 py-2 text-xs font-bold text-white hover:bg-sky-500 disabled:opacity-40 transition"
                >
                  {busyId === "development" ? "Saving…" : "Add coaching record"}
                </button>
              </form>
            </div>
          </div>

          <hr className="border-white/10" />

          {/* SECTION 3: COACH NOTE */}
          <div id="drawer-note" className="space-y-3">
            <div className="flex items-center justify-between">
              <div>
                <label
                  htmlFor="coach-note"
                  className="text-xs font-bold uppercase tracking-wider text-slate-400"
                >
                  Private coach note
                </label>
                <p className="mt-0.5 text-[10px] text-slate-600">
                  Visible only in your coach account unless shared.
                </p>
              </div>

              {/* Selective Sharing Switch for Coach Note */}
              <div className="flex items-center gap-1 rounded-lg border border-white/10 bg-black/40 p-0.5">
                <button
                  type="button"
                  onClick={() => setNoteVisibility("coach_only")}
                  className={`flex items-center gap-1.5 rounded-md px-2 py-1 text-[10px] font-bold transition ${
                    noteVisibility === "coach_only"
                      ? "bg-white/15 text-white shadow-sm"
                      : "text-slate-400 hover:text-slate-200"
                  }`}
                >
                  <Lock className="h-3 w-3" />
                  <span>Coach Only</span>
                </button>
                <button
                  type="button"
                  onClick={() => setNoteVisibility("shared")}
                  className={`flex items-center gap-1.5 rounded-md px-2 py-1 text-[10px] font-bold transition ${
                    noteVisibility === "shared"
                      ? "bg-emerald-500/20 text-emerald-300 shadow-sm"
                      : "text-slate-400 hover:text-slate-200"
                  }`}
                >
                  <Globe2 className="h-3 w-3" />
                  <span>Share with Family</span>
                </button>
              </div>
            </div>

            <textarea
              id="coach-note"
              aria-label="Private coach note"
              value={noteDraft}
              onChange={(e) => setNoteDraft(e.target.value)}
              maxLength={4000}
              rows={5}
              placeholder="Focus areas, training observations, or follow-up…"
              className="w-full rounded-xl border border-white/10 bg-black/30 p-3 text-sm text-white outline-none focus:border-orange-500/50"
            />

            <div className="flex items-center justify-between">
              <span className="text-[10px] text-slate-600">
                {noteDraft.length}/4000
              </span>
              <button
                type="button"
                onClick={handleSaveNote}
                disabled={busyId === "note"}
                className="rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-50 transition"
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
