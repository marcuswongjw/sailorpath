"use client";

import { useState, useEffect, useMemo } from "react";
import { read, utils } from "xlsx";
import {
  Upload,
  Database,
  FileSpreadsheet,
  AlertTriangle,
  UserCheck,
  Calendar,
  Grid,
  CheckCircle,
  RefreshCw,
  Save,
  Shield,
  Columns3,
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
  BarChart3,
} from "lucide-react";
import { getPercentileBadge } from "@/lib/ranking";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { findDuplicateSailorPairs } from "@/lib/nameMatch";
import {
  parseRegattaResultRows,
  summarizeRegattaImport,
  type RegattaImportRow,
} from "@/lib/excel/parseRegattaResultsSheet";
import { ClaimsAdminPanel } from "@/components/ClaimsAdminPanel";
import { PromoteAdminPanel } from "@/components/PromoteAdminPanel";
import { SupportInboxPanel } from "@/components/SupportInboxPanel";
import { AdminStatsPanel } from "@/components/admin/AdminStatsPanel";
import {
  DB_COLS_STORAGE,
  DB_SAILOR_COLUMNS,
  defaultDbColVisible,
} from "@/components/admin/adminConstants";
import { parseApi } from "@/components/admin/parseApi";
import { AdminSuggestionsPanel } from "@/components/admin/AdminSuggestionsPanel";
import { ageYears } from "@/lib/age";
import {
  halfBoundaryOptions,
  isHalfBoundaryYmd,
  todayYmdSg,
} from "@/lib/datesSg";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type { ImportPossibleDuplicate } from "@/types/import";

import { Plus, Trash2, Edit3, User, Medal, Copy } from "lucide-react";

/** Gold entry / drop: 1 Jan or 1 Jul only (half-year boundaries). */
const HALF_BOUNDARY_OPTS = halfBoundaryOptions(2018);

interface AdminDashboardProps {
  initialSailors: SailorAdmin[];
  initialRegattas: RegattaAdmin[];
  initialResults: ResultAdmin[];
}

