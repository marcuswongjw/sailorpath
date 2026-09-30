"use client";

import { Calendar } from "lucide-react";

export type CalendarFormState = {
  name: string;
  startDate: string;
  endDate: string;
  venue: string;
  organizer: string;
  classes: string;
  norUrl: string;
  registrationUrl: string;
  keyDeadlines: string;
  countsForRanking: boolean;
  isSelectionTrial: boolean;
};

export type SavedCalendarEvent = {
  id: string;
  slug: string;
  name: string;
  startDate: string;
  endDate?: string | null;
  venue?: string | null;
  organizer?: string | null;
  classes?: string[] | null;
  norUrl?: string | null;
  registrationUrl?: string | null;
  countsForRanking?: boolean | null;
  isSelectionTrial?: boolean | null;
  keyDeadlines?: string | null;
};

const DEFAULT_CALENDAR_CLASSES = [
  "Optimist",
  "ILCA 4",
  "ILCA 6",
  "ILCA 7",
  "29er",
  "420",
  "Techno 293",
  "iQFOiL",
  "WingFoil",
  "RS Feva",
] as const;

export function calendarFormFrom(
  event: { name: string; startDate: string; endDate?: string; venue?: string; organizer?: string; norUrl?: string; registrationUrl?: string; countsForRanking: boolean; isSelectionTrial: boolean; keyDeadlines?: string; expectedClasses: string[] }
): CalendarFormState {
  return {
    name: event.name || "",
    startDate: event.startDate || "",
    endDate: event.endDate || "",
    venue: event.venue || "",
    organizer: event.organizer || "",
    classes: event.expectedClasses.join(", "),
    norUrl: event.norUrl || "",
    registrationUrl: event.registrationUrl || "",
    keyDeadlines: event.keyDeadlines || "",
    countsForRanking: event.countsForRanking,
    isSelectionTrial: event.isSelectionTrial,
  };
}

export type CalendarEventFormProps = {
  calendarForm: CalendarFormState | null;
  setCalendarForm: React.Dispatch<React.SetStateAction<CalendarFormState | null>>;
  calendarSaving: boolean;
  handleSaveCalendar: () => void | Promise<void>;
  showCalendarForm: boolean;
  setShowCalendarForm: (v: boolean) => void;
};

/**
 * Collapsible calendar event details form for the regatta admin panel.
 * Manages event name, dates, venue, organiser, classes, NOR/registration URLs,
 * ranking and selection trial settings.
 */
