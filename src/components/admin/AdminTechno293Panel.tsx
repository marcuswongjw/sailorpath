"use client";

import { useCallback, useMemo, useState, useRef, useEffect } from "react";
import Link from "next/link";
import {
  Plus,
  Trash2,
  ExternalLink,
  Calendar,
  MapPin,
  RefreshCw,
  Trophy,
  Edit3,
  CheckCircle2,
  AlertTriangle,
  Compass,
} from "lucide-react";
import {
  SINGAPORE_TECHNO293_REGATTAS,
  loadTechno293Regattas,
  saveTechno293Regattas,
  fetchServerTechno293Regattas,
  syncTechno293ToServer,
  deleteTechno293FromServer,
  sortTechno293Regattas,
  type Techno293Regatta,
  type Techno293SailorResult,
  type Techno293RaceScore,
} from "@/lib/techno293";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

export function AdminTechno293Panel({
  isSuperadmin = true,
}: {
  isSuperadmin?: boolean;
}) {
  const { toast } = useFeedback();

  const [regattas, setRegattas] = useState<Techno293Regatta[]>(
    SINGAPORE_TECHNO293_REGATTAS
  );
  const [selectedRegattaId, setSelectedRegattaId] = useState<string>(
    SINGAPORE_TECHNO293_REGATTAS[0]?.id || ""
  );
  const [isSyncingServer, setIsSyncingServer] = useState(false);
  const [lastSyncedAt, setLastSyncedAt] = useState<Date | null>(null);

  // Editing modal state
  const [isEditingRegatta, setIsEditingRegatta] = useState(false);
  const [regattaFormData, setRegattaFormData] = useState<Partial<Techno293Regatta>>({});

  useEffect(() => {
    let cancelled = false;
    const hydrate = async () => {
      const loaded = loadTechno293Regattas();
      if (!cancelled && loaded.length > 0) {
        setRegattas(sortTechno293Regattas(loaded));
      }

      setIsSyncingServer(true);
      const serverData = await fetchServerTechno293Regattas({ includeAll: true });
      if (!cancelled) {
        setIsSyncingServer(false);
        if (serverData && serverData.length > 0) {
          setRegattas(sortTechno293Regattas(serverData));
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
    () => sortTechno293Regattas(regattas),
    [regattas]
  );

  const activeRegatta = useMemo(
    () =>
      sortedRegattas.find((r) => r.id === selectedRegattaId) ||
      sortedRegattas[0] ||
      SINGAPORE_TECHNO293_REGATTAS[0],
    [sortedRegattas, selectedRegattaId]
  );

  const persistChanges = useCallback(
    async (next: Techno293Regatta[], showToast = true) => {
      const sorted = sortTechno293Regattas(next);
      setRegattas(sorted);
      saveTechno293Regattas(sorted);

      if (isSuperadmin) {
        setIsSyncingServer(true);
        const res = await syncTechno293ToServer(sorted);
        setIsSyncingServer(false);
        if (res.success) {
          setLastSyncedAt(new Date());
          if (showToast) {
            toast.success("Changes saved and published");
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

    const exists = regattas.some((r) => r.id === regattaFormData.id);
    let next: Techno293Regatta[];

    if (exists) {
      next = regattas.map((r) =>
        r.id === regattaFormData.id ? ({ ...r, ...regattaFormData } as Techno293Regatta) : r
      );
    } else {
      const newRegatta: Techno293Regatta = {
        id: regattaFormData.id,
        name: regattaFormData.name || "",
        shortName: regattaFormData.shortName || regattaFormData.name || "",
        dates: regattaFormData.dates || "",
        venue: regattaFormData.venue || "",
        organizer: regattaFormData.organizer || "Singapore Sailing Federation",
        format: regattaFormData.format || "Course Race",
        status: regattaFormData.status || "Upcoming",
        lifecycleStatus: regattaFormData.lifecycleStatus || "published",
        scoringSystem:
          regattaFormData.scoringSystem || "World Sailing RRS Appendix A (Low Point)",
        rulesNotes: regattaFormData.rulesNotes || "",
        seriesName: regattaFormData.seriesName || "2026 Southwest Monsoon Grand Prix Series",
        seriesPart: regattaFormData.seriesPart || "",
        websiteUrl: regattaFormData.websiteUrl || "",
        results: [],
      };
      next = [...regattas, newRegatta];
      setSelectedRegattaId(newRegatta.id);
    }

    void persistChanges(next);
    setIsEditingRegatta(false);
    setRegattaFormData({});
  };

  const handleDeleteRegatta = async (id: string) => {
    if (!window.confirm("Are you sure you want to delete this Techno 293 regatta?")) {
      return;
    }
    const next = regattas.filter((r) => r.id !== id);
    setRegattas(next);
    saveTechno293Regattas(next);
    if (selectedRegattaId === id && next.length > 0) {
      setSelectedRegattaId(next[0].id);
    }
    if (isSuperadmin) {
      await deleteTechno293FromServer(id);
    }
    toast.info("Regatta deleted");
  };

  const maxRaces = useMemo(() => {
    if (!activeRegatta.results || activeRegatta.results.length === 0) return 0;
    return Math.max(...activeRegatta.results.map((r) => r.races.length), 0);
  }, [activeRegatta]);

  return (
    <div className="space-y-6">
      {/* Header Bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-slate-900/60 border border-white/10 rounded-3xl p-5 backdrop-blur-md">
        <div className="flex items-center gap-3">
          <div className="h-10 w-10 rounded-2xl bg-cyan-500/15 border border-cyan-500/25 flex items-center justify-center text-cyan-400">
            <Compass className="h-5 w-5" />
          </div>
          <div>
            <h2 className="text-xl font-black text-white flex items-center gap-2">
              <span>Techno 293 Regattas &amp; Results Manager</span>
            </h2>
            <p className="text-xs text-slate-400">
              Manage Southwest Monsoon Grand Prix rounds, scores, and published status.
            </p>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => {
              setRegattaFormData({
                id: `techno-gp-${Date.now()}`,
                name: "2026 Southwest Monsoon Grand Prix Series",
                shortName: "SW Monsoon GP",
                dates: "October 2026",
                venue: "National Sailing Centre",
                organizer: "Singapore Sailing Federation & WAS",
                format: "Course Race",
                status: "Upcoming",
                lifecycleStatus: "published",
                scoringSystem: "World Sailing RRS Appendix A (Low Point)",
              });
              setIsEditingRegatta(true);
            }}
            className="px-3.5 py-2 rounded-xl text-xs font-bold bg-cyan-500 hover:bg-cyan-400 text-slate-950 flex items-center gap-1.5 transition-all shadow-md shadow-cyan-500/20"
          >
            <Plus className="h-3.5 w-3.5" />
            <span>New Regatta</span>
          </button>

          <button
            type="button"
            onClick={() => void persistChanges(regattas)}
            disabled={isSyncingServer}
            className="px-3.5 py-2 rounded-xl text-xs font-bold bg-white/5 hover:bg-white/10 text-slate-300 border border-white/10 flex items-center gap-1.5 transition-all"
          >
            <RefreshCw
              className={`h-3.5 w-3.5 ${isSyncingServer ? "animate-spin text-cyan-400" : ""}`}
            />
            <span>{isSyncingServer ? "Syncing..." : "Sync DB"}</span>
          </button>

          <Link
            href="/sg/techno293"
            target="_blank"
            className="px-3.5 py-2 rounded-xl text-xs font-bold bg-white/5 hover:bg-white/10 text-cyan-300 border border-cyan-500/20 flex items-center gap-1.5 transition-all"
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
                  ? "bg-cyan-500/10 border-cyan-400/50 shadow-lg shadow-cyan-500/10"
                  : "bg-slate-900/40 border-white/5 hover:bg-white/[0.04] hover:border-white/10"
              }`}
            >
              <div>
                <div className="flex items-center justify-between gap-2 mb-1.5">
                  <span
                    className={`text-[10px] font-bold px-2 py-0.5 rounded-full uppercase ${
                      regatta.status === "Completed"
                        ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/30"
                        : "bg-blue-500/20 text-blue-300 border border-blue-500/30"
                    }`}
                  >
                    {regatta.status}
                  </span>
                  <span className="text-[11px] text-slate-400 font-mono">
                    {count} sailors
                  </span>
                </div>
                <h3 className="text-sm font-bold text-white line-clamp-1">
                  {regatta.name}
                </h3>
                <div className="text-xs text-slate-400 mt-1">
                  {regatta.dates} • {regatta.venue}
                </div>
              </div>

              <div className="flex items-center justify-between pt-2 border-t border-white/5 text-xs">
                <span className="text-slate-400 font-mono text-[10px]">
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
                    className="p-1 rounded-lg hover:bg-white/10 text-slate-400 hover:text-white"
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
                    className="p-1 rounded-lg hover:bg-red-500/10 text-slate-400 hover:text-red-400"
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

      {/* Regatta Results Manager */}
      <div className="bg-slate-900/60 border border-white/10 rounded-3xl p-5 sm:p-6 backdrop-blur-md space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-white/10">
          <div>
            <span className="text-xs font-bold text-cyan-400 uppercase tracking-wide">
              Scorecard Manager
            </span>
            <h3 className="text-lg sm:text-xl font-black text-white">
              {activeRegatta.name} ({activeRegatta.results?.length || 0} competitors)
            </h3>
          </div>
          <div className="text-xs text-slate-400">
            {activeRegatta.results && activeRegatta.results.length > 0
              ? `${maxRaces} races recorded`
              : "No scores uploaded"}
          </div>
        </div>

        {/* Scorecard Table */}
        {!activeRegatta.results || activeRegatta.results.length === 0 ? (
          <div className="py-12 text-center text-slate-400 text-sm">
            No sailor results recorded for this event yet.
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs border-collapse">
              <thead>
                <tr className="border-b border-white/10 text-slate-400 uppercase tracking-wider font-semibold text-[11px]">
                  <th className="py-2.5 px-3 text-center w-12">Rank</th>
                  <th className="py-2.5 px-3">Sailor</th>
                  <th className="py-2.5 px-3 text-center">Sail #</th>
                  <th className="py-2.5 px-3 text-center">Division</th>
                  {Array.from({ length: maxRaces }).map((_, i) => (
                    <th key={i} className="py-2.5 px-2 text-center font-bold text-slate-300">
                      R{i + 1}
                    </th>
                  ))}
                  <th className="py-2.5 px-3 text-right">Gross</th>
                  <th className="py-2.5 px-4 text-right font-black text-cyan-400">Nett</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5">
                {activeRegatta.results.map((sailor) => (
                  <tr key={sailor.name} className="hover:bg-white/[0.03]">
                    <td className="py-3 px-3 text-center">
                      <div className="flex justify-center">
                        <RankMedalBadge rank={sailor.rank} />
                      </div>
                    </td>
                    <td className="py-3 px-3 font-bold text-white">
                      {sailor.name}
                    </td>
                    <td className="py-3 px-3 text-center font-mono text-slate-300">
                      {sailor.sailNumber}
                    </td>
                    <td className="py-3 px-3 text-center">
                      <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-white/5 text-slate-300 border border-white/10">
                        {sailor.ageCategory || sailor.division || "Open"}
                      </span>
                    </td>
                    {Array.from({ length: maxRaces }).map((_, i) => {
                      const r = sailor.races[i];
                      if (!r) {
                        return (
                          <td key={i} className="py-3 px-2 text-center text-slate-400">
                            —
                          </td>
                        );
                      }
                      return (
                        <td
                          key={i}
                          className={`py-3 px-2 text-center font-mono ${
                            r.isDiscarded
                              ? "text-slate-400 line-through bg-red-500/5"
                              : "text-slate-200 font-semibold"
                          }`}
                        >
                          {r.code ? `${r.score} ${r.code}` : r.score}
                        </td>
                      );
                    })}
                    <td className="py-3 px-3 text-right font-mono text-slate-400">
                      {sailor.grossScore}
                    </td>
                    <td className="py-3 px-4 text-right font-mono text-sm font-black text-cyan-400">
                      {sailor.nettScore}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Edit Regatta Modal */}
      {isEditingRegatta && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-slate-900 border border-white/10 rounded-3xl p-6 max-w-lg w-full space-y-4 shadow-2xl">
            <h3 className="text-lg font-black text-white">
              {regattas.some((r) => r.id === regattaFormData.id)
                ? "Edit Regatta Details"
                : "Create Techno 293 Regatta"}
            </h3>

            <form onSubmit={handleUpdateRegatta} className="space-y-3 text-xs">
              <div>
                <label className="block text-slate-400 font-bold mb-1">
                  Regatta ID (unique)
                </label>
                <input
                  type="text"
                  required
                  value={regattaFormData.id || ""}
                  onChange={(e) =>
                    setRegattaFormData({ ...regattaFormData, id: e.target.value })
                  }
                  className="w-full px-3 py-2 rounded-xl bg-white/5 border border-white/10 text-white"
                />
              </div>

              <div>
                <label className="block text-slate-400 font-bold mb-1">
                  Full Regatta Name
                </label>
                <input
                  type="text"
                  required
                  value={regattaFormData.name || ""}
                  onChange={(e) =>
                    setRegattaFormData({ ...regattaFormData, name: e.target.value })
                  }
                  className="w-full px-3 py-2 rounded-xl bg-white/5 border border-white/10 text-white"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-slate-400 font-bold mb-1">
                    Short Name (Badge)
                  </label>
                  <input
                    type="text"
                    required
                    value={regattaFormData.shortName || ""}
                    onChange={(e) =>
                      setRegattaFormData({
                        ...regattaFormData,
                        shortName: e.target.value,
                      })
                    }
                    className="w-full px-3 py-2 rounded-xl bg-white/5 border border-white/10 text-white"
                  />
                </div>
                <div>
                  <label className="block text-slate-400 font-bold mb-1">
                    Status
                  </label>
                  <select
                    value={regattaFormData.status || "Upcoming"}
                    onChange={(e) =>
                      setRegattaFormData({
                        ...regattaFormData,
                        status: e.target.value as "Completed" | "Upcoming",
                      })
                    }
                    className="w-full px-3 py-2 rounded-xl bg-white/5 border border-white/10 text-white"
                  >
                    <option value="Completed">Completed</option>
                    <option value="Upcoming">Upcoming</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-slate-400 font-bold mb-1">Dates</label>
                  <input
                    type="text"
                    value={regattaFormData.dates || ""}
                    onChange={(e) =>
                      setRegattaFormData({ ...regattaFormData, dates: e.target.value })
                    }
                    className="w-full px-3 py-2 rounded-xl bg-white/5 border border-white/10 text-white"
                  />
                </div>
                <div>
                  <label className="block text-slate-400 font-bold mb-1">Venue</label>
                  <input
                    type="text"
                    value={regattaFormData.venue || ""}
                    onChange={(e) =>
                      setRegattaFormData({ ...regattaFormData, venue: e.target.value })
                    }
                    className="w-full px-3 py-2 rounded-xl bg-white/5 border border-white/10 text-white"
                  />
                </div>
              </div>

              <div>
                <label className="block text-slate-400 font-bold mb-1">
                  Organizer
                </label>
                <input
                  type="text"
                  value={regattaFormData.organizer || ""}
                  onChange={(e) =>
                    setRegattaFormData({
                      ...regattaFormData,
                      organizer: e.target.value,
                    })
                  }
                  className="w-full px-3 py-2 rounded-xl bg-white/5 border border-white/10 text-white"
                />
              </div>

              <div className="flex items-center justify-end gap-2 pt-3 border-t border-white/10">
                <button
                  type="button"
                  onClick={() => setIsEditingRegatta(false)}
                  className="px-4 py-2 rounded-xl text-xs font-bold text-slate-400 hover:text-white"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-4 py-2 rounded-xl text-xs font-bold bg-cyan-500 text-slate-950 hover:bg-cyan-400"
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
