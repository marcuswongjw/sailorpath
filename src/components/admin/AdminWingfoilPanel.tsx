"use client";

import { useMemo, useState, useRef } from "react";
import Link from "next/link";
import {
  Upload,
  Plus,
  Trash2,
  ExternalLink,
  Download,
  Calendar,
  MapPin,
  Flame,
  FileImage,
  X,
  Eye,
  RefreshCw,
  Trophy,
} from "lucide-react";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  parseWingfoilScreenshotFilename,
  recalculateScoreboard,
  type WingfoilRegatta,
  type WingfoilSailorResult,
  type WingfoilRaceScore,
} from "@/lib/wingfoil";
import { useFeedback } from "@/components/ui/FeedbackProvider";

export function AdminWingfoilPanel({ isSuperadmin = true }: { isSuperadmin?: boolean }) {
  const { toast } = useFeedback();

  // Local state for regattas initialized with official Singapore data
  const [regattas, setRegattas] = useState<WingfoilRegatta[]>(
    SINGAPORE_WINGFOIL_REGATTAS
  );
  const [selectedRegattaId, setSelectedRegattaId] = useState<string>(
    SINGAPORE_WINGFOIL_REGATTAS[0]?.id || ""
  );

  // Uploaded screenshot preview state
  const [screenshotPreview, setScreenshotPreview] = useState<string | null>(null);
  const [screenshotFilename, setScreenshotFilename] = useState<string | null>(null);
  const [showScreenshotModal, setShowScreenshotModal] = useState<boolean>(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  // New competitor form state
  const [showAddEntry, setShowAddEntry] = useState(false);
  const [newEntry, setNewEntry] = useState<Partial<WingfoilSailorResult>>({
    name: "",
    sailNumber: "",
    gender: "M",
    ageCategory: "16&U",
    schoolName: "",
    club: "",
  });

  const activeRegatta = useMemo(
    () => regattas.find((r) => r.id === selectedRegattaId) || regattas[0],
    [regattas, selectedRegattaId]
  );

  const results = useMemo(
    () => activeRegatta?.results || [],
    [activeRegatta]
  );

  // Handle Screenshot Upload & Metadata Extraction
  const handleScreenshotUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    const file = e.target.files?.[0];
    if (!file) return;

    // 1. Extract Regatta Name and Start Date from Filename
    const { regattaName, startDate } = parseWingfoilScreenshotFilename(file.name);
    setScreenshotFilename(file.name);

    // 2. Read file as Data URL for visual preview
    const reader = new FileReader();
    reader.onload = (loadEvent) => {
      const url = loadEvent.target?.result as string;
      setScreenshotPreview(url);
    };
    reader.readAsDataURL(file);

    // 3. Check if a regatta with this name already exists or update current
    toast.success(
      `Screenshot recognized! Extracted Name: "${regattaName}", Start Date: ${startDate}`
    );

    // Check if matching regatta exists, or prompt/update active
    setRegattas((prev) => {
      const existsIndex = prev.findIndex(
        (r) =>
          r.name.toLowerCase().includes(regattaName.toLowerCase()) ||
          r.id === selectedRegattaId
      );

      if (existsIndex >= 0) {
        const updated = [...prev];
        updated[existsIndex] = {
          ...updated[existsIndex],
          name: updated[existsIndex].name || regattaName,
          dates: updated[existsIndex].dates || startDate,
        };
        return updated;
      } else {
        const newRegatta: WingfoilRegatta = {
          id: `wingfoil-${Date.now()}`,
          name: regattaName,
          shortName: regattaName.slice(0, 16),
          dates: startDate,
          venue: "National Sailing Centre (NSC), Singapore",
          organizer: "Singapore Sailing Federation",
          format: "Sprint Slalom",
          status: "Completed",
          scoringSystem: "Appendix A (9 races, 1 discard)",
          rulesNotes: "Delta Buoy Slalom course, 4–5 min heat target time, 1 discard after 4+ races.",
          results: [...(SINGAPORE_WINGFOIL_REGATTAS[0]?.results || [])],
        };
        setSelectedRegattaId(newRegatta.id);
        return [newRegatta, ...prev];
      }
    });

    if (fileInputRef.current) {
      fileInputRef.current.value = "";
    }
  };

  // Update a single heat score for a competitor
  const handleScoreChange = (
    sailorIndex: number,
    raceIndex: number,
    valStr: string,
    codeStr?: string
  ) => {
    if (!activeRegatta) return;
    const currentResults = [...(activeRegatta.results || [])];
    const sailor = { ...currentResults[sailorIndex] };
    const races: WingfoilRaceScore[] = [...sailor.races];

    const numScore = valStr === "" ? 8 : Number(valStr);
    const code = (codeStr as WingfoilRaceScore["code"]) || undefined;

    races[raceIndex] = {
      score: isNaN(numScore) ? 8 : numScore,
      code: code || undefined,
    };

    sailor.races = races;
    currentResults[sailorIndex] = sailor;

    // Recalculate scoreboard discards and rankings
    const updatedScoreboard = recalculateScoreboard(currentResults);

    setRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updatedScoreboard } : r
      )
    );
  };

  // Add a new competitor
  const handleAddCompetitor = (e: React.FormEvent) => {
    e.preventDefault();
    if (!newEntry.name || !newEntry.sailNumber) {
      toast.error("Name and Sail Number are required");
      return;
    }

    const defaultRaces: WingfoilRaceScore[] = Array.from({ length: 9 }, () => ({
      score: 8,
      code: "DNF",
    }));

    const competitor: WingfoilSailorResult = {
      rank: results.length + 1,
      name: newEntry.name.trim(),
      sailNumber: newEntry.sailNumber.trim(),
      gender: newEntry.gender || "M",
      ageCategory: newEntry.ageCategory || "16&U",
      schoolName: newEntry.schoolName?.trim() || "—",
      club: newEntry.club?.trim() || "—",
      races: defaultRaces,
      grossScore: 72,
      nettScore: 64,
    };

    const updatedScoreboard = recalculateScoreboard([...results, competitor]);

    setRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updatedScoreboard } : r
      )
    );

    setNewEntry({
      name: "",
      sailNumber: "",
      gender: "M",
      ageCategory: "16&U",
      schoolName: "",
      club: "",
    });
    setShowAddEntry(false);
    toast.success(`Added entry for ${competitor.name}`);
  };

  // Delete competitor
  const handleDeleteCompetitor = (name: string) => {
    if (!confirm(`Delete competitor ${name} from this regatta?`)) return;
    const filtered = results.filter((s) => s.name !== name);
    const updated = recalculateScoreboard(filtered);

    setRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updated } : r
      )
    );
    toast.success(`Removed competitor ${name}`);
  };

  // Export results as CSV
  const handleExportCsv = () => {
    if (!results.length) {
      toast.error("No results to export");
      return;
    }
    const headers = [
      "Rank",
      "Sail Number",
      "Name",
      "Gender",
      "Category",
      "School",
      "Club",
      "R1",
      "R2",
      "R3",
      "R4",
      "R5",
      "R6",
      "R7",
      "R8",
      "R9",
      "Gross",
      "Nett",
    ];

    const rows = results.map((s) => [
      s.rank,
      `"${s.sailNumber}"`,
      `"${s.name}"`,
      s.gender,
      `"${s.ageCategory}"`,
      `"${s.schoolName}"`,
      `"${s.club}"`,
      ...s.races.map((r) =>
        r.code ? `"${r.score} (${r.code})"` : r.score
      ),
      s.grossScore,
      s.nettScore,
    ]);

    const csvContent =
      "data:text/csv;charset=utf-8," +
      [headers.join(","), ...rows.map((e) => e.join(","))].join("\n");

    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute(
      "download",
      `${activeRegatta?.shortName || "WingFoil"}_Results.csv`
    );
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    toast.success("Downloaded results CSV");
  };

  return (
    <div className="w-full min-w-0 space-y-6">
      {/* Top Header & Fast Actions */}
      <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-4 glass-panel rounded-3xl p-6 border border-white/5 bg-[#131520]">
        <div>
          <div className="flex items-center gap-2">
            <span className="flex h-6 w-6 items-center justify-center rounded-lg bg-orange-500/20 text-orange-400">
              <Flame className="h-4 w-4" />
            </span>
            <h2 className="text-lg font-black text-white tracking-tight">
              WingFoil Results & Regatta Manager
            </h2>
            <span className="rounded-full bg-emerald-500/10 border border-emerald-500/20 px-2.5 py-0.5 text-[10px] font-bold text-emerald-400">
              Sprint Slalom
            </span>
          </div>
          <p className="mt-1 text-xs text-slate-400 max-w-2xl leading-relaxed">
            Manage Singapore WingFoil sprint slalom regattas, entries, and heat finishes (R1–R9).
            Automatic World Sailing RRS Appendix A discard scoring (1 discard after 4+ races).
          </p>
        </div>

        <div className="flex flex-wrap items-center gap-2">
          {/* Screenshot Upload Button */}
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            onChange={handleScreenshotUpload}
            className="hidden"
          />
          <button
            type="button"
            onClick={() => fileInputRef.current?.click()}
            className="inline-flex items-center gap-1.5 rounded-full border border-orange-500/30 bg-orange-500/10 hover:bg-orange-500/20 px-4 py-2 text-xs font-bold text-orange-300 transition-all shadow-sm"
          >
            <Upload className="h-3.5 w-3.5 text-orange-400" />
            Upload Results Screenshot
          </button>

          {/* Export CSV */}
          <button
            type="button"
            onClick={handleExportCsv}
            className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-300 transition-all"
          >
            <Download className="h-3.5 w-3.5 text-slate-400" />
            Export CSV
          </button>

          {/* View Live Public Page */}
          <Link
            href="/sg/wingfoil"
            target="_blank"
            className="inline-flex items-center gap-1.5 rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white transition-all shadow-lg shadow-orange-950/40"
          >
            <ExternalLink className="h-3.5 w-3.5" />
            View Public Hub
          </Link>
        </div>
      </div>

      {/* Screenshot Preview Card (if uploaded) */}
      {screenshotPreview && (
        <div className="glass-panel rounded-2xl p-4 border border-orange-500/20 bg-orange-500/[0.04] flex flex-col sm:flex-row items-center justify-between gap-4">
          <div className="flex items-center gap-3 min-w-0">
            <div className="h-14 w-24 rounded-lg overflow-hidden border border-white/10 bg-black/40 shrink-0 relative group cursor-pointer" onClick={() => setShowScreenshotModal(true)}>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={screenshotPreview}
                alt="Uploaded WingFoil Scorecard"
                className="h-full w-full object-cover group-hover:scale-105 transition-transform"
              />
              <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity">
                <Eye className="h-4 w-4 text-white" />
              </div>
            </div>
            <div className="min-w-0">
              <div className="flex items-center gap-2">
                <FileImage className="h-4 w-4 text-orange-400 shrink-0" />
                <span className="text-xs font-bold text-white truncate">
                  {screenshotFilename || "Uploaded Screenshot"}
                </span>
                <span className="rounded bg-emerald-500/20 text-emerald-300 text-[9px] font-bold px-1.5 py-0.5">
                  Metadata Extracted
                </span>
              </div>
              <p className="text-[11px] text-slate-400 mt-0.5">
                Regatta name and start date successfully extracted from screenshot filename. Click thumbnail to view side-by-side.
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2 shrink-0">
            <button
              type="button"
              onClick={() => setShowScreenshotModal(true)}
              className="px-3 py-1.5 rounded-full border border-white/10 text-xs font-semibold text-slate-300 hover:text-white hover:bg-white/5"
            >
              View Full Image
            </button>
            <button
              type="button"
              onClick={() => {
                setScreenshotPreview(null);
                setScreenshotFilename(null);
              }}
              className="p-1.5 rounded-full text-slate-500 hover:text-rose-400 hover:bg-rose-500/10"
              title="Dismiss image preview"
            >
              <X className="h-4 w-4" />
            </button>
          </div>
        </div>
      )}

      {/* Regatta Selector & Event Metadata */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
        {/* Event Details Card */}
        <div className="lg:col-span-4 glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
          <div>
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
              Selected WingFoil Regatta
            </label>
            <select
              value={selectedRegattaId}
              onChange={(e) => setSelectedRegattaId(e.target.value)}
              className="mt-1.5 w-full rounded-xl border border-white/10 bg-slate-950 px-3.5 py-2.5 text-xs font-bold text-white focus:border-orange-500/40"
            >
              {regattas.map((r) => (
                <option key={r.id} value={r.id}>
                  {r.name} ({r.dates})
                </option>
              ))}
            </select>
          </div>

          {activeRegatta && (
            <div className="space-y-3 pt-3 border-t border-white/5 text-xs">
              <div className="flex items-start gap-2">
                <Calendar className="h-4 w-4 text-slate-400 mt-0.5 shrink-0" />
                <div>
                  <span className="text-[10px] font-bold text-slate-500 uppercase block">
                    Dates
                  </span>
                  <span className="font-semibold text-slate-200">
                    {activeRegatta.dates}
                  </span>
                </div>
              </div>

              <div className="flex items-start gap-2">
                <MapPin className="h-4 w-4 text-slate-400 mt-0.5 shrink-0" />
                <div>
                  <span className="text-[10px] font-bold text-slate-500 uppercase block">
                    Venue & Organizer
                  </span>
                  <span className="font-semibold text-slate-200">
                    {activeRegatta.venue}
                  </span>
                  <span className="text-[10px] text-slate-400 block mt-0.5">
                    {activeRegatta.organizer}
                  </span>
                </div>
              </div>

              <div className="flex items-start gap-2">
                <Trophy className="h-4 w-4 text-orange-400 mt-0.5 shrink-0" />
                <div>
                  <span className="text-[10px] font-bold text-slate-500 uppercase block">
                    Format & Scoring
                  </span>
                  <span className="font-semibold text-orange-300">
                    {activeRegatta.format} · {activeRegatta.scoringSystem}
                  </span>
                  <p className="text-[10px] text-slate-400 mt-0.5 leading-snug">
                    {activeRegatta.rulesNotes}
                  </p>
                </div>
              </div>

              <div className="p-3 rounded-xl bg-white/[0.02] border border-white/5 space-y-1 mt-2">
                <span className="text-[10px] font-bold text-slate-400 uppercase">
                  Singapore WingFoil Rule
                </span>
                <p className="text-[10px] text-slate-400 leading-relaxed">
                  Stand-alone event series with no rolling national ranking. Appendix A applies (1 discard when 4+ races completed).
                </p>
              </div>
            </div>
          )}

          <button
            type="button"
            onClick={() => setShowAddEntry(true)}
            className="w-full flex items-center justify-center gap-2 rounded-xl bg-orange-600/90 hover:bg-orange-500 px-4 py-2.5 text-xs font-bold text-white transition-all shadow-md shadow-orange-950/40"
          >
            <Plus className="h-4 w-4" />
            Add Competitor Entry
          </button>
        </div>

        {/* Scoreboard Table */}
        <div className="lg:col-span-8 glass-panel rounded-3xl border border-white/5 overflow-hidden flex flex-col">
          <div className="p-4 sm:p-5 border-b border-white/5 flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-slate-900/30">
            <div>
              <h3 className="text-sm font-bold text-white flex items-center gap-2">
                Heat Scoreboard (R1 – R9)
                <span className="rounded-full bg-white/10 px-2 py-0.5 text-[10px] font-bold text-slate-300">
                  {results.length} Competitors
                </span>
              </h3>
              <p className="text-[11px] text-slate-400 mt-0.5">
                Strikethrough values indicate discarded worst races (Appendix A). Click any cell to adjust position or scoring code.
              </p>
            </div>
            <button
              type="button"
              onClick={() => {
                const updated = recalculateScoreboard(results);
                setRegattas((prev) =>
                  prev.map((r) =>
                    r.id === activeRegatta.id ? { ...r, results: updated } : r
                  )
                );
                toast.success("Recalculated Appendix A discards & ranks!");
              }}
              className="inline-flex items-center gap-1 text-[11px] font-bold text-orange-400 hover:text-orange-300 bg-orange-500/10 px-3 py-1.5 rounded-full border border-orange-500/20 shrink-0"
            >
              <RefreshCw className="h-3 w-3" />
              Recalculate Discards
            </button>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs text-slate-300">
              <thead className="bg-[#11131c] text-[10px] font-black uppercase text-slate-400 border-b border-white/5">
                <tr>
                  <th className="px-3 py-3 w-10 text-center">Rank</th>
                  <th className="px-3 py-3 w-16">Sail #</th>
                  <th className="px-3 py-3">Competitor</th>
                  <th className="px-2 py-3 w-16">Cat</th>
                  {Array.from({ length: 9 }).map((_, i) => (
                    <th key={i} className="px-1.5 py-3 w-12 text-center">
                      R{i + 1}
                    </th>
                  ))}
                  <th className="px-2.5 py-3 w-12 text-center font-bold">Gross</th>
                  <th className="px-2.5 py-3 w-12 text-center font-black text-orange-400">Nett</th>
                  <th className="px-2 py-3 w-10 text-center">Action</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 font-medium text-xs">
                {results.length === 0 ? (
                  <tr>
                    <td colSpan={16} className="px-6 py-12 text-center text-slate-500">
                      No competitors entered yet. Click &ldquo;Add Competitor Entry&rdquo; or upload a results screenshot.
                    </td>
                  </tr>
                ) : (
                  results.map((sailor, sailorIdx) => (
                    <tr
                      key={`${sailor.name}-${sailor.sailNumber}`}
                      className="hover:bg-white/[0.02] transition-colors"
                    >
                      <td className="px-3 py-3 text-center font-black text-white">
                        {sailor.rank === 1 ? (
                          <span className="inline-flex h-6 w-6 items-center justify-center rounded-full bg-amber-400 text-slate-950 font-black text-[11px] shadow-sm shadow-amber-400/30">
                            1
                          </span>
                        ) : sailor.rank === 2 ? (
                          <span className="inline-flex h-6 w-6 items-center justify-center rounded-full bg-slate-300 text-slate-950 font-black text-[11px]">
                            2
                          </span>
                        ) : sailor.rank === 3 ? (
                          <span className="inline-flex h-6 w-6 items-center justify-center rounded-full bg-amber-700 text-amber-100 font-black text-[11px]">
                            3
                          </span>
                        ) : (
                          <span className="text-slate-400 font-bold">{sailor.rank}</span>
                        )}
                      </td>
                      <td className="px-3 py-3 font-mono font-bold text-white">
                        {sailor.sailNumber}
                      </td>
                      <td className="px-3 py-3 min-w-[140px]">
                        <div className="font-bold text-white leading-tight">
                          {sailor.name}
                        </div>
                        <div className="text-[10px] text-slate-400 truncate max-w-[180px]">
                          {sailor.schoolName !== "—" ? sailor.schoolName : sailor.club}
                        </div>
                      </td>
                      <td className="px-2 py-3 text-[10px] font-bold text-slate-400">
                        {sailor.ageCategory}
                      </td>

                      {/* R1 through R9 Heat Score Inputs */}
                      {sailor.races.map((race, raceIdx) => {
                        const isDiscarded = race.isDiscarded;
                        const code = race.code;
                        return (
                          <td
                            key={raceIdx}
                            className={`px-1 py-2 text-center ${
                              isDiscarded ? "opacity-50" : ""
                            }`}
                          >
                            <div className="flex flex-col items-center">
                              <input
                                type="number"
                                min={1}
                                max={20}
                                value={race.score ?? ""}
                                onChange={(e) =>
                                  handleScoreChange(
                                    sailorIdx,
                                    raceIdx,
                                    e.target.value,
                                    race.code
                                  )
                                }
                                className={`w-9 text-center font-mono font-bold rounded p-0.5 text-xs border ${
                                  isDiscarded
                                    ? "line-through bg-slate-900 border-white/5 text-slate-500"
                                    : race.score === 1
                                    ? "bg-amber-400/20 border-amber-400/40 text-amber-300"
                                    : race.score === 2
                                    ? "bg-sky-400/20 border-sky-400/40 text-sky-200"
                                    : race.score === 3
                                    ? "bg-orange-500/20 border-orange-500/40 text-orange-200"
                                    : "bg-slate-950 border-white/10 text-white"
                                }`}
                              />
                              <select
                                value={code || ""}
                                onChange={(e) =>
                                  handleScoreChange(
                                    sailorIdx,
                                    raceIdx,
                                    String(race.score),
                                    e.target.value
                                  )
                                }
                                className="w-11 text-[9px] font-bold mt-0.5 bg-transparent border-0 text-slate-500 hover:text-slate-300 text-center"
                              >
                                <option value="" className="bg-slate-900 text-slate-300">
                                  FIN
                                </option>
                                <option value="DNF" className="bg-slate-900 text-slate-300">
                                  DNF
                                </option>
                                <option value="DNS" className="bg-slate-900 text-slate-300">
                                  DNS
                                </option>
                                <option value="DSQ" className="bg-slate-900 text-slate-300">
                                  DSQ
                                </option>
                                <option value="DNC" className="bg-slate-900 text-slate-300">
                                  DNC
                                </option>
                                <option value="RDG" className="bg-slate-900 text-slate-300">
                                  RDG
                                </option>
                              </select>
                            </div>
                          </td>
                        );
                      })}

                      <td className="px-2.5 py-3 text-center font-mono font-bold text-slate-400">
                        {sailor.grossScore}
                      </td>
                      <td className="px-2.5 py-3 text-center font-mono font-black text-orange-400 text-sm">
                        {sailor.nettScore}
                      </td>
                      <td className="px-2 py-3 text-center">
                        <button
                          type="button"
                          onClick={() => handleDeleteCompetitor(sailor.name)}
                          className="p-1 rounded text-slate-500 hover:text-rose-400 hover:bg-rose-500/10 transition-colors"
                          title="Delete entry"
                        >
                          <Trash2 className="h-3.5 w-3.5" />
                        </button>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      {/* Add Competitor Modal */}
      {showAddEntry && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/70 backdrop-blur-sm">
          <div className="glass-panel w-full max-w-md rounded-3xl p-6 border border-white/10 bg-[#131520] shadow-2xl space-y-4">
            <div className="flex items-center justify-between border-b border-white/5 pb-3">
              <h3 className="text-base font-bold text-white flex items-center gap-2">
                <Plus className="h-4 w-4 text-orange-500" />
                Add Competitor Entry
              </h3>
              <button
                type="button"
                onClick={() => setShowAddEntry(false)}
                className="rounded-full p-1 text-slate-400 hover:text-white"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <form onSubmit={handleAddCompetitor} className="space-y-3 text-xs">
              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Competitor Name *
                </label>
                <input
                  type="text"
                  required
                  placeholder="e.g. Mason Qifeng Lau"
                  value={newEntry.name || ""}
                  onChange={(e) =>
                    setNewEntry({ ...newEntry, name: e.target.value })
                  }
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Sail Number *
                  </label>
                  <input
                    type="text"
                    required
                    placeholder="e.g. 27"
                    value={newEntry.sailNumber || ""}
                    onChange={(e) =>
                      setNewEntry({ ...newEntry, sailNumber: e.target.value })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white font-mono"
                  />
                </div>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Gender
                  </label>
                  <select
                    value={newEntry.gender || "M"}
                    onChange={(e) =>
                      setNewEntry({
                        ...newEntry,
                        gender: e.target.value as "M" | "F",
                      })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                  >
                    <option value="M">Male (M)</option>
                    <option value="F">Female (F)</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Age Category
                  </label>
                  <select
                    value={newEntry.ageCategory || "16&U"}
                    onChange={(e) =>
                      setNewEntry({ ...newEntry, ageCategory: e.target.value })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                  >
                    <option value="16&U">16&U (Under 16)</option>
                    <option value="U19">U19 (Youth)</option>
                    <option value="Open">Open</option>
                    <option value="Masters">Masters</option>
                    <option value="Women">Women</option>
                  </select>
                </div>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    School Name
                  </label>
                  <input
                    type="text"
                    placeholder="e.g. Tao Nan School"
                    value={newEntry.schoolName || ""}
                    onChange={(e) =>
                      setNewEntry({ ...newEntry, schoolName: e.target.value })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                  />
                </div>
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Club / Organization
                </label>
                <input
                  type="text"
                  placeholder="e.g. Constant Wind SeaSports"
                  value={newEntry.club || ""}
                  onChange={(e) =>
                    setNewEntry({ ...newEntry, club: e.target.value })
                  }
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div className="flex justify-end gap-2 pt-3 border-t border-white/5">
                <button
                  type="button"
                  onClick={() => setShowAddEntry(false)}
                  className="rounded-full px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2 text-xs font-bold text-white shadow-lg shadow-orange-950/40"
                >
                  Save Entry
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Screenshot Full Image Modal */}
      {showScreenshotModal && screenshotPreview && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/85 backdrop-blur-md">
          <div className="glass-panel w-full max-w-5xl rounded-3xl p-6 border border-white/10 bg-[#131520] shadow-2xl space-y-4">
            <div className="flex items-center justify-between border-b border-white/5 pb-3">
              <div className="flex items-center gap-2">
                <FileImage className="h-5 w-5 text-orange-400" />
                <h3 className="text-sm font-bold text-white">
                  Uploaded Scorecard Screenshot — {screenshotFilename}
                </h3>
              </div>
              <button
                type="button"
                onClick={() => setShowScreenshotModal(false)}
                className="rounded-full p-1.5 text-slate-400 hover:text-white bg-white/5"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
            <div className="overflow-auto max-h-[75vh] flex items-center justify-center rounded-2xl bg-black/50 p-2 border border-white/5">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={screenshotPreview}
                alt="WingFoil Results Full Screenshot"
                className="max-w-full h-auto object-contain rounded-lg"
              />
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
