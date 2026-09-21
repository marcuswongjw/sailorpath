"use client";

import { useCallback, useMemo, useState, useRef, useEffect } from "react";
import Link from "next/link";
import {
  Plus,
  Trash2,
  ExternalLink,
  RefreshCw,
  Edit3,
  Flame,
  FileSpreadsheet,
  UserPlus,
  X,
  Check,
} from "lucide-react";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  loadWingfoilRegattas,
  saveWingfoilRegattas,
  fetchServerWingfoilRegattas,
  syncWingfoilToServer,
  deleteWingfoilFromServer,
  sortWingfoilRegattas,
  recalculateScoreboard,
  mergeWingfoilRegattaLists,
  WINGFOIL_CATEGORIES,
  normalizeWingfoilCategory,
  type WingfoilRegatta,
  type WingfoilSailorResult,
  type WingfoilRaceScore,
  type WingfoilCategory,
} from "@/lib/wingfoil";
import { readWingfoilExcel } from "@/lib/wingfoilExcel";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

export function AdminWingfoilPanel({
  isSuperadmin = true,
}: {
  isSuperadmin?: boolean;
}) {
  const { toast } = useFeedback();

  const [regattas, setRegattas] = useState<WingfoilRegatta[]>(
    SINGAPORE_WINGFOIL_REGATTAS
  );
  const [selectedRegattaId, setSelectedRegattaId] = useState<string>(
    SINGAPORE_WINGFOIL_REGATTAS[0]?.id || ""
  );
  const [isSyncingServer, setIsSyncingServer] = useState(false);
  const [, setLastSyncedAt] = useState<Date | null>(null);

  // Regatta editing modal state
  const [isEditingRegatta, setIsEditingRegatta] = useState(false);
  const [regattaFormData, setRegattaFormData] = useState<Partial<WingfoilRegatta>>({});

  // Sailor editing modal state
  const [isEditingSailor, setIsEditingSailor] = useState(false);
  const [editingSailorIndex, setEditingSailorIndex] = useState<number | null>(null);
  const [sailorFormData, setSailorFormData] = useState<{
    rank: number;
    name: string;
    sailNumber: string;
    gender: "M" | "F";
    ageCategory: WingfoilCategory;
    schoolName: string;
    club: string;
    racesStr: string;
  }>({
    rank: 1,
    name: "",
    sailNumber: "",
    gender: "M",
    ageCategory: "Open",
    schoolName: "",
    club: "",
    racesStr: "",
  });

  const fileInputRef = useRef<HTMLInputElement | null>(null);

  useEffect(() => {
    let cancelled = false;
    const hydrate = async () => {
      const loaded = loadWingfoilRegattas();
      if (!cancelled && loaded.length > 0) {
        setRegattas(sortWingfoilRegattas(loaded));
      }

      setIsSyncingServer(true);
      const serverData = await fetchServerWingfoilRegattas({ includeAll: true });
      if (!cancelled) {
        setIsSyncingServer(false);
        if (serverData && serverData.length > 0) {
          const merged = mergeWingfoilRegattaLists(
            serverData,
            loaded.length > 0 ? loaded : SINGAPORE_WINGFOIL_REGATTAS
          );
          setRegattas(sortWingfoilRegattas(merged));
          setLastSyncedAt(new Date());
        }
      }
    };

    void hydrate();
    return () => {
      cancelled = true;
    };
  }, []);

  const sortedRegattas = useMemo(
    () => sortWingfoilRegattas(regattas),
    [regattas]
  );

  const activeRegatta = useMemo(
    () =>
      sortedRegattas.find((r) => r.id === selectedRegattaId) ||
      sortedRegattas[0] ||
      SINGAPORE_WINGFOIL_REGATTAS[0],
    [sortedRegattas, selectedRegattaId]
  );

  const persistChanges = useCallback(
    async (next: WingfoilRegatta[], showToast = true) => {
      const sorted = sortWingfoilRegattas(next);
      setRegattas(sorted);
      saveWingfoilRegattas(sorted);

      if (isSuperadmin) {
        setIsSyncingServer(true);
        const res = await syncWingfoilToServer(sorted);
        setIsSyncingServer(false);
        if (res.success) {
          setLastSyncedAt(new Date());
          if (showToast) {
            toast.success("Changes saved and published to live site");
          }
        } else {
          toast.error(res.error || "Saved locally, but server sync failed");
        }
      }
    },
    [isSuperadmin, toast]
  );

  const handleUpdateRegatta = (e: React.FormEvent) => {
    e.preventDefault();
    if (!regattaFormData.name || !regattaFormData.id) return;

    const isNew = !regattas.some((r) => r.id === regattaFormData.id);
    let next: WingfoilRegatta[];

    if (isNew) {
      const newRegatta: WingfoilRegatta = {
        id: regattaFormData.id,
        name: regattaFormData.name,
        shortName: regattaFormData.shortName || regattaFormData.name,
        dates: regattaFormData.dates || "TBD",
        venue: regattaFormData.venue || "Singapore Waters",
        organizer: regattaFormData.organizer || "Singapore Sailing",
        format: regattaFormData.format || "Sprint Slalom",
        status: (regattaFormData.status as "Completed" | "Upcoming") || "Upcoming",
        lifecycleStatus: (regattaFormData.lifecycleStatus as "published" | "draft") || "published",
        scoringSystem: regattaFormData.scoringSystem || "World Sailing RRS Appendix A (Low Point)",
        rulesNotes: regattaFormData.rulesNotes || "",
        results: [],
        seriesName: regattaFormData.seriesName,
      };
      next = [...regattas, newRegatta];
      setSelectedRegattaId(newRegatta.id);
    } else {
      next = regattas.map((r) =>
        r.id === regattaFormData.id ? ({ ...r, ...regattaFormData } as WingfoilRegatta) : r
      );
    }

    void persistChanges(next);
    setIsEditingRegatta(false);
  };

  const handleDeleteRegatta = async (id: string) => {
    if (!window.confirm("Are you sure you want to delete this wingfoil regatta?")) return;
    const next = regattas.filter((r) => r.id !== id);
    setRegattas(next);
    saveWingfoilRegattas(next);

    if (isSuperadmin) {
      setIsSyncingServer(true);
      await deleteWingfoilFromServer(id);
      setIsSyncingServer(false);
    }

    if (selectedRegattaId === id) {
      setSelectedRegattaId(next[0]?.id || "");
    }
    toast.success("Regatta deleted");
  };

  const handleExcelUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    try {
      toast.info(`Parsing ${file.name}…`);
      const parsed = await readWingfoilExcel(file);
      if (!parsed || !parsed.results || parsed.results.length === 0) {
        toast.error("No valid sailor results found in Excel file.");
        return;
      }

      const recalculated = recalculateScoreboard(parsed.results);
      const updatedRegatta: WingfoilRegatta = {
        ...activeRegatta,
        status: "Completed",
        results: recalculated,
      };

      const next = regattas.map((r) => (r.id === activeRegatta.id ? updatedRegatta : r));
      await persistChanges(next);
      toast.success(`Imported ${parsed.results.length} sailor results into ${activeRegatta.shortName}!`);
    } catch (err) {
      console.error(err);
      toast.error("Failed to parse Excel file. Check format.");
    } finally {
      if (fileInputRef.current) fileInputRef.current.value = "";
    }
  };

  const handleOpenAddSailor = () => {
    setEditingSailorIndex(null);
    const currentResults = activeRegatta.results || [];
    const maxR = currentResults.length > 0 ? Math.max(...currentResults.map((r) => r.races.length)) : 3;
    const defaultScores = Array.from({ length: maxR }, (_, i) => `${i + 1}`).join(", ");

    setSailorFormData({
      rank: currentResults.length + 1,
      name: "",
      sailNumber: "",
      gender: "M",
      ageCategory: "Open",
      schoolName: "",
      club: "",
      racesStr: defaultScores,
    });
    setIsEditingSailor(true);
  };

  const handleOpenEditSailor = (sailor: WingfoilSailorResult, index: number) => {
    setEditingSailorIndex(index);
    const racesStr = sailor.races
      .map((r) => {
        if (r.code) return `${r.score} ${r.code}`;
        if (r.isDiscarded) return `(${r.score})`;
        return `${r.score}`;
      })
      .join(", ");

    setSailorFormData({
      rank: sailor.rank,
      name: sailor.name,
      sailNumber: sailor.sailNumber,
      gender: sailor.gender || "M",
      ageCategory: normalizeWingfoilCategory(sailor.ageCategory),
      schoolName: sailor.schoolName || "",
      club: sailor.club || "",
      racesStr,
    });
    setIsEditingSailor(true);
  };

  const handleSaveSailor = (e: React.FormEvent) => {
    e.preventDefault();
    if (!sailorFormData.name.trim()) return;

    // Parse race scores
    const tokens = sailorFormData.racesStr.split(",").map((s) => s.trim()).filter(Boolean);
    const parsedRaces: WingfoilRaceScore[] = tokens.map((tok) => {
      const isDisc = tok.startsWith("(") && tok.endsWith(")");
      const clean = isDisc ? tok.slice(1, -1).trim() : tok;
      const numMatch = clean.match(/^(\d+(?:\.\d+)?)/);
      const codeMatch = clean.match(/(DNF|DNS|DSQ|DNC|RDG)/i);

      const score = numMatch ? parseFloat(numMatch[1]) : 10;
      const code = codeMatch ? (codeMatch[1].toUpperCase() as WingfoilRaceScore["code"]) : undefined;

      return {
        score,
        isDiscarded: isDisc,
        code,
      };
    });

    const gross = parsedRaces.reduce((sum, r) => sum + r.score, 0);
    const nett = parsedRaces.reduce((sum, r) => sum + (r.isDiscarded ? 0 : r.score), 0);

    const newSailor: WingfoilSailorResult = {
      rank: sailorFormData.rank,
      name: sailorFormData.name.trim(),
      sailNumber: sailorFormData.sailNumber.trim(),
      gender: sailorFormData.gender,
      ageCategory: sailorFormData.ageCategory,
      schoolName: sailorFormData.schoolName.trim(),
      club: sailorFormData.club.trim(),
      races: parsedRaces,
      grossScore: gross,
      nettScore: nett,
    };

    const currentResults = [...(activeRegatta.results || [])];
    if (editingSailorIndex !== null && editingSailorIndex >= 0) {
      currentResults[editingSailorIndex] = newSailor;
    } else {
      currentResults.push(newSailor);
    }

    const recalculated = recalculateScoreboard(currentResults);
    const updatedRegatta: WingfoilRegatta = {
      ...activeRegatta,
      status: "Completed",
      results: recalculated,
    };

    const next = regattas.map((r) => (r.id === activeRegatta.id ? updatedRegatta : r));
    void persistChanges(next);
    setIsEditingSailor(false);
  };

  const handleDeleteSailor = (index: number) => {
    if (!window.confirm("Remove this sailor from the regatta?")) return;
    const currentResults = (activeRegatta.results || []).filter((_, i) => i !== index);
    const recalculated = recalculateScoreboard(currentResults);
    const updatedRegatta: WingfoilRegatta = {
      ...activeRegatta,
      results: recalculated,
    };
    const next = regattas.map((r) => (r.id === activeRegatta.id ? updatedRegatta : r));
    void persistChanges(next);
  };

  const maxRaces = useMemo(() => {
    if (!activeRegatta.results || activeRegatta.results.length === 0) return 0;
    return Math.max(...activeRegatta.results.map((r) => r.races.length), 0);
  }, [activeRegatta]);

  return (
    <div className="space-y-6">
      {/* Hidden Excel File Input */}
      <input
        type="file"
        ref={fileInputRef}
        onChange={handleExcelUpload}
        accept=".xlsx,.xls,.csv"
        className="hidden"
      />

      {/* Header Bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-2xl sm:rounded-3xl p-5 shadow-xs">
        <div className="flex items-center gap-3">
          <div className="h-10 w-10 rounded-2xl bg-[var(--sp-harbour-teal)]/10 border border-[var(--sp-harbour-teal)]/20 flex items-center justify-center text-[var(--sp-harbour-teal)]">
            <Flame className="h-5 w-5" />
          </div>
          <div>
            <h2 className="text-xl font-black font-display text-[var(--sp-harbour-shadow)] flex items-center gap-2">
              <span>Wingfoil Regattas &amp; Results Manager</span>
            </h2>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-0.5">
              Manage Northeast &amp; Southwest Monsoon Grand Prix rounds, scores, and published status.
            </p>
          </div>
        </div>

        <div className="flex items-center gap-2.5 flex-wrap">
          <button
            type="button"
            onClick={() => {
              setRegattaFormData({
                id: `wingfoil-gp-${Date.now()}`,
                name: "2026 Southwest Monsoon Grand Prix Series",
                shortName: "SW Monsoon GP",
                dates: "October 2026",
                venue: "National Sailing Centre",
                organizer: "Singapore Sailing Federation",
                format: "Sprint Slalom",
                status: "Upcoming",
                lifecycleStatus: "published",
                scoringSystem: "World Sailing RRS Appendix A / B8 (Low Point)",
              });
              setIsEditingRegatta(true);
            }}
            className="sp-btn-primary px-3.5 py-2 text-xs font-bold flex items-center gap-1.5 shadow-xs"
          >
            <Plus className="h-3.5 w-3.5" />
            <span>New Regatta</span>
          </button>

          <button
            type="button"
            onClick={() => void persistChanges(regattas)}
            disabled={isSyncingServer}
            className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] hover:bg-[var(--sp-cool-veil)]/50 text-[var(--sp-harbour-shadow)] px-3.5 py-2 text-xs font-bold flex items-center gap-1.5 transition-all shadow-xs"
          >
            <RefreshCw
              className={`h-3.5 w-3.5 ${isSyncingServer ? "animate-spin text-[var(--sp-racing-orange)]" : ""}`}
            />
            <span>{isSyncingServer ? "Syncing…" : "Sync DB"}</span>
          </button>

          <Link
            href="/sg/wingfoil"
            target="_blank"
            className="rounded-xl border border-[var(--sp-harbour-teal)]/30 bg-[var(--sp-harbour-teal)]/10 hover:bg-[var(--sp-harbour-teal)]/20 text-[var(--sp-harbour-teal)] px-3.5 py-2 text-xs font-bold flex items-center gap-1.5 transition-all shadow-xs"
          >
            <span>Live View</span>
            <ExternalLink className="h-3.5 w-3.5" />
          </Link>
        </div>
      </div>

      {/* Regatta Selection Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
        {sortedRegattas.map((regatta) => {
          const isSelected = regatta.id === activeRegatta.id;
          const count = regatta.results?.length || 0;

          return (
            <div
              key={regatta.id}
              onClick={() => setSelectedRegattaId(regatta.id)}
              className={`p-4 rounded-2xl border transition-all cursor-pointer flex flex-col justify-between space-y-3 ${
                isSelected
                  ? "border-2 border-[var(--sp-harbour-teal)] bg-[var(--sp-harbour-teal)]/5 shadow-sm"
                  : "bg-[var(--sp-warm-white)] border-[var(--sp-cool-veil)] hover:border-[var(--sp-harbour-teal)]/40 hover:bg-[var(--sp-sailcloth)]/30 shadow-xs"
              }`}
            >
              <div>
                <div className="flex items-center justify-between gap-2 mb-1.5">
                  <span
                    className={`text-[12px] font-bold px-2 py-0.5 rounded-full uppercase ${
                      regatta.status === "Completed"
                        ? "bg-emerald-500/15 text-emerald-700 dark:text-emerald-300 border border-emerald-500/30"
                        : "bg-[var(--sp-harbour-teal)]/15 text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/30"
                    }`}
                  >
                    {regatta.status}
                  </span>
                  <span className="text-[13px] text-[var(--sp-slate-soft)] font-mono">
                    {count} sailors
                  </span>
                </div>
                <h3 className="text-sm font-bold text-[var(--sp-harbour-shadow)] line-clamp-1">
                  {regatta.name}
                </h3>
                <div className="text-xs text-[var(--sp-slate-soft)] mt-1">
                  {regatta.dates} • {regatta.venue}
                </div>
              </div>

              <div className="flex items-center justify-between pt-2 border-t border-[var(--sp-cool-veil)] text-xs">
                <span className="text-[var(--sp-slate-soft)] font-mono text-[13px]">
                  {regatta.shortName}
                </span>
                <div className="flex items-center gap-1.5">
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation();
                      setRegattaFormData({ ...regatta });
                      setIsEditingRegatta(true);
                    }}
                    className="p-1 rounded-lg hover:bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                    title="Edit regatta details"
                  >
                    <Edit3 className="h-3.5 w-3.5" />
                  </button>
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation();
                      void handleDeleteRegatta(regatta.id);
                    }}
                    className="p-1 rounded-lg hover:bg-rose-50 text-[var(--sp-slate-soft)] hover:text-rose-600"
                    title="Delete regatta"
                  >
                    <Trash2 className="h-3.5 w-3.5" />
                  </button>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Regatta Results Scorecard Manager */}
      <div className="bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-2xl sm:rounded-3xl p-5 sm:p-6 shadow-xs space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-[var(--sp-cool-veil)]">
          <div>
            <span className="text-xs font-bold text-[var(--sp-racing-orange)] uppercase tracking-wide">
              Scorecard Manager
            </span>
            <h3 className="text-lg sm:text-xl font-black font-display text-[var(--sp-harbour-shadow)]">
              {activeRegatta.name} ({activeRegatta.results?.length || 0} competitors)
            </h3>
          </div>

          <div className="flex items-center gap-2">
            <button
              type="button"
              onClick={() => fileInputRef.current?.click()}
              className="rounded-xl border border-emerald-500/30 bg-emerald-500/10 hover:bg-emerald-500/20 text-emerald-700 dark:text-emerald-300 px-3 py-1.5 text-xs font-bold flex items-center gap-1.5 transition-all"
            >
              <FileSpreadsheet className="h-3.5 w-3.5 text-emerald-600" />
              <span>Import Excel</span>
            </button>

            <button
              type="button"
              onClick={handleOpenAddSailor}
              className="sp-btn-primary px-3 py-1.5 text-xs font-bold flex items-center gap-1.5"
            >
              <UserPlus className="h-3.5 w-3.5" />
              <span>Add Sailor</span>
            </button>
          </div>
        </div>

        {/* Scorecard Table */}
        {!activeRegatta.results || activeRegatta.results.length === 0 ? (
          <div className="py-12 text-center text-[var(--sp-slate-soft)] text-sm space-y-3">
            <p>No sailor results recorded for this event yet.</p>
            <div className="flex items-center justify-center gap-3">
              <button
                type="button"
                onClick={() => fileInputRef.current?.click()}
                className="px-4 py-2 rounded-xl text-xs font-bold bg-emerald-500/10 text-emerald-700 dark:text-emerald-300 border border-emerald-500/30 hover:bg-emerald-500/20 transition-all flex items-center gap-1.5"
              >
                <FileSpreadsheet className="h-4 w-4" />
                <span>Upload Excel Results (.xlsx)</span>
              </button>
              <button
                type="button"
                onClick={handleOpenAddSailor}
                className="px-4 py-2 rounded-xl text-xs font-bold border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-cool-veil)]/50 transition-all flex items-center gap-1.5"
              >
                <UserPlus className="h-4 w-4" />
                <span>Add First Competitor</span>
              </button>
            </div>
          </div>
        ) : (
          <div className="overflow-x-auto rounded-2xl border border-[var(--sp-cool-veil)]">
            <table className="w-full text-left text-xs border-collapse">
              <thead>
                <tr className="border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] uppercase tracking-wider font-semibold text-[12px]">
                  <th className="py-2.5 px-3 text-center w-12">Rank</th>
                  <th className="py-2.5 px-3">Sailor</th>
                  <th className="py-2.5 px-3 text-center">Sail #</th>
                  <th className="py-2.5 px-3 text-center">Gender</th>
                  <th className="py-2.5 px-3 text-center">Category</th>
                  <th className="py-2.5 px-3">Club / School</th>
                  {Array.from({ length: maxRaces }).map((_, i) => (
                    <th key={i} className="py-2.5 px-2 text-center font-bold text-[var(--sp-charcoal-slate)]">
                      R{i + 1}
                    </th>
                  ))}
                  <th className="py-2.5 px-3 text-right">Gross</th>
                  <th className="py-2.5 px-4 text-right font-black text-[var(--sp-racing-orange)]">Nett</th>
                  <th className="py-2.5 px-3 text-center w-20">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                {activeRegatta.results.map((sailor, idx) => (
                  <tr key={sailor.name + idx} className="hover:bg-[var(--sp-sailcloth)]/50 transition-colors">
                    <td className="py-3 px-3 text-center">
                      <div className="flex justify-center">
                        <RankMedalBadge rank={sailor.rank} />
                      </div>
                    </td>
                    <td className="py-3 px-3 font-bold text-[var(--sp-harbour-shadow)]">
                      {sailor.name}
                    </td>
                    <td className="py-3 px-3 text-center font-mono text-[var(--sp-charcoal-slate)]">
                      {sailor.sailNumber}
                    </td>
                    <td className="py-3 px-3 text-center font-bold text-[var(--sp-charcoal-slate)]">
                      {sailor.gender || "M"}
                    </td>
                    <td className="py-3 px-3 text-center">
                      <span className="px-2 py-0.5 rounded text-[11px] font-bold bg-[var(--sp-harbour-teal)]/10 text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/20">
                        {normalizeWingfoilCategory(sailor.ageCategory)}
                      </span>
                    </td>
                    <td className="py-3 px-3 text-[var(--sp-slate-soft)]">
                      <p className="font-medium text-[var(--sp-charcoal-slate)] truncate max-w-[8rem]">{sailor.club || "—"}</p>
                      {sailor.schoolName && (
                        <p className="text-[13px] text-[var(--sp-slate-soft)] truncate max-w-[8rem]">{sailor.schoolName}</p>
                      )}
                    </td>
                    {Array.from({ length: maxRaces }).map((_, i) => {
                      const r = sailor.races[i];
                      if (!r) {
                        return (
                          <td key={i} className="py-3 px-2 text-center text-[var(--sp-slate-soft)]">
                            —
                          </td>
                        );
                      }
                      return (
                        <td
                          key={i}
                          className={`py-3 px-2 text-center font-mono ${
                            r.isDiscarded
                              ? "text-[var(--sp-slate-soft)] line-through bg-rose-500/5"
                              : "text-[var(--sp-charcoal-slate)] font-semibold"
                          }`}
                        >
                          {r.code ? `${r.score} ${r.code}` : r.score}
                        </td>
                      );
                    })}
                    <td className="py-3 px-3 text-right font-mono text-[var(--sp-slate-soft)]">
                      {sailor.grossScore}
                    </td>
                    <td className="py-3 px-4 text-right font-mono text-sm font-black text-[var(--sp-racing-orange)]">
                      {sailor.nettScore}
                    </td>
                    <td className="py-3 px-3 text-center">
                      <div className="flex items-center justify-center gap-1">
                        <button
                          type="button"
                          onClick={() => handleOpenEditSailor(sailor, idx)}
                          className="p-1 rounded hover:bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                          title="Edit sailor"
                        >
                          <Edit3 className="h-3.5 w-3.5" />
                        </button>
                        <button
                          type="button"
                          onClick={() => handleDeleteSailor(idx)}
                          className="p-1 rounded hover:bg-rose-50 text-[var(--sp-slate-soft)] hover:text-rose-600"
                          title="Delete sailor"
                        >
                          <Trash2 className="h-3.5 w-3.5" />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Edit / Add Sailor Modal */}
      {isEditingSailor && (
        <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-3xl p-6 max-w-md w-full space-y-4 shadow-2xl">
            <div className="flex items-center justify-between border-b border-[var(--sp-cool-veil)] pb-3">
              <h3 className="text-base font-black font-display text-[var(--sp-harbour-shadow)]">
                {editingSailorIndex !== null ? "Edit Competitor" : "Add Competitor"}
              </h3>
              <button
                type="button"
                onClick={() => setIsEditingSailor(false)}
                className="p-1 rounded-lg text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <form onSubmit={handleSaveSailor} className="space-y-3 text-xs">
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Name</label>
                  <input
                    type="text"
                    required
                    value={sailorFormData.name}
                    onChange={(e) => setSailorFormData({ ...sailorFormData, name: e.target.value })}
                    placeholder="e.g. Samuel Tan"
                    className="w-full sp-input py-2"
                  />
                </div>
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Sail Number</label>
                  <input
                    type="text"
                    value={sailorFormData.sailNumber}
                    onChange={(e) => setSailorFormData({ ...sailorFormData, sailNumber: e.target.value })}
                    placeholder="e.g. 11"
                    className="w-full sp-input py-2"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Gender</label>
                  <select
                    value={sailorFormData.gender}
                    onChange={(e) =>
                      setSailorFormData({ ...sailorFormData, gender: e.target.value as "M" | "F" })
                    }
                    className="w-full sp-select py-2"
                  >
                    <option value="M">Male (M)</option>
                    <option value="F">Female (F)</option>
                  </select>
                </div>
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Category</label>
                  <select
                    value={sailorFormData.ageCategory}
                    onChange={(e) =>
                      setSailorFormData({
                        ...sailorFormData,
                        ageCategory: e.target.value as WingfoilCategory,
                      })
                    }
                    className="w-full sp-select py-2"
                  >
                    {WINGFOIL_CATEGORIES.map((cat) => (
                      <option key={cat} value={cat}>
                        {cat}
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Club</label>
                  <input
                    type="text"
                    value={sailorFormData.club}
                    onChange={(e) => setSailorFormData({ ...sailorFormData, club: e.target.value })}
                    placeholder="e.g. Constant Wind"
                    className="w-full sp-input py-2"
                  />
                </div>
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">School (optional)</label>
                  <input
                    type="text"
                    value={sailorFormData.schoolName}
                    onChange={(e) => setSailorFormData({ ...sailorFormData, schoolName: e.target.value })}
                    placeholder="e.g. RI"
                    className="w-full sp-input py-2"
                  />
                </div>
              </div>

              <div>
                <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">
                  Race Scores (comma-separated, wrap discards in parentheses)
                </label>
                <input
                  type="text"
                  required
                  value={sailorFormData.racesStr}
                  onChange={(e) => setSailorFormData({ ...sailorFormData, racesStr: e.target.value })}
                  placeholder="e.g. 1, 2, 1, (4), 2, 1"
                  className="w-full sp-input py-2 font-mono"
                />
                <p className="text-[13px] text-[var(--sp-slate-soft)] mt-1">
                  Example: 1, 2, (9 DNF), 3, 1 (parentheses mark discarded scores)
                </p>
              </div>

              <div className="pt-3 border-t border-[var(--sp-cool-veil)] flex justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setIsEditingSailor(false)}
                  className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-bold text-[var(--sp-charcoal-slate)] hover:bg-[var(--sp-cool-veil)]/50"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="sp-btn-primary px-4 py-2 text-xs font-bold flex items-center gap-1.5 shadow-xs"
                >
                  <Check className="h-4 w-4" />
                  <span>Save Sailor</span>
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Edit Regatta Modal */}
      {isEditingRegatta && (
        <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-3xl p-6 max-w-lg w-full space-y-4 shadow-2xl">
            <h3 className="text-lg font-black font-display text-[var(--sp-harbour-shadow)]">
              {regattas.some((r) => r.id === regattaFormData.id)
                ? "Edit Regatta Details"
                : "Create Wingfoil Regatta"}
            </h3>

            <form onSubmit={handleUpdateRegatta} className="space-y-3 text-xs">
              <div>
                <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Regatta ID</label>
                <input
                  type="text"
                  required
                  disabled={regattas.some((r) => r.id === regattaFormData.id)}
                  value={regattaFormData.id || ""}
                  onChange={(e) => setRegattaFormData({ ...regattaFormData, id: e.target.value })}
                  className="w-full sp-input py-2 font-mono disabled:opacity-60"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Full Name</label>
                  <input
                    type="text"
                    required
                    value={regattaFormData.name || ""}
                    onChange={(e) => setRegattaFormData({ ...regattaFormData, name: e.target.value })}
                    className="w-full sp-input py-2"
                  />
                </div>
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Short Name</label>
                  <input
                    type="text"
                    required
                    value={regattaFormData.shortName || ""}
                    onChange={(e) =>
                      setRegattaFormData({ ...regattaFormData, shortName: e.target.value })
                    }
                    className="w-full sp-input py-2"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Dates</label>
                  <input
                    type="text"
                    required
                    value={regattaFormData.dates || ""}
                    onChange={(e) => setRegattaFormData({ ...regattaFormData, dates: e.target.value })}
                    className="w-full sp-input py-2"
                  />
                </div>
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Venue</label>
                  <input
                    type="text"
                    required
                    value={regattaFormData.venue || ""}
                    onChange={(e) => setRegattaFormData({ ...regattaFormData, venue: e.target.value })}
                    className="w-full sp-input py-2"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Series Name</label>
                  <input
                    type="text"
                    value={regattaFormData.seriesName || ""}
                    onChange={(e) =>
                      setRegattaFormData({ ...regattaFormData, seriesName: e.target.value })
                    }
                    className="w-full sp-input py-2"
                  />
                </div>
                <div>
                  <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">Status</label>
                  <select
                    value={regattaFormData.status || "Upcoming"}
                    onChange={(e) =>
                      setRegattaFormData({
                        ...regattaFormData,
                        status: e.target.value as "Completed" | "Upcoming",
                      })
                    }
                    className="w-full sp-select py-2"
                  >
                    <option value="Completed">Completed</option>
                    <option value="Upcoming">Upcoming</option>
                  </select>
                </div>
              </div>

              <div className="pt-3 border-t border-[var(--sp-cool-veil)] flex justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setIsEditingRegatta(false)}
                  className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-bold text-[var(--sp-charcoal-slate)] hover:bg-[var(--sp-cool-veil)]/50"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="sp-btn-primary px-4 py-2 text-xs font-bold shadow-xs"
                >
                  Save Regatta
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
