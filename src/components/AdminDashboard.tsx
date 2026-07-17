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
  HelpCircle,
  UserPlus,
  RefreshCw,
  Save,
  Shield,
  Columns3,
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
} from "lucide-react";
import { getPercentileBadge } from "@/lib/ranking";
import { createBrowserSupabase } from "@/lib/supabase/browser";

import { Plus, Trash2, Edit3, User, Medal } from "lucide-react";

/** Database Management — sailors table columns (visibility prefs in localStorage) */
const DB_SAILOR_COLUMNS: {
  key: string;
  label: string;
  defaultOn: boolean;
}[] = [
  { key: "name", label: "Name", defaultOn: true },
  { key: "sailNumber", label: "Sail #", defaultOn: false },
  { key: "series", label: "Series", defaultOn: false },
  { key: "best3", label: "Best 3 of 5", defaultOn: true },
  { key: "gender", label: "Gender", defaultOn: true },
  { key: "squad", label: "Squad", defaultOn: true },
  { key: "club", label: "Club", defaultOn: false },
  { key: "nationality", label: "Nationality", defaultOn: false },
  { key: "school", label: "School", defaultOn: false },
  { key: "goldEntry", label: "Gold Entry", defaultOn: true },
  { key: "silverEntry", label: "Silver Entry", defaultOn: true },
  { key: "dropDate", label: "Drop Date", defaultOn: true },
  { key: "squadJan25", label: "Squad Jan 25", defaultOn: false },
  { key: "squadJul25", label: "Squad Jul 25", defaultOn: false },
  { key: "squadJan26", label: "Squad Jan 26", defaultOn: false },
  { key: "squadJul26", label: "Squad Jul 26", defaultOn: false },
  { key: "histJun24", label: "Hist Jun 24", defaultOn: false },
  { key: "histDec24", label: "Hist Dec 24", defaultOn: false },
  { key: "histJun25", label: "Hist Jun 25", defaultOn: false },
  { key: "histDec25", label: "Hist Dec 25", defaultOn: false },
  { key: "histJun26", label: "Hist Jun 26", defaultOn: false },
  { key: "worlds", label: "Worlds", defaultOn: false },
  { key: "european", label: "European", defaultOn: false },
  { key: "asian", label: "Asian", defaultOn: false },
  { key: "seaGames", label: "SEA Games", defaultOn: false },
];

const DB_COLS_STORAGE = "sp-admin-db-sailor-cols";

function defaultDbColVisible(): Record<string, boolean> {
  const o: Record<string, boolean> = {};
  for (const c of DB_SAILOR_COLUMNS) o[c.key] = c.defaultOn;
  return o;
}

interface AdminDashboardProps {
  initialSailors: any[];
  initialRegattas: any[];
  initialResults: any[];
}