export function CalendarEventForm({
  calendarForm,
  setCalendarForm,
  calendarSaving,
  handleSaveCalendar,
  showCalendarForm,
  setShowCalendarForm,
}: CalendarEventFormProps) {
  if (!showCalendarForm) return null;
  if (!calendarForm) return null;

  return (
    <div className="rounded-2xl border border-slate-200 bg-slate-50/70 p-4 sm:p-5 space-y-4 shadow-xs">
      <div className="flex items-center justify-between">
        <h4 className="text-xs font-black uppercase tracking-wider text-orange-600 flex items-center gap-1.5">
          <Calendar className="h-3.5 w-3.5" />
          Public Notice Board &amp; Calendar Details
        </h4>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <div className="sm:col-span-2">
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            Event Name
          </label>
          <input
            value={calendarForm.name}
            onChange={(e) =>
              setCalendarForm({ ...calendarForm, name: e.target.value })
            }
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <div>
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            Start Date
          </label>
          <input
            type="date"
            value={calendarForm.startDate}
            onChange={(e) =>
              setCalendarForm({
                ...calendarForm,
                startDate: e.target.value,
              })
            }
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <div>
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            End Date
          </label>
          <input
            type="date"
            value={calendarForm.endDate}
            onChange={(e) =>
              setCalendarForm({
                ...calendarForm,
                endDate: e.target.value,
              })
            }
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <div className="sm:col-span-2">
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            Venue
          </label>
          <input
            value={calendarForm.venue}
            onChange={(e) =>
              setCalendarForm({ ...calendarForm, venue: e.target.value })
            }
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <div className="sm:col-span-2">
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            Organiser
          </label>
          <input
            value={calendarForm.organizer}
            onChange={(e) =>
              setCalendarForm({
                ...calendarForm,
                organizer: e.target.value,
              })
            }
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <div className="sm:col-span-2">
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider block mb-1.5">
            Sailing Classes
          </label>
          <div className="p-3 rounded-xl border border-slate-300 bg-white shadow-xs">
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-2">
              {Array.from(
                new Set([
                  ...DEFAULT_CALENDAR_CLASSES,
                  ...((calendarForm.classes || "")
                    .split(",")
                    .map((c) => c.trim())
                    .filter(Boolean)),
                ])
              ).map((cls) => {
                const currentList = (calendarForm.classes || "")
                  .split(",")
                  .map((c) => c.trim())
                  .filter(Boolean);
                const isChecked = currentList.includes(cls);
                return (
                  <label
                    key={cls}
                    className={`flex items-center gap-2 p-2 rounded-lg border text-xs font-semibold cursor-pointer select-none transition-all ${
                      isChecked
                        ? "bg-orange-50 border-orange-300 text-orange-900 shadow-xs"
                        : "bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-100"
                    }`}
                  >
                    <input
                      type="checkbox"
                      checked={isChecked}
                      onChange={(e) => {
                        const updated = e.target.checked
                          ? [...currentList, cls]
                          : currentList.filter((item) => item !== cls);
                        setCalendarForm({
                          ...calendarForm,
                          classes: updated.join(", "),
                        });
                      }}
                      className="rounded border-slate-300 text-orange-600 focus:ring-orange-500 h-4 w-4"
                    />
                    <span className="truncate">{cls}</span>
                  </label>
                );
              })}
            </div>
          </div>
        </div>
        <div className="sm:col-span-2">
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            Status / Deadline
          </label>
          <input
            value={calendarForm.keyDeadlines}
            onChange={(e) =>
              setCalendarForm({
                ...calendarForm,
                keyDeadlines: e.target.value,
              })
            }
            placeholder="Entry closes 24 August 2026, 2359h"
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <div className="sm:col-span-2">
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            Official Notice Board URL
          </label>
          <input
            type="url"
            value={calendarForm.norUrl}
            onChange={(e) =>
              setCalendarForm({ ...calendarForm, norUrl: e.target.value })
            }
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <div className="sm:col-span-2">
          <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
            Registration Link
          </label>
          <input
            type="url"
            value={calendarForm.registrationUrl}
            onChange={(e) =>
              setCalendarForm({
                ...calendarForm,
                registrationUrl: e.target.value,
              })
            }
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
          />
        </div>
        <label className="sm:col-span-2 flex items-start gap-2.5 text-xs font-semibold text-slate-800 cursor-pointer">
          <input
            type="checkbox"
            className="mt-0.5 rounded border-slate-300 text-orange-600 focus:ring-orange-500 h-4 w-4"
            checked={calendarForm.countsForRanking}
            onChange={(e) =>
              setCalendarForm({
                ...calendarForm,
                countsForRanking: e.target.checked,
              })
            }
          />
          <span>
            Ranking regatta
            <span className="block text-[11px] font-normal text-slate-600">
              Applies to linked class sheets. Fewer than 3 races stays non-ranking.
            </span>
          </span>
        </label>
        <label className="flex items-center gap-2.5 text-xs font-semibold text-slate-800 cursor-pointer">
          <input
            type="checkbox"
            className="rounded border-slate-300 text-amber-600 focus:ring-amber-500 h-4 w-4"
            checked={calendarForm.isSelectionTrial}
            onChange={(e) =>
              setCalendarForm({
                ...calendarForm,
                isSelectionTrial: e.target.checked,
              })
            }
          />
          Official selection trial
        </label>
        <div className="sm:col-span-2 flex justify-end">
          <button
            type="button"
            disabled={calendarSaving}
            onClick={handleSaveCalendar}
            className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2 text-xs font-bold text-white transition-colors disabled:opacity-40 shadow-sm"
          >
            {calendarSaving ? "Saving…" : "Save Event Details"}
          </button>
        </div>
      </div>
    </div>
  );
}
