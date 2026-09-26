"use client";

import React, { useState, useEffect, useRef, useTransition, useId } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import {
  Search,
  X,
  Trophy,
  User,
  Calendar,
  Building2,
  GraduationCap,
  ChevronRight,
  Filter,
  RotateCcw,
  Sparkles,
  Loader2,
  SlidersHorizontal,
} from "lucide-react";
import type { SailorSearchResult, RegattaSearchResult } from "@/lib/search";

export type SearchClientProps = {
  initialQuery?: string;
  initialFleet?: string;
  initialSquad?: string;
  initialClub?: string;
  initialSchool?: string;
  initialSailors: SailorSearchResult[];
  initialRegattas: RegattaSearchResult[];
};

const POPULAR_SEARCHES = [
  { label: "Optimist Gold", query: "Optimist Gold", fleet: "gold" },
  { label: "Optimist Silver", query: "Optimist Silver", fleet: "silver" },
  { label: "ILCA 4", query: "ILCA 4", fleet: "ilca" },
  { label: "Temasek Regatta", query: "Temasek", fleet: "all" },
  { label: "Pulau Ujong", query: "Pulau Ujong", fleet: "all" },
  { label: "SAFYC", query: "SAFYC", fleet: "all" },
  { label: "Changi (CSC)", query: "CSC", fleet: "all" },
  { label: "Raffles (RI)", query: "RI", fleet: "all" },
  { label: "ACS (Independent)", query: "ACSI", fleet: "all" },
];