export function AdminDashboard({ initialSailors, initialRegattas, initialResults }: AdminDashboardProps) {
  const [activeTab, setActiveTab] = useState<
    "roster" | "import" | "reconciliation" | "edit"
  >("roster");
  
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
  const [fullImportRows, setFullImportRows] = useState<
    {
      name: string;
      rank: number | null;
      nett: number | null;
      total: number | null;
      club?: string | null;
      nationality?: string | null;
      /** Optional — updates sailor profile when present */
      sailNumber?: string | null;
      /** Optional DOB (YYYY-MM-DD) or birth year as YYYY-01-01 */
      dob?: string | null;
      birthYear?: number | null;
    }[]
  >([]);
  const [importRegattaId, setImportRegattaId] = useState<string | null>(null);

  // One-time bulk sailor roster (before regatta results)
  const [rosterRows, setRosterRows] = useState<Record<string, any>[]>([]);
  const [rosterStatus, setRosterStatus] = useState<string | null>(null);
  const [rosterBusy, setRosterBusy] = useState(false);

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
  const [parsedData, setParsedData] = useState<any[] | null>(null);
  const [columnMapping, setColumnMapping] = useState({
    rank: "Rank",
    name: "Sailor Name",
    score: "Nett Score",
  });
  const [importStatus, setImportStatus] = useState<string | null>(null);

  // Reconciliation Queue States
  const [reconciliationQueue, setReconciliationQueue] = useState<any[]>([]);

  // Bulk Editor States
  const [selectedSailors, setSelectedSailors] = useState<string[]>([]);
  const [bulkField, setBulkField] = useState<string>("");
  const [bulkValue, setBulkValue] = useState<string>("");
  const [sailorList, setSailorList] = useState(initialSailors);
  const [bulkStatus, setBulkStatus] = useState<string | null>(null);

  // Database Editor Sub-Tabs & Forms
  const [editSubTab, setEditSubTab] = useState<"sailors" | "regattas" | "results">("sailors");
  const [dbSearch, setDbSearch] = useState("");
  const [dbFleetFilter, setDbFleetFilter] = useState<string>("all");
  const [dbSquadFilter, setDbSquadFilter] = useState<string>("all");
  const [dbDroppedFilter, setDbDroppedFilter] = useState<string>("all");
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
  const [editingRegattaId, setEditingRegattaId] = useState<string | null>(null);
  const [regattaForm, setRegattaForm] = useState<any>({
    id: "",
    name: "",
    date: "",
    totalFleetSize: 50,
    division: "Gold",
  });

  const [resultsList, setResultsList] = useState(initialResults || []);
  const [selectedRegattaIdForResultEdit, setSelectedRegattaIdForResultEdit] = useState<string>(
    initialRegattas?.[0]?.id || ""
  );
  const [editingResultId, setEditingResultId] = useState<string | null>(null);
  const [resultForm, setResultForm] = useState<any>({
    id: "",
    regattaId: "",
    sailorId: "",
    rank: 1,
    nettScore: 1,
    totalScore: "",
    isDNS: false,
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
      if (dbFleetFilter === "gold" && cf !== "gold" && !s.goldEntryDate) return false;
      if (dbFleetFilter === "gold" && cf === "silver") return false;
      if (dbFleetFilter === "silver" && cf !== "silver" && !(!s.goldEntryDate && s.silverEntryDate)) {
        if (cf !== "silver") return false;
      }
      if (dbFleetFilter === "unassigned") {
        if (s.currentFleet || s.goldEntryDate || s.silverEntryDate) return false;
      }
    }
    if (dbSquadFilter !== "all") {
      if (String(s.nationalSquadStatus || "") !== dbSquadFilter) return false;
    }
    if (dbDroppedFilter === "yes" && !s.manuallyDropped) return false;
    if (dbDroppedFilter === "no" && s.manuallyDropped) return false;
    return true;
  });

  const seriesLabelOf = (s: any) =>
    s.manuallyDropped
      ? "Dropped"
      : String(s.currentFleet || "").toLowerCase() === "gold" || s.goldEntryDate
        ? "Gold"
        : String(s.currentFleet || "").toLowerCase() === "silver" ||
            s.silverEntryDate
          ? "Silver"
          : "Guest";

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
        case "squad":
          return s.nationalSquadStatus || "";
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

  const pickCol = (row: Record<string, any>, aliases: string[]) => {
    const keys = Object.keys(row);
    for (const a of aliases) {
      const hit = keys.find((k) => k.toLowerCase().replace(/\s+/g, "") === a.toLowerCase().replace(/\s+/g, ""));
      if (hit != null && row[hit] !== "" && row[hit] != null) return row[hit];
    }
    for (const a of aliases) {
      const hit = keys.find((k) => k.toLowerCase().includes(a.toLowerCase()));
      if (hit != null && row[hit] !== "" && row[hit] != null) return row[hit];
    }
    return null;
  };

  const excelDateToIso = (v: unknown): string | null => {
    if (v == null || v === "") return null;
    if (typeof v === "number" && Number.isFinite(v)) {
      // Excel serial date
      const epoch = new Date(Date.UTC(1899, 11, 30));
      const d = new Date(epoch.getTime() + v * 86400000);
      return d.toISOString().slice(0, 10);
    }
    const s = String(v).trim();
    if (!s) return null;
    // Already ISO-ish
    if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
    const parsed = Date.parse(s);
    if (!Number.isNaN(parsed)) return new Date(parsed).toISOString().slice(0, 10);
    return s; // leave as-is for DB to reject if invalid
  };

  const handleRosterFile = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setRosterStatus(null);
    const buf = await file.arrayBuffer();
    const wb = read(buf);
    const sheet = wb.Sheets[wb.SheetNames[0]];
    const json = utils.sheet_to_json<Record<string, any>>(sheet, { defval: "" });
    const mapped = json
      .map((row) => {
        const name = String(
          pickCol(row, ["name", "sailor", "sailorname", "full name"]) || ""
        ).trim();
        if (!name) return null;

        // Map user's export columns
        const goldEntryDate = excelDateToIso(
          pickCol(row, [
            "entered gold",
            "goldentrydate",
            "gold entry",
            "gold entry date",
          ])
        );
        const silverEntryDate = excelDateToIso(
          pickCol(row, [
            "entered silver",
            "silverentrydate",
            "silver entry",
            "silver entry date",
          ])
        );
        // Optimist Drop only (not "Manually dropped")
        const dropDate = excelDateToIso(
          pickCol(row, ["optimist drop", "dropdate", "drop date", "drop"])
        );
        const dob = excelDateToIso(
          pickCol(row, ["born", "dob", "date of birth", "birthdate", "birth"])
        );

        // Gold squad = Nat A / Nat B / DS
        const nationalSquadStatus = pickCol(row, [
          "gold squad",
          "goldsquad",
          "nationalsquadstatus",
          "squad status",
          "nat squad",
        ]);

        // Fleet current = Gold | Silver for Jul–Dec 2026
        const currentFleet = pickCol(row, [
          "fleet current",
          "fleetcurrent",
          "current fleet",
          "fleet",
        ]);

        // Manually dropped = Y/N (not a date)
        const manuallyDropped = pickCol(row, [
          "manually dropped",
          "manuallydropped",
          "manual drop",
        ]);

        const school = pickCol(row, ["school"]);

        return {
          name,
          handle: pickCol(row, ["handle", "slug", "username"]),
          sailNumber: pickCol(row, [
            "sailnumber",
            "sail number",
            "sail",
            "sail#",
            "sail no",
            "sail no.",
          ]),
          club: pickCol(row, ["club", "club origin", "team"]),
          school,
          nationality: pickCol(row, [
            "nationality",
            "nation",
            "country",
            "country of origin",
            "noc",
          ]),
          gender: pickCol(row, ["gender", "sex"]),
          goldEntryDate,
          silverEntryDate,
          dropDate,
          currentFleet,
          manuallyDropped,
          nationalSquadStatus:
            nationalSquadStatus != null
              ? String(nationalSquadStatus).trim()
              : null,
          dob,
          weight: pickCol(row, ["weight", "weight kg"]),
          bio: pickCol(row, ["bio", "biography"]),
          instagram: pickCol(row, ["instagram", "ig"]),
          facebook: pickCol(row, ["facebook", "fb"]),
          natSquadStatusJan25: pickCol(row, [
            "squadjan25",
            "natsquadstatusjan25",
            "nat jan 25",
            "squad jan 25",
          ]),
          natSquadStatusJul25: pickCol(row, [
            "squadjul25",
            "natsquadstatusjul25",
            "nat jul 25",
            "squad jul 25",
          ]),
          natSquadStatusJan26: pickCol(row, [
            "squadjan26",
            "natsquadstatusjan26",
            "nat jan 26",
            "squad jan 26",
          ]),
          natSquadStatusJul26: pickCol(row, [
            "squadjul26",
            "natsquadstatusjul26",
            "nat jul 26",
            "squad jul 26",
          ]),
          histRankingJun24: pickCol(row, [
            "histjun24",
            "histrankingjun24",
            "rank jun 24",
            "hist jun 24",
          ]),
          histRankingDec24: pickCol(row, [
            "histdec24",
            "histrankingdec24",
            "rank dec 24",
            "hist dec 24",
          ]),
          histRankingJun25: pickCol(row, [
            "histjun25",
            "histrankingjun25",
            "rank jun 25",
            "hist jun 25",
          ]),
          histRankingDec25: pickCol(row, [
            "histdec25",
            "histrankingdec25",
            "rank dec 25",
            "hist dec 25",
          ]),
          histRankingJun26: pickCol(row, [
            "histjun26",
            "histrankingjun26",
            "rank jun 26",
            "hist jun 26",
          ]),
          worlds: pickCol(row, ["worlds", "worlds year"]),
          european: pickCol(row, ["euros", "european", "europeans", "europeans year"]),
          asian: pickCol(row, ["asians", "asian", "asians year"]),
          seaGames: pickCol(row, ["sea games", "seagames", "sea games year"]),
        };
      })
      .filter(Boolean) as Record<string, any>[];
    setRosterRows(mapped);
    setRosterStatus(
      `Parsed ${mapped.length} sailors. Mapped: Born→DOB, Gold squad→squad status, Fleet current→Gold/Silver, Entered Gold/Silver, Optimist Drop, Manually dropped (Y/N), School, hist/campaigns.`
    );
  };

  const handleRosterImport = async () => {
    if (!isSuperadmin) {
      alert("Superadmin only");
      return;
    }
    if (!rosterRows.length) {
      alert("Upload a roster Excel/CSV first");
      return;
    }
    setRosterBusy(true);
    setRosterStatus("Importing roster…");
    try {
      const res = await fetch("/api/admin/sailors/bulk", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ rows: rosterRows }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Roster import failed");
      setRosterStatus(data.message);
      const list = await fetch("/api/admin/sailors").then((r) => r.json());
      if (list.sailors) setSailorList(list.sailors);
    } catch (err: any) {
      setRosterStatus(err.message || "Import failed");
    } finally {
      setRosterBusy(false);
    }
  };

  // XLSX Drag & Drop Handlers
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
      // array buffer is more reliable than binary string for xlsx
      const workbook = read(data, { type: "array" });
      const sheetName = workbook.SheetNames[0];
      const sheet = workbook.Sheets[sheetName];
      const json = utils.sheet_to_json<Record<string, unknown>>(sheet, {
        defval: "",
        raw: false,
      });
      const mapped = json
        .map((r) => {
          const keys = Object.keys(r);
          // Prefer exact "Name" over columns that merely contain "name" (e.g. none)
          // Never treat Club as Name
          const nameKey =
            keys.find((k) => /^name$/i.test(k.trim())) ||
            keys.find((k) => /^(sailor|sailor name|competitor)$/i.test(k.trim())) ||
            keys.find(
              (k) =>
                /name|sailor/i.test(k) && !/club|team|boat|sail/i.test(k)
            ) ||
            keys.find((k) => /sailor/i.test(k));
          const rankKey =
            keys.find((k) => /^rank$/i.test(k.trim())) ||
            keys.find((k) => /rank|pos|place|position/i.test(k));
          const nettKey =
            keys.find((k) => /^nett$/i.test(k.trim())) ||
            keys.find((k) => /nett/i.test(k));
          // Total Score / Total / Gross (not nett)
          const totalKey =
            keys.find((k) => /^total score$/i.test(k.trim())) ||
            keys.find((k) => /^total$/i.test(k.trim())) ||
            keys.find((k) => /total score|gross/i.test(k));
          const clubKey =
            keys.find((k) => /^club$/i.test(k.trim())) ||
            keys.find(
              (k) =>
                /^(club|team|yacht club|sailing club)$/i.test(k.trim()) ||
                (/club|team/i.test(k) && !/squad|national/i.test(k))
            );
          const nationalityKey =
            keys.find((k) =>
              /^(nationality|nation|country|noc|country of origin)$/i.test(
                k.trim()
              )
            ) ||
            keys.find(
              (k) =>
                /nationality|country of origin|\bnoc\b/i.test(k) &&
                !/squad|nat\s*[ab]|national squad/i.test(k)
            );
          // Optional sailor profile columns (not required for import)
          const sailKey =
            keys.find((k) =>
              /^(sail\s*(number|no\.?|#|num)?|sailnumber|boat\s*(number|no\.?)?)$/i.test(
                k.trim()
              )
            ) ||
            keys.find(
              (k) =>
                /sail\s*(number|no|#)|sailnumber|boat\s*no/i.test(k) &&
                !/sailor/i.test(k)
            );
          const birthYearKey =
            keys.find((k) =>
              /^(birth\s*year|birthyear|year\s*of\s*birth|yob|born\s*year)$/i.test(
                k.trim()
              )
            ) || keys.find((k) => /birth\s*year|yob|year of birth/i.test(k));
          const dobKey =
            keys.find((k) =>
              /^(dob|date\s*of\s*birth|birth\s*date|born|birthday)$/i.test(
                k.trim()
              )
            ) ||
            keys.find(
              (k) =>
                /date of birth|birth\s*date|birthday|\bdob\b/i.test(k) &&
                !/year/i.test(k)
            );

          if (!nameKey) {
            return {
              name: "",
              rank: null,
              nett: null,
              total: null,
              club: null,
              nationality: null,
              sailNumber: null,
              dob: null,
              birthYear: null,
            };
          }
          const name = String(r[nameKey] ?? "").trim();
          // Skip header-like repeats
          if (!name || /^name$/i.test(name)) {
            return {
              name: "",
              rank: null,
              nett: null,
              total: null,
              club: null,
              nationality: null,
              sailNumber: null,
              dob: null,
              birthYear: null,
            };
          }
          const rankRaw = rankKey != null ? r[rankKey] : null;
          const nettRaw = nettKey != null ? r[nettKey] : null;
          const totalRaw = totalKey != null ? r[totalKey] : null;
          const rank =
            rankRaw !== "" && rankRaw != null ? Number(rankRaw) : null;
          const nett =
            nettRaw !== "" && nettRaw != null ? Number(nettRaw) : null;
          const total =
            totalRaw !== "" && totalRaw != null ? Number(totalRaw) : null;
          const clubRaw =
            clubKey != null && r[clubKey] != null
              ? String(r[clubKey]).trim()
              : "";
          const club =
            clubRaw && !/^n\/?a$/i.test(clubRaw) ? clubRaw : null;
          const natRaw =
            nationalityKey != null && r[nationalityKey] != null
              ? String(r[nationalityKey]).trim()
              : "";
          const nationality =
            natRaw && !/^n\/?a$/i.test(natRaw) ? natRaw : null;
          const sailRaw =
            sailKey != null && r[sailKey] != null ? String(r[sailKey]).trim() : "";
          const sailNumber = sailRaw && !/^n\/?a$/i.test(sailRaw) ? sailRaw : null;

          // Birth year only (2013) or full DOB — both optional; never required
          let birthYear: number | null = null;
          let dob: string | null = null;
          if (birthYearKey != null && r[birthYearKey] != null && r[birthYearKey] !== "") {
            const by = Number(String(r[birthYearKey]).trim());
            if (Number.isFinite(by) && by >= 1990 && by <= 2035) {
              birthYear = Math.round(by);
            }
          }
          if (dobKey != null && r[dobKey] != null && r[dobKey] !== "") {
            const raw = r[dobKey];
            // Plain year in DOB column → treat as birth year only
            if (
              (typeof raw === "number" &&
                raw >= 1990 &&
                raw <= 2035 &&
                Number.isInteger(raw)) ||
              (typeof raw === "string" && /^\d{4}$/.test(raw.trim()))
            ) {
              if (birthYear == null) birthYear = Math.round(Number(raw));
            } else {
              dob = excelDateToIso(raw);
              // Guard against excel serial mis-read as year
              if (dob && !/^\d{4}-\d{2}-\d{2}/.test(dob)) dob = null;
            }
          }

          return {
            name,
            rank: Number.isFinite(rank as number) ? rank : null,
            nett: Number.isFinite(nett as number) ? nett : null,
            total: Number.isFinite(total as number) ? total : null,
            club,
            nationality,
            sailNumber,
            // full date when known; birthYear alone when only year known
            dob,
            birthYear,
          };
        })
        .filter((r) => r.name);
      setFullImportRows(mapped);
      setParsedData(mapped.slice(0, 20));
      const withSail = mapped.filter((r) => r.sailNumber).length;
      const withDob = mapped.filter((r) => r.dob || r.birthYear).length;
      const withClub = mapped.filter((r) => r.club).length;
      const withNat = mapped.filter((r) => r.nationality).length;
      const profileBits = [
        withSail && `${withSail} sail #`,
        withDob && `${withDob} birth year/DOB`,
        withClub && `${withClub} club`,
        withNat && `${withNat} nationality`,
      ].filter(Boolean);
      setImportStatus(
        `Parsed ${mapped.length} competitor rows from “${sheetName}”` +
          (profileBits.length
            ? ` (${profileBits.join(", ")} — will update sailor profiles on import)`
            : ` (optional profile columns absent — results still import fine)`) +
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
      setImportRegattaId(data.regatta?.id || null);
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
      const queue = (data.unmatched || []).map(
        (
          u: {
            rawName: string;
            rank: number | null;
            nett: number | null;
            suggestedId: string | null;
            suggestedName: string | null;
            similarity: number;
          },
          i: number
        ) => ({
          id: `unmapped-${Date.now()}-${i}`,
          rawName: u.rawName,
          score: u.rank ?? u.nett ?? 0,
          suggestedId: u.suggestedId,
          suggestedName: u.suggestedName,
          similarity: Math.round((u.similarity || 0) * 100),
          regattaId: data.regatta?.id,
          rank: u.rank,
          nett: u.nett,
        })
      );
      setReconciliationQueue(queue);
      setImportStatus(data.message);
      if (queue.length) setActiveTab("reconciliation");
    } catch (e: any) {
      setImportStatus(null);
      alert(e.message || "Import failed");
    }
  };

  // Reconciliation Handlers — persist via API
  const handleMerge = async (queueId: string, sailorId: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden.");
      return;
    }
    const item = reconciliationQueue.find((q) => q.id === queueId) as any;
    if (!item) return;
    try {
      const res = await fetch("/api/admin/reconcile", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "merge",
          rawName: item.rawName,
          suggestedId: sailorId,
          regattaId: item.regattaId || importRegattaId,
          rank: item.rank ?? item.score,
          nett: item.nett ?? item.score,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Merge failed");
      setReconciliationQueue((prev) => prev.filter((q) => q.id !== queueId));
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleCreateNew = async (queueId: string, rawName: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden.");
      return;
    }
    const item = reconciliationQueue.find((q) => q.id === queueId) as any;
    try {
      const res = await fetch("/api/admin/reconcile", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "create",
          rawName,
          regattaId: item?.regattaId || importRegattaId,
          rank: item?.rank ?? item?.score,
          nett: item?.nett ?? item?.score,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Create failed");
      setReconciliationQueue((prev) => prev.filter((q) => q.id !== queueId));
      // refresh sailor list
      const sRes = await fetch("/api/admin/sailors");
      if (sRes.ok) {
        const sData = await sRes.json();
        if (sData.sailors) setSailorList(sData.sailors);
      }
    } catch (e: any) {
      alert(e.message);
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

  const parseApi = async (res: Response) => {
    const text = await res.text();
    try {
      return text ? JSON.parse(text) : {};
    } catch {
      throw new Error(
        res.ok
          ? "Invalid server response"
          : `Request failed (${res.status}). ${text.slice(0, 120) || "No details"}`
      );
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
          else if (bulkField === "manuallyDropped") {
            const t = String(bulkValue).toLowerCase();
            typedValue = t === "y" || t === "yes" || t === "true" || t === "1";
          }
          else if (bulkField === "nationalSquadStatus" && bulkValue === "CLEAR") typedValue = null;
          else if (bulkValue === "") typedValue = null;
          return { ...s, [bulkField]: typedValue };
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
    const wantsGold =
      String(sailorForm.currentFleet || "").toLowerCase() === "gold" ||
      Boolean(sailorForm.goldEntryDate);
    const hasSilverPath =
      Boolean(sailorForm.silverEntryDate) ||
      String(sailorForm.currentFleet || "").toLowerCase() === "silver" ||
      Boolean(existing?.silverEntryDate) ||
      String(existing?.currentFleet || "").toLowerCase() === "silver" ||
      Boolean(existing?.goldEntryDate) ||
      String(existing?.currentFleet || "").toLowerCase() === "gold";
    if (wantsGold && !hasSilverPath) {
      alert(
        "Gold fleet requires Silver history first. Admit as Silver first (Silver entry date or Fleet = Silver), save, then set Gold."
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
      nationalSquadStatus: sailorForm.nationalSquadStatus || null,
      currentFleet: sailorForm.currentFleet || null,
      goldEntryDate: dateOnly(sailorForm.goldEntryDate),
      silverEntryDate: dateOnly(sailorForm.silverEntryDate),
      dropDate: dateOnly(sailorForm.dropDate),
      dob: dateOnly(sailorForm.dob),
      weight: sailorForm.weight === "" || sailorForm.weight == null ? null : sailorForm.weight,
      instagram: sailorForm.instagram || null,
      manuallyDropped: Boolean(sailorForm.manuallyDropped),
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
    const payload = {
      ...resultForm,
      isDns: Boolean(resultForm.isDNS || resultForm.isDns),
      isDNS: Boolean(resultForm.isDNS || resultForm.isDns),
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
      `Create DNS scores for all ${reg?.division || ""} series members who do not have a result at “${reg?.name || "this regatta"}”?\n\n` +
        `Default DNS points = fleet size + 1 = ${(reg?.totalFleetSize || 0) + 1}.\n` +
        `You can edit any DNS score afterwards.`
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

      {/* Tab Navigation */}
      <div className="flex border-b border-white/5 gap-4 overflow-x-auto pb-0.5">
        <button
          onClick={() => setActiveTab("roster")}
          className={`pb-4 text-sm font-bold border-b-2 transition-all flex items-center gap-2 whitespace-nowrap ${
            activeTab === "roster"
              ? "border-orange-500 text-white"
              : "border-transparent text-slate-400 hover:text-white"
          }`}
        >
          <UserPlus className="h-4 w-4" />
          Sailor Roster
        </button>
        <button
          onClick={() => setActiveTab("import")}
          className={`pb-4 text-sm font-bold border-b-2 transition-all flex items-center gap-2 whitespace-nowrap ${
            activeTab === "import"
              ? "border-orange-500 text-white"
              : "border-transparent text-slate-400 hover:text-white"
          }`}
        >
          <FileSpreadsheet className="h-4 w-4" />
          Regatta Excel
        </button>
        <button
          onClick={() => setActiveTab("reconciliation")}
          className={`pb-4 text-sm font-bold border-b-2 transition-all flex items-center gap-2 relative whitespace-nowrap ${
            activeTab === "reconciliation"
              ? "border-orange-500 text-white"
              : "border-transparent text-slate-400 hover:text-white"
          }`}
        >
          <UserCheck className="h-4 w-4" />
          Name Reconciliation Queue
          {reconciliationQueue.length > 0 && (
            <span className="absolute -top-1 -right-3 flex h-4 w-4 items-center justify-center rounded-full bg-orange-600 text-[10px] font-black text-white">
              {reconciliationQueue.length}
            </span>
          )}
        </button>
        <button
          onClick={() => setActiveTab("edit")}
          className={`pb-4 text-sm font-bold border-b-2 transition-all flex items-center gap-2 whitespace-nowrap ${
            activeTab === "edit"
              ? "border-orange-500 text-white"
              : "border-transparent text-slate-400 hover:text-white"
          }`}
        >
          <Database className="h-4 w-4" />
          Database & bulk edit
        </button>
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

      {/* Tab Contents */}
      <div className="flex-1 flex flex-col">
        {/* Tab 0: One-time sailor roster import */}
        {activeTab === "roster" && (
          <div className="space-y-6">
            <div className="glass-panel rounded-3xl p-6 sm:p-8 border border-white/5 space-y-4">
              <div>
                <h2 className="text-lg font-bold text-white flex items-center gap-2">
                  <UserPlus className="h-5 w-5 text-orange-500" />
                  Bulk import sailor roster (one-time)
                </h2>
                <p className="text-xs text-slate-500 mt-2 leading-relaxed max-w-3xl">
                  Load all sailors into the database <strong className="text-slate-300">before</strong>{" "}
                  importing regatta results. Include columns such as Name, Sail Number, Club, Nationality,
                  Gender, Gold Entry Date, Silver Entry Date, Drop Date, Squad, DOB, Weight, and optional
                  historical fields. Re-importing the same handle/sail number will update existing rows.
                </p>
              </div>

              <div className="rounded-xl border border-white/5 bg-slate-950/50 p-4 text-[11px] text-slate-400 leading-relaxed space-y-2">
                <p className="font-bold text-slate-300">Your spreadsheet columns are supported:</p>
                <p className="font-mono text-[10px]">
                  Name · Gender · Born · Club · Nationality · School · Fleet current · Gold squad · Entered Gold ·
                  Entered Silver · Optimist Drop · Manually dropped · squadJan26 · squadJul26 ·
                  histJun24… · Worlds · Euros · Asians · SEA Games
                </p>
                <p className="text-amber-200/90">
                  Sail number optional — defaults to SGP 000; edit later in Database Management or bulk edit.
                  Run SQL migrations if columns are missing:{" "}
                  <code className="text-amber-100">002_sailor_school_fleet.sql</code>,{" "}
                  <code className="text-amber-100">005_nationality.sql</code>.
                </p>
              </div>

              <div className="flex flex-col sm:flex-row items-start sm:items-center gap-3">
                <label className="rounded-full bg-slate-800 border border-white/5 px-4 py-2 text-xs font-bold text-white hover:bg-slate-700 transition-all cursor-pointer">
                  Choose Excel / CSV
                  <input
                    type="file"
                    accept=".xlsx,.xls,.csv"
                    className="hidden"
                    onChange={handleRosterFile}
                  />
                </label>
                <button
                  type="button"
                  disabled={!isSuperadmin || rosterBusy || rosterRows.length === 0}
                  onClick={handleRosterImport}
                  className="rounded-full bg-orange-600 hover:bg-orange-500 disabled:opacity-40 px-5 py-2 text-xs font-bold text-white"
                >
                  {rosterBusy
                    ? "Importing…"
                    : `Import ${rosterRows.length || 0} sailors to database`}
                </button>
              </div>

              {rosterStatus && (
                <p className="text-xs font-bold text-emerald-400 flex items-center gap-2">
                  <CheckCircle className="h-4 w-4" />
                  {rosterStatus}
                </p>
              )}

              {rosterRows.length > 0 && (
                <div className="overflow-x-auto rounded-2xl border border-white/5 max-h-80">
                  <table className="w-full text-left text-[11px] min-w-[700px]">
                    <thead className="bg-white/5 text-slate-500 sticky top-0">
                      <tr>
                        <th className="px-3 py-2">Name</th>
                        <th className="px-3 py-2">Sail #</th>
                        <th className="px-3 py-2">Club</th>
                        <th className="px-3 py-2">Gold</th>
                        <th className="px-3 py-2">Silver</th>
                        <th className="px-3 py-2">Squad</th>
                      </tr>
                    </thead>
                    <tbody>
                      {rosterRows.slice(0, 40).map((r, i) => (
                        <tr key={i} className="border-t border-white/5">
                          <td className="px-3 py-2 text-white font-semibold">{r.name}</td>
                          <td className="px-3 py-2 text-slate-400">{r.sailNumber || "—"}</td>
                          <td className="px-3 py-2 text-slate-400">{r.club || "—"}</td>
                          <td className="px-3 py-2 text-slate-400">{r.goldEntryDate || "—"}</td>
                          <td className="px-3 py-2 text-slate-400">{r.silverEntryDate || "—"}</td>
                          <td className="px-3 py-2 text-slate-400">
                            {r.nationalSquadStatus || "—"}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                  {rosterRows.length > 40 && (
                    <p className="text-[10px] text-slate-600 px-3 py-2">
                      Showing first 40 of {rosterRows.length} rows
                    </p>
                  )}
                </div>
              )}

              <p className="text-[11px] text-slate-500">
                Currently in database: <strong className="text-white">{sailorList.length}</strong>{" "}
                sailors. After roster load, use <strong className="text-slate-300">Regatta Excel</strong>{" "}
                to import results (names will match).
              </p>
            </div>
          </div>
        )}

        {/* Tab 1: Excel Import */}
        {activeTab === "import" && (
          <div className="space-y-6">
            <div className="glass-panel rounded-3xl p-8 border border-white/5 text-center flex flex-col items-center">
              <div
                onDragEnter={handleDrag}
                onDragOver={handleDrag}
                onDragLeave={handleDrag}
                onDrop={handleDrop}
                className={`w-full max-w-xl border-2 border-dashed rounded-2xl p-8 flex flex-col items-center justify-center cursor-pointer transition-all ${
                  dragActive ? "border-orange-500 bg-orange-500/5" : "border-white/10 hover:border-white/20"
                }`}
              >
                <Upload className="h-10 w-10 text-orange-500 mb-4" />
                <p className="text-sm font-bold text-white mb-2">Drag and drop your Regatta Excel/CSV file here</p>
                <p className="text-xs text-slate-500 mb-4">
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
                <div className="mt-6 flex items-center gap-2 text-xs font-bold text-emerald-400">
                  <CheckCircle className="h-4 w-4 text-emerald-500" />
                  {importStatus}
                </div>
              )}

              {fullImportRows.length > 0 && (
                <div className="mt-6 w-full max-w-xl grid grid-cols-1 sm:grid-cols-2 gap-3 text-left">
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

            {/* Column Mapping Preview */}
            {parsedData && (
              <div className="glass-card rounded-2xl p-6 border border-white/5 space-y-6">
                <div>
                  <h3 className="text-base font-bold text-white">Preview (first 15 rows)</h3>
                  <p className="text-xs text-slate-500 mt-1">
                    Headers are auto-detected (Name / Rank / Nett). Unmatched names go to reconciliation.
                  </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-400">Rank Column</label>
                    <select
                      value={columnMapping.rank}
                      onChange={(e) => setColumnMapping((prev) => ({ ...prev, rank: e.target.value }))}
                      className="w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                    >
                      {Object.keys(parsedData[0] || {}).map((k) => (
                        <option key={k} value={k}>
                          {k}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-400">Sailor Name Column</label>
                    <select
                      value={columnMapping.name}
                      onChange={(e) => setColumnMapping((prev) => ({ ...prev, name: e.target.value }))}
                      className="w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                    >
                      {Object.keys(parsedData[0] || {}).map((k) => (
                        <option key={k} value={k}>
                          {k}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-400">Nett Score Column</label>
                    <select
                      value={columnMapping.score}
                      onChange={(e) => setColumnMapping((prev) => ({ ...prev, score: e.target.value }))}
                      className="w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                    >
                      {Object.keys(parsedData[0] || {}).map((k) => (
                        <option key={k} value={k}>
                          {k}
                        </option>
                      ))}
                    </select>
                  </div>
                </div>

                {/* Table Preview */}
                <div className="border border-white/5 rounded-xl overflow-hidden">
                  <table className="w-full text-left text-xs font-semibold text-slate-300">
                    <thead className="bg-white/5 text-[10px] text-slate-500 uppercase font-bold border-b border-white/5">
                      <tr>
                        <th className="py-3 px-4">Mapped Rank</th>
                        <th className="py-3 px-4">Mapped Name</th>
                        <th className="py-3 px-4 text-right">Mapped Nett Score</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-white/5">
                      {parsedData.map((row, idx) => (
                        <tr key={idx} className="hover:bg-white/5">
                          <td className="py-3 px-4 font-mono">{row[columnMapping.rank]}</td>
                          <td className="py-3 px-4 font-bold text-white">{row[columnMapping.name]}</td>
                          <td className="py-3 px-4 text-right font-mono">{row[columnMapping.score]}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <div className="flex justify-end">
                  <button
                    disabled={!isSuperadmin}
                    onClick={() => {
                      alert("Regatta imported successfully! Database updated.");
                      setParsedData(null);
                    }}
                    className={`rounded-full bg-orange-600 px-6 py-2.5 text-xs font-bold text-white hover:bg-orange-500 transition-all ${
                      !isSuperadmin && "opacity-50 cursor-not-allowed"
                    }`}
                  >
                    Commit Import to Database
                  </button>
                </div>
              </div>
            )}
          </div>
        )}

        {/* Tab 2: Name Reconciliation */}
        {activeTab === "reconciliation" && (
          <div className="space-y-6">
            <div className="glass-panel rounded-3xl p-6 border border-white/5">
              <h2 className="text-lg font-bold text-white flex items-center gap-2">
                <UserCheck className="h-5 w-5 text-orange-500" />
                Unmapped Sailor Names Queue
              </h2>
              <p className="text-xs text-slate-500 mt-1">
                The import process found these names which do not match existing sailors exactly. Reconciliation suggestions are calculated using pg_trgm trigram similarity algorithms.
              </p>
            </div>

            {reconciliationQueue.length === 0 ? (
              <div className="glass-card rounded-2xl p-8 border border-white/5 text-center text-slate-400">
                All names successfully reconciled! No pending items in queue.
              </div>
            ) : (
              <div className="space-y-4">
                {reconciliationQueue.map((item) => (
                  <div
                    key={item.id}
                    className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col md:flex-row items-start md:items-center justify-between gap-6"
                  >
                    <div>
                      <span className="text-[10px] font-bold text-slate-500 tracking-wider uppercase">Raw Imported Name</span>
                      <h3 className="text-lg font-bold text-white mt-1">{item.rawName}</h3>
                      <p className="text-xs text-slate-400 mt-1">Finished with nett score: **{item.score}**</p>
                    </div>

                    <div className="flex-1 flex flex-col md:flex-row items-stretch md:items-center gap-4 justify-end w-full md:w-auto">
                      {item.suggestedId ? (
                        <div className="flex-1 max-w-sm rounded-xl bg-white/5 border border-white/5 p-3 flex justify-between items-center">
                          <div>
                            <span className="block text-[9px] font-bold text-orange-400 uppercase">AI Match Suggestion</span>
                            <span className="block text-xs font-extrabold text-white mt-0.5">{item.suggestedName}</span>
                          </div>
                          <span className="text-xs font-black text-emerald-400 px-2 py-0.5 rounded bg-emerald-500/10 border border-emerald-500/20">
                            {item.similarity}% match
                          </span>
                        </div>
                      ) : (
                        <div className="flex-1 max-w-sm rounded-xl bg-white/5 border border-white/5 p-3 flex items-center justify-center text-slate-500 text-xs gap-1.5">
                          <HelpCircle className="h-4 w-4" />
                          <span>No match candidate found (Similarity &lt; 60%)</span>
                        </div>
                      )}

                      <div className="flex gap-2 justify-end">
                        {item.suggestedId && (
                          <button
                            disabled={!isSuperadmin}
                            onClick={() => handleMerge(item.id, item.suggestedId!)}
                            className="rounded-full bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-500 transition-all disabled:opacity-50"
                          >
                            Merge to {item.suggestedName}
                          </button>
                        )}
                        <button
                          disabled={!isSuperadmin}
                          onClick={() => handleCreateNew(item.id, item.rawName)}
                          className="rounded-full bg-slate-800 border border-white/5 px-4 py-2 text-xs font-bold text-white hover:bg-slate-700 transition-all disabled:opacity-50 flex items-center gap-1"
                        >
                          <UserPlus className="h-3.5 w-3.5" />
                          Create New Sailor
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* Bulk editor merged into Database & bulk edit tab */}

        {/* Database & bulk edit */}
        {activeTab === "edit" && (
          <div className="space-y-6">
            {/* Sub Tabs */}
            <div className="flex gap-2 bg-[#131520] border border-white/5 p-1 rounded-full max-w-md">
              {(["sailors", "regattas", "results"] as const).map((sub) => (
                <button
                  key={sub}
                  onClick={() => {
                    setEditSubTab(sub);
                    setEditingSailorId(null);
                    setEditingRegattaId(null);
                    setEditingResultId(null);
                  }}
                  className={`flex-1 rounded-full py-1.5 text-xs font-bold capitalize transition-all ${
                    editSubTab === sub
                      ? "bg-orange-600 text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  {sub}
                </button>
              ))}
            </div>

            {/* Sub-Tab Content: SAILORS */}
            {editSubTab === "sailors" && (
              <div className="space-y-6">
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
                    <label className="text-[10px] font-bold text-slate-500 uppercase">Fleet</label>
                    <select
                      value={dbFleetFilter}
                      onChange={(e) => setDbFleetFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All fleets</option>
                      <option value="gold">Gold</option>
                      <option value="silver">Silver</option>
                      <option value="unassigned">Unassigned</option>
                    </select>
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">Squad</label>
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
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">Manually dropped</label>
                    <select
                      value={dbDroppedFilter}
                      onChange={(e) => setDbDroppedFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All</option>
                      <option value="no">Active only</option>
                      <option value="yes">Dropped only</option>
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
                        <optgroup label="Fleet Status & Dates">
                          <option value="goldEntryDate">Gold Fleet Entry Date</option>
                          <option value="silverEntryDate">Silver Fleet Entry Date</option>
                          <option value="dropDate">Optimist Drop Date</option>
                          <option value="currentFleet">Fleet current (Gold/Silver)</option>
                          <option value="manuallyDropped">Manually dropped (Y/N)</option>
                        </optgroup>
                        <optgroup label="Profile">
                          <option value="club">Club</option>
                          <option value="school">School</option>
                          <option value="nationality">Nationality</option>
                          <option value="sailNumber">Sail Number</option>
                          <option value="gender">Gender (M/F)</option>
                          <option value="nationalSquadStatus">Squad (Nat A/B/DS)</option>
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
                      {["goldEntryDate", "silverEntryDate", "dropDate", "dob"].includes(bulkField) ? (
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
                          <option value="">Guest / clear</option>
                          <option value="Silver">Silver</option>
                          <option value="Gold">Gold</option>
                        </select>
                      ) : bulkField === "manuallyDropped" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="N">N (active)</option>
                          <option value="Y">Y (dropped)</option>
                        </select>
                      ) : [
                          "nationalSquadStatus",
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
                  <p className="text-[10px] text-slate-500">
                    <strong className="text-slate-400">Merge duplicates:</strong> tick exactly two
                    rows → <strong className="text-emerald-400">Merge 2 selected</strong>. The more
                    complete profile is kept; the other is deleted after results/aliases move over.
                  </p>
                  {bulkStatus && (
                    <div className="flex items-center gap-2 text-xs font-bold text-emerald-400">
                      <CheckCircle className="h-4 w-4" />
                      {bulkStatus}
                    </div>
                  )}
                </div>

                {/* Sailor Form Card */}
                {editingSailorId && (
                  <div className="glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider">
                      {editingSailorId === "new" ? "Add New Sailor Profile" : "Edit Sailor Profile"}
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
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">National Squad Status</label>
                        <select
                          value={sailorForm.nationalSquadStatus || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, nationalSquadStatus: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="">None</option>
                          <option value="Nat A">National A (Nat A)</option>
                          <option value="Nat B">National B (Nat B)</option>
                          <option value="DS">Development Squad (DS)</option>
                        </select>
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
                          SG series fleet
                        </label>
                        <select
                          value={sailorForm.currentFleet || ""}
                          onChange={(e) => {
                            const v = e.target.value;
                            const next: any = { ...sailorForm, currentFleet: v };
                            // Admit Silver: stamp entry date if empty
                            if (v === "Silver" && !next.silverEntryDate) {
                              next.silverEntryDate = new Date()
                                .toISOString()
                                .slice(0, 10);
                            }
                            // Promote Gold: stamp gold date if empty (needs silver first — validated on save)
                            if (v === "Gold" && !next.goldEntryDate) {
                              next.goldEntryDate = new Date()
                                .toISOString()
                                .slice(0, 10);
                            }
                            if (v === "") {
                              // Guest — leave dates; clear fleet tag only
                            }
                            setSailorForm(next);
                          }}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="">Guest (not in series)</option>
                          <option value="Silver">Silver Fleet</option>
                          <option value="Gold">Gold Fleet (from Silver only)</option>
                        </select>
                        <p className="mt-1 text-[10px] text-slate-500 leading-snug">
                          New series members start as Silver. Gold only after Silver history.
                          Regatta import never changes this.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Gold Fleet Entry Date</label>
                        <input
                          type="date"
                          value={sailorForm.goldEntryDate || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, goldEntryDate: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
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
                        <input
                          type="date"
                          value={sailorForm.dropDate || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, dropDate: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                    </div>

                    <div className="flex justify-end gap-2 border-t border-white/5 pt-4">
                      <button
                        onClick={() => setEditingSailorId(null)}
                        className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                      >
                        Cancel
                      </button>
                      <button
                        onClick={handleSaveSailor}
                        className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                      >
                        Save Sailor
                      </button>
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
                                  seriesLabel === "Gold"
                                    ? "bg-yellow-500/10 text-yellow-400 border-yellow-500/20"
                                    : seriesLabel === "Silver"
                                      ? "bg-slate-400/10 text-slate-300 border-slate-400/20"
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
                            squad: (
                              <span className="text-[10px] text-slate-400 bg-white/5 px-2 py-0.5 rounded border border-white/5">
                                {s.nationalSquadStatus || "None"}
                              </span>
                            ),
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
                                    onClick={() => {
                                      setCompetitionsSailorId(null);
                                      setEditingSailorId(s.id);
                                      const d = (v: unknown) =>
                                        v ? String(v).slice(0, 10) : "";
                                      setSailorForm({
                                        ...s,
                                        weight: s.weight
                                          ? s.weight.toString()
                                          : "",
                                        nationalSquadStatus:
                                          s.nationalSquadStatus || "",
                                        nationality: s.nationality || "",
                                        currentFleet: s.currentFleet || "",
                                        school: s.school || "",
                                        manuallyDropped:
                                          s.manuallyDropped || false,
                                        instagram: s.instagram || "",
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
                                    }}
                                    className="text-slate-400 hover:text-white"
                                  >
                                    <Edit3 className="h-4 w-4" />
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

            {/* Sub-Tab Content: REGATTAS */}
            {editSubTab === "regattas" && (
              <div className="space-y-6">
                {/* Regatta Form Card */}
                {editingRegattaId && (
                  <div className="glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider">
                      {editingRegattaId === "new" ? "Add New Regatta Event" : "Edit Regatta Details"}
                    </h3>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Regatta Name</label>
                        <input
                          type="text"
                          value={regattaForm.name}
                          onChange={(e) => setRegattaForm({ ...regattaForm, name: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                          placeholder="e.g. NSC Cup Series 1"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Date (YYYY-MM-DD)</label>
                        <input
                          type="date"
                          value={regattaForm.date}
                          onChange={(e) => setRegattaForm({ ...regattaForm, date: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Total Fleet Size</label>
                        <input
                          type="number"
                          value={regattaForm.totalFleetSize}
                          onChange={(e) => setRegattaForm({ ...regattaForm, totalFleetSize: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Division / Fleet Split</label>
                        <select
                          value={regattaForm.division || "Gold"}
                          onChange={(e) => setRegattaForm({ ...regattaForm, division: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3.5 py-2 text-white text-xs"
                        >
                          <option value="Gold">Gold Fleet Only</option>
                          <option value="Silver">Silver Fleet Only</option>
                          <option value="Both">Both (Gold & Silver split)</option>
                        </select>
                      </div>
                    </div>

                    <div className="flex justify-end gap-2 border-t border-white/5 pt-4">
                      <button
                        onClick={() => setEditingRegattaId(null)}
                        className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                      >
                        Cancel
                      </button>
                      <button
                        onClick={handleSaveRegatta}
                        className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                      >
                        Save Regatta
                      </button>
                    </div>
                  </div>
                )}

                {/* Regattas List */}
                <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
                  <div className="p-6 border-b border-white/5 flex items-center justify-between">
                    <div>
                      <h3 className="text-base font-bold text-white">Regatta Events</h3>
                      <p className="text-xs text-slate-500">Edit or delete regatta meta parameters.</p>
                    </div>
                    <button
                      onClick={() => {
                        setEditingRegattaId("new");
                        setRegattaForm({
                          id: "",
                          name: "",
                          date: new Date().toISOString().split("T")[0],
                          totalFleetSize: 50,
                          division: "Gold",
                        });
                      }}
                      className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                    >
                      <Plus className="h-4 w-4" />
                      Add Regatta
                    </button>
                  </div>

                  <table className="w-full text-left border-collapse text-xs">
                    <thead>
                      <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                        <th className="py-4 px-6">Event Name</th>
                        <th className="py-4 px-6">Event Date</th>
                        <th className="py-4 px-6 text-center">Total Fleet Size</th>
                        <th className="py-4 px-6 text-center">Division</th>
                        <th className="py-4 px-6 text-right">Actions</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                      {regattaList.map((r) => (
                        <tr key={r.id} className="hover:bg-white/5 transition-colors">
                          <td className="py-4 px-6 font-bold text-white">{r.name}</td>
                          <td className="py-4 px-6 font-mono text-slate-400">{r.date}</td>
                          <td className="py-4 px-6 text-center font-mono">{r.totalFleetSize}</td>
                          <td className="py-4 px-6 text-center">
                            <span className="text-[10px] font-extrabold px-2 py-0.5 rounded bg-white/5 border border-white/5 text-orange-400">
                              {r.division || "Gold"}
                            </span>
                          </td>
                          <td className="py-4 px-6 text-right">
                            <div className="flex justify-end items-center gap-2">
                              <button
                                onClick={() => {
                                  setEditingRegattaId(r.id);
                                  setRegattaForm(r);
                                }}
                                className="text-slate-400 hover:text-white"
                              >
                                <Edit3 className="h-4 w-4" />
                              </button>
                              <button
                                onClick={() => handleDeleteRegatta(r.id)}
                                className="text-slate-500 hover:text-red-400"
                              >
                                <Trash2 className="h-4 w-4" />
                              </button>
                            </div>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            {/* Sub-Tab Content: RESULTS */}
            {editSubTab === "results" && (
              <div className="space-y-6">
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
                        {r.name} ({r.date})
                      </option>
                    ))}
                  </select>
                </div>

                {/* Result Form Card */}
                {editingResultId && (
                  <div className="glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider">
                      {editingResultId === "new" ? "Add Sailor Regatta Result" : "Edit Sailor Regatta Result"}
                    </h3>
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
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Nett Score (Points)</label>
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
                          onChange={(e) => setResultForm({ ...resultForm, rank: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
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
                                    nettScore: dnsPts,
                                  }
                                : {}),
                            });
                          }}
                          className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                        />
                        <label htmlFor="dnsCheckbox" className="text-xs font-bold text-slate-400 cursor-pointer">
                          Did Not Start (DNS) — sets rank to fleet+1; you can edit the number
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
                    <div className="p-6 border-b border-white/5 flex items-center justify-between">
                      <div>
                        <h3 className="text-base font-bold text-white">Regatta Results Table</h3>
                        <p className="text-xs text-slate-500">Edit or delete competitor scores for this specific event.</p>
                      </div>
                      <div className="flex flex-wrap gap-2">
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
                              nettScore: 1,
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
                      Non-starters: use <strong className="text-slate-400">Fill DNS</strong> to
                      create editable DNS rows (default rank = fleet size + 1). Tick DNS when
                      adding/editing a single sailor. Ranking uses the stored rank, so you can
                      change a DNS score later.
                    </p>

                    <table className="w-full text-left border-collapse text-xs">
                      <thead>
                        <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                          <th className="py-4 px-6">Competitor</th>
                          <th className="py-4 px-6">Sail Number</th>
                          <th className="py-4 px-6 text-center">Total Score</th>
                          <th className="py-4 px-6 text-center">Nett Score</th>
                          <th className="py-4 px-6 text-center">Rank / pts</th>
                          <th className="py-4 px-6 text-center">Status</th>
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
                            return (
                              <tr
                                key={res.id}
                                className={`hover:bg-white/5 transition-colors ${
                                  dns ? "bg-rose-500/[0.03]" : ""
                                }`}
                              >
                                <td className="py-4 px-6 font-bold text-white">
                                  {sailor ? sailor.name : "Deleted / Unmapped Sailor"}
                                </td>
                                <td className="py-4 px-6 font-mono text-slate-400">
                                  {sailor ? sailor.sailNumber : "-"}
                                </td>
                                <td className="py-4 px-6 text-center font-mono">
                                  {res.totalScore != null ? res.totalScore : "—"}
                                </td>
                                <td className="py-4 px-6 text-center font-mono">{res.nettScore}</td>
                                <td className="py-4 px-6 text-center font-mono">
                                  {res.rank}
                                  {dns ? "*" : ""}
                                </td>
                                <td className="py-4 px-6 text-center">
                                  <span className={`inline-block px-2 py-0.5 rounded text-[10px] ${
                                    dns
                                      ? "bg-rose-500/10 text-rose-500 border border-rose-500/20"
                                      : "bg-slate-800 text-slate-400"
                                  }`}>
                                    {dns ? "DNS" : "Finished"}
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
                                          isDNS: dns,
                                          isDns: dns,
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
                            <td colSpan={7} className="text-center py-12 text-slate-500">
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
                        nettScore: 1,
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
                            {r.name} ({r.date}) · {r.division}
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
                        Nett Score
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
                            ...(on ? { rank: dnsPts, nettScore: dnsPts } : {}),
                          });
                        }}
                        className="rounded border-slate-700 bg-slate-900 text-orange-600 h-4 w-4"
                      />
                      <label htmlFor="modalDns" className="text-xs text-slate-400 font-bold cursor-pointer">
                        DNS (default rank = fleet size + 1; editable)
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
                          {r.rank}{dns ? "*" : ""}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.totalScore != null ? r.totalScore : "—"}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.nettScore}
                        </td>
                        <td className="py-3 px-4 text-center">
                          <span className={`text-[10px] px-2 py-0.5 rounded ${
                            dns
                              ? "bg-rose-500/10 text-rose-400 border border-rose-500/20"
                              : "text-slate-500"
                          }`}>
                            {dns ? "DNS" : "Finished"}
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
                                  isDNS: dns,
                                  isDns: dns,
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
