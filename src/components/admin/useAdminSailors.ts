"use client";

import { useState, useEffect, useMemo, type Dispatch, type SetStateAction } from "react";
import { natSquadFieldForPeriod } from "@/lib/ranking";
import { findDuplicateSailorPairs } from "@/lib/nameMatch";
import {
  DB_COLS_STORAGE,
  defaultDbColVisible,
} from "@/components/admin/adminConstants";
import { parseApi, apiErr, apiStr, apiNum } from "@/components/admin/parseApi";
import { emptySailorForm } from "@/components/admin/adminForms";
import { mergeSailorsClient } from "@/components/admin/mergeSailorsClient";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { birthYear } from "@/lib/age";
import { currentPeriodFromSgToday, isHalfBoundaryYmd } from "@/lib/datesSg";
import { errorMessage } from "@/lib/errors";
import {
  isInSgSeries,
  seriesMembershipLabel,
} from "@/lib/seriesMembership";
import type { SailorAdmin } from "@/types/sailor";
import type { ResultAdmin } from "@/types/result";

type UseAdminSailorsArgs = {
  isSuperadmin: boolean;
  sailorList: SailorAdmin[];
  setSailorList: Dispatch<SetStateAction<SailorAdmin[]>>;
  resultsList: ResultAdmin[];
  setResultsList: Dispatch<SetStateAction<ResultAdmin[]>>;
  /** Included so best3 refreshes when regatta set changes. */
  regattaListLength: number;
  refreshResultsList: (opts?: { regattaId?: string }) => Promise<void>;
  /** Competitions modal open — sailors clears editingSailorId then delegates. */
  openSailorResultsBase: (sailorId: string) => void | Promise<void>;
  competitionsSailorId: string | null;
  setCompetitionsSailorId: Dispatch<SetStateAction<string | null>>;
  /** Refetch sailors (and results when deletes cascade) from the server. */
  invalidateSailors?: () => void;
  invalidateResults?: () => void;
};

/**
 * Sailors Database sub-tab: filters, sort, columns, selection, duplicates,
 * bulk ops, form CRUD, best3, empty-series cleanup, nationality backfill.
 */
