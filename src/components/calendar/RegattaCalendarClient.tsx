"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { EventFacts } from "@/components/EventFacts";
import {
  Calendar,
  Search,
  Sailboat,
  Trophy,
  ExternalLink,
  FileText,
  Download,
  Clock,
  Compass,
  ShieldCheck,
  Globe,
  AlertCircle,
} from "lucide-react";
import type { RegattaRecord } from "@/lib/ranking";
import { matchesRegattaClass, nationalRankingLabel } from "@/lib/calendar/publicRegattas";

export type RegattaCalendarClientProps = {
  regattas: RegattaRecord[];
  resultSheetsByEvent?: Record<string, RegattaRecord[]>;
  initialClass?: string;
  initialRanking?: string;
  initialYear?: string;
  initialRegion?: string;
  initialSearch?: string;
  initialTrialOnly?: boolean;
  initialTimelineTab?: "upcoming" | "past";
};

function formatMonth(dateStr: string): string {
  const ymd = String(dateStr || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(ymd)) return "";
  const m = Number(ymd.slice(5, 7));
  const months = [
    "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
    "JUL", "AUG", "SEP", "OCT", "NOV", "DEC",
  ];
  return months[m - 1] || "";
}

function formatDay(dateStr: string): string {
  const ymd = String(dateStr || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(ymd)) return "";
  return String(Number(ymd.slice(8, 10)));
}

function formatDateRange(startDateStr: string, endDateStr?: string | null): string {
  const startDay = formatDay(startDateStr);
  const month = formatMonth(startDateStr);
  const year = startDateStr.slice(0, 4);

  if (!endDateStr || endDateStr === startDateStr) {
    return `${startDay} ${month} ${year}`;
  }

  const endDay = formatDay(endDateStr);
  const endMonth = formatMonth(endDateStr);

  if (month === endMonth) {
    return `${startDay} – ${endDay} ${month} ${year}`;
  }
  return `${startDay} ${month} – ${endDay} ${endMonth} ${year}`;
}

function getCountdownLabel(startDateStr: string, endDateStr?: string | null): {
  label: string;
  tone: "today" | "urgent" | "soon" | "future" | "past";
} {
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const start = new Date(`${startDateStr.slice(0, 10)}T00:00:00`);
  const end = endDateStr ? new Date(`${endDateStr.slice(0, 10)}T23:59:59`) : new Date(`${startDateStr.slice(0, 10)}T23:59:59`);

  if (today > end) {
    return { label: "Completed", tone: "past" };
  }

  const diffMs = start.getTime() - today.getTime();
  const diffDays = Math.round(diffMs / (1000 * 60 * 60 * 24));

  if (diffDays <= 0 && today <= end) {
    return { label: "Racing Today", tone: "today" };
  }
  if (diffDays === 1) {
    return { label: "Tomorrow", tone: "urgent" };
  }
  if (diffDays <= 7) {
    return { label: `In ${diffDays} days`, tone: "urgent" };
  }
  if (diffDays <= 30) {
    const weeks = Math.round(diffDays / 7);
    return { label: `In ${weeks} week${weeks === 1 ? "" : "s"}`, tone: "soon" };
  }
  const months = Math.round(diffDays / 30);
  return { label: `In ${months} month${months === 1 ? "" : "s"}`, tone: "future" };
}

function regattaClasses(regatta: RegattaRecord): string[] {
  if (regatta.classes && regatta.classes.length > 0) return regatta.classes;
  return [regatta.boatClass || "Optimist"];
}

/** Calendar cards open the resolver, which sends each event to its real results page. */
export function regattaPageHref(
  regatta: Pick<RegattaRecord, "slug">,
  timelineTab: "upcoming" | "past" = "upcoming"
): string {
  const slug = regatta.slug || "";
  const suffix = timelineTab === "past" ? "?calendar=past" : "";
  if (
    slug === "snsc-2026" ||
    slug.startsWith("singapore-national-sailing-championships-2026")
  ) {
    return `/regattas/snsc-2026${suffix}`;
  }
  return `/regattas/${encodeURIComponent(slug)}${suffix}`;
}