export function AdminDashboard({ initialSailors, initialRegattas, initialResults }: AdminDashboardProps) {
  const [activeTab, setActiveTab] = useState<
    "import" | "edit" | "stats"
  >("edit");
  
  // Auth state — role from server /profiles, never user_metadata
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [adminRole, setAdminRole] = useState<"superadmin" | "coach" | "sailor" | "parent">("sailor");
  const [importMeta, setImportMeta] = useState({
    name: "",
    date: new Date().toISOString().slice(0, 10),
    division: "Gold",
    fleetSize: 50,
  });
  const [fullImportRows, setFullImportRows] = useState<RegattaImportRow[]>([]);


  useEffect(() => {
    let subscription: { unsubscribe: () => void } | undefined;

    async function loadRole() {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (!session?.user) {
          setUser(null);
          setAdminRole("sailor");
          setLoading(false);
          return;
        }
        setUser(session.user);
        try {
          const res = await fetch("/api/admin/me");
          const data = await res.json();
          setAdminRole((data.role || "sailor") as any);
        } catch {
          setAdminRole("sailor");
        }
      } catch {
        setUser(null);
        setAdminRole("sailor");
      } finally {
        setLoading(false);
      }
    }

    try {
      const supabase = createBrowserSupabase();
      loadRole();
      const { data } = supabase.auth.onAuthStateChange(() => {
        loadRole();
      });
      subscription = data.subscription;
    } catch {
      setLoading(false);
    }

    return () => subscription?.unsubscribe();
  }, []);

  // Excel Import States
  const [dragActive, setDragActive] = useState(false);
  const [importStatus, setImportStatus] = useState<string | null>(null);
  const [importPossibleDuplicates, setImportPossibleDuplicates] = useState<
    ImportPossibleDuplicate[]
  >([]);

  // Ignored duplicate pairs (localStorage, pair key idA|idB sorted)
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

  // Bulk Editor States
  const [selectedSailors, setSelectedSailors] = useState<string[]>([]);
  const [bulkField, setBulkField] = useState<string>("");
  const [bulkValue, setBulkValue] = useState<string>("");
  const [sailorList, setSailorList] = useState(initialSailors);
  const [bulkStatus, setBulkStatus] = useState<string | null>(null);

  // Database Editor Sub-Tabs & Forms
  const [editSubTab, setEditSubTab] = useState<
    | "sailors"
    | "regattas"
    | "results"
    | "suggestions"
    | "claims"
    | "promote"
    | "support"
  >("sailors");
  const [dbSearch, setDbSearch] = useState("");
  const [dbFleetFilter, setDbFleetFilter] = useState<string>("all");
  const [dbSquadFilter, setDbSquadFilter] = useState<string>("all");
  const [regattaSearch, setRegattaSearch] = useState("");
  const [regattaDivisionFilter, setRegattaDivisionFilter] =
    useState<string>("all");
  /** all | series | nonranking */
  const [regattaRankingFilter, setRegattaRankingFilter] =
    useState<string>("all");
  const [dbColVisible, setDbColVisible] = useState<Record<string, boolean>>(
    defaultDbColVisible
  );
  const [dbColPickerOpen, setDbColPickerOpen] = useState(false);
  const [dbSortKey, setDbSortKey] = useState<string>("name");
  const [dbSortDir, setDbSortDir] = useState<"asc" | "desc">("asc");
  const [best3BySailor, setBest3BySailor] = useState<Record<string, number>>(
    {}
  );
  const [competitionsSailorId, setCompetitionsSailorId] = useState<string | null>(
    null
  );
  const [competitionsLoading, setCompetitionsLoading] = useState(false);
  const [editingSailorId, setEditingSailorId] = useState<string | null>(null);
  const [sailorForm, setSailorForm] = useState<any>({
    id: "",
    name: "",
    handle: "",
    sailNumber: "",
    club: "",
    nationality: "",
    gender: "M",
    nationalSquadStatus: "",
    instagram: "",
                            avatarUrl: "",
    dob: "",
    weight: "",
    bio: "",
    goldEntryDate: "",
    silverEntryDate: "",
    dropDate: "",
    natSquadStatusJan25: "",
    natSquadStatusJul25: "",
    natSquadStatusJan26: "",
    natSquadStatusJul26: "",
    histRankingJun24: "",
    histRankingDec24: "",
    histRankingJun25: "",
    histRankingDec25: "",
    histRankingJun26: "",
    worlds: "",
    european: "",
    asian: "",
    seaGames: "",
  });

  const [regattaList, setRegattaList] = useState(initialRegattas || []);
  const filteredRegattaList = useMemo(() => {
    const q = regattaSearch.trim().toLowerCase();
    return [...(regattaList || [])]
      .filter((r) => {
        if (
          regattaDivisionFilter !== "all" &&
          String(r.division || "Gold") !== regattaDivisionFilter
        ) {
          return false;
        }
        const isNon = r.countsForRanking === false;
        if (regattaRankingFilter === "series" && isNon) return false;
        if (regattaRankingFilter === "nonranking" && !isNon) return false;
        if (!q) return true;
        const hay =
          `${r.name || ""} ${r.date || ""} ${r.division || ""} ${r.slug || ""}`.toLowerCase();
        return hay.includes(q);
      })
      .sort((a, b) => String(b.date || "").localeCompare(String(a.date || "")));
  }, [
    regattaList,
    regattaSearch,
    regattaDivisionFilter,
    regattaRankingFilter,
  ]);
  const suggestionCount = useMemo(
    () =>
      (regattaList || []).filter(
        (r) => r.countsForRanking === false && !r.reviewedAt
      ).length,
    [regattaList]
  );
  const [editingRegattaId, setEditingRegattaId] = useState<string | null>(null);
  const [regattaForm, setRegattaForm] = useState<any>({
    id: "",
    name: "",
    date: "",
    totalFleetSize: 50,
    division: "Gold",
    raceCount: "",
    geography: "SG",
    boatClass: "Optimist",
    countsForRanking: true,
  });

  const [resultsList, setResultsList] = useState(initialResults || []);
  const [selectedRegattaIdForResultEdit, setSelectedRegattaIdForResultEdit] = useState<string>(
    initialRegattas?.[0]?.id || ""
  );
  const [editingResultId, setEditingResultId] = useState<string | null>(null);
  const [showDuplicateFinder, setShowDuplicateFinder] = useState(false);
  const [resultForm, setResultForm] = useState<any>({
    id: "",
    regattaId: "",
    sailorId: "",
    rank: 1,
    nettScore: "",
    totalScore: "",
    isDNS: false,
    isOverseasCommitment: false,
  });

  // Check superadmin permissions
  const isSuperadmin = adminRole === "superadmin";

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

  // Best 3 of 5 for current period (Gold + Silver ranked sailors)
  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const [g, s] = await Promise.all([
          fetch(
            "/api/rankings?fleet=Gold&year=2026&half=" +
              encodeURIComponent("Jul-Dec")
          ).then((r) => r.json()),
          fetch(
            "/api/rankings?fleet=Silver&year=2026&half=" +
              encodeURIComponent("Jul-Dec")
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
  }, [sailorList, resultsList, regattaList]);

  const filteredDbSailors = sailorList.filter((s) => {
    const q = dbSearch.trim().toLowerCase();
    if (q) {
      const hay = `${s.name} ${s.sailNumber || ""} ${s.club || ""} ${s.school || ""} ${s.handle || ""}`.toLowerCase();
      if (!hay.includes(q)) return false;
    }
    if (dbFleetFilter !== "all") {
      const cf = String(s.currentFleet || "").toLowerCase();
      const inSeries =
        cf === "series" ||
        cf === "gold" ||
        cf === "silver" ||
        (!cf && Boolean(s.goldEntryDate || s.silverEntryDate));
      if (dbFleetFilter === "series" && !inSeries) return false;
      if (dbFleetFilter === "guest" && inSeries) return false;
      // Ranking-style filters (derived for current dates, not Fleet current)
      if (dbFleetFilter === "gold") {
        if (!inSeries || !s.goldEntryDate) return false;
      }
      if (dbFleetFilter === "silver") {
        if (!inSeries || s.goldEntryDate) return false;
      }
    }
    if (dbSquadFilter !== "all") {
      // Current period squad (Jul 26), with legacy nationalSquadStatus fallback
      const sq =
        s.natSquadStatusJul26 || s.nationalSquadStatus || "";
      if (String(sq) !== dbSquadFilter) return false;
    }
    return true;
  });

  const seriesLabelOf = (s: any) => {
    // Optimist drop date = out of Gold/Silver from that day (SG calendar)
    if (s.dropDate) {
      const ymd = String(s.dropDate).slice(0, 10);
      // Compare as YYYY-MM-DD (UTC+8 calendar fields stored as date-only)
      const today = new Date().toLocaleDateString("en-CA", {
        timeZone: "Asia/Singapore",
      });
      if (/^\d{4}-\d{2}-\d{2}$/.test(ymd) && ymd <= today) {
        return "Dropped";
      }
    }
    const cf = String(s.currentFleet || "").toLowerCase();
    if (cf === "guest") return "Guest";
    const inSeries =
      cf === "series" ||
      cf === "gold" ||
      cf === "silver" ||
      (!cf && Boolean(s.goldEntryDate || s.silverEntryDate));
    if (!inSeries) return "Guest";
    if (s.goldEntryDate) return "Series · Gold entry";
    return "Series · Silver";
  };

  const duplicatePairs = useMemo(() => {
    const pairKey = (a: string, b: string) =>
      [a, b].sort().join("|");
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
    const val = (s: any) => {
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
        case "age": {
          const a = ageYears(s.dob as string | null);
          return a == null ? 99999 : a;
        }
        case "club":
          return s.club || "";
        case "nationality":
          return s.nationality || "";
        case "school":
          return s.school || "";
        case "goldEntry":
          return s.goldEntryDate || "";
        case "silverEntry":
          return s.silverEntryDate || "";
        case "dropDate":
          return s.dropDate || "";
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
          return s.worlds ?? 99999;
        case "european":
          return s.european ?? 99999;
        case "asian":
          return s.asian ?? 99999;
        case "seaGames":
          return s.seaGames ?? 99999;
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

  const handleDrag = (e: any) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.type === "dragenter" || e.type === "dragover") {
      setDragActive(true);
    } else if (e.type === "dragleave") {
      setDragActive(false);
    }
  };

  const handleDrop = (e: any) => {
    e.preventDefault();
    e.stopPropagation();
    setDragActive(false);

    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      handleFile(e.dataTransfer.files[0]);
    }
  };

  const handleFileChange = (e: any) => {
    if (e.target.files && e.target.files[0]) {
      handleFile(e.target.files[0]);
    }
  };

  const handleFile = (file: File) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const data = e.target?.result;
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
      // Refresh sailors after auto-create
      try {
        const list = await fetch("/api/admin/sailors").then((r) => r.json());
        if (list.sailors) setSailorList(list.sailors);
      } catch {
        /* ignore */
      }
      if (data.regatta) {
        setRegattaList((prev) => {
          const exists = prev.some((r) => r.id === data.regatta.id);
          return exists
            ? prev.map((r) => (r.id === data.regatta.id ? data.regatta : r))
            : [...prev, data.regatta];
        });
      }
      // Surface DB/migration hints (e.g. decimal nett scores)
      if (data.hint || data.errorSamples?.length) {
        const extra = [
          data.hint,
          ...(data.errorSamples || []).slice(0, 3),
        ]
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
      // Refresh results after import
      try {
        const rRes = await fetch("/api/admin/results");
        if (rRes.ok) {
          const rData = await rRes.json();
          if (rData.results) setResultsList(rData.results);
        }
      } catch {
        /* optional */
      }
    } catch (e: any) {
      setImportStatus(null);
      setImportPossibleDuplicates([]);
      alert(e.message || "Import failed");
    }
  };

  // Bulk Edit Handlers
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
      alert("Error: 403 Forbidden. Only Superadmins can update fleet properties.");
      return;
    }
    if (selectedSailors.length === 0) {
      alert("Please select at least one sailor to bulk edit.");
      return;
    }
    if (!bulkField) {
      alert("Please select a field to update.");
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
      if (!res.ok) throw new Error(data.error || "Bulk update failed");

      setSailorList((prev) =>
        prev.map((s) => {
          if (!selectedSailors.includes(s.id)) return s;
          let typedValue: any = bulkValue;
          const isNumeric = [
            "histRankingJun24", "histRankingDec24", "histRankingJun25", "histRankingDec25", "histRankingJun26",
            "weight",
          ].includes(bulkField);
          if (isNumeric) typedValue = bulkValue === "" ? null : parseInt(bulkValue) || null;
          else if (
            [
              "natSquadStatusJan25",
              "natSquadStatusJul25",
              "natSquadStatusJan26",
              "natSquadStatusJul26",
            ].includes(bulkField) &&
            bulkValue === "CLEAR"
          ) {
            typedValue = null;
          } else if (bulkValue === "") typedValue = null;
          const next = { ...s, [bulkField]: typedValue };
          // Keep legacy current-squad field in sync when setting Jul 26
          if (bulkField === "natSquadStatusJul26") {
            next.nationalSquadStatus = typedValue;
          }
          return next;
        })
      );
      setBulkStatus(data.message || `Updated ${selectedSailors.length} sailors.`);
      setSelectedSailors([]);
      setBulkValue("");
      setTimeout(() => setBulkStatus(null), 3000);
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleMergeSailors = async () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can merge sailors.");
      return;
    }
    if (selectedSailors.length !== 2) {
      alert("Select exactly two sailors (tick two checkboxes), then Merge.");
      return;
    }
    const [aId, bId] = selectedSailors;
    const a = sailorList.find((s) => s.id === aId);
    const b = sailorList.find((s) => s.id === bId);
    if (!a || !b) {
      alert("Could not find both sailors — refresh and try again.");
      return;
    }

    // Prefer keep = more complete profile / real sail number / gold history
    const score = (s: any) => {
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

    const ok = confirm(
      `Merge duplicate sailors?\n\n` +
        `KEEP (profile retained):\n  ${keep.name} · ${keep.sailNumber || "—"}\n\n` +
        `DELETE after merge (results + aliases moved):\n  ${merge.name} · ${merge.sailNumber || "—"}\n\n` +
        `Results move to the kept sailor. On the same regatta, the better (lower) rank is kept.\n\nContinue?`
    );
    if (!ok) return;

    try {
      const res = await fetch("/api/admin/sailors/merge", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ keepId: keep.id, mergeId: merge.id }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Merge failed");

      setSailorList((prev) => {
        const without = prev.filter((s) => s.id !== merge.id);
        return without.map((s) => (s.id === keep.id && data.keep ? data.keep : s));
      });
      setSelectedSailors([]);
      // Refresh results so moved rows show under keep
      try {
        await refreshResultsList();
      } catch {
        /* ignore */
      }
      setBulkStatus(
        data.message ||
          `Merged ${merge.name} → ${keep.name} (${data.resultsMoved ?? 0} results moved).`
      );
      setTimeout(() => setBulkStatus(null), 6000);
      alert(
        `${data.message}\n\nResults moved: ${data.resultsMoved ?? 0}\n` +
          `Conflicts resolved: ${data.resultsMergedConflict ?? 0}\n` +
          `Conflicts kept (kept sailor better): ${data.resultsDroppedConflict ?? 0}`
      );
    } catch (e: any) {
      alert(e.message || "Merge failed");
    }
  };

  const handleBulkDelete = async () => {
    if (!isSuperadmin) {
      alert("Superadmin only");
      return;
    }
    if (selectedSailors.length === 0) {
      alert("Select at least one sailor to delete.");
      return;
    }
    if (
      !confirm(
        `Delete ${selectedSailors.length} sailor(s) and all their regatta results? This cannot be undone.`
      )
    ) {
      return;
    }
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
      if (!res.ok) throw new Error(data.error || "Bulk delete failed");
      setSailorList((prev) => prev.filter((s) => !selectedSailors.includes(s.id)));
      setResultsList((prev) =>
        prev.filter((r) => !selectedSailors.includes(r.sailorId))
      );
      setSelectedSailors([]);
      setBulkStatus(data.message || "Deleted.");
      setTimeout(() => setBulkStatus(null), 4000);
    } catch (e: any) {
      alert(e.message);
    }
  };

  // Sailor CRUD Handlers — persist to DB
  const handleSaveSailor = async () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!sailorForm.name || !sailorForm.sailNumber) {
      alert("Name and Sail Number are required.");
      return;
    }
    // Client-side Gold-from-Silver guard (server also enforces)
    const existing = sailorList.find((s) => s.id === editingSailorId);
    const wantsGold = Boolean(sailorForm.goldEntryDate);
    const hasSilverPath =
      Boolean(sailorForm.silverEntryDate) ||
      Boolean(existing?.silverEntryDate) ||
      Boolean(existing?.goldEntryDate);
    if (wantsGold && !hasSilverPath) {
      alert(
        "Gold entry requires Silver history first. Set Silver entry date, save, then set Gold entry."
      );
      return;
    }
    if (
      sailorForm.goldEntryDate &&
      !isHalfBoundaryYmd(String(sailorForm.goldEntryDate))
    ) {
      alert(
        "Gold entry date must be 1 Jan or 1 Jul (half-year boundary), e.g. 2026-01-01 or 2026-07-01."
      );
      return;
    }
    if (
      sailorForm.dropDate &&
      !isHalfBoundaryYmd(String(sailorForm.dropDate))
    ) {
      alert(
        "Drop date must be 1 Jan or 1 Jul (half-year boundary), e.g. 2026-07-01."
      );
      return;
    }
    // Only send known fields (avoid dumping internal/extra props that break APIs)
    const dateOnly = (v: unknown) => {
      if (v == null || v === "") return null;
      const s = String(v);
      return /^\d{4}-\d{2}-\d{2}/.test(s) ? s.slice(0, 10) : s;
    };
    const payload = {
      name: sailorForm.name,
      handle: sailorForm.handle,
      sailNumber: sailorForm.sailNumber,
      club: sailorForm.club,
      school: sailorForm.school ?? null,
      nationality: sailorForm.nationality || null,
      gender: sailorForm.gender,
      bio: sailorForm.bio || null,
      // Current squad mirrors Jul–Dec 2026 (period-locked) when set
      nationalSquadStatus:
        sailorForm.natSquadStatusJul26 ||
        sailorForm.nationalSquadStatus ||
        null,
      currentFleet:
        ["series", "gold", "silver"].includes(
          String(sailorForm.currentFleet || "").toLowerCase()
        )
          ? "Series"
          : "Guest",
      goldEntryDate: dateOnly(sailorForm.goldEntryDate),
      silverEntryDate: dateOnly(sailorForm.silverEntryDate),
      dropDate: dateOnly(sailorForm.dropDate),
      dob: dateOnly(sailorForm.dob),
      weight: sailorForm.weight === "" || sailorForm.weight == null ? null : sailorForm.weight,
      instagram: sailorForm.instagram || null,
      avatarUrl: sailorForm.avatarUrl || null,
      natSquadStatusJan25: sailorForm.natSquadStatusJan25 || null,
      natSquadStatusJul25: sailorForm.natSquadStatusJul25 || null,
      natSquadStatusJan26: sailorForm.natSquadStatusJan26 || null,
      natSquadStatusJul26: sailorForm.natSquadStatusJul26 || null,
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
        if (!res.ok) throw new Error(data.error || data.detail || "Create failed");
        setSailorList((prev) => [...prev, data.sailor]);
        alert(data.warning ? `Sailor created. Note: ${data.warning}` : "Sailor created successfully!");
      } else {
        const res = await fetch("/api/admin/sailors", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...payload, id: editingSailorId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || data.detail || "Update failed");
        setSailorList((prev) =>
          prev.map((s) => (s.id === editingSailorId ? data.sailor : s))
        );
        alert(
          data.warning
            ? `Sailor updated. Note: ${data.warning}`
            : "Sailor updated successfully!"
        );
      }
      setEditingSailorId(null);
    } catch (e: any) {
      alert(e.message || "Update failed");
    }
  };

  const handleDeleteSailor = async (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!id) {
      alert("Missing sailor id — refresh the page and try again.");
      return;
    }
    if (!confirm("Are you sure you want to delete this sailor? Their results will also be deleted."))
      return;
    try {
      const res = await fetch(`/api/admin/sailors?id=${encodeURIComponent(id)}`, {
        method: "DELETE",
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setSailorList((prev) => prev.filter((s) => s.id !== id));
      setResultsList((prev) => prev.filter((r) => r.sailorId !== id));
      alert("Sailor deleted.");
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleSaveRegatta = async () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!regattaForm.name || !regattaForm.date) {
      alert("Regatta Name and Date are required.");
      return;
    }
    try {
      if (editingRegattaId === "new") {
        const res = await fetch("/api/admin/regattas", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(regattaForm),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Create failed");
        setRegattaList((prev) => [...prev, data.regatta]);
        if (!selectedRegattaIdForResultEdit) {
          setSelectedRegattaIdForResultEdit(data.regatta.id);
        }
        alert("Regatta created successfully!");
      } else {
        const res = await fetch("/api/admin/regattas", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...regattaForm, id: editingRegattaId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Update failed");
        setRegattaList((prev) =>
          prev.map((r) => (r.id === editingRegattaId ? data.regatta : r))
        );
        alert("Regatta updated successfully!");
      }
      setEditingRegattaId(null);
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleDeleteRegatta = async (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!id) {
      alert("Missing regatta id — refresh the page and try again.");
      return;
    }
    if (
      !confirm(
        "Are you sure you want to delete this regatta? All results associated with it will also be deleted."
      )
    ) {
      return;
    }
    try {
      const res = await fetch(`/api/admin/regattas?id=${encodeURIComponent(id)}`, {
        method: "DELETE",
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setRegattaList((prev) => prev.filter((r) => r.id !== id));
      setResultsList((prev) => prev.filter((row) => row.regattaId !== id));
      if (selectedRegattaIdForResultEdit === id) {
        setSelectedRegattaIdForResultEdit("");
      }
      alert("Regatta deleted.");
    } catch (e: any) {
      alert(e.message);
    }
  };

  const refreshResultsList = async () => {
    try {
      const res = await fetch("/api/admin/results");
      const data = await parseApi(res);
      if (res.ok && Array.isArray(data.results)) {
        setResultsList(data.results);
      }
    } catch {
      /* keep existing list */
    }
  };

  const openSailorResults = async (sailorId: string) => {
    setEditingSailorId(null);
    setEditingResultId(null);
    setCompetitionsSailorId(sailorId);
    setCompetitionsLoading(true);
    try {
      await refreshResultsList();
    } finally {
      setCompetitionsLoading(false);
    }
  };

  const closeSailorResults = () => {
    setCompetitionsSailorId(null);
    setEditingResultId(null);
  };

  const handleSaveResult = async () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!resultForm.sailorId || !resultForm.regattaId) {
      alert("Sailor and Regatta must be selected.");
      return;
    }
    const overseas = Boolean(resultForm.isOverseasCommitment);
    const reg = regattaList.find((r) => r.id === resultForm.regattaId);
    const dnsPts = (reg?.totalFleetSize || 50) + 1;
    const rankNum = Number(resultForm.rank);
    // Real finish better than DNS points → not DNS
    let isDns = overseas
      ? false
      : Boolean(resultForm.isDNS || resultForm.isDns);
    if (isDns && Number.isFinite(rankNum) && rankNum < dnsPts) {
      isDns = false;
    }
    const payload = {
      ...resultForm,
      rank: rankNum,
      isDns,
      isDNS: isDns,
      isOverseasCommitment: overseas,
    };
    try {
      if (editingResultId === "new") {
        const res = await fetch("/api/admin/results", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Create failed");
        setResultsList((prev) => {
          const row = data.result;
          const without = prev.filter(
            (r) =>
              !(r.sailorId === row.sailorId && r.regattaId === row.regattaId)
          );
          return [...without, row];
        });
        alert("Result added successfully!");
      } else {
        const res = await fetch("/api/admin/results", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...payload, id: editingResultId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Update failed");
        setResultsList((prev) =>
          prev.map((r) => (r.id === editingResultId ? data.result : r))
        );
        alert("Result updated successfully!");
      }
      setEditingResultId(null);
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleFillDnsForRegatta = async (regattaId: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden.");
      return;
    }
    if (!regattaId) {
      alert("Select a regatta first.");
      return;
    }
    const reg = regattaList.find((r) => r.id === regattaId);
    const ok = confirm(
      `Create DNS scores for active ${reg?.division || ""} fleet members who do not have a result at “${reg?.name || "this regatta"}”?\n\n` +
        `DNS points = fleet size + 1 = ${(reg?.totalFleetSize || 0) + 1}.\n` +
        `You can edit any row afterwards (e.g. overseas commitment).`
    );
    if (!ok) return;
    try {
      const res = await fetch("/api/admin/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "fillDns", regattaId }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Fill DNS failed");
      await refreshResultsList();
      alert(data.message || `Created ${data.created} DNS rows.`);
    } catch (e: any) {
      alert(e.message || "Fill DNS failed");
    }
  };

  /** Ensure every active fleet sailor has results for all ranking regattas in a half-year */
  const handleFillDnsForPeriod = async (
    fleet: "Gold" | "Silver",
    year: number,
    half: "Jan-Jun" | "Jul-Dec"
  ) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden.");
      return;
    }
    const ok = confirm(
      `Ensure DNS for all active ${fleet} fleet sailors in ${half} ${year}?\n\n` +
        `Each sailor will get a result for every ranking regatta in that period they are missing.\n` +
        `Missing → rank = that regatta’s fleet size + 1 (DNS).\n` +
        `Existing results (including overseas) are left unchanged.`
    );
    if (!ok) return;
    try {
      const res = await fetch("/api/admin/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "fillDnsPeriod",
          fleet,
          year,
          half,
        }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Period DNS fill failed");
      await refreshResultsList();
      const events = (data.rankingRegattas || [])
        .map(
          (e: any) =>
            `• ${e.name} (${e.date}) → DNS ${e.dnsPoints}`
        )
        .join("\n");
      alert(
        `${data.message}\n\nRanking regattas:\n${events || "(none found — import regattas with dates in this period)"}`
      );
    } catch (e: any) {
      alert(e.message || "Period DNS fill failed");
    }
  };

  const handleDeleteResult = async (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!id) {
      alert("Missing result id — refresh the page and try again.");
      return;
    }
    if (!confirm("Are you sure you want to delete this result?")) return;
    try {
      const res = await fetch(`/api/admin/results?id=${encodeURIComponent(id)}`, {
        method: "DELETE",
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setResultsList((prev) => prev.filter((r) => r.id !== id));
      alert("Result deleted.");
    } catch (e: any) {
      alert(e.message);
    }
  };

  if (loading) {
    return (
      <div className="flex-1 flex items-center justify-center min-h-[60vh]">
        <RefreshCw className="h-8 w-8 text-orange-500 animate-spin" />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="mx-auto max-w-md w-full px-4 py-20 flex-1 flex flex-col justify-center">
        <div className="glass-card rounded-3xl p-8 border border-white/5 text-center space-y-6">
          <div className="h-12 w-12 rounded-full bg-red-500/10 border border-red-500/20 flex items-center justify-center mx-auto text-red-400">
            <Shield className="h-6 w-6" />
          </div>
          <div className="space-y-2">
            <h1 className="text-xl font-black text-white">Admin Authentication Required</h1>
            <p className="text-xs text-slate-400 leading-relaxed">
              To make persistent database updates on the SailorPath platform, you must log in with an authorized administrator account.
            </p>
          </div>
          <a
            href={`https://sailorpath.com/login?next=${encodeURIComponent("https://admin.sailorpath.com/")}`}
            className="block w-full rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-xs font-bold text-white transition-all shadow-lg shadow-orange-600/20 text-center"
          >
            Sign In to Admin Portal
          </a>
          <p className="text-[10px] text-slate-500 leading-relaxed">
            After login you return here. For a live (non-demo) admin, set{" "}
            <code className="text-slate-400">DATABASE_URL</code> on Vercel and make your{" "}
            <code className="text-slate-400">profiles.role = superadmin</code>.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12 flex-1 flex flex-col gap-8">
      <div className="glass-panel rounded-2xl p-4 flex flex-col sm:flex-row items-center justify-between gap-4 border border-white/5 bg-slate-900/40">
        <div className="flex items-center gap-2 text-xs font-bold text-slate-300">
          <Shield className="h-4 w-4 text-orange-500" />
          <span>Logged in as: <span className="text-white">{user?.email}</span></span>
        </div>
        <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-3 py-0.5 text-[10px] font-black text-orange-400 capitalize">
          {adminRole}
        </span>
      </div>

      {/* Tab Navigation — equal width for all tabs */}
      <div className="grid grid-cols-3 gap-1 rounded-2xl border border-white/5 bg-[#131520] p-1">
        {(
          [
            ["import", "Regatta Excel", FileSpreadsheet],
            ["edit", "Database & bulk edit", Database],
            ["stats", "Stats & usage", BarChart3],
          ] as const
        ).map(([key, label, Icon]) => (
          <button
            key={key}
            type="button"
            onClick={() => setActiveTab(key)}
            className={`relative flex items-center justify-center gap-2 rounded-xl px-2 py-3 text-xs sm:text-sm font-bold transition-all min-h-[3rem] ${
              activeTab === key
                ? "bg-orange-600 text-white shadow-md shadow-orange-950/30"
                : "text-slate-400 hover:text-white hover:bg-white/5"
            }`}
          >
            <Icon className="h-4 w-4 shrink-0" />
            <span className="text-center leading-tight">{label}</span>
          </button>
        ))}
      </div>

      {/* RLS Policy Indicator Banner for non-superadmins */}
      {!isSuperadmin && (
        <div className="bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl p-4 flex items-start gap-3">
          <AlertTriangle className="h-5 w-5 flex-shrink-0 text-red-500 mt-0.5" />
          <div>
            <h3 className="font-bold text-sm">Access Denied (RLS & UI Blocked)</h3>
            <p className="text-xs text-red-300/80 mt-1">
              Your active role is **{adminRole}**. Regatta result modification, AI reconciliation, and bulk fleet changes require explicit `role = 'superadmin'` credentials. In a real environment, database writing is blocked by RLS policies.
            </p>
          </div>
        </div>
      )}

      {/* Tab Contents — always full width of admin shell */}
      <div className="flex-1 flex flex-col w-full min-w-0">
        {/* Tab 1: Excel Import */}
        {activeTab === "import" && (
          <div className="w-full min-w-0 space-y-6">
            <div className="glass-panel rounded-3xl p-6 sm:p-8 border border-white/5 w-full">
              <div
                onDragEnter={handleDrag}
                onDragOver={handleDrag}
                onDragLeave={handleDrag}
                onDrop={handleDrop}
                className={`w-full border-2 border-dashed rounded-2xl p-8 flex flex-col items-center justify-center cursor-pointer transition-all text-center ${
                  dragActive ? "border-orange-500 bg-orange-500/5" : "border-white/10 hover:border-white/20"
                }`}
              >
                <Upload className="h-10 w-10 text-orange-500 mb-4" />
                <p className="text-sm font-bold text-white mb-2">Drag and drop your Regatta Excel/CSV file here</p>
                <p className="text-xs text-slate-500 mb-4 max-w-3xl">
                  Supports .xlsx, .xls, and .csv. Required: Name (+ Rank/Nett if available).
                  Optional: Total Score, Club, Nationality, Sail Number, Birth Year / DOB — when present, sailor profiles are updated.
                  Unmatched names become <strong className="text-slate-300">guests</strong> (not on Gold/Silver rankings until you admit them as Silver in Database).
                </p>
                <label className="rounded-full bg-slate-800 border border-white/5 px-4 py-2 text-xs font-bold text-white hover:bg-slate-700 transition-all cursor-pointer">
                  Select File
                  <input type="file" onChange={handleFileChange} className="hidden" accept=".xlsx,.xls,.csv" />
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
                      onChange={(e) => setImportMeta((m) => ({ ...m, name: e.target.value }))}
                    />
                  </label>
                  <label className="text-xs text-slate-400">
                    Event date
                    <input
                      type="date"
                      className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                      value={importMeta.date}
                      onChange={(e) => setImportMeta((m) => ({ ...m, date: e.target.value }))}
                    />
                  </label>
                  <label className="text-xs text-slate-400">
                    Division
                    <select
                      className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                      value={importMeta.division}
                      onChange={(e) => setImportMeta((m) => ({ ...m, division: e.target.value }))}
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
                        setImportMeta((m) => ({ ...m, fleetSize: Number(e.target.value) || 50 }))
                      }
                    />
                  </label>
                  <button
                    type="button"
                    onClick={handleImportToDb}
                    disabled={!isSuperadmin}
                    className="sm:col-span-2 rounded-full bg-orange-600 hover:bg-orange-500 disabled:opacity-40 px-4 py-2.5 text-xs font-bold text-white"
                  >
                    Import {fullImportRows.length} rows to database
                  </button>
                </div>
              )}
            </div>
          </div>
        )}

        {/* Database & bulk edit */}
        {activeTab === "edit" && (
          <div className="w-full min-w-0 space-y-6">
            {/* Sub Tabs */}
            <div className="grid grid-cols-3 sm:grid-cols-4 lg:grid-cols-7 gap-1 bg-[#131520] border border-white/5 p-1 rounded-2xl w-full">
              {(
                [
                  ["sailors", "Sailors"],
                  ["regattas", "Regattas"],
                  ["results", "Results"],
                  ["suggestions", "Suggestions"],
                  ["claims", "Claims"],
                  ["promote", "Promote"],
                  ["support", "Support"],
                ] as const
              ).map(([sub, label]) => (
                <button
                  key={sub}
                  type="button"
                  onClick={() => {
                    setEditSubTab(sub);
                    setEditingSailorId(null);
                    setEditingRegattaId(null);
                    setEditingResultId(null);
                  }}
                  className={`rounded-xl py-2.5 text-xs font-bold transition-all text-center relative ${
                    editSubTab === sub
                      ? "bg-orange-600 text-white"
                      : "text-slate-400 hover:text-white hover:bg-white/5"
                  }`}
                >
                  {label}
                  {sub === "suggestions" && suggestionCount > 0 && (
                    <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-sky-500 px-1 text-[9px] font-black text-white">
                      {suggestionCount}
                    </span>
                  )}
                </button>
              ))}
            </div>

            {/* Sub-tab content always full width */}
            <div className="w-full min-w-0 min-h-[50vh]">
            {/* Sub-Tab Content: SAILORS */}
            {editSubTab === "sailors" && (
              <div className="w-full min-w-0 space-y-6">
                {/* Filters */}
                <div className="glass-panel rounded-2xl border border-white/5 p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">Search</label>
                    <input
                      type="search"
                      placeholder="Name, sail #, club, school…"
                      value={dbSearch}
                      onChange={(e) => setDbSearch(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    />
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">SG Series</label>
                    <select
                      value={dbFleetFilter}
                      onChange={(e) => setDbFleetFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All</option>
                      <option value="series">In SG Fleet</option>
                      <option value="guest">Guest</option>
                      <option value="gold">Has Gold entry</option>
                      <option value="silver">Series · no Gold entry</option>
                    </select>
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">Squad Jul 26</label>
                    <select
                      value={dbSquadFilter}
                      onChange={(e) => setDbSquadFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All squads</option>
                      <option value="Nat A">Nat A</option>
                      <option value="Nat B">Nat B</option>
                      <option value="DS">DS</option>
                    </select>
                  </div>
                  <p className="sm:col-span-2 lg:col-span-4 text-[11px] text-slate-500">
                    Showing <strong className="text-white">{filteredDbSailors.length}</strong> of{" "}
                    {sailorList.length} sailors
                    {selectedSailors.length > 0 && (
                      <>
                        {" "}
                        · <strong className="text-orange-400">{selectedSailors.length}</strong> selected
                        for bulk edit
                      </>
                    )}
                  </p>
                </div>

                {/* Bulk edit toolbar (merged from former Bulk Date Editor) */}
                <div className="glass-panel rounded-2xl border border-orange-500/20 bg-orange-500/[0.03] p-4 space-y-3">
                  <div className="flex items-center gap-2">
                    <Grid className="h-4 w-4 text-orange-500" />
                    <h3 className="text-sm font-bold text-white">Bulk edit selected sailors</h3>
                  </div>
                  <p className="text-[11px] text-slate-500">
                    Tick sailors in the table below, choose a property and value, then apply. Use
                    Columns to show historical / overseas fields in the same overview.
                  </p>
                  <div className="flex flex-wrap items-end gap-4">
                    <div className="flex flex-col gap-1 min-w-[180px]">
                      <label className="text-[10px] font-bold text-slate-400 uppercase">Property</label>
                      <select
                        value={bulkField}
                        onChange={(e) => {
                          setBulkField(e.target.value);
                          setBulkValue("");
                        }}
                        className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                      >
                        <option value="">-- Select property --</option>
                        <optgroup label="SG Series & Dates">
                          <option value="currentFleet">SG Series (Guest / In SG Fleet)</option>
                          <option value="goldEntryDate">Gold Fleet Entry Date</option>
                          <option value="silverEntryDate">Silver Fleet Entry Date</option>
                          <option value="dropDate">Optimist Drop Date</option>
                        </optgroup>
                        <optgroup label="Profile">
                          <option value="club">Club</option>
                          <option value="school">School</option>
                          <option value="nationality">Nationality</option>
                          <option value="sailNumber">Sail Number</option>
                          <option value="gender">Gender (M/F)</option>
                          <option value="dob">Date of Birth</option>
                          <option value="weight">Weight (kg)</option>
                        </optgroup>
                        <optgroup label="Squad history">
                          <option value="natSquadStatusJan25">Squad Jan 25</option>
                          <option value="natSquadStatusJul25">Squad Jul 25</option>
                          <option value="natSquadStatusJan26">Squad Jan 26</option>
                          <option value="natSquadStatusJul26">Squad Jul 26</option>
                        </optgroup>
                        <optgroup label="Historical rankings">
                          <option value="histRankingJun24">Hist Jun 24</option>
                          <option value="histRankingDec24">Hist Dec 24</option>
                          <option value="histRankingJun25">Hist Jun 25</option>
                          <option value="histRankingDec25">Hist Dec 25</option>
                          <option value="histRankingJun26">Hist Jun 26</option>
                        </optgroup>
                        <optgroup label="Overseas Representation">
                          <option value="worlds">Worlds years (e.g. 2023, 2025)</option>
                          <option value="european">European years</option>
                          <option value="asian">Asian years</option>
                          <option value="seaGames">SEA Games years</option>
                        </optgroup>
                      </select>
                    </div>
                    <div className="flex flex-col gap-1 min-w-[140px]">
                      <label className="text-[10px] font-bold text-slate-400 uppercase">Value</label>
                      {bulkField === "goldEntryDate" || bulkField === "dropDate" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="">— clear / none —</option>
                          {HALF_BOUNDARY_OPTS.map((o) => (
                            <option key={o.value} value={o.value}>
                              {o.label}
                            </option>
                          ))}
                        </select>
                      ) : ["silverEntryDate", "dob"].includes(bulkField) ? (
                        <input
                          type="date"
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        />
                      ) : bulkField === "gender" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="">—</option>
                          <option value="M">M</option>
                          <option value="F">F</option>
                        </select>
                      ) : bulkField === "currentFleet" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="Guest">Guest</option>
                          <option value="Series">In SG Fleet</option>
                        </select>
                      ) : [
                          "natSquadStatusJan25",
                          "natSquadStatusJul25",
                          "natSquadStatusJan26",
                          "natSquadStatusJul26",
                        ].includes(bulkField) ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="">—</option>
                          <option value="Nat A">Nat A</option>
                          <option value="Nat B">Nat B</option>
                          <option value="DS">DS</option>
                          <option value="CLEAR">Clear</option>
                        </select>
                      ) : [
                          "histRankingJun24",
                          "histRankingDec24",
                          "histRankingJun25",
                          "histRankingDec25",
                          "histRankingJun26",
                          "weight",
                        ].includes(bulkField) ? (
                        <input
                          type="number"
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs font-mono"
                          placeholder="Number"
                        />
                      ) : (
                        <input
                          type="text"
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          disabled={!bulkField}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs disabled:opacity-40"
                          placeholder={bulkField ? "Value" : "Select property first"}
                        />
                      )}
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin || selectedSailors.length === 0 || !bulkField}
                      onClick={handleApplyBulk}
                      className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-40 flex items-center gap-1.5"
                    >
                      <Save className="h-4 w-4" />
                      Apply to {selectedSailors.length || 0}
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin || selectedSailors.length !== 2}
                      onClick={handleMergeSailors}
                      title="Select exactly 2 sailors to merge duplicates"
                      className="rounded-full bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-500 disabled:opacity-40 flex items-center gap-1.5"
                    >
                      <UserCheck className="h-4 w-4" />
                      Merge 2 selected
                      {selectedSailors.length === 2 ? "" : ` (${selectedSailors.length}/2)`}
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin || selectedSailors.length === 0}
                      onClick={handleBulkDelete}
                      className="rounded-full bg-rose-600/90 px-4 py-2 text-xs font-bold text-white hover:bg-rose-500 disabled:opacity-40 flex items-center gap-1.5"
                    >
                      <Trash2 className="h-4 w-4" />
                      Delete selected
                    </button>
                  </div>
                  <div className="flex flex-wrap items-center gap-3">
                    <p className="text-[10px] text-slate-500 flex-1 min-w-[200px]">
                      <strong className="text-slate-400">Merge duplicates:</strong> tick exactly two
                      rows → <strong className="text-emerald-400">Merge 2 selected</strong>. The more
                      complete profile is kept; the other is deleted after results/aliases move over.
                    </p>
                    <button
                      type="button"
                      onClick={() => setShowDuplicateFinder((v) => !v)}
                      className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white flex items-center gap-1.5"
                    >
                      <Copy className="h-3.5 w-3.5 text-orange-400" />
                      Find similar names
                      {duplicatePairs.length > 0 && (
                        <span className="rounded-full bg-orange-600/20 text-orange-300 px-1.5 py-0.5 text-[10px]">
                          {duplicatePairs.length}
                        </span>
                      )}
                    </button>
                  </div>

                  {showDuplicateFinder && (
                    <div className="rounded-xl border border-white/10 bg-slate-950/60 p-4 space-y-3">
                      <div className="flex items-start justify-between gap-3">
                        <div>
                          <h4 className="text-xs font-bold text-white uppercase tracking-wider">
                            Possible duplicate sailors
                          </h4>
                          <p className="text-[11px] text-slate-500 mt-1">
                            Shows pairs with ≥60% match (jumbled names, partial names, same sail #).
                            <span className="text-rose-300/90 font-semibold"> High ≥80%</span>
                            {" · "}
                            <span className="text-amber-300/90 font-semibold">Medium 60–79%</span>
                            . Select both → Merge 2 selected.
                          </p>
                        </div>
                        <button
                          type="button"
                          onClick={() => setShowDuplicateFinder(false)}
                          className="text-[11px] font-bold text-slate-500 hover:text-white"
                        >
                          Hide
                        </button>
                      </div>
                      {duplicatePairs.length === 0 ? (
                        <p className="text-xs text-slate-500 py-4 text-center">
                          No pairs at 60%+ similarity.
                        </p>
                      ) : (
                        <ul className="space-y-2 max-h-72 overflow-y-auto">
                          {duplicatePairs.slice(0, 60).map((p) => {
                            const pct = Math.round(p.similarity * 100);
                            const high = p.band === "high" || pct >= 80;
                            return (
                              <li
                                key={`${p.a.id}-${p.b.id}`}
                                className={`flex flex-col sm:flex-row sm:items-center justify-between gap-2 rounded-lg border px-3 py-2 text-xs ${
                                  high
                                    ? "border-rose-500/40 bg-rose-500/10"
                                    : "border-amber-500/35 bg-amber-500/10"
                                }`}
                              >
                                <div className="min-w-0">
                                  <div className="flex flex-wrap items-center gap-2 mb-1">
                                    <span
                                      className={`rounded-full px-2 py-0.5 text-[10px] font-black ${
                                        high
                                          ? "bg-rose-500/20 text-rose-200 border border-rose-500/30"
                                          : "bg-amber-500/20 text-amber-100 border border-amber-500/30"
                                      }`}
                                    >
                                      {pct}% · {high ? "High" : "Medium"}
                                    </span>
                                    <span className="text-[10px] text-slate-500">
                                      {p.how}
                                    </span>
                                  </div>
                                  <p className="text-white font-semibold truncate">
                                    {p.a.name}
                                    <span className="text-slate-500 font-mono text-[10px] ml-2">
                                      {p.a.sailNumber || "—"}
                                    </span>
                                  </p>
                                  <p className="text-slate-300 font-semibold truncate">
                                    {p.b.name}
                                    <span className="text-slate-500 font-mono text-[10px] ml-2">
                                      {p.b.sailNumber || "—"}
                                    </span>
                                  </p>
                                </div>
                                <div className="flex flex-wrap gap-2 shrink-0">
                                  <button
                                    type="button"
                                    onClick={() => {
                                      setSelectedSailors([p.a.id, p.b.id]);
                                      setDbSearch("");
                                      setShowDuplicateFinder(true);
                                    }}
                                    className="rounded-full bg-emerald-600/90 hover:bg-emerald-500 px-3 py-1.5 text-[10px] font-bold text-white"
                                  >
                                    Select pair
                                  </button>
                                  <button
                                    type="button"
                                    onClick={() =>
                                      ignoreDuplicatePair(p.a.id, p.b.id)
                                    }
                                    className="rounded-full border border-white/15 bg-white/5 px-3 py-1.5 text-[10px] font-bold text-slate-400 hover:text-white"
                                  >
                                    Ignore
                                  </button>
                                </div>
                              </li>
                            );
                          })}
                        </ul>
                      )}
                    </div>
                  )}
                  {bulkStatus && (
                    <div className="flex items-center gap-2 text-xs font-bold text-emerald-400">
                      <CheckCircle className="h-4 w-4" />
                      {bulkStatus}
                    </div>
                  )}
                </div>

                {/* Sailor Form — fixed modal so Edit is always visible */}
                {editingSailorId && (
                  <div className="fixed inset-0 z-[100] flex items-end sm:items-center justify-center p-0 sm:p-4">
                    <button
                      type="button"
                      aria-label="Close edit form"
                      className="absolute inset-0 bg-black/70 backdrop-blur-sm"
                      onClick={() => setEditingSailorId(null)}
                    />
                    <div
                      id="sailor-edit-form"
                      className="relative z-10 w-full sm:max-w-3xl max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-3xl border border-orange-500/30 bg-[#0c0d14] shadow-2xl p-5 sm:p-6 space-y-4"
                    >
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider sticky top-0 bg-[#0c0d14] pb-2 z-10">
                      {editingSailorId === "new" ? "Add New Sailor Profile" : "Edit Sailor Profile"}
                      <span className="block text-[11px] font-semibold text-slate-500 normal-case tracking-normal mt-0.5">
                        {editingSailorId !== "new" ? sailorForm.name || "" : "Fill in details and save"}
                      </span>
                    </h3>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                      <div className="md:col-span-2">
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Full Name</label>
                        <input
                          type="text"
                          value={sailorForm.name}
                          onChange={(e) => setSailorForm({ ...sailorForm, name: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Sail Number</label>
                        <input
                          type="text"
                          value={sailorForm.sailNumber}
                          onChange={(e) => setSailorForm({ ...sailorForm, sailNumber: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs text-slate-300 font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Club</label>
                        <input
                          type="text"
                          value={sailorForm.club}
                          onChange={(e) => setSailorForm({ ...sailorForm, club: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">School</label>
                        <input
                          type="text"
                          value={sailorForm.school || ""}
                          onChange={(e) =>
                            setSailorForm({ ...sailorForm, school: e.target.value })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                          placeholder="e.g. Raffles Institution"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Nationality</label>
                        <input
                          type="text"
                          value={sailorForm.nationality || ""}
                          onChange={(e) =>
                            setSailorForm({ ...sailorForm, nationality: e.target.value })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                          placeholder="e.g. Singapore / SGP"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Gender (M/F)</label>
                        <select
                          value={sailorForm.gender || "M"}
                          onChange={(e) => setSailorForm({ ...sailorForm, gender: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="M">Male (M)</option>
                          <option value="F">Female (F)</option>
                        </select>
                      </div>
                      <div className="md:col-span-3 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 border-t border-white/5 pt-4">
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] font-bold text-orange-400/90 uppercase tracking-wider">
                          Nat squad by period (fixed for the whole half-year)
                        </p>
                        {(
                          [
                            ["natSquadStatusJan25", "Jan – Jun 2025"],
                            ["natSquadStatusJul25", "Jul – Dec 2025"],
                            ["natSquadStatusJan26", "Jan – Jun 2026"],
                            ["natSquadStatusJul26", "Jul – Dec 2026 (current)"],
                          ] as const
                        ).map(([key, label]) => (
                          <div key={key}>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              {label}
                            </label>
                            <select
                              value={(sailorForm as any)[key] || ""}
                              onChange={(e) => {
                                const v = e.target.value;
                                setSailorForm({
                                  ...sailorForm,
                                  [key]: v,
                                  // Keep legacy “current squad” in sync with Jul–Dec 2026
                                  ...(key === "natSquadStatusJul26"
                                    ? { nationalSquadStatus: v }
                                    : {}),
                                });
                              }}
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                            >
                              <option value="">None</option>
                              <option value="Nat A">National A (Nat A)</option>
                              <option value="Nat B">National B (Nat B)</option>
                              <option value="DS">Development Squad (DS)</option>
                            </select>
                          </div>
                        ))}
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] text-slate-600 leading-relaxed">
                          Rankings boards show the squad for the period selected.
                          Jul–Dec 2026 also updates the live “current squad” field.
                          History is visible on Gold register and each sailor profile.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">DOB (YYYY-MM-DD)</label>
                        <input
                          type="date"
                          value={sailorForm.dob || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, dob: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Weight (kg)</label>
                        <input
                          type="number"
                          value={sailorForm.weight || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, weight: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Handle (URL Parameter)</label>
                        <input
                          type="text"
                          value={sailorForm.handle}
                          onChange={(e) => setSailorForm({ ...sailorForm, handle: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="e.g. ashlyn-t"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Instagram Handle</label>
                        <input
                          type="text"
                          value={sailorForm.instagram || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, instagram: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="e.g. @username"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Avatar URL</label>
                        <input
                          type="url"
                          value={sailorForm.avatarUrl || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, avatarUrl: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="https://… (public image URL)"
                        />
                      </div>
                      <div className="md:col-span-3 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 border-t border-white/5 pt-4">
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] font-bold text-emerald-400/90 uppercase tracking-wider">
                          Overseas Representation — multiple years allowed (e.g. 2023, 2025)
                        </p>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">Worlds years</label>
                          <input
                            type="text"
                            value={sailorForm.worlds || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, worlds: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2023, 2025"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">European years</label>
                          <input
                            type="text"
                            value={sailorForm.european || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, european: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2024"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">Asian years</label>
                          <input
                            type="text"
                            value={sailorForm.asian || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, asian: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2022, 2024"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">SEA Games years</label>
                          <input
                            type="text"
                            value={sailorForm.seaGames || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, seaGames: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2023"
                          />
                        </div>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Biography</label>
                        <textarea
                          value={sailorForm.bio || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, bio: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs h-10"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">
                          SG Series Fleet
                        </label>
                        <select
                          value={
                            ["series", "gold", "silver"].includes(
                              String(sailorForm.currentFleet || "").toLowerCase()
                            )
                              ? "Series"
                              : "Guest"
                          }
                          onChange={(e) => {
                            const v = e.target.value;
                            const next: any = {
                              ...sailorForm,
                              currentFleet: v === "Series" ? "Series" : "Guest",
                            };
                            // Admit to series: stamp silver entry if empty (SG calendar)
                            if (
                              v === "Series" &&
                              !next.silverEntryDate &&
                              !next.goldEntryDate
                            ) {
                              next.silverEntryDate = todayYmdSg();
                            }
                            setSailorForm(next);
                          }}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="Guest">Guest (not ranked)</option>
                          <option value="Series">In SG Fleet</option>
                        </select>
                        <p className="mt-1 text-[10px] text-slate-500 leading-snug">
                          Guest = never on Gold/Silver rankings. In SG Fleet =
                          Silver until Gold entry date, then Gold until Drop
                          date. Gold entry & drop are half boundaries only (1
                          Jan / 1 Jul).
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Gold Fleet Entry Date</label>
                        <select
                          value={sailorForm.goldEntryDate || ""}
                          onChange={(e) =>
                            setSailorForm({
                              ...sailorForm,
                              goldEntryDate: e.target.value,
                            })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        >
                          <option value="">— none —</option>
                          {/* Preserve legacy non-boundary values so admin can fix them */}
                          {sailorForm.goldEntryDate &&
                            !HALF_BOUNDARY_OPTS.some(
                              (o) => o.value === sailorForm.goldEntryDate
                            ) && (
                              <option value={sailorForm.goldEntryDate}>
                                {sailorForm.goldEntryDate} (not 1 Jan/1 Jul —
                                pick a boundary)
                              </option>
                            )}
                          {HALF_BOUNDARY_OPTS.map((o) => (
                            <option key={o.value} value={o.value}>
                              {o.label}
                            </option>
                          ))}
                        </select>
                        <p className="mt-1 text-[10px] text-slate-500">
                          Only 1 Jan or 1 Jul — applies for the whole half-year.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Silver Fleet Entry Date</label>
                        <input
                          type="date"
                          value={sailorForm.silverEntryDate || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, silverEntryDate: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Optimist Drop Date</label>
                        <select
                          value={sailorForm.dropDate || ""}
                          onChange={(e) =>
                            setSailorForm({
                              ...sailorForm,
                              dropDate: e.target.value,
                            })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        >
                          <option value="">— none —</option>
                          {sailorForm.dropDate &&
                            !HALF_BOUNDARY_OPTS.some(
                              (o) => o.value === sailorForm.dropDate
                            ) && (
                              <option value={sailorForm.dropDate}>
                                {sailorForm.dropDate} (not 1 Jan/1 Jul — pick a
                                boundary)
                              </option>
                            )}
                          {HALF_BOUNDARY_OPTS.map((o) => (
                            <option key={`d-${o.value}`} value={o.value}>
                              {o.label}
                            </option>
                          ))}
                        </select>
                        <p className="mt-1 text-[10px] text-slate-500">
                          Only 1 Jan or 1 Jul. Drop on that day removes the
                          sailor from that half and later.
                        </p>
                      </div>
                      <div className="md:col-span-3 grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3 border-t border-white/5 pt-4">
                        <p className="col-span-2 sm:col-span-3 lg:col-span-5 text-[10px] font-bold text-blue-400/90 uppercase tracking-wider">
                          Historical rankings (shown on All Gold Fleet Sailors)
                        </p>
                        {(
                          [
                            ["histRankingJun24", "Jun 24"],
                            ["histRankingDec24", "Dec 24"],
                            ["histRankingJun25", "Jun 25"],
                            ["histRankingDec25", "Dec 25"],
                            ["histRankingJun26", "Jun 26"],
                          ] as const
                        ).map(([key, label]) => (
                          <div key={key}>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              {label}
                            </label>
                            <input
                              type="number"
                              min={1}
                              value={(sailorForm as any)[key] ?? ""}
                              onChange={(e) =>
                                setSailorForm({
                                  ...sailorForm,
                                  [key]: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                              placeholder="—"
                            />
                          </div>
                        ))}
                      </div>
                    </div>

                    <div className="flex justify-end gap-2 border-t border-white/5 pt-4 sticky bottom-0 bg-[#0c0d14] pb-1">
                      <button
                        type="button"
                        onClick={() => setEditingSailorId(null)}
                        className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                      >
                        Cancel
                      </button>
                      <button
                        type="button"
                        onClick={handleSaveSailor}
                        className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                      >
                        Save Sailor
                      </button>
                    </div>
                    </div>
                  </div>
                )}

                {/* Sailors List */}
                <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
                  <div className="p-6 border-b border-white/5 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div>
                      <h3 className="text-base font-bold text-white">Sailors List</h3>
                      <p className="text-xs text-slate-500">
                        Click headers to sort. Choose columns to show. Edit profile or competitions per sailor.
                      </p>
                    </div>
                    <div className="flex flex-wrap items-center gap-2">
                      <div className="relative">
                        <button
                          type="button"
                          onClick={() => setDbColPickerOpen((o) => !o)}
                          className="rounded-full bg-slate-800 border border-white/10 px-4 py-2 text-xs font-bold text-white hover:bg-slate-700 flex items-center gap-1.5"
                        >
                          <Columns3 className="h-4 w-4 text-orange-400" />
                          Columns
                        </button>
                        {dbColPickerOpen && (
                          <div className="absolute right-0 top-full mt-2 z-30 w-56 rounded-xl border border-white/10 bg-slate-950 shadow-xl p-3 space-y-1.5">
                            <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                              Visible columns
                            </p>
                            {DB_SAILOR_COLUMNS.map((c) => (
                              <label
                                key={c.key}
                                className="flex items-center gap-2 text-xs text-slate-300 cursor-pointer hover:text-white"
                              >
                                <input
                                  type="checkbox"
                                  checked={colOn(c.key)}
                                  disabled={c.key === "name"}
                                  onChange={() =>
                                    setDbColVisible((prev) => ({
                                      ...prev,
                                      [c.key]: !colOn(c.key),
                                    }))
                                  }
                                  className="rounded border-slate-700 bg-slate-900 text-orange-600 h-3.5 w-3.5"
                                />
                                {c.label}
                                {!c.defaultOn && (
                                  <span className="text-[9px] text-slate-600">optional</span>
                                )}
                              </label>
                            ))}
                            <button
                              type="button"
                              onClick={() => setDbColVisible(defaultDbColVisible())}
                              className="mt-2 w-full text-[10px] font-bold text-orange-400 hover:text-orange-300"
                            >
                              Reset defaults
                            </button>
                          </div>
                        )}
                      </div>
                      <button
                        onClick={() => {
                          setCompetitionsSailorId(null);
                          setEditingSailorId("new");
                          setSailorForm({
                            id: "",
                            name: "",
                            handle: "",
                            sailNumber: "SGP ",
                            club: "",
                            nationality: "",
                            gender: "M",
                            nationalSquadStatus: "",
                            currentFleet: "",
                            instagram: "",
                                                    dob: "",
                            weight: "",
                            bio: "",
                            goldEntryDate: "",
                            silverEntryDate: "",
                            dropDate: "",
                            natSquadStatusJan25: "",
                            natSquadStatusJul25: "",
                            natSquadStatusJan26: "",
                            natSquadStatusJul26: "",
                            histRankingJun24: "",
                            histRankingDec24: "",
                            histRankingJun25: "",
                            histRankingDec25: "",
                            histRankingJun26: "",
                            worlds: "",
                            european: "",
                            asian: "",
                            seaGames: "",
                          });
                        }}
                        className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                      >
                        <Plus className="h-4 w-4" />
                        Add Sailor
                      </button>
                    </div>
                  </div>

                  <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse text-xs min-w-[720px]">
                      <thead>
                        <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                          <th className="py-3 px-3 w-10 text-center">
                            <input
                              type="checkbox"
                              checked={
                                sortedDbSailors.length > 0 &&
                                sortedDbSailors.every((s) =>
                                  selectedSailors.includes(s.id)
                                )
                              }
                              onChange={toggleSelectAllVisible}
                              className="rounded border-slate-700 bg-slate-900 text-orange-600 h-3.5 w-3.5"
                              title="Select all visible"
                            />
                          </th>
                          {DB_SAILOR_COLUMNS.filter((c) => colOn(c.key)).map((c) => (
                            <th
                              key={c.key}
                              className={`py-3 px-4 whitespace-nowrap ${
                                c.key === "best3" ||
                                c.key === "goldEntry" ||
                                c.key === "silverEntry" ||
                                c.key === "dropDate" ||
                                c.key.startsWith("hist") ||
                                ["worlds", "european", "asian", "seaGames"].includes(
                                  c.key
                                )
                                  ? "text-center"
                                  : ""
                              }`}
                            >
                              <button
                                type="button"
                                onClick={() => toggleDbSort(c.key)}
                                className="inline-flex items-center gap-1 hover:text-white"
                              >
                                {c.label}
                                {dbSortKey === c.key ? (
                                  dbSortDir === "asc" ? (
                                    <ArrowUp className="h-3 w-3 text-orange-400" />
                                  ) : (
                                    <ArrowDown className="h-3 w-3 text-orange-400" />
                                  )
                                ) : (
                                  <ArrowUpDown className="h-3 w-3 opacity-40" />
                                )}
                              </button>
                            </th>
                          ))}
                          <th className="py-3 px-4 text-right">Actions</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                        {sortedDbSailors.map((s) => {
                          const seriesLabel = seriesLabelOf(s);
                          const isChecked = selectedSailors.includes(s.id);
                          const cells: Record<string, any> = {
                            name: (
                              <span className="font-bold text-white">
                                {s.name}
                                {s.nationality && !colOn("nationality") ? (
                                  <span className="block text-[10px] font-semibold text-slate-500 mt-0.5">
                                    {s.nationality}
                                  </span>
                                ) : null}
                              </span>
                            ),
                            sailNumber: (
                              <span className="font-mono text-slate-400">
                                {s.sailNumber}
                              </span>
                            ),
                            series: (
                              <span
                                className={`text-[10px] font-bold px-2 py-0.5 rounded border ${
                                  seriesLabel.startsWith("Series")
                                    ? "bg-sky-500/10 text-sky-300 border-sky-500/25"
                                    : seriesLabel === "Dropped"
                                      ? "bg-amber-500/10 text-amber-300 border-amber-500/20"
                                      : "bg-white/5 text-slate-500 border-white/10"
                                }`}
                              >
                                {seriesLabel}
                              </span>
                            ),
                            best3: (
                              <span className="font-mono font-black text-white">
                                {best3BySailor[s.id] != null
                                  ? best3BySailor[s.id]
                                  : "—"}
                              </span>
                            ),
                            gender: s.gender || "M",
                            age: (() => {
                              const a = ageYears(s.dob as string | null);
                              return a != null ? (
                                <span className="font-mono text-white">{a}</span>
                              ) : (
                                <span className="text-slate-600">—</span>
                              );
                            })(),
                            club: s.club || "—",
                            nationality: s.nationality || "—",
                            school: s.school || "—",
                            goldEntry: (
                              <span className="font-mono">
                                {s.goldEntryDate
                                  ? String(s.goldEntryDate).slice(0, 10)
                                  : "-"}
                              </span>
                            ),
                            silverEntry: (
                              <span className="font-mono">
                                {s.silverEntryDate
                                  ? String(s.silverEntryDate).slice(0, 10)
                                  : "-"}
                              </span>
                            ),
                            dropDate: (
                              <span className="font-mono">
                                {s.dropDate ? String(s.dropDate).slice(0, 10) : "-"}
                              </span>
                            ),
                            squadJan25: s.natSquadStatusJan25 || "—",
                            squadJul25: s.natSquadStatusJul25 || "—",
                            squadJan26: s.natSquadStatusJan26 || "—",
                            squadJul26: s.natSquadStatusJul26 || "—",
                            histJun24: s.histRankingJun24 ?? "—",
                            histDec24: s.histRankingDec24 ?? "—",
                            histJun25: s.histRankingJun25 ?? "—",
                            histDec25: s.histRankingDec25 ?? "—",
                            histJun26: s.histRankingJun26 ?? "—",
                            worlds: s.worlds != null && s.worlds !== "" ? String(s.worlds) : "—",
                            european: s.european != null && s.european !== "" ? String(s.european) : "—",
                            asian: s.asian != null && s.asian !== "" ? String(s.asian) : "—",
                            seaGames: s.seaGames != null && s.seaGames !== "" ? String(s.seaGames) : "—",
                          };
                          return (
                            <tr
                              key={s.id}
                              className={`hover:bg-white/5 transition-colors ${
                                isChecked
                                  ? "bg-orange-500/5"
                                  : competitionsSailorId === s.id
                                    ? "bg-orange-500/[0.03]"
                                    : ""
                              }`}
                            >
                              <td className="py-3 px-3 text-center">
                                <input
                                  type="checkbox"
                                  checked={isChecked}
                                  onChange={() => toggleSelectSailor(s.id)}
                                  className="rounded border-slate-700 bg-slate-900 text-orange-600 h-3.5 w-3.5"
                                />
                              </td>
                              {DB_SAILOR_COLUMNS.filter((c) => colOn(c.key)).map(
                                (c) => (
                                  <td
                                    key={c.key}
                                    className={`py-3 px-4 ${
                                      c.key === "best3" ||
                                      c.key === "goldEntry" ||
                                      c.key === "silverEntry" ||
                                      c.key === "dropDate" ||
                                      c.key.startsWith("hist") ||
                                      [
                                        "worlds",
                                        "european",
                                        "asian",
                                        "seaGames",
                                      ].includes(c.key)
                                        ? "text-center font-mono"
                                        : ""
                                    }`}
                                  >
                                    {cells[c.key]}
                                  </td>
                                )
                              )}
                              <td className="py-3 px-4 text-right">
                                <div className="flex justify-end items-center gap-2">
                                  <button
                                    type="button"
                                    title="View & edit all regatta results for this sailor"
                                    onClick={(e) => {
                                      e.preventDefault();
                                      e.stopPropagation();
                                      void openSailorResults(s.id);
                                    }}
                                    className="inline-flex items-center gap-1 rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[10px] font-bold text-orange-300 hover:border-orange-500/40 hover:text-orange-200"
                                  >
                                    <Medal className="h-3.5 w-3.5" />
                                    Results
                                  </button>
                                  <button
                                    type="button"
                                    title="Edit profile"
                                    onClick={(e) => {
                                      e.preventDefault();
                                      e.stopPropagation();
                                      setCompetitionsSailorId(null);
                                      const d = (v: unknown) =>
                                        v ? String(v).slice(0, 10) : "";
                                      setSailorForm({
                                        ...s,
                                        weight: s.weight
                                          ? s.weight.toString()
                                          : "",
                                        nationalSquadStatus:
                                          s.natSquadStatusJul26 ||
                                          s.nationalSquadStatus ||
                                          "",
                                        natSquadStatusJan25:
                                          s.natSquadStatusJan25 || "",
                                        natSquadStatusJul25:
                                          s.natSquadStatusJul25 || "",
                                        natSquadStatusJan26:
                                          s.natSquadStatusJan26 || "",
                                        natSquadStatusJul26:
                                          s.natSquadStatusJul26 ||
                                          s.nationalSquadStatus ||
                                          "",
                                        nationality: s.nationality || "",
                                        currentFleet: s.currentFleet || "",
                                        school: s.school || "",
                                        histRankingJun24:
                                          s.histRankingJun24 != null
                                            ? String(s.histRankingJun24)
                                            : "",
                                        histRankingDec24:
                                          s.histRankingDec24 != null
                                            ? String(s.histRankingDec24)
                                            : "",
                                        histRankingJun25:
                                          s.histRankingJun25 != null
                                            ? String(s.histRankingJun25)
                                            : "",
                                        histRankingDec25:
                                          s.histRankingDec25 != null
                                            ? String(s.histRankingDec25)
                                            : "",
                                        histRankingJun26:
                                          s.histRankingJun26 != null
                                            ? String(s.histRankingJun26)
                                            : "",
                                        instagram: s.instagram || "",
                                        avatarUrl: s.avatarUrl || "",
                                        dob: d(s.dob),
                                        bio: s.bio || "",
                                        goldEntryDate: d(s.goldEntryDate),
                                        silverEntryDate: d(s.silverEntryDate),
                                        dropDate: d(s.dropDate),
                                        worlds: s.worlds != null ? String(s.worlds) : "",
                                        european: s.european != null ? String(s.european) : "",
                                        asian: s.asian != null ? String(s.asian) : "",
                                        seaGames: s.seaGames != null ? String(s.seaGames) : "",
                                      });
                                      setEditingSailorId(s.id);
                                    }}
                                    className="inline-flex items-center gap-1 rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40"
                                  >
                                    <Edit3 className="h-3.5 w-3.5" />
                                    Edit
                                  </button>
                                  <button
                                    type="button"
                                    title="Delete sailor"
                                    onClick={() => handleDeleteSailor(s.id)}
                                    className="text-slate-500 hover:text-red-400"
                                  >
                                    <Trash2 className="h-4 w-4" />
                                  </button>
                                </div>
                              </td>
                            </tr>
                          );
                        })}
                      </tbody>
                    </table>
                  </div>
                  <p className="px-4 py-2 text-[10px] text-slate-600 border-t border-white/5">
                    Tick rows for bulk edit · Best 3 of 5 = Jul–Dec 2026 series score ·
                    Results button = all competitions for that sailor · Columns for squad / overseas.
                  </p>
                </div>
              </div>
            )}

            {/* Sub-Tab Content: REGATTAS — split list + detail (not a tall single column) */}
            {editSubTab === "regattas" && (
              <div className="w-full min-w-0 space-y-4">
                <div className="glass-panel rounded-2xl border border-white/5 p-4 flex flex-col sm:flex-row sm:items-end gap-3 w-full">
                  <div className="flex-1 min-w-0">
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Search events
                    </label>
                    <input
                      type="search"
                      value={regattaSearch}
                      onChange={(e) => setRegattaSearch(e.target.value)}
                      placeholder="Name, date, division…"
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    />
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Division
                    </label>
                    <select
                      value={regattaDivisionFilter}
                      onChange={(e) => setRegattaDivisionFilter(e.target.value)}
                      className="mt-1 w-full sm:w-40 rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All</option>
                      <option value="Gold">Gold</option>
                      <option value="Silver">Silver</option>
                      <option value="Both">Both</option>
                      <option value="NonRanking">NonRanking</option>
                    </select>
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Ranking
                    </label>
                    <select
                      value={regattaRankingFilter}
                      onChange={(e) => setRegattaRankingFilter(e.target.value)}
                      className="mt-1 w-full sm:w-40 rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All events</option>
                      <option value="series">Series only</option>
                      <option value="nonranking">Non-ranking only</option>
                    </select>
                  </div>
                  <button
                    type="button"
                    onClick={() => {
                      setEditingRegattaId("new");
                      setRegattaForm({
                        id: "",
                        name: "",
                        date: new Date().toISOString().split("T")[0],
                        totalFleetSize: 50,
                        division: "Gold",
                        raceCount: "",
                        geography: "SG",
                        boatClass: "Optimist",
                        countsForRanking: true,
                      });
                    }}
                    className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2.5 text-xs font-bold text-white flex items-center justify-center gap-1 shrink-0"
                  >
                    <Plus className="h-4 w-4" />
                    Add regatta
                  </button>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 w-full min-w-0 items-start">
                  {/* Compact event list */}
                  <div className="lg:col-span-5 glass-panel rounded-2xl border border-white/5 overflow-hidden flex flex-col max-h-[min(70vh,720px)]">
                    <div className="px-4 py-3 border-b border-white/5 flex items-center justify-between shrink-0">
                      <h3 className="text-sm font-bold text-white">
                        Events{" "}
                        <span className="text-slate-500 font-semibold">
                          ({filteredRegattaList.length})
                        </span>
                      </h3>
                    </div>
                    <div className="overflow-y-auto flex-1 divide-y divide-white/5">
                      {filteredRegattaList.length === 0 ? (
                        <p className="p-6 text-xs text-slate-500 text-center">
                          No regattas match filters.
                        </p>
                      ) : (
                        filteredRegattaList.map((r) => {
                          const active = editingRegattaId === r.id;
                          return (
                            <button
                              key={r.id}
                              type="button"
                              onClick={() => {
                                setEditingRegattaId(r.id);
                                setRegattaForm({
                                  ...r,
                                  raceCount:
                                    r.raceCount != null ? String(r.raceCount) : "",
                                  totalFleetSize:
                                    r.totalFleetSize != null
                                      ? String(r.totalFleetSize)
                                      : "",
                                  geography: r.geography || "SG",
                                  boatClass: r.boatClass || "Optimist",
                                  countsForRanking: r.countsForRanking !== false,
                                });
                              }}
                              className={`w-full text-left px-4 py-3 transition-colors hover:bg-white/[0.04] ${
                                active
                                  ? "bg-orange-500/10 border-l-2 border-orange-500"
                                  : "border-l-2 border-transparent"
                              }`}
                            >
                              <p className="text-xs font-bold text-white truncate">
                                {r.name}
                                {r.countsForRanking === false && (
                                  <span className="ml-1.5 rounded-full bg-sky-500/15 border border-sky-500/30 px-1.5 py-0.5 text-[9px] font-black text-sky-300">
                                    Non-ranking
                                  </span>
                                )}
                              </p>
                              <p className="text-[10px] text-slate-500 mt-0.5 font-mono">
                                {regattaDateLabel(r.date)} · {r.geography || "SG"} ·{" "}
                                {r.boatClass || "Optimist"} · {r.division || "Gold"}{" "}
                                · fleet {r.totalFleetSize}
                              </p>
                            </button>
                          );
                        })
                      )}
                    </div>
                  </div>

                  {/* Detail / edit pane */}
                  <div className="lg:col-span-7 glass-panel rounded-2xl border border-white/5 p-5 sm:p-6 min-h-[320px]">
                    {!editingRegattaId ? (
                      <div className="h-full flex flex-col items-center justify-center text-center py-16 px-4">
                        <Calendar className="h-10 w-10 text-slate-600 mb-3" />
                        <p className="text-sm font-bold text-slate-300">
                          Select an event to edit
                        </p>
                        <p className="text-xs text-slate-500 mt-1 max-w-sm">
                          Choose a regatta from the list, or add a new one. Details
                          open here so the list stays compact.
                        </p>
                      </div>
                    ) : (
                      <div className="space-y-4">
                        <div className="flex items-start justify-between gap-3">
                          <div>
                            <h3 className="text-sm font-black text-white uppercase tracking-wider">
                              {editingRegattaId === "new"
                                ? "New regatta"
                                : "Edit regatta"}
                            </h3>
                            <p className="text-[11px] text-slate-500 mt-0.5">
                              Meta only — results stay under Results tab.
                            </p>
                          </div>
                          {editingRegattaId !== "new" && (
                            <button
                              type="button"
                              onClick={() => handleDeleteRegatta(editingRegattaId)}
                              className="text-slate-500 hover:text-red-400 p-1"
                              title="Delete regatta"
                            >
                              <Trash2 className="h-4 w-4" />
                            </button>
                          )}
                        </div>
                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                          <div className="sm:col-span-2">
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Event name
                            </label>
                            <input
                              type="text"
                              value={regattaForm.name}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  name: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="e.g. NSC Cup Series 1"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Date
                            </label>
                            <input
                              type="date"
                              value={regattaForm.date}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  date: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Total fleet size
                            </label>
                            <input
                              type="number"
                              value={regattaForm.totalFleetSize}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  totalFleetSize: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Division
                            </label>
                            <select
                              value={regattaForm.division || "Gold"}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  division: e.target.value,
                                  countsForRanking:
                                    e.target.value === "NonRanking"
                                      ? false
                                      : regattaForm.countsForRanking !== false,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                            >
                              <option value="Gold">Gold only</option>
                              <option value="Silver">Silver only</option>
                              <option value="Both">Both</option>
                              <option value="NonRanking">Non-ranking</option>
                            </select>
                          </div>
                          <div className="sm:col-span-2">
                            <label className="flex items-center gap-2 text-xs text-slate-300 cursor-pointer">
                              <input
                                type="checkbox"
                                checked={regattaForm.countsForRanking !== false}
                                onChange={(e) =>
                                  setRegattaForm({
                                    ...regattaForm,
                                    countsForRanking: e.target.checked,
                                    division: e.target.checked
                                      ? regattaForm.division === "NonRanking"
                                        ? "Gold"
                                        : regattaForm.division
                                      : "NonRanking",
                                  })
                                }
                                className="rounded border-slate-600"
                              />
                              <span>
                                <strong className="text-white">Counts for ranking</strong>
                                <span className="block text-[10px] text-slate-500">
                                  Off = logbook / overseas only — not used in Best 3 of 5
                                </span>
                              </span>
                            </label>
                            {regattaForm.countsForRanking === false && (
                              <p className="mt-2 rounded-lg border border-sky-500/30 bg-sky-500/10 px-2 py-1.5 text-[10px] font-bold text-sky-200">
                                Non-ranking event — clearly excluded from series scoring
                              </p>
                            )}
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Geography / country
                            </label>
                            <input
                              type="text"
                              value={regattaForm.geography || "SG"}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  geography: e.target.value.toUpperCase(),
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                              placeholder="SG"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Class
                            </label>
                            <input
                              type="text"
                              value={regattaForm.boatClass || "Optimist"}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  boatClass: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="Optimist"
                            />
                          </div>
                        </div>
                        <div className="flex flex-wrap justify-end gap-2 border-t border-white/5 pt-4">
                          <button
                            type="button"
                            onClick={() => setEditingRegattaId(null)}
                            className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                          >
                            Close
                          </button>
                          <button
                            type="button"
                            onClick={handleSaveRegatta}
                            className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                          >
                            Save regatta
                          </button>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            )}

            {/* Sub-Tab Content: RESULTS */}
            {editSubTab === "results" && (
              <div className="w-full min-w-0 space-y-6">
                {/* Period-wide DNS: every fleet sailor gets a result for each ranking regatta */}
                <div className="glass-panel rounded-3xl p-6 border border-rose-500/20 bg-rose-500/[0.03] space-y-3">
                  <h3 className="text-sm font-bold text-white uppercase tracking-wider">
                    Ensure DNS for fleet period
                  </h3>
                  <p className="text-xs text-slate-500 leading-relaxed">
                    Gold (or Silver) fleet sailors must have a result for{" "}
                    <strong className="text-slate-400">every ranking regatta</strong> in the
                    half-year they are in that fleet. Missing events get DNS = fleet size + 1.
                    Run this after importing period regattas. Edit overseas commitment scores
                    afterwards.
                  </p>
                  <div className="flex flex-wrap gap-2">
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() =>
                        void handleFillDnsForPeriod("Gold", 2026, "Jul-Dec")
                      }
                      className="rounded-full bg-rose-600/90 hover:bg-rose-500 disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                    >
                      Gold · Jul–Dec 2026
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() =>
                        void handleFillDnsForPeriod("Silver", 2026, "Jul-Dec")
                      }
                      className="rounded-full bg-slate-700 hover:bg-slate-600 disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                    >
                      Silver · Jul–Dec 2026
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() =>
                        void handleFillDnsForPeriod("Gold", 2026, "Jan-Jun")
                      }
                      className="rounded-full bg-white/5 border border-white/10 hover:bg-white/10 disabled:opacity-40 px-4 py-2 text-xs font-bold text-slate-300"
                    >
                      Gold · Jan–Jun 2026
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() =>
                        void handleFillDnsForPeriod("Silver", 2026, "Jan-Jun")
                      }
                      className="rounded-full bg-white/5 border border-white/10 hover:bg-white/10 disabled:opacity-40 px-4 py-2 text-xs font-bold text-slate-300"
                    >
                      Silver · Jan–Jun 2026
                    </button>
                  </div>
                </div>

                {/* Select Regatta Dropdown */}
                <div className="glass-panel rounded-3xl p-6 border border-white/5 flex flex-col md:flex-row md:items-center justify-between gap-4">
                  <div className="space-y-1">
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider">Select Regatta Event</h3>
                    <p className="text-xs text-slate-500">Choose a regatta to view and edit individual results.</p>
                  </div>
                  <select
                    value={selectedRegattaIdForResultEdit}
                    onChange={(e) => {
                      setSelectedRegattaIdForResultEdit(e.target.value);
                      setEditingResultId(null);
                    }}
                    className="rounded-xl border border-white/5 bg-slate-950 px-4 py-2.5 text-white text-xs font-semibold focus:outline-none w-full md:w-72"
                  >
                    <option value="" disabled>-- Choose Regatta --</option>
                    {regattaList.map((r) => (
                      <option key={r.id} value={r.id}>
                        {r.name} ({regattaDateLabel(r.date)})
                        {r.countsForRanking === false ? " · non-ranking" : ""}
                      </option>
                    ))}
                  </select>
                </div>

                {selectedRegattaIdForResultEdit &&
                  regattaList.find((r) => r.id === selectedRegattaIdForResultEdit)
                    ?.countsForRanking === false && (
                    <div className="rounded-xl border border-sky-500/30 bg-sky-500/10 px-4 py-3 text-xs font-bold text-sky-200">
                      This regatta is <strong>non-ranking</strong> — results here are
                      for logbook only and are not used in Best 3 of 5 series scoring.
                    </div>
                  )}

                {/* Result Form Card */}
                {editingResultId && (
                  <div className="glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider">
                      {editingResultId === "new" ? "Add Sailor Regatta Result" : "Edit Sailor Regatta Result"}
                    </h3>
                    {regattaList.find((r) => r.id === resultForm.regattaId)
                      ?.countsForRanking === false && (
                      <p className="text-[11px] text-sky-300 font-semibold">
                        Non-ranking event — not used in series rankings.
                      </p>
                    )}
                    <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Sailor Name</label>
                        <select
                          value={resultForm.sailorId}
                          onChange={(e) => setResultForm({ ...resultForm, sailorId: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="" disabled>-- Select Sailor --</option>
                          {sailorList.map((s) => (
                            <option key={s.id} value={s.id}>
                              {s.name} ({s.sailNumber})
                            </option>
                          ))}
                        </select>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Total Score</label>
                        <input
                          type="number"
                          step="any"
                          value={resultForm.totalScore}
                          onChange={(e) => setResultForm({ ...resultForm, totalScore: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="Optional"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Nett Score (optional)</label>
                        <input
                          type="number"
                          step="any"
                          value={resultForm.nettScore}
                          onChange={(e) => setResultForm({ ...resultForm, nettScore: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Rank (Finishing Pos)</label>
                        <input
                          type="number"
                          value={resultForm.rank}
                          onChange={(e) => {
                            const val = e.target.value;
                            const reg = regattaList.find(
                              (r) => r.id === resultForm.regattaId
                            );
                            const dnsPts =
                              (reg?.totalFleetSize || 50) + 1;
                            const n = Number(val);
                            // Better than DNS score (fleet+1) → uncheck DNS
                            const clearDns =
                              Number.isFinite(n) && n > 0 && n < dnsPts;
                            setResultForm({
                              ...resultForm,
                              rank: val,
                              ...(clearDns
                                ? { isDNS: false, isDns: false }
                                : {}),
                            });
                          }}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                        <p className="mt-1 text-[10px] text-slate-600">
                          DNS points = fleet+1. Enter a better rank to clear DNS.
                        </p>
                      </div>
                      <div className="flex items-center gap-2 h-full pt-5 md:pl-4">
                        <input
                          type="checkbox"
                          id="dnsCheckbox"
                          checked={Boolean(resultForm.isDNS || resultForm.isDns)}
                          onChange={(e) => {
                            const on = e.target.checked;
                            const reg = regattaList.find(
                              (r) => r.id === resultForm.regattaId
                            );
                            const dnsPts =
                              (reg?.totalFleetSize || 50) + 1;
                            setResultForm({
                              ...resultForm,
                              isDNS: on,
                              isDns: on,
                              // When marking DNS, default points to fleet+1 (editable)
                              ...(on
                                ? {
                                    rank: dnsPts,
                                  }
                                : {}),
                            });
                          }}
                          className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                        />
                        <label htmlFor="dnsCheckbox" className="text-xs font-bold text-slate-400 cursor-pointer">
                          Did Not Start (DNS) — sets rank to fleet+1; better rank auto-clears this
                        </label>
                      </div>
                      <div className="flex items-center gap-2 h-full pt-2 md:pl-4 md:col-span-2">
                        <input
                          type="checkbox"
                          id="overseasCheckbox"
                          checked={Boolean(resultForm.isOverseasCommitment)}
                          onChange={(e) => {
                            const on = e.target.checked;
                            setResultForm({
                              ...resultForm,
                              isOverseasCommitment: on,
                              // Overseas is not generic DNS
                              isDNS: on ? false : resultForm.isDNS,
                              isDns: on ? false : resultForm.isDns,
                            });
                          }}
                          className="rounded border-slate-700 bg-slate-900 text-sky-500 focus:ring-sky-500 h-4 w-4"
                        />
                        <label htmlFor="overseasCheckbox" className="text-xs font-bold text-sky-300/90 cursor-pointer leading-snug">
                          Overseas commitment (SSF) — set points to standing before trip (e.g. rank 2 → 2 pts); tag only, does not auto-calc
                        </label>
                      </div>
                    </div>

                    <div className="flex justify-end gap-2 border-t border-white/5 pt-4">
                      <button
                        onClick={() => setEditingResultId(null)}
                        className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                      >
                        Cancel
                      </button>
                      <button
                        onClick={handleSaveResult}
                        className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                      >
                        Save Result
                      </button>
                    </div>
                  </div>
                )}

                {/* Results List */}
                {selectedRegattaIdForResultEdit && (
                  <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
                    <div className="p-6 border-b border-white/5 flex flex-col lg:flex-row lg:items-center justify-between gap-4">
                      <div>
                        <h3 className="text-base font-bold text-white">Regatta Results Table</h3>
                        <p className="text-xs text-slate-500">Edit or delete scores for this event.</p>
                      </div>
                      <div className="flex flex-wrap items-end gap-3">
                        <button
                          type="button"
                          onClick={() =>
                            void handleFillDnsForRegatta(
                              selectedRegattaIdForResultEdit
                            )
                          }
                          className="rounded-full bg-slate-800 border border-rose-500/30 hover:bg-rose-500/10 px-4 py-2 text-xs font-bold text-rose-300 flex items-center gap-1"
                          title="Create DNS (fleet size + 1) for series members with no result"
                        >
                          Fill DNS for non-starters
                        </button>
                        <button
                          onClick={() => {
                            const reg = regattaList.find(
                              (r) => r.id === selectedRegattaIdForResultEdit
                            );
                            const dnsPts = (reg?.totalFleetSize || 50) + 1;
                            setEditingResultId("new");
                            setResultForm({
                              id: "",
                              regattaId: selectedRegattaIdForResultEdit,
                              sailorId: "",
                              rank: 1,
                              nettScore: "",
                              totalScore: "",
                              isDNS: false,
                              _dnsDefault: dnsPts,
                            });
                          }}
                          className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                        >
                          <Plus className="h-4 w-4" />
                          Add Score
                        </button>
                      </div>
                    </div>

                    <p className="px-6 pb-2 text-[11px] text-slate-500">
                      Non-starters: <strong className="text-slate-400">Fill DNS</strong> (fleet size + 1)
                      or mark <strong className="text-sky-300">Overseas commitment</strong> and set
                      points to their standing before the trip (e.g. 2nd → 2 pts). Both are editable.
                    </p>

                    <table className="w-full text-left border-collapse text-xs">
                      <thead>
                        <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                          <th className="py-4 px-4 text-center">Rank</th>
                          <th className="py-4 px-6">Name</th>
                          <th className="py-4 px-4 text-center">Gender</th>
                          <th className="py-4 px-4 text-center">Age</th>
                          <th className="py-4 px-4 text-center">Total Score</th>
                          <th className="py-4 px-4 text-center">Nett Score</th>
                          <th className="py-4 px-4 text-center">Status</th>
                          <th className="py-4 px-6 text-right">Actions</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                        {resultsList
                          .filter((res) => res.regattaId === selectedRegattaIdForResultEdit)
                          .slice()
                          .sort((a, b) => (a.rank || 999) - (b.rank || 999))
                          .map((res) => {
                            const sailor = sailorList.find((s) => s.id === res.sailorId);
                            const dns = Boolean(res.isDns || res.isDNS);
                            const overseas = Boolean(res.isOverseasCommitment);
                            const age = (() => {
                              if (!sailor?.dob) return "—";
                              const y = new Date(sailor.dob).getFullYear();
                              if (!Number.isFinite(y)) return "—";
                              return String(new Date().getFullYear() - y);
                            })();
                            return (
                              <tr
                                key={res.id}
                                className={`hover:bg-white/5 transition-colors ${
                                  overseas
                                    ? "bg-sky-500/[0.04]"
                                    : dns
                                      ? "bg-rose-500/[0.03]"
                                      : ""
                                }`}
                              >
                                <td className="py-4 px-4 text-center font-mono font-bold text-orange-400">
                                  {res.rank}
                                  {overseas ? "†" : dns ? "*" : ""}
                                </td>
                                <td className="py-4 px-6 font-bold text-white">
                                  {sailor ? sailor.name : "Deleted / Unmapped Sailor"}
                                </td>
                                <td className="py-4 px-4 text-center text-slate-300">
                                  {sailor?.gender || "—"}
                                </td>
                                <td className="py-4 px-4 text-center font-mono text-slate-300">
                                  {age}
                                </td>
                                <td className="py-4 px-4 text-center font-mono">
                                  {res.totalScore != null ? res.totalScore : "—"}
                                </td>
                                <td className="py-4 px-4 text-center font-mono">
                                  {res.nettScore != null ? res.nettScore : "—"}
                                </td>
                                <td className="py-4 px-4 text-center">
                                  <span className={`inline-block px-2 py-0.5 rounded text-[10px] ${
                                    overseas
                                      ? "bg-sky-500/10 text-sky-300 border border-sky-500/25"
                                      : dns
                                        ? "bg-rose-500/10 text-rose-500 border border-rose-500/20"
                                        : "bg-slate-800 text-slate-400"
                                  }`}>
                                    {overseas ? "Overseas" : dns ? "DNS" : "Finished"}
                                  </span>
                                </td>
                                <td className="py-4 px-6 text-right">
                                  <div className="flex justify-end items-center gap-2">
                                    <button
                                      onClick={() => {
                                        setEditingResultId(res.id);
                                        setResultForm({
                                          ...res,
                                          nettScore: res.nettScore?.toString?.() ?? res.nettScore,
                                          totalScore:
                                            res.totalScore != null
                                              ? String(res.totalScore)
                                              : "",
                                          rank: res.rank?.toString?.() ?? res.rank,
                                          isDNS: dns && !overseas,
                                          isDns: dns && !overseas,
                                          isOverseasCommitment: overseas,
                                        });
                                      }}
                                      className="text-slate-400 hover:text-white"
                                    >
                                      <Edit3 className="h-4 w-4" />
                                    </button>
                                    <button
                                      onClick={() => handleDeleteResult(res.id)}
                                      className="text-slate-500 hover:text-red-400"
                                    >
                                      <Trash2 className="h-4 w-4" />
                                    </button>
                                  </div>
                                </td>
                              </tr>
                            );
                          })}
                        {resultsList.filter((res) => res.regattaId === selectedRegattaIdForResultEdit).length === 0 && (
                          <tr>
                            <td colSpan={8} className="text-center py-12 text-slate-500">
                              No sailor results logged. Click Add Score or Fill DNS for non-starters.
                            </td>
                          </tr>
                        )}
                      </tbody>
                    </table>
                  </div>
                )}
              </div>
            )}

            {editSubTab === "suggestions" && (
              <div className="w-full min-w-0">
                {isSuperadmin ? (
                  <AdminSuggestionsPanel
                    onRegattaUpdated={(reg) => {
                      setRegattaList((prev) => {
                        const exists = prev.some((r) => r.id === reg.id);
                        return exists
                          ? prev.map((r) =>
                              r.id === reg.id ? { ...r, ...reg } : r
                            )
                          : [...prev, reg as RegattaAdmin];
                      });
                    }}
                  />
                ) : (
                  <p className="text-sm text-slate-500">
                    Suggestions require superadmin.
                  </p>
                )}
              </div>
            )}

            {editSubTab === "claims" && (
              <div className="w-full min-w-0">
                <ClaimsAdminPanel isSuperadmin={isSuperadmin} />
              </div>
            )}
            {editSubTab === "promote" && (
              <div className="w-full min-w-0">
                <PromoteAdminPanel
                  isSuperadmin={isSuperadmin}
                  onPromoted={(sailor) => {
                    setSailorList((prev) =>
                      prev.map((s) =>
                        s.id === sailor.id ? { ...s, ...sailor } : s
                      )
                    );
                  }}
                />
              </div>
            )}
            {editSubTab === "support" && (
              <div className="w-full min-w-0">
                <SupportInboxPanel isSuperadmin={isSuperadmin} />
              </div>
            )}
            </div>
            {/* end sub-tab content full-width shell */}
          </div>
        )}

        {activeTab === "stats" && (
          <div className="w-full min-w-0">
            {isSuperadmin ? (
              <AdminStatsPanel />
            ) : (
              <div className="glass-panel rounded-3xl p-6 border border-white/5 text-sm text-slate-400">
                Stats & usage require superadmin.
              </div>
            )}
          </div>
        )}
      </div>

      {/* Fixed modal: per-sailor results (always on top, outside scroll containers) */}
      {competitionsSailorId && (() => {
        const sailor = sailorList.find((x) => x.id === competitionsSailorId);
        const sid = competitionsSailorId;
        const sailorResults = resultsList
          .filter((r) => String(r.sailorId) === String(sid))
          .map((r) => {
            const reg = regattaList.find((g) => g.id === r.regattaId);
            return { ...r, regatta: reg };
          })
          .sort((a, b) => {
            const da = a.regatta?.date || "";
            const db_ = b.regatta?.date || "";
            return String(db_).localeCompare(String(da));
          });
        return (
          <div
            className="fixed inset-0 z-[200] flex items-end sm:items-center justify-center p-0 sm:p-4"
            role="dialog"
            aria-modal="true"
            aria-label="Sailor regatta results"
          >
            <button
              type="button"
              className="absolute inset-0 bg-black/70 backdrop-blur-sm"
              aria-label="Close"
              onClick={closeSailorResults}
            />
            <div className="relative z-10 w-full sm:max-w-4xl max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-3xl border border-orange-500/30 bg-[#0c0d14] shadow-2xl p-5 sm:p-6 space-y-4">
              <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3">
                <div>
                  <h3 className="text-base font-black text-white flex items-center gap-2">
                    <Medal className="h-5 w-5 text-orange-400" />
                    All regatta results — {sailor?.name || "Sailor"}
                  </h3>
                  <p className="text-xs text-slate-500 mt-1">
                    Edit rank / total / nett for each event, add a missing regatta, or delete.
                    {competitionsLoading ? " Refreshing…" : ""}
                  </p>
                  <p className="text-[11px] text-slate-600 mt-1">
                    {sailorResults.length} result
                    {sailorResults.length === 1 ? "" : "s"} found
                    {sailor?.sailNumber ? ` · ${sailor.sailNumber}` : ""}
                  </p>
                </div>
                <div className="flex flex-wrap gap-2">
                  <button
                    type="button"
                    onClick={() => {
                      setEditingResultId("new");
                      setResultForm({
                        id: "",
                        regattaId: regattaList[0]?.id || "",
                        sailorId: sid,
                        rank: 1,
                        nettScore: "",
                        totalScore: "",
                        isDNS: false,
                      });
                    }}
                    className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                  >
                    <Plus className="h-4 w-4" />
                    Add result
                  </button>
                  <button
                    type="button"
                    onClick={closeSailorResults}
                    className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-300 hover:text-white"
                  >
                    Close
                  </button>
                </div>
              </div>

              {editingResultId && (
                <div className="rounded-2xl border border-white/10 bg-slate-950/80 p-4 space-y-3">
                  <p className="text-[10px] font-bold text-slate-500 uppercase">
                    {editingResultId === "new" ? "New result" : "Edit result"}
                  </p>
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
                    <div className="sm:col-span-2">
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Regatta
                      </label>
                      <select
                        value={resultForm.regattaId}
                        onChange={(e) =>
                          setResultForm({
                            ...resultForm,
                            regattaId: e.target.value,
                            sailorId: sid,
                          })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                      >
                        <option value="">— Select —</option>
                        {regattaList.map((r) => (
                          <option key={r.id} value={r.id}>
                            {r.name} ({regattaDateLabel(r.date)}) · {r.division}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Rank
                      </label>
                      <input
                        type="number"
                        value={resultForm.rank}
                        onChange={(e) =>
                          setResultForm({ ...resultForm, rank: e.target.value })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                      />
                    </div>
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Total Score
                      </label>
                      <input
                        type="number"
                        step="any"
                        value={resultForm.totalScore}
                        onChange={(e) =>
                          setResultForm({
                            ...resultForm,
                            totalScore: e.target.value,
                          })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                      />
                    </div>
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Nett Score (optional)
                      </label>
                      <input
                        type="number"
                        step="any"
                        value={resultForm.nettScore}
                        onChange={(e) =>
                          setResultForm({
                            ...resultForm,
                            nettScore: e.target.value,
                          })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                      />
                    </div>
                    <div className="flex items-center gap-2 sm:col-span-2">
                      <input
                        type="checkbox"
                        id="modalDns"
                        checked={Boolean(resultForm.isDNS || resultForm.isDns)}
                        onChange={(e) => {
                          const on = e.target.checked;
                          const reg = regattaList.find(
                            (r) => r.id === resultForm.regattaId
                          );
                          const dnsPts = (reg?.totalFleetSize || 50) + 1;
                          setResultForm({
                            ...resultForm,
                            isDNS: on,
                            isDns: on,
                            ...(on ? { rank: dnsPts } : {}),
                          });
                        }}
                        className="rounded border-slate-700 bg-slate-900 text-orange-600 h-4 w-4"
                      />
                      <label htmlFor="modalDns" className="text-xs text-slate-400 font-bold cursor-pointer">
                        DNS (default rank = fleet size + 1; editable)
                      </label>
                    </div>
                    <div className="flex items-center gap-2 sm:col-span-2">
                      <input
                        type="checkbox"
                        id="modalOverseas"
                        checked={Boolean(resultForm.isOverseasCommitment)}
                        onChange={(e) => {
                          const on = e.target.checked;
                          setResultForm({
                            ...resultForm,
                            isOverseasCommitment: on,
                            isDNS: on ? false : resultForm.isDNS,
                            isDns: on ? false : resultForm.isDns,
                          });
                        }}
                        className="rounded border-slate-700 bg-slate-900 text-sky-500 h-4 w-4"
                      />
                      <label htmlFor="modalOverseas" className="text-xs text-sky-300/90 font-bold cursor-pointer leading-snug">
                        Overseas commitment (SSF) — set rank/pts to standing (e.g. 2nd → 2 pts)
                      </label>
                    </div>
                  </div>
                  <div className="flex justify-end gap-2">
                    <button
                      type="button"
                      onClick={() => setEditingResultId(null)}
                      className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400"
                    >
                      Cancel
                    </button>
                    <button
                      type="button"
                      onClick={() => void handleSaveResult()}
                      className="rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white"
                    >
                      Save result
                    </button>
                  </div>
                </div>
              )}

              <div className="overflow-x-auto rounded-xl border border-white/5">
                <table className="w-full text-left text-xs">
                  <thead>
                    <tr className="bg-white/5 text-[10px] font-bold text-slate-400 uppercase">
                      <th className="py-3 px-4">Regatta</th>
                      <th className="py-3 px-4 text-center">Date</th>
                      <th className="py-3 px-4 text-center">Div</th>
                      <th className="py-3 px-4 text-center">Rank</th>
                      <th className="py-3 px-4 text-center">Total</th>
                      <th className="py-3 px-4 text-center">Nett</th>
                      <th className="py-3 px-4 text-center">Status</th>
                      <th className="py-3 px-4 text-right">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-white/5 text-slate-300">
                    {sailorResults.map((r) => {
                      const dns = Boolean(r.isDns || r.isDNS);
                      const overseas = Boolean(r.isOverseasCommitment);
                      return (
                      <tr key={r.id || `${r.sailorId}-${r.regattaId}`} className="hover:bg-white/5">
                        <td className="py-3 px-4 font-bold text-white">
                          {r.regatta?.name || "Unknown regatta"}
                        </td>
                        <td className="py-3 px-4 text-center font-mono text-slate-400">
                          {r.regatta?.date
                            ? String(r.regatta.date).slice(0, 10)
                            : "—"}
                        </td>
                        <td className="py-3 px-4 text-center">
                          {r.regatta?.division || "—"}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.rank}{overseas ? "†" : dns ? "*" : ""}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.totalScore != null ? r.totalScore : "—"}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.nettScore != null ? r.nettScore : "—"}
                        </td>
                        <td className="py-3 px-4 text-center">
                          <span className={`text-[10px] px-2 py-0.5 rounded ${
                            overseas
                              ? "bg-sky-500/10 text-sky-300 border border-sky-500/25"
                              : dns
                                ? "bg-rose-500/10 text-rose-400 border border-rose-500/20"
                                : "text-slate-500"
                          }`}>
                            {overseas ? "Overseas" : dns ? "DNS" : "Finished"}
                          </span>
                        </td>
                        <td className="py-3 px-4 text-right">
                          <div className="flex justify-end gap-2">
                            <button
                              type="button"
                              onClick={() => {
                                setEditingResultId(r.id);
                                setResultForm({
                                  id: r.id,
                                  regattaId: r.regattaId,
                                  sailorId: sid,
                                  nettScore:
                                    r.nettScore?.toString?.() ?? r.nettScore,
                                  totalScore:
                                    r.totalScore != null
                                      ? String(r.totalScore)
                                      : "",
                                  rank: r.rank?.toString?.() ?? r.rank,
                                  isDNS: dns && !overseas,
                                  isDns: dns && !overseas,
                                  isOverseasCommitment: overseas,
                                });
                              }}
                              className="text-slate-400 hover:text-white"
                            >
                              <Edit3 className="h-4 w-4" />
                            </button>
                            <button
                              type="button"
                              onClick={() => void handleDeleteResult(r.id)}
                              className="text-slate-500 hover:text-red-400"
                            >
                              <Trash2 className="h-4 w-4" />
                            </button>
                          </div>
                        </td>
                      </tr>
                      );
                    })}
                    {!competitionsLoading && sailorResults.length === 0 && (
                      <tr>
                        <td
                          colSpan={8}
                          className="py-10 text-center text-slate-500"
                        >
                          No competitions logged yet. Click Add result (use DNS for non-starts).
                        </td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        );
      })()}
    </div>
  );
}