export function useAdminSailors({
  isSuperadmin,
  sailorList,
  setSailorList,
  resultsList,
  setResultsList,
  regattaListLength,
  refreshResultsList,
  openSailorResultsBase,
  competitionsSailorId,
  setCompetitionsSailorId,
  invalidateSailors,
  invalidateResults,
}: UseAdminSailorsArgs) {
  const { toast, confirm } = useFeedback();
  const [ignoredDuplicateKeys, setIgnoredDuplicateKeys] = useState<Set<string>>(
    () => {
      if (typeof window === "undefined") return new Set();
      try {
        const raw = localStorage.getItem("sailorpath_ignored_duplicates");
        const arr = raw ? (JSON.parse(raw) as string[]) : [];
        return new Set(arr);
      } catch {
        return new Set();
      }
    }
  );

  const [selectedSailors, setSelectedSailors] = useState<string[]>([]);
  const [bulkField, setBulkField] = useState<string>("");
  const [bulkValue, setBulkValue] = useState<string>("");
  const [bulkStatus, setBulkStatus] = useState<string | null>(null);

  const [dbSearch, setDbSearch] = useState("");
  const [dbFleetFilter, setDbFleetFilter] = useState<string>("all");
  const [dbSquadFilter, setDbSquadFilter] = useState<string>("all");
  const [dbColVisible, setDbColVisible] = useState<Record<string, boolean>>(
    defaultDbColVisible
  );
  const [dbColPickerOpen, setDbColPickerOpen] = useState(false);
  const [dbSortKey, setDbSortKey] = useState<string>("name");
  const [dbSortDir, setDbSortDir] = useState<"asc" | "desc">("asc");
  const [best3BySailor, setBest3BySailor] = useState<Record<string, number>>(
    {}
  );
  const [editingSailorId, setEditingSailorId] = useState<string | null>(null);
  const [sailorForm, setSailorForm] = useState(emptySailorForm);
  const [showDuplicateFinder, setShowDuplicateFinder] = useState(false);

  const openSailorResults = (sailorId: string) => {
    setEditingSailorId(null);
    return openSailorResultsBase(sailorId);
  };

  // Column prefs
  useEffect(() => {
    try {
      const raw = localStorage.getItem(DB_COLS_STORAGE);
      if (raw) {
        const parsed = JSON.parse(raw) as Record<string, boolean>;
        setDbColVisible({ ...defaultDbColVisible(), ...parsed });
      }
    } catch {
      /* ignore */
    }
  }, []);

  useEffect(() => {
    try {
      localStorage.setItem(DB_COLS_STORAGE, JSON.stringify(dbColVisible));
    } catch {
      /* ignore */
    }
  }, [dbColVisible]);

  // Best 3 of 5 for current SG half (Gold + Silver)
  useEffect(() => {
    if (sailorList.length === 0) {
      setBest3BySailor({});
      return;
    }
    let cancelled = false;
    (async () => {
      try {
        const cur = currentPeriodFromSgToday();
        const halfQ = encodeURIComponent(cur.half);
        const [g, s] = await Promise.all([
          fetch(
            `/api/rankings?fleet=Gold&year=${cur.year}&half=${halfQ}`
          ).then((r) => r.json()),
          fetch(
            `/api/rankings?fleet=Silver&year=${cur.year}&half=${halfQ}`
          ).then((r) => r.json()),
        ]);
        if (cancelled) return;
        const m: Record<string, number> = {};
        for (const row of [...(g.ranked || []), ...(s.ranked || [])]) {
          if (row?.id != null && row.overallScore != null) {
            m[row.id] = row.overallScore;
          }
        }
        setBest3BySailor(m);
      } catch {
        if (!cancelled) setBest3BySailor({});
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [sailorList, resultsList, regattaListLength]);

  const filteredDbSailors = sailorList.filter((s) => {
    const q = dbSearch.trim().toLowerCase();
    if (q) {
      const hay =
        `${s.name} ${s.sailNumber || ""} ${s.sailNumberIlca4 || ""} ${s.club || ""} ${s.school || ""} ${s.handle || ""}`.toLowerCase();
      if (!hay.includes(q)) return false;
    }
    if (dbFleetFilter !== "all") {
      const inSeries = isInSgSeries(s);
      const hasIlca =
        Boolean(String(s.sailNumberIlca4 || "").trim()) ||
        Boolean((s as { ilca4NationalList?: boolean }).ilca4NationalList);
      if (dbFleetFilter === "series" && !inSeries) return false;
      if (dbFleetFilter === "guest" && inSeries) return false;
      if (dbFleetFilter === "gold") {
        if (!inSeries || !s.goldEntryDate) return false;
      }
      if (dbFleetFilter === "silver") {
        if (!inSeries || s.goldEntryDate) return false;
      }
      if (dbFleetFilter === "ilca4" && !hasIlca) return false;
      if (dbFleetFilter === "dual") {
        const hasOpti =
          inSeries ||
          Boolean(s.goldEntryDate) ||
          Boolean(s.silverEntryDate) ||
          (Boolean(String(s.sailNumber || "").trim()) &&
            !/^SGP\s*0+$/i.test(String(s.sailNumber)));
        if (!hasIlca || !hasOpti) return false;
      }
    }
    if (dbSquadFilter !== "all") {
      const field = natSquadFieldForPeriod(currentPeriodFromSgToday());
      const periodVal = field
        ? (s as Record<string, unknown>)[field]
        : null;
      const sq =
        periodVal || s.natSquadStatusJul26 || s.nationalSquadStatus || "";
      if (String(sq) !== dbSquadFilter) return false;
    }
    return true;
  });

  const seriesLabelOf = (s: Parameters<typeof seriesMembershipLabel>[0]) =>
    seriesMembershipLabel(s);

  /** In SG Fleet with no gold/silver entry — cannot rank until stamped */
  const emptySeriesCount = useMemo(
    () =>
      sailorList.filter((s) => {
        const cf = String(s.currentFleet || "")
          .trim()
          .toLowerCase();
        const isSeriesTag =
          cf === "series" ||
          cf === "gold" ||
          cf === "silver" ||
          cf === "in sg fleet" ||
          cf === "member";
        if (!isSeriesTag) return false;
        return !s.goldEntryDate && !s.silverEntryDate;
      }).length,
    [sailorList]
  );

  const handleBackfillNationalityFromSail = async () => {
    const ok = await confirm({
      title: "Backfill nationality from sail numbers?",
      message:
        "Set nationality from sail number country codes (e.g. SGP 115 → SGP) for sailors who have no nationality yet.",
      confirmLabel: "Continue",
    });
    if (!ok) return;
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "backfillNationalityFromSail" }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Backfill failed"));
      invalidateSailors?.();
      toast.success(
        apiStr(data, "message") ||
          `Updated ${apiNum(data, "updated") ?? 0} sailors`
      );
    } catch (e: unknown) {
      toast.error(errorMessage(e, "Backfill failed"));
    }
  };

  const handleCleanupEmptySeries = async () => {
    if (!isSuperadmin) {
      toast.error("Only Superadmins can run this.");
      return;
    }
    const ok = await confirm({
      title: "Stamp empty Series sailors?",
      message: `Stamp silver entry (Singapore today) on ${emptySeriesCount} Series sailor(s) with no entry dates?`,
      confirmLabel: "Continue",
    });
    if (!ok) return;
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "stampEmptySeriesSilver" }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Cleanup failed"));
      invalidateSailors?.();
      toast.success(
        apiStr(data, "message") ||
          `Updated ${apiNum(data, "updated") ?? 0} sailors`
      );
    } catch (e: unknown) {
      toast.error(errorMessage(e, "Cleanup failed"));
    }
  };

  const duplicatePairs = useMemo(() => {
    const pairKey = (a: string, b: string) => [a, b].sort().join("|");
    return findDuplicateSailorPairs(
      sailorList.map((s) => ({
        id: s.id,
        name: s.name,
        sailNumber: s.sailNumber,
      })),
      0.6
    ).filter((p) => !ignoredDuplicateKeys.has(pairKey(p.a.id, p.b.id)));
  }, [sailorList, ignoredDuplicateKeys]);

  const ignoreDuplicatePair = (aId: string, bId: string) => {
    const key = [aId, bId].sort().join("|");
    setIgnoredDuplicateKeys((prev) => {
      const next = new Set(prev);
      next.add(key);
      try {
        localStorage.setItem(
          "sailorpath_ignored_duplicates",
          JSON.stringify([...next])
        );
      } catch {
        /* ignore */
      }
      return next;
    });
  };

  const sortedDbSailors = useMemo(() => {
    const rows = [...filteredDbSailors];
    const dir = dbSortDir === "asc" ? 1 : -1;
    const val = (s: SailorAdmin): string | number => {
      switch (dbSortKey) {
        case "name":
          return s.name || "";
        case "sailNumber":
          return s.sailNumber || "";
        case "series":
          return seriesLabelOf(s);
        case "best3":
          return best3BySailor[s.id] ?? 99999;
        case "gender":
          return s.gender || "";
        case "birthYear":
        case "age": {
          const y = birthYear(s.dob as string | null);
          return y == null ? 99999 : y;
        }
        case "club":
          return s.club || "";
        case "nationality":
          return s.nationality || "";
        case "school":
          return s.school || "";
        case "goldEntry":
          return s.goldEntryDate ? String(s.goldEntryDate) : "";
        case "silverEntry":
          return s.silverEntryDate ? String(s.silverEntryDate) : "";
        case "dropDate":
          return s.dropDate ? String(s.dropDate) : "";
        case "squadJan25":
          return s.natSquadStatusJan25 || "";
        case "squadJul25":
          return s.natSquadStatusJul25 || "";
        case "squadJan26":
          return s.natSquadStatusJan26 || "";
        case "squadJul26":
          return s.natSquadStatusJul26 || "";
        case "histJun24":
          return s.histRankingJun24 ?? 99999;
        case "histDec24":
          return s.histRankingDec24 ?? 99999;
        case "histJun25":
          return s.histRankingJun25 ?? 99999;
        case "histDec25":
          return s.histRankingDec25 ?? 99999;
        case "histJun26":
          return s.histRankingJun26 ?? 99999;
        case "worlds":
          return s.worlds != null ? String(s.worlds) : "";
        case "european":
          return s.european != null ? String(s.european) : "";
        case "asian":
          return s.asian != null ? String(s.asian) : "";
        case "seaGames":
          return s.seaGames != null ? String(s.seaGames) : "";
        default:
          return s.name || "";
      }
    };
    rows.sort((a, b) => {
      const av = val(a);
      const bv = val(b);
      if (typeof av === "number" && typeof bv === "number") {
        if (av !== bv) return (av - bv) * dir;
      } else {
        const c = String(av).localeCompare(String(bv), undefined, {
          numeric: true,
          sensitivity: "base",
        });
        if (c !== 0) return c * dir;
      }
      return String(a.name).localeCompare(String(b.name));
    });
    return rows;
  }, [filteredDbSailors, dbSortKey, dbSortDir, best3BySailor]);

  const toggleDbSort = (key: string) => {
    if (dbSortKey === key) setDbSortDir((d) => (d === "asc" ? "desc" : "asc"));
    else {
      setDbSortKey(key);
      setDbSortDir(key === "best3" ? "asc" : "asc");
    }
  };

  const colOn = (key: string) => dbColVisible[key] !== false;

  const toggleSelectSailor = (id: string) => {
    setSelectedSailors((prev) =>
      prev.includes(id) ? prev.filter((item) => item !== id) : [...prev, id]
    );
  };

  const toggleSelectAllVisible = () => {
    const ids = sortedDbSailors.map((s) => s.id);
    const allOn =
      ids.length > 0 && ids.every((id) => selectedSailors.includes(id));
    if (allOn) {
      setSelectedSailors((prev) => prev.filter((id) => !ids.includes(id)));
    } else {
      setSelectedSailors((prev) => Array.from(new Set([...prev, ...ids])));
    }
  };

  const handleApplyBulk = async () => {
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can update fleet properties."
      );
      return;
    }
    if (selectedSailors.length === 0) {
      toast.error("Please select at least one sailor to bulk edit.");
      return;
    }
    if (!bulkField) {
      toast.error("Please select a field to update.");
      return;
    }
    try {
      const res = await fetch("/api/admin/bulk", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorIds: selectedSailors,
          field: bulkField,
          value: bulkValue,
        }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Bulk update failed"));

      setSailorList((prev) =>
        prev.map((s) => {
          if (!selectedSailors.includes(s.id)) return s;
          let typedValue: string | number | null = bulkValue;
          const isNumeric = [
            "histRankingJun24",
            "histRankingDec24",
            "histRankingJun25",
            "histRankingDec25",
            "histRankingJun26",
            "weight",
          ].includes(bulkField);
          if (isNumeric)
            typedValue = bulkValue === "" ? null : parseInt(bulkValue) || null;
          else if (
            [
              "natSquadStatusJan25",
              "natSquadStatusJul25",
              "natSquadStatusJan26",
              "natSquadStatusJul26",
              "natSquadStatusJan27",
              "natSquadStatusJul27",
            ].includes(bulkField) &&
            bulkValue === "CLEAR"
          ) {
            typedValue = null;
          } else if (bulkValue === "") typedValue = null;
          const next = { ...s, [bulkField]: typedValue };
          if (
            bulkField === "natSquadStatusJul26" ||
            bulkField === "natSquadStatusJan27" ||
            bulkField === "natSquadStatusJul27"
          ) {
            next.nationalSquadStatus =
              typedValue == null ? null : String(typedValue);
          }
          return next;
        })
      );
      setBulkStatus(
        apiStr(data, "message") ||
          `Updated ${selectedSailors.length} sailors.`
      );
      setSelectedSailors([]);
      setBulkValue("");
      setTimeout(() => setBulkStatus(null), 3000);
      invalidateSailors?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    }
  };

  const handleMergeSailors = async () => {
    if (!isSuperadmin) {
      toast.error("Error: 403 Forbidden. Only Superadmins can merge sailors.");
      return;
    }
    if (selectedSailors.length !== 2) {
      toast.error("Select exactly two sailors (tick two checkboxes), then Merge.");
      return;
    }
    const [aId, bId] = selectedSailors;
    const a = sailorList.find((s) => s.id === aId);
    const b = sailorList.find((s) => s.id === bId);
    if (!a || !b) {
      toast.error("Could not find both sailors — refresh and try again.");
      return;
    }

    const score = (s: SailorAdmin) => {
      let n = 0;
      if (s.goldEntryDate) n += 5;
      if (s.silverEntryDate) n += 2;
      if (s.sailNumber && !/^SGP\s*0+$/i.test(s.sailNumber)) n += 3;
      if (s.dob) n += 1;
      if (s.club && s.club !== "N/A") n += 1;
      if (s.currentFleet) n += 2;
      if (s.nationalSquadStatus) n += 1;
      const resCount = resultsList.filter((r) => r.sailorId === s.id).length;
      n += resCount;
      return n;
    };
    let keep = a;
    let merge = b;
    if (score(b) > score(a)) {
      keep = b;
      merge = a;
    }

    const ok = await confirm({
      title: "Merge duplicate sailors?",
      message:
        `KEEP (profile retained):\n  ${keep.name} · ${keep.sailNumber || "—"}\n\n` +
        `DELETE after merge (results + aliases moved):\n  ${merge.name} · ${merge.sailNumber || "—"}\n\n` +
        `Results move to the kept sailor. On the same regatta, the better (lower) rank is kept.`,
      confirmLabel: "Merge",
      tone: "danger",
    });
    if (!ok) return;

    try {
      const data = await mergeSailorsClient({
        keepId: keep.id,
        mergeId: merge.id,
        setSailorList,
        setResultsList,
        refreshResultsList: () => refreshResultsList(),
      });
      setSelectedSailors([]);
      setBulkStatus(
        data.message ||
          `Merged ${merge.name} → ${keep.name} (${data.resultsMoved ?? 0} results moved).`
      );
      setTimeout(() => setBulkStatus(null), 6000);
      toast.success(
        `${data.message || "Merged"}\n\nResults moved: ${data.resultsMoved ?? 0}\n` +
          `Conflicts resolved: ${data.resultsMergedConflict ?? 0}\n` +
          `Conflicts kept (kept sailor better): ${data.resultsDroppedConflict ?? 0}`
      );
      invalidateSailors?.();
      invalidateResults?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e, "Merge failed"));
    }
  };

  /** ILCA ranking panel: merge a known keep/merge pair via shared client. */
  const handleMergePair = async (keepId: string, mergeId: string) => {
    const keep = sailorList.find((s) => s.id === keepId);
    const merge = sailorList.find((s) => s.id === mergeId);
    if (!keep || !merge) {
      toast.error("Sailors not found");
      return;
    }
    const ok = await confirm({
      title: "Merge ILCA 4 duplicates?",
      message: `KEEP: ${keep.name}\nDELETE: ${merge.name}\n\nResults and aliases move to keep.`,
      confirmLabel: "Merge",
      tone: "danger",
    });
    if (!ok) return;
    try {
      const data = await mergeSailorsClient({
        keepId,
        mergeId,
        setSailorList,
        setResultsList,
      });
      toast.success(data.message || `Merged ${merge.name} → ${keep.name}`);
      invalidateSailors?.();
      invalidateResults?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e, "Merge failed"));
    }
  };

  const handleBulkDelete = async () => {
    if (!isSuperadmin) {
      toast.error("Superadmin only");
      return;
    }
    if (selectedSailors.length === 0) {
      toast.error("Select at least one sailor to delete.");
      return;
    }
    const ok = await confirm({
      title: `Delete ${selectedSailors.length} sailor(s)?`,
      message:
        "Delete selected sailors and all their regatta results? This cannot be undone.",
      confirmLabel: "Delete",
      tone: "danger",
    });
    if (!ok) return;
    try {
      const res = await fetch("/api/admin/bulk", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "delete",
          sailorIds: selectedSailors,
        }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Bulk delete failed"));
      setSailorList((prev) =>
        prev.filter((s) => !selectedSailors.includes(s.id))
      );
      setResultsList((prev) =>
        prev.filter((r) => !selectedSailors.includes(r.sailorId))
      );
      setSelectedSailors([]);
      setBulkStatus(apiStr(data, "message") || "Deleted.");
      setTimeout(() => setBulkStatus(null), 4000);
      invalidateSailors?.();
      invalidateResults?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    }
  };

  const handleSaveSailor = async () => {
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!sailorForm.name || !sailorForm.sailNumber) {
      toast.error("Name and Sail Number are required.");
      return;
    }
    const existing = sailorList.find((s) => s.id === editingSailorId);
    const wantsGold = Boolean(sailorForm.goldEntryDate);
    const hasSilverPath =
      Boolean(sailorForm.silverEntryDate) ||
      Boolean(existing?.silverEntryDate) ||
      Boolean(existing?.goldEntryDate);
    if (wantsGold && !hasSilverPath) {
      toast.error(
        "Gold entry requires Silver history first. Set Silver entry date, save, then set Gold entry."
      );
      return;
    }
    if (
      sailorForm.goldEntryDate &&
      !isHalfBoundaryYmd(String(sailorForm.goldEntryDate))
    ) {
      toast.error(
        "Gold entry date must be 1 Jan or 1 Jul (half-year boundary), e.g. 2026-01-01 or 2026-07-01."
      );
      return;
    }
    if (
      sailorForm.dropDate &&
      !isHalfBoundaryYmd(String(sailorForm.dropDate))
    ) {
      toast.error(
        "Drop date must be 1 Jan or 1 Jul (half-year boundary), e.g. 2026-07-01."
      );
      return;
    }
    const dateOnly = (v: unknown) => {
      if (v == null || v === "") return null;
      const s = String(v);
      return /^\d{4}-\d{2}-\d{2}/.test(s) ? s.slice(0, 10) : s;
    };
    const payload = {
      name: sailorForm.name,
      handle: sailorForm.handle,
      sailNumber: sailorForm.sailNumber,
      sailNumberIlca4: sailorForm.sailNumberIlca4
        ? String(sailorForm.sailNumberIlca4).trim() || null
        : null,
      club: sailorForm.club,
      school: sailorForm.school ?? null,
      nationality: sailorForm.nationality || null,
      gender: sailorForm.gender,
      bio: sailorForm.bio || null,
      nationalSquadStatus:
        sailorForm.natSquadStatusJul27 ||
        sailorForm.natSquadStatusJan27 ||
        sailorForm.natSquadStatusJul26 ||
        sailorForm.nationalSquadStatus ||
        null,
      currentFleet: ["series", "gold", "silver"].includes(
        String(sailorForm.currentFleet || "").toLowerCase()
      )
        ? "Series"
        : "Guest",
      goldEntryDate: dateOnly(sailorForm.goldEntryDate),
      silverEntryDate: dateOnly(sailorForm.silverEntryDate),
      dropDate: dateOnly(sailorForm.dropDate),
      dob: dateOnly(sailorForm.dob),
      weight:
        sailorForm.weight === "" || sailorForm.weight == null
          ? null
          : sailorForm.weight,
      instagram: sailorForm.instagram || null,
      avatarUrl: sailorForm.avatarUrl || null,
      natSquadStatusJan25: sailorForm.natSquadStatusJan25 || null,
      natSquadStatusJul25: sailorForm.natSquadStatusJul25 || null,
      natSquadStatusJan26: sailorForm.natSquadStatusJan26 || null,
      natSquadStatusJul26: sailorForm.natSquadStatusJul26 || null,
      natSquadStatusJan27: sailorForm.natSquadStatusJan27 || null,
      natSquadStatusJul27: sailorForm.natSquadStatusJul27 || null,
      histRankingJun24: sailorForm.histRankingJun24 || null,
      histRankingDec24: sailorForm.histRankingDec24 || null,
      histRankingJun25: sailorForm.histRankingJun25 || null,
      histRankingDec25: sailorForm.histRankingDec25 || null,
      histRankingJun26: sailorForm.histRankingJun26 || null,
      worlds: sailorForm.worlds || null,
      european: sailorForm.european || null,
      asian: sailorForm.asian || null,
      seaGames: sailorForm.seaGames || null,
    };
    try {
      if (editingSailorId === "new") {
        const res = await fetch("/api/admin/sailors", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(apiErr(data, "Create failed"));
        const sailor = data.sailor as SailorAdmin;
        setSailorList((prev) => [...prev, sailor]);
        const warning = apiStr(data, "warning");
        toast.success(
          warning
            ? `Sailor created. Note: ${warning}`
            : "Sailor created successfully!"
        );
      } else {
        const res = await fetch("/api/admin/sailors", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...payload, id: editingSailorId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(apiErr(data, "Update failed"));
        const sailor = data.sailor as SailorAdmin;
        setSailorList((prev) =>
          prev.map((s) => (s.id === editingSailorId ? sailor : s))
        );
        const warning = apiStr(data, "warning");
        toast.success(
          warning
            ? `Sailor updated. Note: ${warning}`
            : "Sailor updated successfully!"
        );
      }
      invalidateSailors?.();
      setEditingSailorId(null);
    } catch (e: unknown) {
      toast.error(errorMessage(e, "Update failed"));
    }
  };

  const handleDeleteSailor = async (id: string) => {
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!id) {
      toast.error("Missing sailor id — refresh the page and try again.");
      return;
    }
    const ok = await confirm({
      title: "Delete this sailor?",
      message: "Their results will also be deleted.",
      confirmLabel: "Delete",
      tone: "danger",
    });
    if (!ok) return;
    try {
      const res = await fetch(
        `/api/admin/sailors?id=${encodeURIComponent(id)}`,
        { method: "DELETE" }
      );
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Delete failed"));
      setSailorList((prev) => prev.filter((s) => s.id !== id));
      setResultsList((prev) => prev.filter((r) => r.sailorId !== id));
      invalidateSailors?.();
      invalidateResults?.();
      toast.success("Sailor deleted.");
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    }
  };

  const panelProps = {
    filteredDbSailors,
    sortedDbSailors,
    selectedSailors,
    setSelectedSailors,
    dbSearch,
    setDbSearch,
    dbFleetFilter,
    setDbFleetFilter,
    dbSquadFilter,
    setDbSquadFilter,
    setDbColVisible,
    dbColPickerOpen,
    setDbColPickerOpen,
    dbSortKey,
    dbSortDir,
    toggleDbSort,
    colOn,
    seriesLabelOf,
    best3BySailor,
    duplicatePairs,
    bulkField,
    setBulkField,
    bulkValue,
    setBulkValue,
    handleApplyBulk,
    handleBulkDelete,
    handleMergeSailors,
    toggleSelectSailor,
    toggleSelectAllVisible,
    editingSailorId,
    setEditingSailorId,
    sailorForm,
    setSailorForm,
    handleSaveSailor,
    handleDeleteSailor,
    showDuplicateFinder,
    setShowDuplicateFinder,
    ignoreDuplicatePair,
    bulkStatus,
    openSailorResults,
    competitionsSailorId,
    setCompetitionsSailorId,
    emptySeriesCount,
    onCleanupEmptySeries: handleCleanupEmptySeries,
    onBackfillNationalityFromSail: handleBackfillNationalityFromSail,
  };

  return {
    panelProps,
    editingSailorId,
    setEditingSailorId,
    handleMergePair,
  };
}
