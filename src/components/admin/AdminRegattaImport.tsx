"use client";

import { useState } from "react";
import { read, utils } from "xlsx";
import {
  Upload,
  AlertTriangle,
  CheckCircle,
} from "lucide-react";
import {
  parseRegattaResultRows,
  summarizeRegattaImport,
  type RegattaImportRow,
} from "@/lib/excel/parseRegattaResultsSheet";
import { parseRegattaTitle } from "@/lib/excel/parseRegattaTitle";
import { parseApi } from "@/components/admin/parseApi";
import type { ImportPossibleDuplicate } from "@/types/import";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type { SailorAdmin } from "@/types/sailor";
import {
  BOAT_CLASSES,
  DEFAULT_BOAT_CLASS,
  DEFAULT_GEOGRAPHY,
  classImportNote,
  geographySelectOptions,
  isSingleFleetClass,
} from "@/lib/countries";

type Props = {
  isSuperadmin: boolean;
  onSailorsUpdated?: (sailors: SailorAdmin[]) => void;
  onRegattaUpserted?: (regatta: RegattaAdmin) => void;
  onResultsUpdated?: (results: ResultAdmin[]) => void;
};

/**
 * Regatta Excel import tab (self-contained state + handlers).
 */
export function AdminRegattaImport({
  isSuperadmin,
  onSailorsUpdated,
  onRegattaUpserted,
  onResultsUpdated,
}: Props) {
  const [dragActive, setDragActive] = useState(false);
  const [importStatus, setImportStatus] = useState<string | null>(null);
  /** 0–100; shown while reading / importing */
  const [importProgress, setImportProgress] = useState(0);
  const [importBusy, setImportBusy] = useState(false);
  const [importPossibleDuplicates, setImportPossibleDuplicates] = useState<
    ImportPossibleDuplicate[]
  >([]);
  const [nationalityFlags, setNationalityFlags] = useState<
    {
      sailorId: string;
      name: string;
      previous: string | null;
      imported: string | null;
      raw: string | null;
      action: string;
      detail: string;
    }[]
  >([]);
  const [fullImportRows, setFullImportRows] = useState<RegattaImportRow[]>([]);
  const [importMeta, setImportMeta] = useState({
    name: "",
    date: new Date().toISOString().slice(0, 10),
    division: "Gold",
    fleetSize: 50,
    boatClass: DEFAULT_BOAT_CLASS,
    geography: DEFAULT_GEOGRAPHY,
    /** true = counts toward series rankings */
    countsForRanking: true,
    /** Completed races — ILCA needs ≥3 for ranking */
    raceCount: "" as string | number,
  });

  const handleDrag = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.type === "dragenter" || e.type === "dragover") {
      setDragActive(true);
    } else if (e.type === "dragleave") {
      setDragActive(false);
    }
  };

  const handleFile = (file: File) => {
    setImportBusy(true);
    setImportProgress(5);
    setImportStatus(`Reading “${file.name}”…`);
    setImportPossibleDuplicates([]);
    setNationalityFlags([]);
    const reader = new FileReader();
    reader.onprogress = (ev) => {
      if (ev.lengthComputable && ev.total > 0) {
        setImportProgress(Math.min(40, Math.round((ev.loaded / ev.total) * 40)));
      }
    };
    reader.onload = (ev) => {
      try {
        setImportProgress(45);
        setImportStatus("Parsing spreadsheet…");
        const data = ev.target?.result;
        const workbook = read(data, { type: "array" });
        const sheetName = workbook.SheetNames[0];
        const sheet = workbook.Sheets[sheetName];
        setImportProgress(60);
        const json = utils.sheet_to_json<Record<string, unknown>>(sheet, {
          defval: "",
          raw: false,
        });
        setImportProgress(80);
        const mapped = parseRegattaResultRows(json);
        setFullImportRows(mapped);
        setImportPossibleDuplicates([]);
        setImportProgress(100);

        // Prefer filename; fall back to first sheet name for date/title
        const fromFile = parseRegattaTitle(file.name);
        const fromSheet = parseRegattaTitle(sheetName);
        const title = {
          date: fromFile.date || fromSheet.date,
          name: fromFile.name || fromSheet.name,
          division: fromFile.division || fromSheet.division,
          boatClass: fromFile.boatClass || fromSheet.boatClass,
        };

        setImportMeta((m) => ({
          ...m,
          name: title.name || m.name || fromFile.stem || sheetName,
          date: title.date || m.date,
          division: title.division
            ? title.division
            : /silver/i.test(file.name + sheetName)
              ? "Silver"
              : /gold/i.test(file.name + sheetName)
                ? "Gold"
                : m.division,
          boatClass: title.boatClass || m.boatClass,
          fleetSize: mapped.length || m.fleetSize,
        }));

        const titleNote = title.date
          ? ` Title → ${title.name || "—"} · ${title.date}${
              title.division ? ` · ${title.division}` : ""
            }.`
          : "";
        setImportStatus(
          `Parsed ${mapped.length} competitor rows from “${sheetName}”` +
            summarizeRegattaImport(mapped) +
            `.${titleNote} Confirm geography, ranking, division + date, then Import.`
        );
      } catch (err) {
        setImportProgress(0);
        setImportStatus(null);
        alert(
          err instanceof Error ? err.message : "Failed to parse spreadsheet"
        );
      } finally {
        setImportBusy(false);
        setTimeout(() => setImportProgress(0), 800);
      }
    };
    reader.onerror = () => {
      setImportBusy(false);
      setImportProgress(0);
      setImportStatus(null);
      alert("Failed to read file");
    };
    reader.readAsArrayBuffer(file);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setDragActive(false);
    if (e.dataTransfer.files?.[0]) handleFile(e.dataTransfer.files[0]);
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files?.[0]) handleFile(e.target.files[0]);
  };

  const refreshListsAfterImport = async (regatta?: RegattaAdmin | null) => {
    if (regatta) onRegattaUpserted?.(regatta);
    try {
      const list = await fetch("/api/admin/sailors").then((r) => r.json());
      if (list.sailors) onSailorsUpdated?.(list.sailors);
    } catch {
      /* ignore */
    }
    try {
      const rRes = await fetch("/api/admin/results");
      if (rRes.ok) {
        const rData = await rRes.json();
        if (rData.results) onResultsUpdated?.(rData.results);
      }
    } catch {
      /* optional */
    }
  };

  /**
   * When the import POST times out / drops, the browser reports "Failed to fetch"
   * even though rows may already be committed. Check whether the regatta landed.
   */
  const recoverAfterNetworkError = async (): Promise<{
    ok: boolean;
    message: string;
    regatta?: RegattaAdmin;
  }> => {
    try {
      const res = await fetch("/api/admin/regattas");
      if (!res.ok) return { ok: false, message: "" };
      const data = await res.json();
      const list: RegattaAdmin[] = data.regattas || [];
      const name = importMeta.name.trim().toLowerCase();
      const date = importMeta.date.slice(0, 10);
      const reg = list.find((r) => {
        const rn = String(r.name || "")
          .trim()
          .toLowerCase();
        const rd = String(r.date || "").slice(0, 10);
        return rn === name && rd === date;
      });
      if (!reg) return { ok: false, message: "" };

      let resultCount = 0;
      try {
        const rRes = await fetch("/api/admin/results");
        if (rRes.ok) {
          const rData = await rRes.json();
          const results: ResultAdmin[] = rData.results || [];
          resultCount = results.filter((r) => r.regattaId === reg.id).length;
          if (rData.results) onResultsUpdated?.(rData.results);
        }
      } catch {
        /* ignore count */
      }

      await refreshListsAfterImport(reg);
      return {
        ok: true,
        regatta: reg,
        message:
          resultCount > 0
            ? `Import likely succeeded (network dropped after save). Found “${reg.name}” with ${resultCount} result row(s) linked to this regatta. Refresh admin if lists look stale.`
            : `Regatta “${reg.name}” was saved, but this check found 0 result rows for it (no finishers stored yet). That usually means the request dropped mid-import before results were written — re-import the same file (safe; upserts).`,
      };
    } catch {
      return { ok: false, message: "" };
    }
  };

  const handleImportToDb = async () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can import.");
      return;
    }
    if (!fullImportRows.length || !importMeta.name || !importMeta.date) {
      alert("Parse a file and set regatta name + date first.");
      return;
    }
    setImportBusy(true);
    setImportProgress(8);
    setImportStatus(
      `Importing ${fullImportRows.length} rows to database…`
    );
    setImportPossibleDuplicates([]);
    // Slow crawl while waiting on server (no real stream from API)
    let tick = 8;
    const pulse = window.setInterval(() => {
      tick = Math.min(72, tick + 2);
      setImportProgress(tick);
    }, 400);
    try {
      setImportProgress(15);
      const res = await fetch("/api/admin/import", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          regattaName: importMeta.name,
          eventDate: importMeta.date,
          division: importMeta.division,
          totalFleetSize: importMeta.fleetSize || fullImportRows.length,
          boatClass: importMeta.boatClass,
          geography: importMeta.geography,
          countsForRanking: importMeta.countsForRanking,
          raceCount:
            importMeta.raceCount === "" || importMeta.raceCount == null
              ? null
              : Number(importMeta.raceCount),
          rows: fullImportRows,
          createMissing: true,
        }),
      });
      setImportProgress(78);
      setImportStatus("Processing server response…");
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || data.message || "Import failed");

      setImportProgress(88);
      setImportStatus("Refreshing sailors & results…");
      await refreshListsAfterImport(data.regatta || null);
      setImportProgress(100);

      if (data.hint || data.errorSamples?.length) {
        const extra = [data.hint, ...(data.errorSamples || []).slice(0, 3)]
          .filter(Boolean)
          .join("\n");
        if (extra) {
          alert(
            `${data.message || "Import finished with issues"}\n\n${extra}`
          );
        }
      }
      const unmatchedCount = (data.unmatched || []).length;
      const dupes = Array.isArray(data.possibleDuplicates)
        ? data.possibleDuplicates
        : [];
      setImportPossibleDuplicates(dupes);
      const natFlags = Array.isArray(data.nationalityFlags)
        ? data.nationalityFlags
        : [];
      setNationalityFlags(natFlags);
      setImportStatus(
        (data.message || "Import complete") +
          (unmatchedCount
            ? ` · ${unmatchedCount} unmatched name(s) skipped — add/fix sailor names and re-import.`
            : "") +
          (natFlags.length
            ? ` · ${natFlags.length} nationality flag(s) — review below.`
            : "")
      );
    } catch (e: unknown) {
      const msg = e instanceof Error ? e.message : "Import failed";
      const isNetworkDrop =
        /failed to fetch|networkerror|load failed|network request failed|aborted|timeout/i.test(
          msg
        );

      if (isNetworkDrop) {
        setImportProgress(85);
        setImportStatus("Connection dropped — checking if import saved…");
        const recovered = await recoverAfterNetworkError();
        if (recovered.ok) {
          setImportProgress(100);
          setImportStatus(recovered.message);
          alert(recovered.message);
          return;
        }
        setImportProgress(0);
        setImportStatus(null);
        setImportPossibleDuplicates([]);
        setNationalityFlags([]);
        alert(
          "Failed to fetch — the server may have timed out after saving. " +
            "Check Database → Regattas / Results before re-importing (re-import is safe and upserts)."
        );
        return;
      }

      setImportProgress(0);
      setImportStatus(null);
      setImportPossibleDuplicates([]);
      setNationalityFlags([]);
      alert(msg);
    } finally {
      window.clearInterval(pulse);
      setImportBusy(false);
      setTimeout(() => setImportProgress(0), 1200);
    }
  };

  return (
    <div className="w-full min-w-0 space-y-6">
      <div className="glass-panel rounded-3xl p-6 sm:p-8 border border-white/5 w-full">
        <div
          onDragEnter={handleDrag}
          onDragOver={handleDrag}
          onDragLeave={handleDrag}
          onDrop={handleDrop}
          className={`w-full border-2 border-dashed rounded-2xl p-8 flex flex-col items-center justify-center cursor-pointer transition-all text-center ${
            dragActive
              ? "border-orange-500 bg-orange-500/5"
              : "border-white/10 hover:border-white/20"
          }`}
        >
          <Upload className="h-10 w-10 text-orange-500 mb-4" />
          <p className="text-sm font-bold text-white mb-2">
            Drag and drop your Regatta Excel/CSV file here
          </p>
          <p className="text-xs text-slate-500 mb-4 max-w-3xl">
            Supports .xlsx, .xls, and .csv. Required: Name (+ Rank/Nett if
            available). Optional: Total Score, Club, Nationality, Sail Number,
            Birth Year / DOB. When club / school / sail # differ from the
            profile, the{" "}
            <strong className="text-slate-300">latest regatta date wins</strong>{" "}
            (any class). Optimist series rankings ignore ILCA 4 and other
            classes. Unmatched names become{" "}
            <strong className="text-slate-300">guests</strong> (not on SG series
            until you admit them in Database).
          </p>
          <label className="rounded-full bg-slate-800 border border-white/5 px-4 py-2 text-xs font-bold text-white hover:bg-slate-700 transition-all cursor-pointer">
            Select File
            <input
              type="file"
              onChange={handleFileChange}
              className="hidden"
              accept=".xlsx,.xls,.csv"
            />
          </label>
        </div>

        {(importBusy || importProgress > 0 || importStatus) && (
          <div className="mt-6 max-w-xl mx-auto space-y-2">
            {(importBusy || importProgress > 0) && (
              <div className="space-y-1.5">
                <div className="flex items-center justify-between text-[10px] font-bold uppercase tracking-wide text-slate-500">
                  <span>{importBusy ? "In progress" : "Done"}</span>
                  <span className="tabular-nums text-orange-400">
                    {Math.round(importProgress)}%
                  </span>
                </div>
                <div className="h-2.5 w-full rounded-full bg-slate-900 border border-white/10 overflow-hidden">
                  <div
                    className={`h-full rounded-full transition-all duration-300 ease-out ${
                      importBusy
                        ? "bg-gradient-to-r from-orange-600 to-orange-400"
                        : "bg-emerald-500"
                    }`}
                    style={{ width: `${Math.min(100, Math.max(0, importProgress))}%` }}
                  />
                </div>
              </div>
            )}
            {importStatus && (
              <div
                className={`flex items-start gap-2 text-xs font-bold justify-center text-center ${
                  importBusy ? "text-orange-300" : "text-emerald-400"
                }`}
              >
                <CheckCircle
                  className={`h-4 w-4 shrink-0 mt-0.5 ${
                    importBusy ? "text-orange-400 animate-pulse" : "text-emerald-500"
                  }`}
                />
                <span>{importStatus}</span>
              </div>
            )}
          </div>
        )}

        {nationalityFlags.length > 0 && (
          <div className="mt-4 rounded-2xl border border-sky-500/30 bg-sky-500/5 p-4 space-y-3">
            <div className="flex items-start gap-2">
              <AlertTriangle className="h-4 w-4 text-sky-400 shrink-0 mt-0.5" />
              <div>
                <p className="text-xs font-bold text-sky-200">
                  Nationality flags ({nationalityFlags.length})
                </p>
                <p className="text-[11px] text-slate-400 mt-0.5">
                  Latest regatta updates nationality when present on the sheet.
                  Review mismatches or unrecognized values and correct in
                  Database → Sailors if needed.
                </p>
              </div>
            </div>
            <ul className="space-y-2 max-h-64 overflow-y-auto">
              {nationalityFlags.slice(0, 50).map((f, i) => (
                <li
                  key={`${f.sailorId}-${f.action}-${i}`}
                  className="rounded-xl border border-white/5 bg-slate-950/50 px-3 py-2 text-[11px]"
                >
                  <div className="flex flex-wrap items-center gap-2">
                    <span
                      className={`rounded-full px-1.5 py-0.5 text-[9px] font-black uppercase ${
                        f.action === "updated"
                          ? "bg-emerald-500/15 text-emerald-300 border border-emerald-500/30"
                          : f.action === "unrecognized"
                            ? "bg-rose-500/15 text-rose-300 border border-rose-500/30"
                            : "bg-amber-500/15 text-amber-200 border border-amber-500/30"
                      }`}
                    >
                      {f.action}
                    </span>
                    <span className="font-semibold text-white">{f.name}</span>
                  </div>
                  <p className="text-slate-400 mt-1">{f.detail}</p>
                  {(f.previous || f.imported || f.raw) && (
                    <p className="text-slate-500 mt-0.5 font-mono text-[10px]">
                      was {f.previous || "—"} · sheet {f.imported || f.raw || "—"}
                    </p>
                  )}
                </li>
              ))}
            </ul>
          </div>
        )}

        {importPossibleDuplicates.length > 0 && (
          <div className="mt-4 rounded-2xl border border-amber-500/30 bg-amber-500/5 p-4 space-y-3">
            <div className="flex items-start gap-2">
              <AlertTriangle className="h-4 w-4 text-amber-400 shrink-0 mt-0.5" />
              <div>
                <p className="text-xs font-bold text-amber-200">
                  Possible duplicate names ({importPossibleDuplicates.length})
                </p>
                <p className="text-[11px] text-slate-400 mt-0.5">
                  Names ≥60% similar within this file or vs existing sailors.
                  Import still completed — review and merge in Database → Sailors
                  if they are the same person.
                </p>
              </div>
            </div>
            <ul className="space-y-2 max-h-64 overflow-y-auto">
              {importPossibleDuplicates.slice(0, 40).map((d, i) => (
                <li
                  key={`${d.importName}-${d.otherName}-${i}`}
                  className="rounded-xl border border-white/5 bg-slate-950/50 px-3 py-2 text-[11px]"
                >
                  <div className="flex flex-wrap items-center gap-2">
                    <span
                      className={`rounded-full px-1.5 py-0.5 text-[9px] font-black uppercase ${
                        d.band === "high"
                          ? "bg-rose-500/15 text-rose-300 border border-rose-500/30"
                          : "bg-amber-500/15 text-amber-200 border border-amber-500/30"
                      }`}
                    >
                      {Math.round(d.similarity * 100)}% · {d.band}
                    </span>
                    <span className="rounded-full bg-white/5 px-1.5 py-0.5 text-[9px] font-bold text-slate-400 uppercase">
                      {d.kind === "within-file" ? "In file" : "vs DB"}
                    </span>
                  </div>
                  <p className="text-slate-200 mt-1 font-semibold">
                    {d.importName}
                    <span className="text-slate-500 font-normal"> ↔ </span>
                    {d.otherName}
                  </p>
                  <p className="text-slate-500 mt-0.5">{d.note}</p>
                </li>
              ))}
            </ul>
            {importPossibleDuplicates.length > 40 && (
              <p className="text-[10px] text-slate-500">
                Showing first 40 of {importPossibleDuplicates.length}.
              </p>
            )}
          </div>
        )}

        {fullImportRows.length > 0 && (
          <div className="mt-6 w-full grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 text-left">
            <label className="text-xs text-slate-400 sm:col-span-2">
              Regatta name
              <input
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.name}
                onChange={(e) =>
                  setImportMeta((m) => ({ ...m, name: e.target.value }))
                }
              />
            </label>
            <label className="text-xs text-slate-400">
              Event date
              <input
                type="date"
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.date}
                onChange={(e) =>
                  setImportMeta((m) => ({ ...m, date: e.target.value }))
                }
              />
            </label>
            <label className="text-xs text-slate-400">
              Total fleet size
              <input
                type="number"
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.fleetSize}
                onChange={(e) =>
                  setImportMeta((m) => ({
                    ...m,
                    fleetSize: Number(e.target.value) || 50,
                  }))
                }
              />
            </label>
            <label className="text-xs text-slate-400">
              Class
              <select
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.boatClass}
                onChange={(e) => {
                  const boatClass = e.target.value;
                  setImportMeta((m) => ({
                    ...m,
                    boatClass,
                    // ILCA 4 etc.: single open fleet — no Gold/Silver
                    division: isSingleFleetClass(boatClass)
                      ? "Open"
                      : m.division === "Open"
                        ? "Gold"
                        : m.division,
                  }));
                }}
              >
                {BOAT_CLASSES.map((c) => (
                  <option key={c} value={c}>
                    {c}
                  </option>
                ))}
              </select>
            </label>
            <label className="text-xs text-slate-400">
              Geography
              <select
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.geography}
                onChange={(e) =>
                  setImportMeta((m) => ({ ...m, geography: e.target.value }))
                }
              >
                {geographySelectOptions().map((c) => (
                  <option key={c.code} value={c.code}>
                    {c.code} — {c.name}
                  </option>
                ))}
              </select>
            </label>
            <label className="text-xs text-slate-400">
              Races completed
              <input
                type="number"
                min={0}
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.raceCount}
                onChange={(e) => {
                  const raceCount = e.target.value;
                  const n = Number(raceCount);
                  const isIlca = isSingleFleetClass(importMeta.boatClass);
                  setImportMeta((m) => ({
                    ...m,
                    raceCount,
                    ...(isIlca &&
                    raceCount !== "" &&
                    Number.isFinite(n) &&
                    n < 3
                      ? {
                          countsForRanking: false,
                          division:
                            m.division === "Gold" || m.division === "Open"
                              ? "Open"
                              : m.division,
                        }
                      : {}),
                  }));
                }}
                placeholder="e.g. 6 (ILCA: &lt;3 = non-ranking)"
              />
            </label>
            <label className="text-xs text-slate-400">
              Ranking
              <select
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.countsForRanking ? "ranking" : "non-ranking"}
                onChange={(e) =>
                  setImportMeta((m) => ({
                    ...m,
                    countsForRanking: e.target.value === "ranking",
                    // Keep division sensible when toggling non-ranking
                    division:
                      e.target.value === "non-ranking" &&
                      (m.division === "Gold" || m.division === "Open")
                        ? isSingleFleetClass(m.boatClass)
                          ? "Open"
                          : "NonRanking"
                        : e.target.value === "ranking" &&
                            m.division === "NonRanking"
                          ? "Gold"
                          : m.division,
                  }))
                }
              >
                <option value="ranking">
                  Ranking (series / Best 3 of 5)
                </option>
                <option value="non-ranking">
                  Non-ranking (logbook only / too few races)
                </option>
              </select>
            </label>
            <label className="text-xs text-slate-400">
              Division
              <select
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs disabled:opacity-60"
                value={
                  isSingleFleetClass(importMeta.boatClass)
                    ? "Open"
                    : importMeta.division
                }
                disabled={isSingleFleetClass(importMeta.boatClass)}
                onChange={(e) =>
                  setImportMeta((m) => ({ ...m, division: e.target.value }))
                }
              >
                {isSingleFleetClass(importMeta.boatClass) ? (
                  <option value="Open">Open (single fleet)</option>
                ) : (
                  <>
                    <option value="Gold">Gold</option>
                    <option value="Silver">Silver</option>
                    <option value="Both">Both</option>
                    <option value="NonRanking">Non-ranking</option>
                  </>
                )}
              </select>
            </label>
            <p className="sm:col-span-2 lg:col-span-4 text-[10px] text-slate-500 space-y-1">
              <span className="block">
                Defaults: <strong className="text-slate-400">Optimist</strong>,{" "}
                <strong className="text-slate-400">SG</strong>,{" "}
                <strong className="text-slate-400">Ranking</strong>. Non-ranking
                events do not affect Best 3 of 5 series scores.
              </span>
              {classImportNote(importMeta.boatClass) && (
                <span className="block text-amber-200/90">
                  {classImportNote(importMeta.boatClass)}
                </span>
              )}
            </p>
            <button
              type="button"
              onClick={() => void handleImportToDb()}
              disabled={!isSuperadmin || importBusy}
              className="sm:col-span-2 lg:col-span-4 rounded-full bg-orange-600 hover:bg-orange-500 disabled:opacity-40 px-4 py-2.5 text-xs font-bold text-white"
            >
              {importBusy
                ? `Importing… ${Math.round(importProgress)}%`
                : `Import ${fullImportRows.length} rows to database`}
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
