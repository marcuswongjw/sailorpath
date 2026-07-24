"use client";

import { useState, useEffect, useMemo } from "react";
import {
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
  Plus,
  Trash2,
  Edit3,
  User,
  Medal,
  Copy,
} from "lucide-react";
import { getPercentileBadge } from "@/lib/ranking";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { findDuplicateSailorPairs } from "@/lib/nameMatch";
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
import { AdminRegattaImport } from "@/components/admin/AdminRegattaImport";
import { AdminResultsPanel } from "@/components/admin/AdminResultsPanel";
import { AdminRegattasPanel } from "@/components/admin/AdminRegattasPanel";
import { AdminSailorsPanel } from "@/components/admin/AdminSailorsPanel";
import { ageYears } from "@/lib/age";
import {
  halfBoundaryOptions,
  isHalfBoundaryYmd,
  todayYmdSg,
} from "@/lib/datesSg";
import {
  isInSgSeries,
  seriesMembershipLabel,
} from "@/lib/seriesMembership";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

/** Gold entry / drop: 1 Jan or 1 Jul only (half-year boundaries). */
const HALF_BOUNDARY_OPTS = halfBoundaryOptions();

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
      const inSeries = isInSgSeries(s);
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

  const handleCleanupEmptySeries = async () => {
    if (!isSuperadmin) {
      alert("Only Superadmins can run this.");
      return;
    }
    if (
      !confirm(
        `Stamp silver entry (Singapore today) on ${emptySeriesCount} Series sailor(s) with no entry dates?`
      )
    ) {
      return;
    }
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "stampEmptySeriesSilver" }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Cleanup failed");
      const list = await fetch("/api/admin/sailors").then((r) => r.json());
      if (list.sailors) setSailorList(list.sailors);
      alert(data.message || `Updated ${data.updated} sailors`);
    } catch (e: unknown) {
      alert(e instanceof Error ? e.message : "Cleanup failed");
    }
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
          <AdminRegattaImport
            isSuperadmin={isSuperadmin}
            onSailorsUpdated={(sailors) => setSailorList(sailors)}
            onRegattaUpserted={(regatta) => {
              setRegattaList((prev) => {
                const exists = prev.some((r) => r.id === regatta.id);
                return exists
                  ? prev.map((r) => (r.id === regatta.id ? regatta : r))
                  : [...prev, regatta];
              });
            }}
            onResultsUpdated={(results) => setResultsList(results)}
          />
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
              <AdminSailorsPanel
                isSuperadmin={isSuperadmin}
                sailorList={sailorList}
                filteredDbSailors={filteredDbSailors}
                sortedDbSailors={sortedDbSailors}
                selectedSailors={selectedSailors}
                setSelectedSailors={setSelectedSailors}
                dbSearch={dbSearch}
                setDbSearch={setDbSearch}
                dbFleetFilter={dbFleetFilter}
                setDbFleetFilter={setDbFleetFilter}
                dbSquadFilter={dbSquadFilter}
                setDbSquadFilter={setDbSquadFilter}
                setDbColVisible={setDbColVisible}
                dbColPickerOpen={dbColPickerOpen}
                setDbColPickerOpen={setDbColPickerOpen}
                dbSortKey={dbSortKey}
                dbSortDir={dbSortDir}
                toggleDbSort={toggleDbSort}
                colOn={colOn}
                seriesLabelOf={seriesLabelOf}
                best3BySailor={best3BySailor}
                duplicatePairs={duplicatePairs as any}
                bulkField={bulkField}
                setBulkField={setBulkField}
                bulkValue={bulkValue}
                setBulkValue={setBulkValue}
                handleApplyBulk={handleApplyBulk}
                handleBulkDelete={handleBulkDelete}
                handleMergeSailors={handleMergeSailors}
                toggleSelectSailor={toggleSelectSailor}
                toggleSelectAllVisible={toggleSelectAllVisible}
                editingSailorId={editingSailorId}
                setEditingSailorId={setEditingSailorId}
                sailorForm={sailorForm}
                setSailorForm={setSailorForm}
                handleSaveSailor={handleSaveSailor}
                handleDeleteSailor={handleDeleteSailor}
                showDuplicateFinder={showDuplicateFinder}
                setShowDuplicateFinder={setShowDuplicateFinder}
                ignoreDuplicatePair={ignoreDuplicatePair}
                bulkStatus={bulkStatus}
                openSailorResults={openSailorResults}
                competitionsSailorId={competitionsSailorId}
                setCompetitionsSailorId={setCompetitionsSailorId}
                emptySeriesCount={emptySeriesCount}
                onCleanupEmptySeries={handleCleanupEmptySeries}
              />
            )}

            {/* Sub-Tab Content: REGATTAS */}
            {editSubTab === "regattas" && (
              <AdminRegattasPanel
                isSuperadmin={isSuperadmin}
                filteredRegattaList={filteredRegattaList}
                regattaSearch={regattaSearch}
                setRegattaSearch={setRegattaSearch}
                regattaDivisionFilter={regattaDivisionFilter}
                setRegattaDivisionFilter={setRegattaDivisionFilter}
                regattaRankingFilter={regattaRankingFilter}
                setRegattaRankingFilter={setRegattaRankingFilter}
                editingRegattaId={editingRegattaId}
                setEditingRegattaId={setEditingRegattaId}
                regattaForm={regattaForm}
                setRegattaForm={setRegattaForm}
                handleSaveRegatta={handleSaveRegatta}
                handleDeleteRegatta={handleDeleteRegatta}
              />
            )}

            {/* Sub-Tab Content: RESULTS */}
            {editSubTab === "results" && (
              <AdminResultsPanel
                isSuperadmin={isSuperadmin}
                sailorList={sailorList}
                regattaList={regattaList}
                resultsList={resultsList}
                selectedRegattaIdForResultEdit={selectedRegattaIdForResultEdit}
                setSelectedRegattaIdForResultEdit={setSelectedRegattaIdForResultEdit}
                editingResultId={editingResultId}
                setEditingResultId={setEditingResultId}
                resultForm={resultForm}
                setResultForm={setResultForm}
                handleSaveResult={handleSaveResult}
                handleDeleteResult={handleDeleteResult}
                handleFillDnsForRegatta={handleFillDnsForRegatta}
                handleFillDnsForPeriod={handleFillDnsForPeriod}
              />
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