export function SearchClient({
  initialQuery = "",
  initialFleet = "all",
  initialSquad = "all",
  initialClub = "",
  initialSchool = "",
  initialSailors = [],
  initialRegattas = [],
}: SearchClientProps) {
  const router = useRouter();
  const searchParams = useSearchParams();

  const [query, setQuery] = useState(initialQuery);
  const [fleet, setFleet] = useState(initialFleet);
  const [squad, setSquad] = useState(initialSquad);
  const [club, setClub] = useState(initialClub);
  const [school, setSchool] = useState(initialSchool);
  const [activeTab, setActiveTab] = useState<"all" | "sailors" | "regattas">("all");
  const [showAdvanced, setShowAdvanced] = useState(
    Boolean(initialSquad !== "all" || initialClub || initialSchool)
  );

  const [sailors, setSailors] = useState<SailorSearchResult[]>(initialSailors);
  const [regattas, setRegattas] = useState<RegattaSearchResult[]>(initialRegattas);
  const [isLoading, setIsLoading] = useState(false);
  const [isPending, startTransition] = useTransition();

  const inputRef = useRef<HTMLInputElement>(null);
  const abortControllerRef = useRef<AbortController | null>(null);
  const isFirstRender = useRef(true);

  // Keyboard shortcut: '/' or 'Cmd+K' focuses search input, 'Esc' clears
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (
        (e.key === "/" || ((e.metaKey || e.ctrlKey) && e.key === "k")) &&
        document.activeElement !== inputRef.current
      ) {
        e.preventDefault();
        inputRef.current?.focus();
        inputRef.current?.select();
      } else if (e.key === "Escape" && document.activeElement === inputRef.current) {
        if (query) {
          setQuery("");
        } else {
          inputRef.current?.blur();
        }
      }
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [query]);

  // Fetch search results on query or filter changes with debounce
  useEffect(() => {
    if (isFirstRender.current) {
      isFirstRender.current = false;
      return;
    }

    if (abortControllerRef.current) {
      abortControllerRef.current.abort();
    }

    const controller = new AbortController();
    abortControllerRef.current = controller;

    const timer = setTimeout(async () => {
      setIsLoading(true);

      const params = new URLSearchParams();
      if (query.trim()) params.set("q", query.trim());
      if (fleet !== "all") params.set("fleet", fleet);
      if (squad !== "all") params.set("squad", squad);
      if (club.trim()) params.set("club", club.trim());
      if (school.trim()) params.set("school", school.trim());

      // Update URL silently without full navigation
      const newUrl = params.toString() ? `/search?${params.toString()}` : "/search";
      window.history.replaceState(null, "", newUrl);

      try {
        const res = await fetch(`/api/search?${params.toString()}`, {
          signal: controller.signal,
        });
        if (res.ok) {
          const data = await res.json();
          setSailors(data.sailors || []);
          setRegattas(data.regattas || []);
        }
      } catch (err: any) {
        if (err.name !== "AbortError") {
          console.error("Search error:", err);
        }
      } finally {
        setIsLoading(false);
      }
    }, 200);

    return () => {
      clearTimeout(timer);
      controller.abort();
    };
  }, [query, fleet, squad, club, school]);

  const handleClearAll = () => {
    setQuery("");
    setFleet("all");
    setSquad("all");
    setClub("");
    setSchool("");
    setActiveTab("all");
    inputRef.current?.focus();
  };

  const handlePopularSearchClick = (item: (typeof POPULAR_SEARCHES)[0]) => {
    setQuery(item.query);
    setFleet(item.fleet);
    inputRef.current?.focus();
  };

  const hasActiveFilters =
    fleet !== "all" || squad !== "all" || Boolean(club.trim()) || Boolean(school.trim());

  // Filtered views
  const displaySailors = activeTab === "regattas" ? [] : sailors;
  const displayRegattas = activeTab === "sailors" ? [] : regattas;
  const totalResults = sailors.length + regattas.length;

  return (
    <div className="w-full space-y-6">
      {/* ── Search Input Card ────────────────────────────────────────── */}
      <div className="relative rounded-3xl border border-slate-200 bg-white p-2.5 sm:p-3 shadow-md shadow-slate-200/50 transition-all focus-within:border-orange-500 focus-within:ring-4 focus-within:ring-orange-500/10">
        <div className="flex items-center gap-3 px-2 sm:px-3">
          {isLoading ? (
            <Loader2 className="h-5 w-5 text-orange-500 animate-spin shrink-0" />
          ) : (
            <Search className="h-5 w-5 text-slate-400 shrink-0" />
          )}

          <input
            ref={inputRef}
            type="search"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search by sailor name, sail number (e.g. SGP 4652), club, or regatta…"
            enterKeyHint="search"
            aria-label="Search sailors and regattas"
            className="w-full bg-transparent py-2.5 sm:py-3 text-sm sm:text-base text-slate-900 placeholder:text-slate-400 focus:outline-none"
            autoComplete="off"
            autoCorrect="off"
            spellCheck="false"
          />

          {query && (
            <button
              type="button"
              onClick={() => {
                setQuery("");
                inputRef.current?.focus();
              }}
              className="p-1 rounded-full text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition-colors shrink-0"
              aria-label="Clear search text"
            >
              <X className="h-4 w-4" />
            </button>
          )}

          <div className="hidden sm:flex items-center gap-1.5 shrink-0 pl-1 border-l border-slate-200 text-[11px] font-mono font-medium text-slate-400">
            <kbd className="px-1.5 py-0.5 rounded bg-slate-100 border border-slate-200 text-slate-600 shadow-2xs">
              /
            </kbd>
            <span>focus</span>
          </div>
        </div>

        {/* ── Filter Pills Bar ───────────────────────────────────────── */}
        <div className="flex items-center justify-between gap-2 pt-2.5 mt-2 border-t border-slate-100 overflow-x-auto scrollbar-none px-1">
          <div className="flex items-center gap-1.5 shrink-0">
            <button
              type="button"
              onClick={() => {
                setActiveTab("all");
                setFleet("all");
              }}
              className={`px-3 py-1.5 rounded-full text-xs font-bold transition-all shrink-0 ${
                activeTab === "all" && fleet === "all"
                  ? "bg-slate-900 text-white shadow-xs"
                  : "bg-slate-100 text-slate-600 hover:bg-slate-200"
              }`}
            >
              All ({totalResults})
            </button>

            <button
              type="button"
              onClick={() => {
                setActiveTab("sailors");
                setFleet("all");
              }}
              className={`px-3 py-1.5 rounded-full text-xs font-bold transition-all shrink-0 inline-flex items-center gap-1.5 ${
                activeTab === "sailors" && fleet === "all"
                  ? "bg-slate-900 text-white shadow-xs"
                  : "bg-slate-100 text-slate-600 hover:bg-slate-200"
              }`}
            >
              <User className="h-3 w-3" />
              Sailors ({sailors.length})
            </button>

            {regattas.length > 0 && (
              <button
                type="button"
                onClick={() => setActiveTab("regattas")}
                className={`px-3 py-1.5 rounded-full text-xs font-bold transition-all shrink-0 inline-flex items-center gap-1.5 ${
                  activeTab === "regattas"
                    ? "bg-slate-900 text-white shadow-xs"
                    : "bg-slate-100 text-slate-600 hover:bg-slate-200"
                }`}
              >
                <Trophy className="h-3 w-3 text-amber-500" />
                Regattas ({regattas.length})
              </button>
            )}

            <button
              type="button"
              onClick={() => {
                setActiveTab("sailors");
                setFleet(fleet === "gold" ? "all" : "gold");
              }}
              className={`px-3 py-1.5 rounded-full text-xs font-bold transition-all shrink-0 inline-flex items-center gap-1 ${
                fleet === "gold"
                  ? "bg-amber-500 text-white shadow-xs"
                  : "bg-amber-50 text-amber-800 border border-amber-200/60 hover:bg-amber-100"
              }`}
            >
              <span>🥇</span>
              <span>Gold Fleet</span>
            </button>

            <button
              type="button"
              onClick={() => {
                setActiveTab("sailors");
                setFleet(fleet === "silver" ? "all" : "silver");
              }}
              className={`px-3 py-1.5 rounded-full text-xs font-bold transition-all shrink-0 inline-flex items-center gap-1 ${
                fleet === "silver"
                  ? "bg-slate-700 text-white shadow-xs"
                  : "bg-slate-100 text-slate-700 border border-slate-200 hover:bg-slate-200"
              }`}
            >
              <span>🥈</span>
              <span>Silver Fleet</span>
            </button>

            <button
              type="button"
              onClick={() => {
                setActiveTab("sailors");
                setFleet(fleet === "ilca" ? "all" : "ilca");
              }}
              className={`px-3 py-1.5 rounded-full text-xs font-bold transition-all shrink-0 inline-flex items-center gap-1 ${
                fleet === "ilca"
                  ? "bg-teal-600 text-white shadow-xs"
                  : "bg-teal-50 text-teal-800 border border-teal-200 hover:bg-teal-100"
              }`}
            >
              <span>⛵</span>
              <span>ILCA</span>
            </button>
          </div>

          <button
            type="button"
            onClick={() => setShowAdvanced((prev) => !prev)}
            className={`p-1.5 rounded-xl text-xs font-bold transition-colors inline-flex items-center gap-1 shrink-0 ${
              showAdvanced || hasActiveFilters
                ? "bg-orange-50 text-orange-600 border border-orange-200"
                : "text-slate-500 hover:bg-slate-100"
            }`}
            title="Toggle advanced filters"
            aria-expanded={showAdvanced}
          >
            <SlidersHorizontal className="h-3.5 w-3.5" />
            <span className="hidden sm:inline">Filters</span>
            {hasActiveFilters && (
              <span className="h-1.5 w-1.5 rounded-full bg-orange-600" />
            )}
          </button>
        </div>

        {/* ── Advanced Filters Drawer ─────────────────────────────────── */}
        {showAdvanced && (
          <div className="pt-3 mt-3 border-t border-slate-100 grid grid-cols-1 sm:grid-cols-3 gap-3">
            <div>
              <label className="text-[11px] font-bold uppercase tracking-wider text-slate-500 block mb-1">
                National Squad
              </label>
              <select
                value={squad}
                onChange={(e) => setSquad(e.target.value)}
                className="w-full rounded-xl border border-slate-200 bg-slate-50 px-3 py-1.5 text-xs font-medium text-slate-800 focus:outline-none focus:border-orange-500"
              >
                <option value="all">All squads</option>
                <option value="Nat A">National Squad A (Nat A)</option>
                <option value="Nat B">National Squad B (Nat B)</option>
                <option value="DS">Development Squad (DS)</option>
              </select>
            </div>

            <div>
              <label className="text-[11px] font-bold uppercase tracking-wider text-slate-500 block mb-1">
                Club / Organization
              </label>
              <input
                type="text"
                value={club}
                onChange={(e) => setClub(e.target.value)}
                placeholder="e.g. CSC, SAFYC, NSC"
                className="w-full rounded-xl border border-slate-200 bg-slate-50 px-3 py-1.5 text-xs font-medium text-slate-800 placeholder:text-slate-400 focus:outline-none focus:border-orange-500"
              />
            </div>

            <div>
              <label className="text-[11px] font-bold uppercase tracking-wider text-slate-500 block mb-1">
                School
              </label>
              <input
                type="text"
                value={school}
                onChange={(e) => setSchool(e.target.value)}
                placeholder="e.g. RI, ACSI, RGS, SJI"
                className="w-full rounded-xl border border-slate-200 bg-slate-50 px-3 py-1.5 text-xs font-medium text-slate-800 placeholder:text-slate-400 focus:outline-none focus:border-orange-500"
              />
            </div>

            {hasActiveFilters && (
              <div className="sm:col-span-3 flex justify-end">
                <button
                  type="button"
                  onClick={handleClearAll}
                  className="inline-flex items-center gap-1 px-3 py-1 text-xs font-semibold text-rose-600 hover:text-rose-700 hover:bg-rose-50 rounded-lg transition-colors"
                >
                  <RotateCcw className="h-3 w-3" />
                  Reset all filters
                </button>
              </div>
            )}
          </div>
        )}
      </div>

      {/* ── Popular Search Tags (Empty state or query helper) ────────── */}
      {!query && (
        <div className="rounded-2xl border border-slate-200/80 bg-slate-50/70 p-4 space-y-2.5">
          <p className="text-xs font-bold text-slate-500 uppercase tracking-wider flex items-center gap-1.5">
            <Sparkles className="h-3.5 w-3.5 text-amber-500" />
            Quick Searches &amp; Fleets
          </p>
          <div className="flex flex-wrap gap-1.5">
            {POPULAR_SEARCHES.map((item) => (
              <button
                key={item.label}
                type="button"
                onClick={() => handlePopularSearchClick(item)}
                className="rounded-full border border-slate-200 bg-white hover:border-slate-300 hover:bg-slate-50 px-3 py-1 text-xs font-semibold text-slate-700 shadow-2xs transition-colors"
              >
                {item.label}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* ── Matching Regattas Section ─────────────────────────────────── */}
      {displayRegattas.length > 0 && (
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <h2 className="text-xs font-black uppercase tracking-wider text-slate-500 flex items-center gap-1.5">
              <Trophy className="h-3.5 w-3.5 text-amber-500" />
              Regattas &amp; Events ({displayRegattas.length})
            </h2>
            {activeTab !== "regattas" && displayRegattas.length > 2 && (
              <button
                type="button"
                onClick={() => setActiveTab("regattas")}
                className="text-xs font-bold text-orange-600 hover:underline"
              >
                View all regattas ({displayRegattas.length})
              </button>
            )}
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {displayRegattas.slice(0, activeTab === "regattas" ? 20 : 4).map((reg) => (
              <Link
                key={reg.id}
                href={reg.href}
                className="group block rounded-2xl border border-slate-200 bg-white p-4 shadow-xs hover:border-orange-500/40 hover:shadow-md hover:shadow-orange-500/5 transition-all"
              >
                <div className="flex items-start justify-between gap-2">
                  <div className="min-w-0">
                    <span className="inline-flex items-center gap-1 rounded-full bg-orange-50 px-2 py-0.5 text-[10px] font-black uppercase tracking-wider text-orange-700 border border-orange-200/60 mb-1.5">
                      {reg.boatClass} {reg.division ? `· ${reg.division}` : ""}
                    </span>
                    <h3 className="text-sm font-bold text-slate-900 group-hover:text-orange-600 transition-colors line-clamp-1">
                      {reg.name}
                    </h3>
                  </div>
                  <ChevronRight className="h-4 w-4 text-slate-300 group-hover:text-orange-500 group-hover:translate-x-0.5 transition-all shrink-0 mt-1" />
                </div>

                <div className="mt-3 flex flex-wrap items-center gap-y-1 gap-x-3 text-xs text-slate-500">
                  <span className="inline-flex items-center gap-1">
                    <Calendar className="h-3 w-3 text-slate-400" />
                    {reg.date} {reg.endDate && reg.endDate !== reg.date ? `– ${reg.endDate}` : ""}
                  </span>
                  {reg.venue && (
                    <span className="inline-flex items-center gap-1 truncate max-w-[200px]">
                      <Building2 className="h-3 w-3 text-slate-400 shrink-0" />
                      <span className="truncate">{reg.venue}</span>
                    </span>
                  )}
                  {reg.raceCount != null && reg.raceCount > 0 && (
                    <span className="text-slate-400">· {reg.raceCount} races</span>
                  )}
                </div>
              </Link>
            ))}
          </div>
        </div>
      )}

      {/* ── Sailors Results Section ───────────────────────────────────── */}
      {displaySailors.length > 0 && (
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <h2 className="text-xs font-black uppercase tracking-wider text-slate-500 flex items-center gap-1.5">
              <User className="h-3.5 w-3.5 text-slate-500" />
              Sailor Profiles ({displaySailors.length})
            </h2>
            <span className="text-xs text-slate-400">
              Ranked by relevance
            </span>
          </div>

          <div className="grid grid-cols-1 gap-2.5">
            {displaySailors.map((s) => {
              const initials = s.name
                .split(/\s+/)
                .filter(Boolean)
                .slice(0, 2)
                .map((part) => part[0]?.toUpperCase())
                .join("");

              return (
                <Link
                  key={s.id}
                  href={`/${s.handle}`}
                  className="group relative flex items-center justify-between gap-3 sm:gap-4 rounded-2xl border border-slate-200 bg-white p-3.5 sm:p-4 shadow-xs hover:border-orange-500/50 hover:shadow-md hover:shadow-orange-500/5 transition-all"
                >
                  <div className="flex items-center gap-3 sm:gap-3.5 min-w-0">
                    {/* Sailor Avatar or Initial Monogram */}
                    {s.avatarUrl ? (
                      <img
                        src={s.avatarUrl}
                        alt=""
                        className="h-10 w-10 sm:h-11 sm:w-11 rounded-full object-cover border border-slate-200 shrink-0"
                      />
                    ) : (
                      <div className="h-10 w-10 sm:h-11 sm:w-11 rounded-full bg-slate-100 border border-slate-200 flex items-center justify-center font-black text-xs sm:text-sm text-slate-700 shrink-0 group-hover:bg-orange-50 group-hover:text-orange-700 transition-colors">
                        {initials || "S"}
                      </div>
                    )}

                    <div className="min-w-0 space-y-0.5">
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className="text-sm sm:text-base font-bold text-slate-900 group-hover:text-orange-600 transition-colors truncate">
                          {s.name}
                        </span>

                        {/* Sail Number Badge */}
                        <span className="inline-flex items-center px-2 py-0.5 rounded-md bg-slate-100 text-slate-800 text-xs font-mono font-bold shrink-0">
                          {s.sailNumber.startsWith("SGP") || s.sailNumber.startsWith("SIN")
                            ? s.sailNumber
                            : `SGP ${s.sailNumber}`}
                        </span>

                        {s.sailNumberIlca4 && s.sailNumberIlca4 !== s.sailNumber && (
                          <span className="inline-flex items-center px-1.5 py-0.5 rounded bg-teal-50 text-teal-800 border border-teal-200 text-[10px] font-mono font-semibold shrink-0" title="ILCA 4 Sail Number">
                            ILCA: {s.sailNumberIlca4}
                          </span>
                        )}
                      </div>

                      {/* Club and School details */}
                      <div className="flex flex-wrap items-center gap-x-2 text-xs text-slate-500">
                        {s.club && <span className="truncate">{s.club}</span>}
                        {s.club && s.school && <span className="text-slate-300">·</span>}
                        {s.school && (
                          <span className="inline-flex items-center gap-1 truncate text-slate-600">
                            <GraduationCap className="h-3 w-3 text-slate-400 shrink-0" />
                            <span className="truncate">{s.school}</span>
                          </span>
                        )}
                        {s.nationality && s.nationality !== "Singapore" && s.nationality !== "SGP" && (
                          <>
                            <span className="text-slate-300">·</span>
                            <span className="text-slate-500">{s.nationality}</span>
                          </>
                        )}
                      </div>
                    </div>
                  </div>

                  {/* Badges on right side */}
                  <div className="flex items-center gap-2 shrink-0">
                    {/* Active Fleet Badge */}
                    {s.activeFleet === "Gold" && (
                      <span className="inline-flex items-center gap-1 rounded-full bg-amber-50 border border-amber-300/80 px-2.5 py-1 text-[11px] font-black text-amber-800 shadow-2xs">
                        <span>🥇</span>
                        <span className="hidden sm:inline">Gold Fleet</span>
                      </span>
                    )}
                    {s.activeFleet === "Silver" && (
                      <span className="inline-flex items-center gap-1 rounded-full bg-slate-100 border border-slate-300 px-2.5 py-1 text-[11px] font-black text-slate-700">
                        <span>🥈</span>
                        <span className="hidden sm:inline">Silver Fleet</span>
                      </span>
                    )}
                    {s.ilca4NationalList && (
                      <span className="inline-flex items-center rounded-full bg-teal-50 border border-teal-200 px-2.5 py-1 text-[11px] font-black text-teal-800">
                        ILCA 4
                      </span>
                    )}

                    {/* National Squad Status */}
                    {s.nationalSquadStatus === "Nat A" && (
                      <span className="rounded-full bg-rose-50 border border-rose-200 px-2 py-0.5 text-[10px] font-black text-rose-700">
                        Nat A
                      </span>
                    )}
                    {s.nationalSquadStatus === "Nat B" && (
                      <span className="rounded-full bg-amber-50 border border-amber-200 px-2 py-0.5 text-[10px] font-black text-amber-700">
                        Nat B
                      </span>
                    )}
                    {s.nationalSquadStatus === "DS" && (
                      <span className="rounded-full bg-sky-50 border border-sky-200 px-2 py-0.5 text-[10px] font-black text-sky-700">
                        DS
                      </span>
                    )}

                    <ChevronRight className="h-4 w-4 text-slate-300 group-hover:text-orange-500 group-hover:translate-x-0.5 transition-all" />
                  </div>
                </Link>
              );
            })}
          </div>
        </div>
      )}

      {/* ── Empty State ──────────────────────────────────────────────── */}
      {totalResults === 0 && !isLoading && (
        <div className="rounded-3xl border border-slate-200 bg-white p-8 sm:p-12 text-center space-y-4 shadow-xs">
          <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-slate-100 text-slate-400">
            <Search className="h-6 w-6" />
          </div>
          <div className="space-y-1">
            <h3 className="text-base sm:text-lg font-bold text-slate-900">
              No results found for &ldquo;{query}&rdquo;
            </h3>
            <p className="text-xs sm:text-sm text-slate-500 max-w-md mx-auto">
              We couldn&apos;t find any sailors or regattas matching your search.
            </p>
          </div>

          <div className="rounded-2xl border border-slate-100 bg-slate-50 p-4 text-left max-w-md mx-auto space-y-2 text-xs text-slate-600">
            <p className="font-bold text-slate-800">Search tips:</p>
            <ul className="list-disc list-inside space-y-1 text-slate-500">
              <li>Try searching just the digits of the sail number (e.g. <code className="font-mono bg-white px-1 py-0.5 rounded border border-slate-200 text-slate-800">4652</code> instead of <code className="font-mono bg-white px-1 py-0.5 rounded border border-slate-200 text-slate-800">SGP 4652</code>)</li>
              <li>Try school abbreviations like <strong className="text-slate-700">RI</strong>, <strong className="text-slate-700">ACSI</strong>, <strong className="text-slate-700">RGS</strong>, or <strong className="text-slate-700">SJI</strong></li>
              <li>Try club acronyms like <strong className="text-slate-700">CSC</strong> (Changi), <strong className="text-slate-700">SAFYC</strong>, or <strong className="text-slate-700">NSC</strong></li>
              <li>Try searching by last name only</li>
            </ul>
          </div>

          {hasActiveFilters && (
            <button
              type="button"
              onClick={handleClearAll}
              className="inline-flex items-center gap-1.5 px-4 py-2 rounded-full bg-slate-900 text-white text-xs font-bold hover:bg-slate-800 transition-colors shadow-xs"
            >
              <RotateCcw className="h-3.5 w-3.5" />
              Clear search &amp; filters
            </button>
          )}
        </div>
      )}
    </div>
  );
}
