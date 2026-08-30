"use client";

import { useState } from "react";
import {
  Upload,
  AlertTriangle,
  CheckCircle,
} from "lucide-react";
import {
  parseRegattaResultRows,
  inferLikelyDnsRows,
  summarizeRegattaImport,
  type RegattaImportRow,
} from "@/lib/excel/parseRegattaResultsSheet";
import { parseRegattaTitle } from "@/lib/excel/parseRegattaTitle";
import { parseApi, apiErr, apiStr } from "@/components/admin/parseApi";
import type {
  ImportPossibleDuplicate,
  RegattaImportReview,
} from "@/types/import";
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
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { errorMessage } from "@/lib/errors";
import { MAX_IMPORT_ROWS } from "@/lib/importLimits";

type Props = {
  isSuperadmin: boolean;
  onSailorsUpdated?: (sailors: SailorAdmin[]) => void;
  onRegattaUpserted?: (regatta: RegattaAdmin) => void;
  onResultsUpdated?: (results: ResultAdmin[]) => void;
  /** Refetch all admin lists after a successful import. */
  onImportComplete?: () => void;
};

async function loadXlsx() {
  const moduleUrl = "/vendor/xlsx/xlsx.mjs";
  return (await import(
    /* webpackIgnore: true */ moduleUrl
  )) as typeof import("xlsx");
}

const MAX_IMPORT_FILE_BYTES = 15 * 1024 * 1024;

type RegattaImportMeta = {
  name: string;
  date: string;
  division: string;
  fleetSize: number;
  boatClass: string;
  geography: string;
  countsForRanking: boolean;
  raceCount: string | number;
};

type PendingRegattaReview = {
  review: RegattaImportReview;
  rows: RegattaImportRow[];
  meta: RegattaImportMeta;
};

/**
 * Regatta Excel import tab (self-contained state + handlers).
 */
