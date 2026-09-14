"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import {
  Calendar,
  Search,
  MapPin,
  Sailboat,
  Trophy,
  ExternalLink,
  FileText,
  Download,
  Clock,
  Compass,
  Award,
  ShieldCheck,
  Lock,
  Globe,
  DollarSign,
  ChevronDown,
  AlertCircle,
} from "lucide-react";
import type { RegattaRecord } from "@/lib/ranking";
import { useAccount } from "@/components/AccountProvider";

export type RegattaCalendarClientProps = {
  regattas: RegattaRecord[];
  initialClass?: string;
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
    regatta.countsForRanking ? "Official Singapore National Series Ranking Event" : null,
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
  initialClass = "all",
}: RegattaCalendarClientProps) {
  const { email, ready: accountReady } = useAccount();
  const isLoggedIn = Boolean(email);

  const [selectedClass, setSelectedClass] = useState<string>(initialClass);
  const [selectedRegion, setSelectedRegion] = useState<string>("all");
  const [timelineTab, setTimelineTab] = useState<"upcoming" | "past">("upcoming");
  const [filterTrialOnly, setFilterTrialOnly] = useState<boolean>(false);
  const [searchQuery, setSearchQuery] = useState<string>("");
  const [expandedBudgets, setExpandedBudgets] = useState<Record<string, boolean>>({});

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

      // Class filter
      if (selectedClass !== "all") {
        const cls = String(r.boatClass || "").toLowerCase();
        if (selectedClass === "optimist" && !cls.includes("optimist") && !cls.includes("opti")) {
          return false;
        }
        if (selectedClass === "ilca4" && !cls.includes("ilca 4") && !cls.includes("ilca4")) {
          return false;
        }
        if (selectedClass === "ilca6" && !cls.includes("ilca 6") && !cls.includes("ilca6")) {
          return false;
        }
        if (selectedClass === "wingfoil" && !cls.includes("wingfoil") && !cls.includes("wing")) {
          return false;
        }
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
  }, [activeSource, selectedRegion, selectedClass, filterTrialOnly, searchQuery]);

  // Loading state while verifying account auth
  if (!accountReady) {
    return (
      <div className="mx-auto max-w-5xl w-full px-4 py-20 text-center text-slate-400 space-y-3">
        <div className="inline-block h-8 w-8 animate-spin rounded-full border-4 border-solid border-orange-500 border-r-transparent" />
        <p className="text-xs font-semibold uppercase tracking-wider">Verifying member access…</p>
      </div>
    );
  }

  // Member Access Gate: Calendar is private during active development
  if (!isLoggedIn) {
    return (
      <div className="mx-auto w-full max-w-4xl px-4 py-10 sm:py-16 space-y-8">
        <div className="glass-card relative overflow-hidden rounded-3xl border border-orange-500/25 bg-[#0c0d14] p-6 sm:p-10 text-center space-y-6">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 h-36 w-72 bg-orange-500/10 rounded-full blur-3xl pointer-events-none" />

          <div className="relative mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-orange-500/15 border border-orange-500/30 text-orange-400 shadow-lg shadow-orange-500/10">
            <Lock className="h-8 w-8" />
          </div>

          <div className="relative space-y-2 max-w-xl mx-auto">
            <div className="inline-flex items-center gap-1.5 rounded-full border border-orange-500/30 bg-orange-500/10 px-3 py-0.5 text-[11px] font-bold text-orange-400">
              <Calendar className="h-3 w-3" />
              <span>Private Preview · In Development</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
              2026–2027 Regatta &amp; Campaign Calendar
            </h1>
            <p className="text-xs sm:text-sm text-slate-300 leading-relaxed">
              The comprehensive regatta schedule, international campaigns (Asia &amp; Europe), training clinics, and budget breakdowns are currently in private preview while we finalize features. Sign in or create a free account to preview the calendar.
            </p>
          </div>

          {/* Action buttons */}
          <div className="relative flex flex-col sm:flex-row items-center justify-center gap-3 max-w-md mx-auto pt-2">
            <Link
              href="/login?next=%2Fcalendar"
              className="w-full sm:w-auto rounded-full bg-orange-600 hover:bg-orange-500 active:scale-[0.98] transition-all text-xs font-black uppercase tracking-wider text-white px-6 py-3.5 shadow-lg shadow-orange-950/30 border border-orange-500/30 inline-flex items-center justify-center gap-2 min-h-[44px]"
            >
              Sign In to View Calendar
            </Link>
            <Link
              href="/register?next=%2Fcalendar"
              className="w-full sm:w-auto rounded-full bg-white/5 hover:bg-white/10 active:scale-[0.98] transition-all text-xs font-bold text-slate-200 px-6 py-3.5 border border-white/10 inline-flex items-center justify-center min-h-[44px]"
            >
              Create Free Account
            </Link>
          </div>

          {/* Feature Highlights Grid */}
          <div className="relative grid grid-cols-1 sm:grid-cols-2 gap-3 pt-4 border-t border-white/5 text-left">
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Trophy className="h-4 w-4 text-orange-400 shrink-0" />
                <h2 className="text-xs font-bold text-white">Singapore National Series &amp; Trials</h2>
              </div>
              <p className="text-[11px] text-slate-400 leading-relaxed">
                Ranking events, Asian &amp; Oceania selection trials, and Perth camp qualifiers.
              </p>
            </div>
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Globe className="h-4 w-4 text-sky-400 shrink-0" />
                <h2 className="text-xs font-bold text-white">Asian &amp; European Regattas</h2>
              </div>
              <p className="text-[11px] text-slate-400 leading-relaxed">
                Eastern Seaboard, Torrevieja, Palamós, Hong Kong Race Week, and Trofeo Torboli.
              </p>
            </div>
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <Sailboat className="h-4 w-4 text-emerald-400 shrink-0" />
                <h2 className="text-xs font-bold text-white">Pre-Event Clinics &amp; Camps</h2>
              </div>
              <p className="text-[11px] text-slate-400 leading-relaxed">
                Official clinic schedules, coaching blocks, and local boat charter arrangements.
              </p>
            </div>
            <div className="rounded-xl border border-white/5 bg-white/[0.02] p-4 space-y-1">
              <div className="flex items-center gap-2">
                <DollarSign className="h-4 w-4 text-amber-400 shrink-0" />
                <h2 className="text-xs font-bold text-white">Singapore Campaign Budgets</h2>
              </div>
              <p className="text-[11px] text-slate-400 leading-relaxed">
                Itemized budget breakdowns for 1 sailor + 1 adult covering entries, charters, clinics, flights, and hotels.
              </p>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-5xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      {/* Private Preview Banner */}
      <div className="rounded-2xl border border-amber-500/30 bg-amber-500/10 p-3.5 sm:p-4 text-amber-200 text-xs flex items-start gap-3">
        <AlertCircle className="h-4 w-4 text-amber-400 shrink-0 mt-0.5" />
        <div>
          <span className="font-bold">Private Preview:</span> This calendar is currently in active development for members. Featuring verified Singapore national regattas, Asian championships, and European winter campaigns with travel budget estimates from Singapore.
        </div>
      </div>

      {/* Hero Header */}
      <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 border-b border-white/10 pb-6">
        <div>
          <div className="inline-flex items-center gap-2 rounded-full border border-orange-500/30 bg-orange-500/10 px-3 py-1 text-xs font-bold text-orange-400 mb-2">
            <Calendar className="h-3.5 w-3.5" />
            2026 Racing Season
          </div>
          <h1 className="text-2xl sm:text-4xl font-black text-white tracking-tight">
            Singapore &amp; International Regatta Calendar
          </h1>
          <p className="mt-2 text-sm sm:text-base text-slate-400 max-w-2xl leading-relaxed">
            Official schedule of Singapore ranking regattas, Asian Games &amp; Perth selection trials, and regional youth championships across Asia and Europe.
          </p>
        </div>

        {/* Quick status summary counter */}
        <div className="flex items-center gap-3 bg-white/5 border border-white/10 rounded-2xl px-4 py-3 shrink-0">
          <div className="text-right">
            <p className="text-[10px] font-black uppercase tracking-wider text-slate-500">
              Upcoming Events
            </p>
            <p className="text-xl font-black text-white tabular-nums">
              {upcomingList.length}
            </p>
          </div>
          <span className="h-8 w-px bg-white/10" />
          <div className="text-right">
            <p className="text-[10px] font-black uppercase tracking-wider text-slate-500">
              Selection Trials
            </p>
            <p className="text-xl font-black text-orange-400 tabular-nums">
              {upcomingList.filter((r) => r.isSelectionTrial).length}
            </p>
          </div>
        </div>
      </div>

      {/* Control Bar: Timeline Switcher, Region Filter, Class Filter & Search */}
      <div className="space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 flex-wrap">
          {/* Timeline Tab Toggle */}
          <div className="flex items-center gap-1 rounded-xl bg-black/40 border border-white/10 p-1 w-fit">
            <button
              type="button"
              onClick={() => setTimelineTab("upcoming")}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-xs font-bold transition-all ${
                timelineTab === "upcoming"
                  ? "bg-orange-600 text-white shadow-sm"
                  : "text-slate-400 hover:text-white"
              }`}
            >
              <Clock className="h-3.5 w-3.5" />
              Upcoming Schedule ({upcomingList.length})
            </button>
            <button
              type="button"
              onClick={() => setTimelineTab("past")}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-xs font-bold transition-all ${
                timelineTab === "past"
                  ? "bg-orange-600 text-white shadow-sm"
                  : "text-slate-400 hover:text-white"
              }`}
            >
              <Trophy className="h-3.5 w-3.5" />
              Past Results Archive ({pastList.length})
            </button>
          </div>

          {/* Selection trials highlight filter button */}
          <button
            type="button"
            onClick={() => setFilterTrialOnly((prev) => !prev)}
            className={`rounded-xl px-3.5 py-2 text-xs font-bold border inline-flex items-center gap-1.5 transition-all ${
              filterTrialOnly
                ? "bg-amber-500/20 border-amber-500/40 text-amber-300 shadow-sm"
                : "bg-white/5 border-white/10 text-slate-400 hover:text-white"
            }`}
          >
            <ShieldCheck className="h-4 w-4 text-amber-400" />
            Selection Trials Only
          </button>
        </div>

        {/* Region Filter Bar */}
        <div className="flex items-center gap-2 overflow-x-auto pb-1">
          <span className="text-[11px] font-black text-slate-400 uppercase tracking-wider shrink-0 flex items-center gap-1">
            <Globe className="h-3.5 w-3.5 text-sky-400" />
            Region:
          </span>
          {[
            { id: "all", label: "All Regions" },
            { id: "Singapore", label: "🇸🇬 Singapore" },
            { id: "Asia", label: "🌏 Asia" },
            { id: "Europe", label: "🇪🇺 Europe" },
          ].map((reg) => {
            const isSelected = selectedRegion === reg.id;
            return (
              <button
                key={reg.id}
                type="button"
                onClick={() => setSelectedRegion(reg.id)}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                  isSelected
                    ? "bg-sky-600 text-white border border-sky-400 shadow-sm"
                    : "bg-white/5 text-slate-400 hover:bg-white/10 hover:text-white border border-white/5"
                }`}
              >
                {reg.label}
              </button>
            );
          })}
        </div>

        {/* Class Filter Pills & Search */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-1">
          <div className="flex items-center gap-1.5 overflow-x-auto pb-1 sm:pb-0">
            {[
              { id: "all", label: "All Classes" },
              { id: "optimist", label: "Optimist", icon: Sailboat },
              { id: "ilca4", label: "ILCA 4", icon: Compass },
              { id: "ilca6", label: "ILCA 6", icon: Compass },
              { id: "wingfoil", label: "WingFoil", icon: Trophy },
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
                      ? "bg-white/20 text-white border border-white/30 shadow-sm"
                      : "bg-white/5 text-slate-400 hover:bg-white/10 hover:text-white border border-white/5"
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
            <Search className="absolute left-3 top-2.5 h-3.5 w-3.5 text-slate-500" />
            <input
              type="search"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search regattas or venues…"
              className="w-full rounded-xl bg-black/40 border border-white/10 pl-9 pr-3 py-1.5 text-xs text-white placeholder:text-slate-500 focus:outline-none focus:border-orange-500/50"
            />
          </div>
        </div>
      </div>

      {/* Regatta Event List */}
      {filteredRegattas.length === 0 ? (
        <div className="rounded-2xl border border-white/5 bg-[#131520]/80 p-8 sm:p-12 text-center space-y-3">
          <Calendar className="h-10 w-10 text-slate-600 mx-auto" />
          <p className="text-sm font-bold text-white">No regattas matching your filters</p>
          <p className="text-xs text-slate-500 max-w-sm mx-auto">
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
            className="rounded-full bg-white/10 hover:bg-white/15 px-4 py-2 text-xs font-bold text-white pt-1"
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
            const isBudgetExpanded = Boolean(expandedBudgets[cardKey]);

            return (
              <div
                key={cardKey}
                className={`rounded-2xl border transition-all p-5 sm:p-6 bg-gradient-to-br from-[#151725] to-[#10121d] hover:border-white/20 shadow-sm space-y-4 ${
                  regatta.isSelectionTrial
                    ? "border-amber-500/30"
                    : "border-white/10"
                }`}
              >
                <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-4">
                  {/* Left: Date Badge + Main Details */}
                  <div className="flex items-start gap-4 flex-1 min-w-0">
                    {/* Date Block */}
                    <div className="flex flex-col items-center justify-center rounded-2xl bg-black/40 border border-white/10 px-3.5 py-2.5 text-center min-w-[72px] shrink-0">
                      <span className="text-[11px] font-black uppercase text-orange-400 tracking-wider">
                        {formatMonth(regatta.date)}
                      </span>
                      <span className="text-xl sm:text-2xl font-black text-white tabular-nums leading-tight">
                        {formatDay(regatta.date)}
                      </span>
                      {regatta.endDate && regatta.endDate !== regatta.date && (
                        <span className="text-[10px] text-slate-400 font-mono">
                          to {formatDay(regatta.endDate)}
                        </span>
                      )}
                    </div>

                    {/* Regatta Info */}
                    <div className="min-w-0 space-y-1.5 flex-1">
                      <div className="flex flex-wrap items-center gap-2">
                        <h2 className="text-base sm:text-lg font-black text-white tracking-tight">
                          {regatta.name}
                        </h2>

                        {/* Countdown Badge */}
                        <span
                          className={`rounded-full px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider ${
                            countdown.tone === "today"
                              ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/40 animate-pulse"
                              : countdown.tone === "urgent"
                              ? "bg-amber-500/20 text-amber-300 border border-amber-500/40"
                              : countdown.tone === "soon"
                              ? "bg-sky-500/15 text-sky-300 border border-sky-500/30"
                              : countdown.tone === "past"
                              ? "bg-slate-800 text-slate-400 border border-white/5"
                              : "bg-white/5 text-slate-300 border border-white/10"
                          }`}
                        >
                          {countdown.label}
                        </span>
                      </div>

                      {/* Tag badges */}
                      <div className="flex flex-wrap items-center gap-1.5 pt-0.5">
                        {/* Region badge */}
                        {regatta.region && (
                          <span className="rounded-md border border-white/10 bg-white/5 px-2 py-0.5 text-[10px] font-semibold text-slate-300">
                            {regatta.region === "Europe"
                              ? "🇪🇺 Europe"
                              : regatta.region === "Asia"
                              ? "🌏 Asia"
                              : "🇸🇬 Singapore"}
                          </span>
                        )}

                        <span className="rounded-md border border-sky-500/30 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300 inline-flex items-center gap-1">
                          <Sailboat className="h-3 w-3" />
                          {regatta.boatClass || "Optimist"}
                        </span>

                        {regatta.division && (
                          <span className="rounded-md border border-white/10 bg-white/5 px-2 py-0.5 text-[10px] font-semibold text-slate-300">
                            {regatta.division}
                          </span>
                        )}

                        {regatta.targetFleet && (
                          <span className="rounded-md border border-purple-500/30 bg-purple-500/10 px-2 py-0.5 text-[10px] font-bold text-purple-300">
                            Fleet: {regatta.targetFleet}
                          </span>
                        )}

                        {regatta.clinicDates && (
                          <span className="rounded-md border border-sky-500/30 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300 inline-flex items-center gap-1">
                            <Clock className="h-3 w-3" />
                            Clinic: {regatta.clinicDates}
                          </span>
                        )}

                        {regatta.isSelectionTrial && (
                          <span className="rounded-md border border-amber-500/40 bg-amber-500/15 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-amber-200 inline-flex items-center gap-1">
                            <ShieldCheck className="h-3 w-3 text-amber-400" />
                            Official Selection Trial
                          </span>
                        )}

                        {regatta.countsForRanking && !regatta.isSelectionTrial && (
                          <span className="rounded-md border border-emerald-500/30 bg-emerald-500/10 px-2 py-0.5 text-[10px] font-bold text-emerald-300 inline-flex items-center gap-1">
                            <Award className="h-3 w-3" />
                            National Series Ranking
                          </span>
                        )}
                      </div>

                      {/* Venue, Organizer & Schedule meta line */}
                      <p className="text-xs text-slate-300 flex flex-wrap items-center gap-x-3 gap-y-1 pt-1">
                        <span className="inline-flex items-center gap-1 text-slate-300">
                          <Calendar className="h-3.5 w-3.5 text-slate-500" />
                          {dateRangeStr}
                        </span>
                        {regatta.venue && (
                          <span className="inline-flex items-center gap-1 text-slate-400">
                            <MapPin className="h-3.5 w-3.5 text-slate-500" />
                            {regatta.venue}
                          </span>
                        )}
                        {regatta.organizer && (
                          <span className="text-slate-500 text-[11px]">
                            by {regatta.organizer}
                          </span>
                        )}
                      </p>

                      {/* Key Deadlines indicator */}
                      {regatta.keyDeadlines && (
                        <p className="text-[11px] font-semibold text-amber-300 flex items-center gap-1.5 pt-0.5">
                          <AlertCircle className="h-3.5 w-3.5 text-amber-400 shrink-0" />
                          <span>Status / Deadline: {regatta.keyDeadlines}</span>
                        </p>
                      )}

                      {/* Schedule notes */}
                      {regatta.scheduleNotes && (
                        <p className="text-[11px] text-slate-400 leading-relaxed pt-0.5">
                          {regatta.scheduleNotes}
                        </p>
                      )}
                    </div>
                  </div>

                  {/* Right Actions */}
                  <div className="flex flex-wrap sm:flex-col gap-2 shrink-0 sm:self-center">
                    {/* Notice of Race (NOR) Link */}
                    {regatta.norUrl ? (
                      <a
                        href={regatta.norUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 px-3.5 py-2 text-xs font-bold text-slate-300 hover:text-white inline-flex items-center justify-center gap-1.5 transition-colors"
                      >
                        <FileText className="h-3.5 w-3.5 text-orange-400" />
                        Notice of Race
                        <ExternalLink className="h-3 w-3 text-slate-500" />
                      </a>
                    ) : null}

                    {/* Entry Registration Portal (Upcoming only) */}
                    {regatta.registrationUrl && countdown.tone !== "past" ? (
                      <a
                        href={regatta.registrationUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="rounded-xl bg-orange-600 hover:bg-orange-500 px-3.5 py-2 text-xs font-bold text-white inline-flex items-center justify-center gap-1.5 shadow-sm transition-all"
                      >
                        Register / Enter
                        <ExternalLink className="h-3.5 w-3.5" />
                      </a>
                    ) : null}

                    {/* Add to Calendar (.ics) button */}
                    <button
                      type="button"
                      onClick={() => downloadIcs(regatta)}
                      className="rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 px-3.5 py-2 text-xs font-bold text-slate-300 hover:text-white inline-flex items-center justify-center gap-1.5 transition-colors"
                      title="Add to Google Calendar, Apple Calendar, or Outlook"
                    >
                      <Download className="h-3.5 w-3.5 text-sky-400" />
                      Add to Calendar (.ics)
                    </button>

                    {/* View scoreboard if results published in SailorPath or WingFoil hub */}
                    {regatta.boatClass?.toLowerCase() === "wingfoil" ? (
                      <Link
                        href="/sg/wingfoil"
                        className="rounded-xl border border-white/10 bg-black/30 hover:bg-black/50 px-3.5 py-2 text-xs font-bold text-teal-400 hover:text-teal-300 inline-flex items-center justify-center gap-1 transition-colors"
                      >
                        WingFoil Hub →
                      </Link>
                    ) : regatta.hasResults && regatta.slug ? (
                      <Link
                        href={
                          regatta.boatClass?.toLowerCase().includes("ilca")
                            ? `/sg/ilca4/regattas/${regatta.slug}`
                            : `/sg/optimist/regattas/${regatta.slug}`
                        }
                        className="rounded-xl border border-white/10 bg-black/30 hover:bg-black/50 px-3.5 py-2 text-xs font-bold text-orange-400 hover:text-orange-300 inline-flex items-center justify-center gap-1 transition-colors"
                      >
                        Event Scoreboard →
                      </Link>
                    ) : null}
                  </div>
                </div>

                {/* Campaign Budget Details (if present) */}
                {regatta.campaignBudget && (
                  <div className="pt-3 border-t border-white/5 w-full">
                    <button
                      type="button"
                      onClick={() =>
                        setExpandedBudgets((prev) => ({
                          ...prev,
                          [cardKey]: !prev[cardKey],
                        }))
                      }
                      className="w-full flex items-center justify-between rounded-xl bg-white/[0.03] hover:bg-white/[0.06] border border-white/10 px-3.5 py-2.5 text-xs font-semibold text-slate-300 transition-colors"
                    >
                      <span className="inline-flex items-center gap-2">
                        <DollarSign className="h-4 w-4 text-emerald-400" />
                        <span>Estimated Campaign Budget (from Singapore):</span>
                        <span className="font-black text-emerald-300">
                          SGD ${regatta.campaignBudget.totalEstimatedSgd.toLocaleString()}
                        </span>
                      </span>
                      <span className="inline-flex items-center gap-1 text-[11px] text-slate-400 font-medium">
                        {isBudgetExpanded ? "Hide Breakdown" : "View Breakdown"}
                        <ChevronDown
                          className={`h-3.5 w-3.5 transition-transform ${
                            isBudgetExpanded ? "rotate-180" : ""
                          }`}
                        />
                      </span>
                    </button>

                    {isBudgetExpanded && (
                      <div className="mt-3 rounded-xl border border-emerald-500/20 bg-black/40 p-4 space-y-3">
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-1 pb-2 border-b border-white/10 text-xs">
                          <div>
                            <p className="font-bold text-white">
                              Campaign Cost Breakdown (1 Youth Sailor + 1 Adult Guardian)
                            </p>
                            <p className="text-[11px] text-slate-400">
                              Estimated from Singapore in SGD (including regatta entry, charters, clinics, flights &amp; accommodation)
                            </p>
                          </div>
                          <div className="text-right">
                            <span className="text-base font-black text-emerald-400">
                              SGD ${regatta.campaignBudget.totalEstimatedSgd.toLocaleString()}
                            </span>
                          </div>
                        </div>

                        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2.5 text-xs">
                          <div className="rounded-lg bg-white/5 p-2.5 space-y-0.5 sm:col-span-2">
                            <span className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                              Regatta Entry &amp; Boat Charter
                            </span>
                            <p className="font-medium text-slate-200">
                              {regatta.campaignBudget.regattaCostsLabel}
                            </p>
                          </div>
                          {regatta.campaignBudget.clinicLabel && (
                            <div className="rounded-lg bg-white/5 p-2.5 space-y-0.5">
                              <span className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                                Pre-Regatta Clinic / Camp
                              </span>
                              <p className="font-medium text-slate-200">
                                {regatta.campaignBudget.clinicLabel}
                              </p>
                            </div>
                          )}
                          {regatta.campaignBudget.flightsLabel && (
                            <div className="rounded-lg bg-white/5 p-2.5 space-y-0.5">
                              <span className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                                Return Flights (2 pax)
                              </span>
                              <p className="font-medium text-slate-200">
                                {regatta.campaignBudget.flightsLabel}
                              </p>
                            </div>
                          )}
                          {regatta.campaignBudget.lodgingLabel && (
                            <div className="rounded-lg bg-white/5 p-2.5 space-y-0.5 sm:col-span-2">
                              <span className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                                Accommodation &amp; Ground Logistics
                              </span>
                              <p className="font-medium text-slate-200">
                                {regatta.campaignBudget.lodgingLabel}
                              </p>
                            </div>
                          )}
                        </div>

                        {regatta.campaignBudget.notes && (
                          <p className="text-[11px] text-slate-400 italic pt-1 border-t border-white/5">
                            💡 {regatta.campaignBudget.notes}
                          </p>
                        )}
                      </div>
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}

      {/* Footer information */}
      <div className="rounded-2xl border border-white/5 bg-black/20 p-5 text-center space-y-2">
        <p className="text-xs text-slate-400">
          Official regatta dates, Notices of Race (NOR), and Sailing Instructions are governed by the organizing authorities and national sailing bodies.
        </p>
        <p className="text-[11px] text-slate-500">
          Want to submit or update an upcoming youth sailing regatta?{" "}
          <Link href="/support" className="text-orange-400 hover:underline">
            Contact race office support
          </Link>
        </p>
      </div>
    </div>
  );
}
