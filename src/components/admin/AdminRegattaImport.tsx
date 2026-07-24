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
import { parseApi } from "@/components/admin/parseApi";
import type { ImportPossibleDuplicate } from "@/types/import";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type { SailorAdmin } from "@/types/sailor";

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
  const [importPossibleDuplicates, setImportPossibleDuplicates] = useState<
    ImportPossibleDuplicate[]
  >([]);
  const [fullImportRows, setFullImportRows] = useState<RegattaImportRow[]>([]);
  const [importMeta, setImportMeta] = useState({
    name: "",
    date: new Date().toISOString().slice(0, 10),
    division: "Gold",
    fleetSize: 50,
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
    const reader = new FileReader();
    reader.onload = (ev) => {
      const data = ev.target?.result;
      const workbook = read(data, { type: "array" });
      const sheetName = workbook.SheetNames[0];
      const sheet = workbook.Sheets[sheetName];
      const json = utils.sheet_to_json<Record<string, unknown>>(sheet, {
        defval: "",
        raw: false,
      });
      const mapped = parseRegattaResultRows(json);
      setFullImportRows(mapped);
      setImportPossibleDuplicates([]);
      setImportStatus(
        `Parsed ${mapped.length} competitor rows from “${sheetName}”` +
          summarizeRegattaImport(mapped) +
          `. Set division + date, then Import.`
      );
      setImportMeta((m) => ({
        ...m,
        name: m.name || file.name.replace(/\.[^.]+$/, "").replace(/_/g, " "),
        division: /silver/i.test(file.name)
          ? "Silver"
          : /gold/i.test(file.name)
            ? "Gold"
            : m.division,
        fleetSize: mapped.length || m.fleetSize,
      }));
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

  const handleImportToDb = async () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can import.");
      return;
    }
    if (!fullImportRows.length || !importMeta.name || !importMeta.date) {
      alert("Parse a file and set regatta name + date first.");
      return;
    }
    setImportStatus("Importing…");
    setImportPossibleDuplicates([]);
    try {
      const res = await fetch("/api/admin/import", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          regattaName: importMeta.name,
          eventDate: importMeta.date,
          division: importMeta.division,
          totalFleetSize: importMeta.fleetSize || fullImportRows.length,
          rows: fullImportRows,
          createMissing: true,
        }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || data.message || "Import failed");

      try {
        const list = await fetch("/api/admin/sailors").then((r) => r.json());
        if (list.sailors) onSailorsUpdated?.(list.sailors);
      } catch {
        /* ignore */
      }

      if (data.regatta) onRegattaUpserted?.(data.regatta);

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
      setImportStatus(
        (data.message || "Import complete") +
          (unmatchedCount
            ? ` · ${unmatchedCount} unmatched name(s) skipped — add/fix sailor names and re-import.`
            : "")
      );
      try {
        const rRes = await fetch("/api/admin/results");
        if (rRes.ok) {
          const rData = await rRes.json();
          if (rData.results) onResultsUpdated?.(rData.results);
        }
      } catch {
        /* optional */
      }
    } catch (e: unknown) {
      setImportStatus(null);
      setImportPossibleDuplicates([]);
      alert(e instanceof Error ? e.message : "Import failed");
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
            Birth Year / DOB — when present, sailor profiles are updated.
            Unmatched names become{" "}
            <strong className="text-slate-300">guests</strong> (not on
            Gold/Silver rankings until you admit them as Silver in Database).
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

        {importStatus && (
          <div className="mt-6 flex items-center gap-2 text-xs font-bold text-emerald-400 justify-center text-center max-w-3xl mx-auto">
            <CheckCircle className="h-4 w-4 text-emerald-500 shrink-0" />
            {importStatus}
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
            <label className="text-xs text-slate-400">
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
              Division
              <select
                className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                value={importMeta.division}
                onChange={(e) =>
                  setImportMeta((m) => ({ ...m, division: e.target.value }))
                }
              >
                <option value="Gold">Gold</option>
                <option value="Silver">Silver</option>
                <option value="Both">Both</option>
              </select>
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
            <button
              type="button"
              onClick={() => void handleImportToDb()}
              disabled={!isSuperadmin}
              className="sm:col-span-2 rounded-full bg-orange-600 hover:bg-orange-500 disabled:opacity-40 px-4 py-2.5 text-xs font-bold text-white"
            >
              Import {fullImportRows.length} rows to database
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