export function AdminRegattaImport({
  isSuperadmin,
  onSailorsUpdated,
  onRegattaUpserted,
  onResultsUpdated,
  onImportComplete,
}: Props) {
  const { toast } = useFeedback();
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
  const [pendingReview, setPendingReview] = useState<PendingRegattaReview | null>(null);
  const [fullImportRows, setFullImportRows] = useState<RegattaImportRow[]>([]);
  const [pdfScreenshots, setPdfScreenshots] = useState<
    { pageNumber: number; dataUrl: string }[]
  >([]);
  const [importMeta, setImportMeta] = useState<RegattaImportMeta>({
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

  const handlePdf = async (file: File) => {
    setImportBusy(true);
    setImportProgress(10);
    setImportStatus(`Rendering and reading “${file.name}”…`);
    setImportPossibleDuplicates([]);
    setNationalityFlags([]);
    setPendingReview(null);
    try {
      const { readRegattaPdf } = await import("@/lib/pdf/readRegattaPdf");
      setImportProgress(30);
      const parsed = await readRegattaPdf(file, (progress) => {
        if (progress.phase === "rendering") {
          setImportProgress(
            10 + Math.round(((progress.pageNumber - 1) / progress.pageCount) * 20)
          );
          return;
        }
        setImportStatus(
          `This PDF contains images rather than selectable text. Running OCR on page ${progress.pageNumber} of ${progress.pageCount}…`
        );
        const completedPages = progress.pageNumber - 1 + progress.progress;
        setImportProgress(30 + Math.round((completedPages / progress.pageCount) * 50));
      });
      if (!parsed.rows.length) {
        throw new Error(
          "No result rows were found. This PDF must use a Sailwave-style results table with Rank, Name, race, Total, and Nett columns."
        );
      }
      setImportProgress(85);
      const title = parseRegattaTitle(file.name);
      const unnamedNote = parsed.unnamedEntries
        ? ` ${parsed.unnamedEntries} published entr${parsed.unnamedEntries === 1 ? "y has" : "ies have"} no sailor name and will count toward fleet size but will not create a profile.`
        : "";
      const nextMeta = {
        ...importMeta,
        name: title.name || importMeta.name || title.stem,
        date: title.date || importMeta.date,
        division: title.division || importMeta.division,
        boatClass: title.boatClass || importMeta.boatClass,
        fleetSize: parsed.entries || parsed.rows.length,
        raceCount: parsed.raceCount || "",
      };
      setFullImportRows(parsed.rows);
      setPdfScreenshots(parsed.screenshots);
      setImportMeta(nextMeta);
      if (!title.date) {
        setImportProgress(100);
        setImportStatus(
          `${parsed.usedOcr ? "OCR extracted" : "Extracted"} ${parsed.rows.length} named competitors and ${parsed.raceCount} races.${unnamedNote} Add the event date below, then select Import.`
        );
        toast.info(
          "Results were extracted, but the filename has no valid date. Add the event date before importing."
        );
        return;
      }
      const likelyDnsCount = parsed.rows.filter((row) => row.isDns).length;
      if (parsed.usedOcr) {
        setImportProgress(100);
        setImportStatus(
          `OCR extracted ${parsed.rows.length} named competitors and ${parsed.raceCount} races.${unnamedNote} Review names, sail numbers, race scores, and DNS suggestions below, then select Import.`
        );
        toast.info(
          "OCR extraction is ready for review. Confirm the names and scores before importing."
        );
        return;
      }
      if (likelyDnsCount > 0) {
        setImportProgress(100);
        setImportStatus(
          `${parsed.usedOcr ? "OCR extracted" : "Extracted"} ${parsed.rows.length} named competitors and ${parsed.raceCount} races.${unnamedNote} Review ${likelyDnsCount} likely DNS row${likelyDnsCount === 1 ? "" : "s"} and the ranking scores below, then select Import.`
        );
        toast.info(
          "Likely non-starters were detected. Confirm or edit their DNS status and ranking score before importing."
        );
        return;
      }
      setImportStatus(
        `${parsed.usedOcr ? "OCR extracted" : "Extracted"} ${parsed.rows.length} named competitors and ${parsed.raceCount} races.${unnamedNote} Uploading directly to SailorPath…`
      );
      await handleImportToDb(parsed.rows, nextMeta);
    } catch (error) {
      setImportProgress(0);
      setImportStatus(null);
      setFullImportRows([]);
      setPdfScreenshots([]);
      toast.error(errorMessage(error, "Failed to read PDF"));
    } finally {
      setImportBusy(false);
      window.setTimeout(() => setImportProgress(0), 800);
    }
  };

  const handleFile = (file: File) => {
    if (file.size > MAX_IMPORT_FILE_BYTES) {
      toast.error("File is too large. The upload limit is 15 MB.");
      return;
    }
    if (file.type === "application/pdf" || /\.pdf$/i.test(file.name)) {
      void handlePdf(file);
      return;
    }
    setImportBusy(true);
    setImportProgress(5);
    setImportStatus(`Reading “${file.name}”…`);
    setImportPossibleDuplicates([]);
    setNationalityFlags([]);
    setPendingReview(null);
    setPdfScreenshots([]);
    const reader = new FileReader();
    reader.onprogress = (ev) => {
      if (ev.lengthComputable && ev.total > 0) {
        setImportProgress(Math.min(40, Math.round((ev.loaded / ev.total) * 40)));
      }
    };
    reader.onload = async (ev) => {
      try {
        setImportProgress(45);
        setImportStatus("Parsing spreadsheet…");
        const { read, utils } = await loadXlsx();
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
        const mapped = inferLikelyDnsRows(parseRegattaResultRows(json));
        const parsedRaceCount = Math.max(
          0,
          ...mapped.flatMap((row) =>
            row.races.map((race) => race.raceNumber)
          )
        );
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
          raceCount: parsedRaceCount || m.raceCount,
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
        toast.error(
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
      toast.error("Failed to read file");
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

  const updateImportRow = (
    index: number,
    patch: Partial<Pick<RegattaImportRow, "name" | "rank" | "isDns">>
  ) => {
    setFullImportRows((rows) =>
      rows.map((row, rowIndex) =>
        rowIndex === index ? { ...row, ...patch } : row
      )
    );
    setPendingReview(null);
    setImportStatus(
      "Result edits are ready. Select Import to validate and save them."
    );
  };

  const refreshListsAfterImport = async (regatta?: RegattaAdmin | null) => {
    if (regatta) onRegattaUpserted?.(regatta);
    try {
      const list = await fetch("/api/admin/sailors?all=1", {
        credentials: "include",
      }).then((r) => r.json());
      if (list.sailors) onSailorsUpdated?.(list.sailors);
    } catch {
      /* ignore */
    }
    try {
      // Prefer the imported event only — avoids pulling every result row.
      const resultsUrl = regatta?.id
        ? `/api/admin/results?regattaId=${encodeURIComponent(regatta.id)}`
        : "/api/admin/results?all=1";
      const rRes = await fetch(resultsUrl, { credentials: "include" });
      if (rRes.ok) {
        const rData = await rRes.json();
        if (rData.results) onResultsUpdated?.(rData.results);
      }
    } catch {
      /* optional */
    }
    onImportComplete?.();
  };

  /**
   * When the import POST times out / drops, the browser reports "Failed to fetch"
   * even though rows may already be committed. Check whether the regatta landed.
   */
  const recoverAfterNetworkError = async (
    meta = importMeta
  ): Promise<{
    ok: boolean;
    message: string;
    regatta?: RegattaAdmin;
  }> => {
    try {
      const res = await fetch("/api/admin/regattas?all=1", {
        credentials: "include",
      });
      if (!res.ok) return { ok: false, message: "" };
      const data = await res.json();
      const list: RegattaAdmin[] = data.regattas || [];
      const name = meta.name.trim().toLowerCase();
      const date = meta.date.slice(0, 10);
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
        const rRes = await fetch(
          `/api/admin/results?regattaId=${encodeURIComponent(reg.id)}`,
          { credentials: "include" }
        );
        if (rRes.ok) {
          const rData = await rRes.json();
          const results: ResultAdmin[] = rData.results || [];
          resultCount = results.length;
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

  async function handleImportToDb(
    rowsOverride?: RegattaImportRow[],
    metaOverride?: RegattaImportMeta,
    confirmedRegattaId?: string
  ) {
    const rowsToImport = rowsOverride || fullImportRows;
    const meta = metaOverride || importMeta;
    if (!isSuperadmin) {
      toast.error("Error: 403 Forbidden. Only Superadmins can import.");
      return;
    }
    if (!rowsToImport.length || !meta.name || !meta.date) {
      toast.error("Parse a file and set regatta name + date first.");
      return;
    }
    if (rowsToImport.length > MAX_IMPORT_ROWS) {
      toast.error(
        `Too many rows (${rowsToImport.length}). Split the sheet — max ${MAX_IMPORT_ROWS} per import.`
      );
      return;
    }
    setImportBusy(true);
    setImportProgress(8);
    setImportStatus(
      `Importing ${rowsToImport.length} rows to database…`
    );
    setImportPossibleDuplicates([]);
    if (!confirmedRegattaId) setPendingReview(null);
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
          regattaName: meta.name,
          eventDate: meta.date,
          division: meta.division,
          totalFleetSize: meta.fleetSize || rowsToImport.length,
          boatClass: meta.boatClass,
          geography: meta.geography,
          countsForRanking: meta.countsForRanking,
          raceCount:
            meta.raceCount === "" || meta.raceCount == null
              ? null
              : Number(meta.raceCount),
          rows: rowsToImport,
          createMissing: true,
          confirmedRegattaId: confirmedRegattaId || null,
          confirmedReviewToken:
            confirmedRegattaId && pendingReview?.review.regattaId === confirmedRegattaId
              ? pendingReview.review.reviewToken
              : null,
        }),
      });
      setImportProgress(78);
      setImportStatus("Processing server response…");
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Import failed"));

      if (data.requiresConfirmation === true && data.review && typeof data.review === "object") {
        const review = data.review as RegattaImportReview;
        setPendingReview({
          review,
          rows: rowsToImport.map((row) => ({
            ...row,
            races: row.races.map((race) => ({ ...race })),
          })),
          meta: { ...meta },
        });
        setImportProgress(100);
        setImportStatus(
          `Review required before updating “${review.regattaName}”. No database changes have been made.`
        );
        return;
      }

      setImportProgress(88);
      setImportStatus("Refreshing sailors & results…");
      const importedRegatta =
        data.regatta && typeof data.regatta === "object"
          ? (data.regatta as RegattaAdmin)
          : null;
      await refreshListsAfterImport(importedRegatta);
      setImportProgress(100);

      {
        const hint = apiStr(data, "hint");
        const samples = Array.isArray(data.errorSamples)
          ? data.errorSamples.slice(0, 3)
          : [];
        const extra = [hint, ...samples]
          .filter(Boolean)
          .map(String)
          .join("\n");
        const message = apiStr(data, "message");
        if (extra) {
          toast.info(
            `${message || "Import finished with issues"}\n\n${extra}`
          );
        } else {
          toast.success(message || "Import complete");
        }
      }
      const unmatchedCount = Array.isArray(data.unmatched)
        ? data.unmatched.length
        : 0;
      const dupes = Array.isArray(data.possibleDuplicates)
        ? (data.possibleDuplicates as ImportPossibleDuplicate[])
        : [];
      setImportPossibleDuplicates(dupes);
      const natFlags = Array.isArray(data.nationalityFlags)
        ? (data.nationalityFlags as Array<{
            sailorId: string;
            name: string;
            previous: string | null;
            imported: string | null;
            raw: string | null;
            action: string;
            detail: string;
          }>)
        : [];
      setNationalityFlags(natFlags);
      const message = apiStr(data, "message") || "Import complete";
      setImportStatus(
        message +
          (unmatchedCount
            ? ` · ${unmatchedCount} unmatched name(s) skipped — add/fix sailor names and re-import.`
            : "") +
          (natFlags.length
            ? ` · ${natFlags.length} nationality flag(s) — review below.`
            : "")
      );
      setPendingReview(null);
    } catch (e: unknown) {
      const msg = errorMessage(e, "Import failed");
      const isNetworkDrop =
        /failed to fetch|networkerror|load failed|network request failed|aborted|timeout/i.test(
          msg
        );

      if (isNetworkDrop) {
        setImportProgress(85);
        setImportStatus("Connection dropped — checking if import saved…");
        const recovered = await recoverAfterNetworkError(meta);
        if (recovered.ok) {
          setImportProgress(100);
          setImportStatus(recovered.message);
          toast.info(recovered.message);
          return;
        }
        setImportProgress(0);
        setImportStatus(null);
        setImportPossibleDuplicates([]);
        setNationalityFlags([]);
        toast.error(
          "Failed to fetch — the server may have timed out after saving. " +
            "Check Database → Regattas / Results before re-importing (re-import is safe and upserts)."
        );
        return;
      }

      setImportProgress(0);
      setImportStatus(null);
      setImportPossibleDuplicates([]);
      setNationalityFlags([]);
      toast.error(msg);
    } finally {
      window.clearInterval(pulse);
      setImportBusy(false);
      setTimeout(() => setImportProgress(0), 1200);
    }
  }

  return (
    <div className="w-full min-w-0 space-y-4 sm:space-y-6 overflow-x-clip">
      <div className="glass-panel rounded-2xl sm:rounded-3xl p-4 sm:p-6 lg:p-8 border border-white/5 w-full">
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
            Drop a regatta results PDF, Excel, or CSV file here
          </p>
          <div className="mb-4 max-w-3xl space-y-2 text-xs leading-relaxed text-slate-500">
            <p>
              Supports .pdf, .xlsx, .xls, and .csv. SailorPath reads PDFs and
              imports them directly when the filename contains the event date.
              Existing regattas always pause for discrepancy review before any
              result is replaced.
            </p>
            <p>
              Tied ranks are allowed. Repeated bottom ranks are flagged as
              likely DNS so you can confirm the status and edit the ranking
              score before import. Required: sailor name, plus rank or nett when
              available. Optional: race scores, total score, club, school,
              nationality, sail number, and birth year / DOB.
            </p>
            <p>
              Profile details follow the most recent regatta date. Sail numbers
              remain class-specific, and Optimist rankings exclude other boat
              classes. Unmatched sailors are added as{" "}
              <strong className="text-slate-300">guests</strong> and stay off the
              SG series until admitted in Database.
            </p>
          </div>
          <label className="rounded-full bg-slate-800 border border-white/5 px-4 py-2 text-xs font-bold text-white hover:bg-slate-700 transition-all cursor-pointer">
            Select File
            <input
              type="file"
              onChange={handleFileChange}
              className="hidden"
              accept=".pdf,.xlsx,.xls,.csv,application/pdf"
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

        {pendingReview && (
          <div className="mt-5 rounded-2xl border border-amber-400/35 bg-amber-500/8 p-4 space-y-4">
            <div className="flex items-start gap-2">
              <AlertTriangle className="h-5 w-5 shrink-0 text-amber-300 mt-0.5" />
              <div className="min-w-0">
                <p className="text-sm font-bold text-amber-100">
                  Review discrepancies before replacing current results
                </p>
                <p className="text-[11px] text-amber-100/70 mt-1">
                  The upload matched “{pendingReview.review.regattaName}”. No database
                  changes have been made. Confirming makes this document authoritative:
                  changed values are updated and competitors or races missing from the
                  upload are removed from this regatta.
                </p>
              </div>
            </div>

            <div className="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-7 gap-2">
              {[
                ["Sailors added", pendingReview.review.summary.addedSailors],
                ["Sailors removed", pendingReview.review.summary.removedSailors],
                ["Results changed", pendingReview.review.summary.changedResults],
                ["Races added", pendingReview.review.summary.addedRaces],
                ["Races removed", pendingReview.review.summary.removedRaces],
                ["Races changed", pendingReview.review.summary.changedRaces],
                ["Event fields", pendingReview.review.summary.metadataChanges],
              ].map(([label, count]) => (
                <div key={String(label)} className="rounded-lg border border-white/10 bg-slate-950/60 px-2.5 py-2">
                  <p className="text-lg font-black tabular-nums text-white">{count}</p>
                  <p className="text-[9px] uppercase tracking-wide text-slate-500">{label}</p>
                </div>
              ))}
            </div>

            <div className="max-h-72 overflow-auto rounded-xl border border-white/10">
              <table className="min-w-[680px] w-full text-left text-[11px]">
                <thead className="sticky top-0 bg-slate-950 text-slate-500 uppercase tracking-wide text-[9px]">
                  <tr>
                    <th className="px-3 py-2">Type</th>
                    <th className="px-3 py-2">Sailor</th>
                    <th className="px-3 py-2">Field</th>
                    <th className="px-3 py-2">Current</th>
                    <th className="px-3 py-2">Uploaded</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5 bg-slate-900/70 text-slate-200">
                  {pendingReview.review.discrepancies.map((item, index) => (
                    <tr key={`${item.kind}-${item.sailorName || "event"}-${item.field}-${index}`}>
                      <td className="px-3 py-2 whitespace-nowrap text-amber-300">{item.kind.replaceAll("-", " ")}</td>
                      <td className="px-3 py-2 font-semibold text-white">{item.sailorName || "Regatta"}</td>
                      <td className="px-3 py-2">{item.field}</td>
                      <td className="px-3 py-2 font-mono text-rose-200">{item.before ?? "—"}</td>
                      <td className="px-3 py-2 font-mono text-emerald-200">{item.after ?? "—"}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            {pendingReview.review.truncated && (
              <p className="text-[10px] text-amber-200/70">
                Showing the first 500 differences. The totals above include all detected differences.
              </p>
            )}

            <div className="flex flex-wrap justify-end gap-2">
              <button
                type="button"
                disabled={importBusy}
                onClick={() => {
                  setPendingReview(null);
                  setImportStatus("Update cancelled. Current regatta results were not changed.");
                }}
                className="rounded-full border border-white/15 px-4 py-2 text-xs font-bold text-slate-300 hover:bg-white/5 disabled:opacity-50"
              >
                Cancel update
              </button>
              <button
                type="button"
                disabled={importBusy}
                onClick={() => {
                  const pending = pendingReview;
                  void handleImportToDb(pending.rows, pending.meta, pending.review.regattaId);
                }}
                className="rounded-full bg-amber-500 px-4 py-2 text-xs font-black text-slate-950 hover:bg-amber-400 disabled:opacity-50"
              >
                Confirm and replace results
              </button>
            </div>
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
          <div className="mt-6 w-full space-y-5 text-left">
            {pdfScreenshots.length > 0 && (
              <div className="space-y-3">
                <div>
                  <p className="text-xs font-bold text-white">PDF page review</p>
                  <p className="text-[11px] text-slate-500">
                    Source pages remain on this screen so you can verify the
                    extracted results and any proposed update.
                  </p>
                </div>
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-3">
                  {pdfScreenshots.map((page) => (
                    <figure key={page.pageNumber} className="overflow-hidden rounded-xl border border-white/10 bg-white">
                      {/* The image is generated locally from the admin-selected PDF. */}
                      {/* eslint-disable-next-line @next/next/no-img-element */}
                      <img src={page.dataUrl} alt={`PDF page ${page.pageNumber}`} className="h-auto w-full" />
                      <figcaption className="bg-slate-950 px-3 py-1.5 text-[10px] text-slate-400">
                        Page {page.pageNumber}
                      </figcaption>
                    </figure>
                  ))}
                </div>
              </div>
            )}

            <div>
              <p className="mb-2 text-[11px] text-slate-500">
                Review extracted ranks below. DNS suggestions are highlighted;
                the ranking score remains editable and does not have to equal
                fleet size + 1.
              </p>
            </div>
            <div className="max-h-[32rem] overflow-auto rounded-xl border border-white/10">
              <table className="min-w-full text-[11px]">
                <thead className="sticky top-0 z-10 bg-slate-950 text-slate-400">
                  <tr>
                    <th className="px-3 py-2 text-left">Rank / ranking score</th>
                    <th className="px-3 py-2 text-center">DNS</th>
                    <th className="px-3 py-2 text-left">Sail</th>
                    <th className="px-3 py-2 text-left">Name</th>
                    {Array.from(
                      { length: Number(importMeta.raceCount) || 0 },
                      (_, index) => (
                        <th key={index} className="px-3 py-2 text-right">R{index + 1}</th>
                      )
                    )}
                    <th className="px-3 py-2 text-right">Nett</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5 bg-slate-900/60 text-slate-200">
                  {fullImportRows.map((row, index) => (
                    <tr
                      key={`${row.name}-${row.sailNumber || "no-sail"}-${index}`}
                      className={row.isDns ? "bg-amber-500/[0.07]" : undefined}
                    >
                      <td className="px-3 py-2">
                        <input
                          type="number"
                          min={1}
                          value={row.rank ?? ""}
                          disabled={importBusy}
                          onChange={(event) => {
                            const value = event.target.value;
                            updateImportRow(index, {
                              rank: value === "" ? null : Number(value),
                            });
                          }}
                          aria-label={`Ranking score for ${row.name}`}
                          className="w-20 rounded-md border border-white/10 bg-slate-950 px-2 py-1 font-mono text-white disabled:opacity-50"
                        />
                      </td>
                      <td className="px-3 py-2 text-center">
                        <input
                          type="checkbox"
                          checked={row.isDns}
                          disabled={importBusy}
                          onChange={(event) => {
                            const isDns = event.target.checked;
                            updateImportRow(index, {
                              isDns,
                              ...(isDns && row.rank == null
                                ? { rank: importMeta.fleetSize + 1 }
                                : {}),
                            });
                          }}
                          aria-label={`${row.name} did not start`}
                          className="h-4 w-4 rounded border-slate-700 bg-slate-900 text-amber-500 focus:ring-amber-500"
                        />
                      </td>
                      <td className="px-3 py-2 whitespace-nowrap">{row.sailNumber || "—"}</td>
                      <td className="px-3 py-2 whitespace-nowrap font-medium">
                        <input
                          type="text"
                          value={row.name}
                          disabled={importBusy}
                          onChange={(event) => {
                            updateImportRow(index, { name: event.target.value });
                          }}
                          aria-label={`Sailor name for row ${index + 1}`}
                          className="min-w-44 rounded-md border border-white/10 bg-slate-950 px-2 py-1 text-white disabled:opacity-50"
                        />
                      </td>
                      {Array.from(
                        { length: Number(importMeta.raceCount) || 0 },
                        (_, raceIndex) => {
                          const race = row.races.find((item) => item.raceNumber === raceIndex + 1);
                          return <td key={raceIndex} className="px-3 py-2 text-right whitespace-nowrap">{race?.rawValue || "—"}</td>;
                        }
                      )}
                      <td className="px-3 py-2 text-right">{row.nett ?? "—"}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

          <div className="w-full grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
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
          </div>
        )}
      </div>
    </div>
  );
}