function downloadIcs(regatta: RegattaRecord) {
  const startYmd = String(regatta.date).slice(0, 10).replace(/-/g, "");
  // For ICS whole-day event end date is exclusive (day after)
  let endYmd = startYmd;
  if (regatta.endDate) {
    const d = new Date(`${regatta.endDate.slice(0, 10)}T00:00:00`);
    d.setDate(d.getDate() + 1);
    endYmd = d.toISOString().slice(0, 10).replace(/-/g, "");
  } else {
    const d = new Date(`${regatta.date.slice(0, 10)}T00:00:00`);
    d.setDate(d.getDate() + 1);
    endYmd = d.toISOString().slice(0, 10).replace(/-/g, "");
  }

  const title = regatta.name.replace(/[,;]/g, " ");
  const description = [
    regatta.scheduleNotes,
    regatta.isSelectionTrial ? "Official Selection Trial for National Squad" : null,
    regatta.norUrl ? `Notice of Race: ${regatta.norUrl}` : null,
    regatta.registrationUrl ? `Registration: ${regatta.registrationUrl}` : null,
    "Track live scores and rankings at: https://sailorpath.com",
  ]
    .filter(Boolean)
    .join("\\n");

  const location = (regatta.venue || "Singapore").replace(/[,;]/g, " ");

  const icsContent = [
    "BEGIN:VCALENDAR",
    "VERSION:2.0",
    "PRODID:-//SailorPath//Singapore Regatta Calendar//EN",
    "CALSCALE:GREGORIAN",
    "METHOD:PUBLISH",
    "BEGIN:VEVENT",
    `UID:${regatta.id || regatta.slug}@sailorpath.com`,
    `DTSTAMP:${new Date().toISOString().replace(/[-:]/g, "").slice(0, 15)}Z`,
    `DTSTART;VALUE=DATE:${startYmd}`,
    `DTEND;VALUE=DATE:${endYmd}`,
    `SUMMARY:${title}`,
    `DESCRIPTION:${description}`,
    `LOCATION:${location}`,
    "STATUS:CONFIRMED",
    "END:VEVENT",
    "END:VCALENDAR",
  ].join("\r\n");

  const blob = new Blob([icsContent], { type: "text/calendar;charset=utf-8" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `${regatta.slug || "regatta"}.ics`;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}

export function RegattaCalendarClient({
  regattas = [],
  resultSheetsByEvent = {},
  initialClass = "all",
  initialRanking = "all",
  initialYear = "all",
  initialRegion = "all",
  initialSearch = "",
  initialTrialOnly = false,
  initialTimelineTab = "upcoming",
}: RegattaCalendarClientProps) {

  const [selectedClass, setSelectedClass] = useState<string>(initialClass);
  const [selectedRegion, setSelectedRegion] = useState<string>(initialRegion);
  const [timelineTab, setTimelineTab] = useState<"upcoming" | "past">(
    initialTimelineTab
  );
  const [filterTrialOnly, setFilterTrialOnly] = useState<boolean>(initialTrialOnly);
  const [searchQuery, setSearchQuery] = useState<string>(initialSearch);

  const [rankingFilter, setRankingFilter] = useState(initialRanking);
  const [selectedYear, setSelectedYear] = useState(initialYear);
  const canFilterRanking = selectedRegion === "Singapore" && ["optimist", "ilca4", "ilca6"].includes(selectedClass);

  const todayStr = useMemo(() => new Date().toISOString().slice(0, 10), []);

  const { upcomingList, pastList } = useMemo(() => {
    const upcoming: RegattaRecord[] = [];
    const past: RegattaRecord[] = [];

    for (const r of regattas) {
      const end = r.endDate ? String(r.endDate).slice(0, 10) : String(r.date).slice(0, 10);
      if (end >= todayStr) {
        upcoming.push(r);
      } else {
        past.push(r);
      }
    }

    // Sort upcoming ascending (soonest first)
    upcoming.sort((a, b) => String(a.date).localeCompare(String(b.date)));
    // Sort past descending (most recent first)
    past.sort((a, b) => String(b.date).localeCompare(String(a.date)));

    return { upcomingList: upcoming, pastList: past };
  }, [regattas, todayStr]);

  const activeSource = timelineTab === "upcoming" ? upcomingList : pastList;

  const filteredRegattas = useMemo(() => {
    return activeSource.filter((r) => {
      // Region filter
      if (selectedRegion !== "all") {
        const reg = r.region || "Singapore";
        if (reg.toLowerCase() !== selectedRegion.toLowerCase()) {
          return false;
        }
      }

      if (!regattaClasses(r).some((label) => matchesRegattaClass(label, selectedClass))) return false;

      if (selectedYear !== "all" && String(r.date).slice(0, 4) !== selectedYear) return false;
      if (canFilterRanking && rankingFilter !== "all") {
        const expected = rankingFilter === "ranking" ? "Counts for Singapore national ranking" : "Does not count for Singapore national ranking";
        if (!(resultSheetsByEvent[r.slug] || []).some((sheet) => matchesRegattaClass(sheet.boatClass, selectedClass) && nationalRankingLabel(sheet) === expected)) return false;
      }
      // Selection trials toggle
      if (filterTrialOnly && !r.isSelectionTrial) {
        return false;
      }

      // Search query filter
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase().trim();
        const matchName = r.name.toLowerCase().includes(q);
        const matchVenue = (r.venue || "").toLowerCase().includes(q);
        const matchOrg = (r.organizer || "").toLowerCase().includes(q);
        const matchNotes = (r.scheduleNotes || "").toLowerCase().includes(q);
        const matchRegion = (r.region || "").toLowerCase().includes(q);
        if (!matchName && !matchVenue && !matchOrg && !matchNotes && !matchRegion) return false;
      }

      return true;
    });
  }, [activeSource, selectedRegion, selectedClass, filterTrialOnly, searchQuery, selectedYear, canFilterRanking, rankingFilter, resultSheetsByEvent]);

  useEffect(() => {
    const params = new URLSearchParams();
    params.set("view", timelineTab);
    if (selectedClass !== "all") params.set("class", selectedClass);
    if (selectedRegion !== "all") params.set("region", selectedRegion);
    if (searchQuery) params.set("q", searchQuery);
    if (selectedYear !== "all") params.set("year", selectedYear);
    if (canFilterRanking && rankingFilter !== "all") params.set("ranking", rankingFilter);
    if (filterTrialOnly) params.set("trials", "1");
    const url = `/calendar?${params}`;
    window.history.replaceState(window.history.state, "", url);
  }, [selectedClass, selectedRegion, timelineTab, searchQuery, filterTrialOnly, selectedYear, canFilterRanking, rankingFilter]);

  useEffect(() => {
    const restore = () => {
      const params = new URLSearchParams(location.search);
      setSelectedClass(params.get("class") || "all");
      setSelectedRegion(params.get("region") || "all");
      setTimelineTab(params.get("view") === "past" ? "past" : "upcoming");
      setSearchQuery(params.get("q") || "");
      setFilterTrialOnly(params.get("trials") === "1");
      setSelectedYear(params.get("year") || "all");
      setRankingFilter(params.get("ranking") || "all");
    };
    window.addEventListener("popstate", restore);
    return () => window.removeEventListener("popstate", restore);
  }, []);

  function rememberFilters() {
    sessionStorage.setItem("regatta-return-url", location.pathname + location.search);
  }

  return (
    <div onClickCapture={(event) => { if ((event.target as HTMLElement).closest("a")) rememberFilters(); }} className="mx-auto max-w-5xl w-full min-w-0 px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      {/* Hero Header */}
      <div className="border-b border-[var(--sp-cool-veil)] pb-6">
        <h1 className="text-2xl sm:text-4xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
          Regattas
        </h1>
      </div>

      {/* Control Bar: Timeline Switcher, Region Filter, Class Filter & Search */}
      <div className="space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 flex-wrap">
          {/* Timeline Tab Toggle */}
          <div className="flex w-full min-w-0 max-w-full flex-wrap items-center gap-1 rounded-xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] p-1 sm:w-fit">
            <button
              type="button"
              onClick={() => setTimelineTab("upcoming")}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-xs font-bold transition-all ${
                timelineTab === "upcoming"
                  ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              <Clock className="h-3.5 w-3.5" />
              Upcoming Regattas ({upcomingList.length})
            </button>
            <button
              type="button"
              onClick={() => setTimelineTab("past")}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-xs font-bold transition-all ${
                timelineTab === "past"
                  ? "bg-[var(--sp-harbour-teal)] !text-white shadow-xs"
                  : "text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              }`}
            >
              <Trophy className="h-3.5 w-3.5" />
              Past Regattas ({pastList.length})
            </button>
          </div>

          {/* Selection trials highlight filter button */}
          <button
            type="button"
            onClick={() => setFilterTrialOnly((prev) => !prev)}
            className={`rounded-xl px-3.5 py-2 text-xs font-bold border inline-flex items-center gap-1.5 transition-all ${
              filterTrialOnly
                ? "bg-[var(--sp-aqua-mist)] border-[var(--sp-harbour-teal)]/40 text-[var(--sp-harbour-teal)] shadow-xs"
                : "bg-[var(--sp-warm-white)] border-[var(--sp-cool-veil)] text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
            }`}
          >
            <ShieldCheck className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
            Selection Trials Only
          </button>
        </div>

        {/* Region Filter Bar */}
        <div className="flex min-w-0 max-w-full items-center gap-2 overflow-x-auto pb-1">
          <span className="text-[11px] font-black text-[var(--sp-slate-soft)] uppercase tracking-wider shrink-0 flex items-center gap-1">
            <Globe className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
            Region:
          </span>
          {[
            { id: "all", label: "All Regions" },
            { id: "Singapore", label: "🇸🇬 Singapore" },
            { id: "Asia", label: "🌏 Asia" },
            { id: "Europe", label: "🇪🇺 Europe" },
            { id: "International", label: "International" },
          ].map((reg) => {
            const isSelected = selectedRegion === reg.id;
            return (
              <button
                key={reg.id}
                type="button"
                onClick={() => setSelectedRegion(reg.id)}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                  isSelected
                    ? "bg-[var(--sp-harbour-teal)] !text-white border border-[var(--sp-harbour-teal)] shadow-xs"
                    : "bg-[var(--sp-warm-white)] text-[var(--sp-slate-soft)] hover:bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)]"
                }`}
              >
                {reg.label}
              </button>
            );
          })}
        </div>

        <div className="flex flex-wrap gap-3 text-sm">
          <label>Year <select value={selectedYear} onChange={(event) => setSelectedYear(event.target.value)} className="rounded-lg border p-2">
            <option value="all">All years</option>
            {[...new Set(regattas.map((event) => String(event.date).slice(0, 4)))].sort().reverse().map((year) => <option key={year} value={year}>{year}</option>)}
          </select></label>
          {canFilterRanking && <label>Singapore national ranking <select value={rankingFilter} onChange={(event) => setRankingFilter(event.target.value)} className="rounded-lg border p-2">
            <option value="all">All class results</option><option value="ranking">Counts for ranking</option><option value="excluded">Does not count</option>
          </select></label>}
        </div>

        {/* Class Filter Pills & Search */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-1">
          <div className="flex min-w-0 max-w-full items-center gap-1.5 overflow-x-auto pb-1 sm:pb-0">
            {[
              { id: "all", label: "All Classes" },
              { id: "optimist", label: "Optimist", icon: Sailboat },
              { id: "ilca", label: "All ILCA", icon: Compass },
              { id: "ilca4", label: "ILCA 4", icon: Compass },
              { id: "ilca6", label: "ILCA 6", icon: Compass },
              { id: "ilca7", label: "ILCA 7", icon: Compass },
              { id: "wingfoil", label: "WingFoil", icon: Trophy },
              { id: "techno293", label: "Techno 293", icon: Sailboat },
              { id: "29er", label: "29er", icon: Sailboat },
              { id: "iqfoil", label: "iQFOiL", icon: Sailboat },
            ].map((cat) => {
              const Icon = cat.icon;
              const isSelected = selectedClass === cat.id;
              return (
                <button
                  key={cat.id}
                  type="button"
                  onClick={() => setSelectedClass(cat.id)}
                  className={`flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                    isSelected
                      ? "bg-[var(--sp-harbour-teal)] !text-white border border-[var(--sp-harbour-teal)] shadow-xs"
                      : "bg-[var(--sp-warm-white)] text-[var(--sp-slate-soft)] hover:bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)]"
                  }`}
                >
                  {Icon && <Icon className="h-3 w-3" />}
                  {cat.label}
                </button>
              );
            })}
          </div>

          {/* Search bar */}
          <div className="relative w-full sm:w-64">
            <Search className="pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-[var(--sp-slate-soft)]" />
            <input
              type="search"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search regattas or venues…"
              className="sp-input w-full !pl-10 !py-2 text-xs"
            />
          </div>
        </div>
      </div>

      {/* Regatta Event List */}
      {filteredRegattas.length === 0 ? (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 sm:p-12 text-center space-y-3 shadow-xs">
          <Calendar className="h-10 w-10 text-[var(--sp-slate-soft)] mx-auto" />
          <p className="text-sm font-bold text-[var(--sp-harbour-shadow)]">No regattas matching your filters</p>
          <p className="text-xs text-[var(--sp-slate-soft)] max-w-sm mx-auto">
            Try clearing search keywords or selecting All Regions / All Classes to see the full racing schedule.
          </p>
          <button
            type="button"
            onClick={() => {
              setSelectedClass("all");
              setSelectedRegion("all");
              setFilterTrialOnly(false);
              setSearchQuery("");
            }}
            className="rounded-full bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-aqua-mist)] border border-[var(--sp-cool-veil)] px-4 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] pt-1 transition-colors"
          >
            Clear Filters
          </button>
        </div>
      ) : (
        <div className="space-y-4">
          {filteredRegattas.map((regatta) => {
            const countdown = getCountdownLabel(regatta.date, regatta.endDate);
            const dateRangeStr = formatDateRange(regatta.date, regatta.endDate);
            const cardKey = regatta.id || regatta.slug;
            const pageHref = regattaPageHref(regatta, timelineTab);
            const classes = regattaClasses(regatta);

            return (
              <div
                key={cardKey}
                className={`relative rounded-2xl border transition-all p-5 sm:p-6 bg-[var(--sp-warm-white)] hover:border-[var(--sp-harbour-teal)] shadow-xs hover:shadow-md space-y-4 ${
                  regatta.isSelectionTrial
                    ? "border-[var(--sp-racing-orange)]/40"
                    : "border-[var(--sp-cool-veil)]"
                }`}
              >
                <Link
                  href={pageHref}
                  aria-label={regatta.name}
                  className="absolute inset-0 z-0 rounded-2xl"
                />
                <div className="relative z-10 flex flex-col sm:flex-row sm:items-start justify-between gap-4 pointer-events-none">
                  {/* Left: Date Badge + Main Details */}
                  <div className="flex items-start gap-4 flex-1 min-w-0">
                    {/* Date Block */}
                    <div className="flex flex-col items-center justify-center rounded-2xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3.5 py-2.5 text-center min-w-[72px] shrink-0">
                      <span className="text-[11px] font-black uppercase text-[var(--sp-racing-orange)] tracking-wider">
                        {formatMonth(regatta.date)}
                      </span>
                      <span className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] tabular-nums leading-tight">
                        {formatDay(regatta.date)}
                      </span>
                      {regatta.endDate && regatta.endDate !== regatta.date && (
                        <span className="text-[10px] text-[var(--sp-slate-soft)] font-mono">
                          to {formatDay(regatta.endDate)}
                        </span>
                      )}
                    </div>

                    {/* Regatta Info */}
                    <div className="min-w-0 space-y-1.5 flex-1">
                      <div className="flex flex-wrap items-center gap-2">
                        <h2 className="text-base sm:text-lg font-black text-[var(--sp-harbour-shadow)] tracking-tight">
                          {regatta.name}
                        </h2>

                        {/* Countdown Badge */}
                        <span
                          className={`rounded-full px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider ${
                            countdown.tone === "today"
                              ? "bg-emerald-500/20 text-emerald-700 border border-emerald-500/40 animate-pulse"
                              : countdown.tone === "urgent"
                              ? "bg-[var(--sp-racing-mist)]/40 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/40"
                              : countdown.tone === "soon"
                              ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/30"
                              : countdown.tone === "past"
                              ? "bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] border border-[var(--sp-cool-veil)]"
                              : "bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal-slate)] border border-[var(--sp-cool-veil)]"
                          }`}
                        >
                          {countdown.label}
                        </span>
                      </div>

                      {/* Tag badges */}
                      <div className="flex flex-wrap items-center gap-1.5 pt-0.5">
                        {/* Region badge */}
                        {regatta.region && (
                          <span className="rounded-md border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-0.5 text-[10px] font-semibold text-[var(--sp-slate-soft)]">
                            {regatta.region === "Europe"
                              ? "🇪🇺 Europe"
                              : regatta.region === "Asia"
                              ? "🌏 Asia"
                              : "🇸🇬 Singapore"}
                          </span>
                        )}

                        {classes.map((className) => (
                          <span
                            key={className}
                            className="rounded-md border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-harbour-teal)] inline-flex items-center gap-1"
                          >
                            <Sailboat className="h-3 w-3" />
                            {className}
                          </span>
                        ))}

                        {regatta.division &&
                          regatta.division.trim().toLowerCase() !== "national" && (
                          <span className="rounded-md border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-0.5 text-[10px] font-semibold text-[var(--sp-slate-soft)]">
                            {regatta.division}
                          </span>
                        )}

                        {regatta.clinicDates && (
                          <span className="rounded-md border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-harbour-teal)] inline-flex items-center gap-1">
                            <Clock className="h-3 w-3" />
                            Clinic: {regatta.clinicDates}
                          </span>
                        )}

                        {regatta.isSelectionTrial && (
                          <span className="rounded-md border border-[var(--sp-racing-orange)]/40 bg-[var(--sp-racing-mist)]/30 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-[var(--sp-racing-orange)] inline-flex items-center gap-1">
                            <ShieldCheck className="h-3 w-3 text-[var(--sp-racing-orange)]" />
                            Official Selection Trial
                          </span>
                        )}

                      </div>

                      {/* Venue, Organizer & Schedule meta line */}
                      <EventFacts
                        dates={dateRangeStr}
                        venue={regatta.venue}
                        organiser={regatta.organizer}
                        className="space-y-0.5 pt-1 text-xs"
                        labelClassName="font-bold text-[var(--sp-charcoal)]"
                        valueClassName="text-[var(--sp-charcoal-slate)]"
                      />

                      {(resultSheetsByEvent[regatta.slug] || []).filter((sheet) => matchesRegattaClass(sheet.boatClass, selectedClass)).length > 0 && (
                        <div className="relative z-10 space-y-2 pt-3" aria-label="Class results">
                          {(resultSheetsByEvent[regatta.slug] || []).filter((sheet) => matchesRegattaClass(sheet.boatClass, selectedClass)).map((sheet) => (
                            <Link key={sheet.id} href={regattaPageHref(sheet, timelineTab)} className="block rounded-lg border border-[var(--sp-cool-veil)] p-2 text-sm font-semibold text-[var(--sp-harbour-teal)] hover:underline focus-visible:outline-2">
                              {sheet.boatClass || "Optimist"} {sheet.division || ""} results
                              {nationalRankingLabel(sheet) && <span className="block text-xs font-normal">{nationalRankingLabel(sheet)}</span>}
                            </Link>
                          ))}
                        </div>
                      )}

                      {/* Key Deadlines indicator */}
                      {regatta.keyDeadlines && (
                        <p className="text-[11px] font-semibold text-[var(--sp-racing-orange)] flex items-center gap-1.5 pt-0.5">
                          <AlertCircle className="h-3.5 w-3.5 text-[var(--sp-racing-orange)] shrink-0" />
                          <span>Status / Deadline: {regatta.keyDeadlines}</span>
                        </p>
                      )}

                    </div>
                  </div>

                  {/* Right Actions */}
                  <div className="pointer-events-auto relative z-10 flex flex-wrap sm:flex-col gap-2 shrink-0 sm:self-center">
                    {/* Notice of Race (NOR) / Official Notice Board Link */}
                    {regatta.norUrl ? (
                      <a
                        href={regatta.norUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-aqua-mist)] px-3.5 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] inline-flex items-center justify-center gap-1.5 transition-colors"
                      >
                        <FileText className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
                        {regatta.norUrl.includes("racingrulesofsailing.org") || regatta.norUrl.includes("/documents/")
                          ? "Official Notice Board"
                          : "Notice of Race"}
                        <ExternalLink className="h-3 w-3 text-[var(--sp-slate-soft)]" />
                      </a>
                    ) : null}

                    {/* Entry Registration Portal (Upcoming only) */}
                    {regatta.registrationUrl && countdown.tone !== "past" ? (
                      <a
                        href={regatta.registrationUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="sp-btn-primary px-3.5 py-2 text-xs font-bold inline-flex items-center justify-center gap-1.5 shadow-xs"
                      >
                        Register / Enter
                        <ExternalLink className="h-3.5 w-3.5" />
                      </a>
                    ) : null}

                    {/* Add to Calendar (.ics) button */}
                    <button
                      type="button"
                      onClick={() => downloadIcs(regatta)}
                      className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-aqua-mist)] px-3.5 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] inline-flex items-center justify-center gap-1.5 transition-colors"
                      title="Add to Google Calendar, Apple Calendar, or Outlook"
                    >
                      <Download className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                      Add to Calendar (.ics)
                    </button>

                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Footer information */}
      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 text-center space-y-2 shadow-xs">
        <p className="text-xs text-[var(--sp-charcoal-slate)]">
          Official regatta dates, Notices of Race (NOR), and Sailing Instructions are governed by the organizing authorities and national sailing bodies.
        </p>
        <p className="text-[11px] text-[var(--sp-slate-soft)]">
          Want to submit or update an upcoming youth sailing regatta?{" "}
          <Link href="/support" className="text-[var(--sp-racing-orange)] font-semibold hover:underline">
            Contact race office support
          </Link>
        </p>
      </div>
    </div>
  );
}
