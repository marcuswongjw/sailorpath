"use client";

import { useState, useEffect } from "react";
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
} from "lucide-react";
import { getPercentileBadge } from "@/lib/ranking";
import { createBrowserSupabase } from "@/lib/supabase/browser";

import { Plus, Trash2, Edit3, User, Medal } from "lucide-react";

interface AdminDashboardProps {
  initialSailors: any[];
  initialRegattas: any[];
  initialResults: any[];
  isDemo: boolean;
}

export function AdminDashboard({ initialSailors, initialRegattas, initialResults, isDemo }: AdminDashboardProps) {
  const [activeTab, setActiveTab] = useState<"import" | "reconciliation" | "bulk" | "edit">("import");
  
  // Auth state — role from server /profiles, never user_metadata
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(!isDemo);
  const [adminRole, setAdminRole] = useState<"superadmin" | "coach" | "sailor" | "parent">(
    isDemo ? "superadmin" : "sailor"
  );
  const [importMeta, setImportMeta] = useState({
    name: "",
    date: new Date().toISOString().slice(0, 10),
    division: "Gold",
    fleetSize: 50,
  });
  const [fullImportRows, setFullImportRows] = useState<
    { name: string; rank: number | null; nett: number | null }[]
  >([]);
  const [importRegattaId, setImportRegattaId] = useState<string | null>(null);

  useEffect(() => {
    if (isDemo) {
      setLoading(false);
      return;
    }

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
  }, [isDemo]);

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
  const [reconciliationQueue, setReconciliationQueue] = useState([
    { id: "unmapped-1", rawName: "Ashlyn T.", score: 8, suggestedId: "sailor-1", suggestedName: "Ashlyn Tan", similarity: 89 },
    { id: "unmapped-2", rawName: "Charles G.", score: 3, suggestedId: "sailor-3", suggestedName: "Charles Goh", similarity: 92 },
    { id: "unmapped-3", rawName: "B. Lim", score: 9, suggestedId: "sailor-2", suggestedName: "Bernice Lim", similarity: 78 },
    { id: "unmapped-4", rawName: "J. Wong", score: 14, suggestedId: null, suggestedName: null, similarity: 0 },
  ]);

  // Bulk Editor States
  const [selectedSailors, setSelectedSailors] = useState<string[]>([]);
  const [bulkField, setBulkField] = useState<string>("");
  const [bulkValue, setBulkValue] = useState<string>("");
  const [sailorList, setSailorList] = useState(initialSailors);
  const [bulkStatus, setBulkStatus] = useState<string | null>(null);

  // Database Editor Sub-Tabs & Forms
  const [editSubTab, setEditSubTab] = useState<"sailors" | "regattas" | "results">("sailors");
  const [editingSailorId, setEditingSailorId] = useState<string | null>(null);
  const [sailorForm, setSailorForm] = useState<any>({
    id: "",
    name: "",
    handle: "",
    sailNumber: "",
    club: "",
    gender: "M",
    nationalSquadStatus: "",
    instagram: "",
    facebook: "",
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
    isDNS: false,
  });

  // Check superadmin permissions
  const isSuperadmin = adminRole === "superadmin";

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
      const workbook = read(data, { type: "binary" });
      const sheetName = workbook.SheetNames[0];
      const sheet = workbook.Sheets[sheetName];
      const json = utils.sheet_to_json<Record<string, unknown>>(sheet, { defval: null });
      const mapped = json
        .map((r) => {
          const keys = Object.keys(r);
          const nameKey = keys.find((k) => /name|sailor/i.test(k)) || keys[0];
          const rankKey = keys.find((k) => /rank|pos|place/i.test(k));
          const nettKey = keys.find((k) => /nett|points|pts|score/i.test(k));
          const name = String(r[nameKey!] ?? "").trim();
          const rank = rankKey != null && r[rankKey] != null ? Number(r[rankKey]) : null;
          const nett = nettKey != null && r[nettKey] != null ? Number(r[nettKey]) : null;
          return {
            name,
            rank: Number.isFinite(rank as number) ? rank : null,
            nett: Number.isFinite(nett as number) ? nett : null,
          };
        })
        .filter((r) => r.name);
      setFullImportRows(mapped);
      setParsedData(mapped.slice(0, 15));
      setImportStatus(`Parsed ${mapped.length} rows. Fill regatta details and click Import to database.`);
      if (!importMeta.name) {
        setImportMeta((m) => ({ ...m, name: file.name.replace(/\.[^.]+$/, "") }));
      }
    };
    reader.readAsBinaryString(file);
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
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Import failed");
      setImportRegattaId(data.regatta?.id || null);
      if (data.regatta) {
        setRegattaList((prev) => {
          const exists = prev.some((r) => r.id === data.regatta.id);
          return exists
            ? prev.map((r) => (r.id === data.regatta.id ? data.regatta : r))
            : [...prev, data.regatta];
        });
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

  const toggleSelectAll = () => {
    if (selectedSailors.length === sailorList.length) {
      setSelectedSailors([]);
    } else {
      setSelectedSailors(sailorList.map((s) => s.id));
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
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Bulk update failed");

      setSailorList((prev) =>
        prev.map((s) => {
          if (!selectedSailors.includes(s.id)) return s;
          let typedValue: any = bulkValue;
          const isNumeric = [
            "histRankingJun24", "histRankingDec24", "histRankingJun25", "histRankingDec25", "histRankingJun26",
            "worlds", "european", "asian", "seaGames", "weight",
          ].includes(bulkField);
          if (isNumeric) typedValue = bulkValue === "" ? null : parseInt(bulkValue) || null;
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
    try {
      if (editingSailorId === "new") {
        const res = await fetch("/api/admin/sailors", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(sailorForm),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Create failed");
        setSailorList((prev) => [...prev, data.sailor]);
        alert("Sailor created successfully!");
      } else {
        const res = await fetch("/api/admin/sailors", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...sailorForm, id: editingSailorId }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Update failed");
        setSailorList((prev) =>
          prev.map((s) => (s.id === editingSailorId ? data.sailor : s))
        );
        alert("Sailor updated successfully!");
      }
      setEditingSailorId(null);
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleDeleteSailor = async (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!confirm("Are you sure you want to delete this sailor?")) return;
    try {
      const res = await fetch(`/api/admin/sailors?id=${encodeURIComponent(id)}`, {
        method: "DELETE",
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setSailorList((prev) => prev.filter((s) => s.id !== id));
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
        const data = await res.json();
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
        const data = await res.json();
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
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setRegattaList((prev) => prev.filter((r) => r.id !== id));
      setResultsList((prev) => prev.filter((res) => res.regattaId !== id));
    } catch (e: any) {
      alert(e.message);
    }
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
    try {
      if (editingResultId === "new") {
        const res = await fetch("/api/admin/results", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(resultForm),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Create failed");
        setResultsList((prev) => [...prev, data.result]);
        alert("Result added successfully!");
      } else {
        const res = await fetch("/api/admin/results", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...resultForm, id: editingResultId }),
        });
        const data = await res.json();
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

  const handleDeleteResult = async (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!confirm("Are you sure you want to delete this result?")) return;
    try {
      const res = await fetch(`/api/admin/results?id=${encodeURIComponent(id)}`, {
        method: "DELETE",
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setResultsList((prev) => prev.filter((r) => r.id !== id));
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

  if (!isDemo && !user) {
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
      {/* Superadmin RLS check controller or User Badge */}
      {isDemo ? (
        <div className="glass-panel rounded-2xl p-4 flex flex-col sm:flex-row items-center justify-between gap-4 border border-white/5">
          <div className="flex items-center gap-2 text-xs font-bold text-slate-400">
            <Shield className="h-4 w-4 text-orange-500" />
            <span>CURRENT SIMULATED USER ROLE:</span>
          </div>
          <div className="flex gap-2">
            {(["superadmin", "coach", "sailor"] as const).map((role) => (
              <button
                key={role}
                onClick={() => setAdminRole(role)}
                className={`rounded-full px-4 py-1 text-xs font-bold capitalize transition-all border ${
                  adminRole === role
                    ? "bg-orange-600 text-white border-orange-500"
                    : "bg-slate-800 text-slate-400 border-white/5 hover:text-white"
                }`}
              >
                {role}
              </button>
            ))}
          </div>
        </div>
      ) : (
        <div className="glass-panel rounded-2xl p-4 flex items-center justify-between gap-4 border border-white/5 bg-slate-900/40">
          <div className="flex items-center gap-2 text-xs font-bold text-slate-300">
            <Shield className="h-4 w-4 text-orange-500" />
            <span>Logged in as: <span className="text-white">{user?.email}</span></span>
          </div>
          <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-3 py-0.5 text-[10px] font-black text-orange-400 capitalize">
            {adminRole}
          </span>
        </div>
      )}

      {/* Tab Navigation */}
      <div className="flex border-b border-white/5 gap-4 overflow-x-auto pb-0.5">
        <button
          onClick={() => setActiveTab("import")}
          className={`pb-4 text-sm font-bold border-b-2 transition-all flex items-center gap-2 whitespace-nowrap ${
            activeTab === "import"
              ? "border-orange-500 text-white"
              : "border-transparent text-slate-400 hover:text-white"
          }`}
        >
          <FileSpreadsheet className="h-4 w-4" />
          Excel Import
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
          onClick={() => setActiveTab("bulk")}
          className={`pb-4 text-sm font-bold border-b-2 transition-all flex items-center gap-2 whitespace-nowrap ${
            activeTab === "bulk"
              ? "border-orange-500 text-white"
              : "border-transparent text-slate-400 hover:text-white"
          }`}
        >
          <Grid className="h-4 w-4" />
          Bulk Date Editor
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
          Database Management
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
                <p className="text-xs text-slate-500 mb-4">Supports .xlsx, .xls, and .csv formats</p>
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

        {/* Tab 3: Bulk Date Editor */}
        {activeTab === "bulk" && (
          <div className="space-y-6">
            <div className="glass-panel rounded-3xl p-6 border border-white/5">
              <h2 className="text-lg font-bold text-white flex items-center gap-2">
                <Grid className="h-5 w-5 text-orange-500" />
                Fleet Entry/Drop Bulk Editor
              </h2>
              <p className="text-xs text-slate-500 mt-1">
                Select multiple sailors below and update their gold/silver fleet entry dates or drop dates simultaneously.
              </p>
            </div>

            {/* Bulk Controls */}
            <div className="glass-card rounded-2xl p-6 border border-white/5 space-y-4">
              <div className="flex flex-wrap items-end gap-6">
                
                {/* 1. Select Field to Edit */}
                <div className="flex flex-col gap-1.5 min-w-[200px]">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Property to Update</label>
                  <select
                    value={bulkField}
                    onChange={(e) => {
                      setBulkField(e.target.value);
                      setBulkValue(""); // clear value on field change
                    }}
                    className="rounded-lg bg-slate-900 border border-white/10 text-white px-3.5 py-2 text-xs focus:outline-none"
                  >
                    <option value="">-- Select Property --</option>
                    <optgroup label="Fleet Status & Dates">
                      <option value="goldEntryDate">Gold Fleet Entry Date</option>
                      <option value="silverEntryDate">Silver Fleet Entry Date</option>
                      <option value="dropDate">Optimist Drop Date (Retirement)</option>
                    </optgroup>
                    <optgroup label="Profile Parameters">
                      <option value="club">Club Origin</option>
                      <option value="gender">Gender (M/F)</option>
                      <option value="nationalSquadStatus">National Squad Status (Current)</option>
                      <option value="dob">Date of Birth</option>
                      <option value="weight">Weight (kg)</option>
                    </optgroup>
                    <optgroup label="Squad Status History">
                      <option value="natSquadStatusJan25">Nat Squad Status Jan 25</option>
                      <option value="natSquadStatusJul25">Nat Squad Status Jul 25</option>
                      <option value="natSquadStatusJan26">Nat Squad Status Jan 26</option>
                      <option value="natSquadStatusJul26">Nat Squad Status Jul 26</option>
                    </optgroup>
                    <optgroup label="Historical Standings">
                      <option value="histRankingJun24">Historical Gold Rank Jun 24</option>
                      <option value="histRankingDec24">Historical Gold Rank Dec 24</option>
                      <option value="histRankingJun25">Historical Gold Rank Jun 25</option>
                      <option value="histRankingDec25">Historical Gold Rank Dec 25</option>
                      <option value="histRankingJun26">Historical Gold Rank Jun 26</option>
                    </optgroup>
                    <optgroup label="Representative campaigns (Year)">
                      <option value="worlds">Worlds Campaign Year</option>
                      <option value="european">European Campaign Year</option>
                      <option value="asian">Asian Campaign Year</option>
                      <option value="seaGames">SEA Games Campaign Year</option>
                    </optgroup>
                  </select>
                </div>

                {/* 2. Render appropriate input field depending on selected property */}
                {bulkField && (
                  <div className="flex flex-col gap-1.5 min-w-[200px] animate-in fade-in slide-in-from-top-1 duration-200">
                    <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">New Value</label>
                    
                    {/* Render Date Inputs */}
                    {["goldEntryDate", "silverEntryDate", "dropDate", "dob"].includes(bulkField) && (
                      <input
                        type="date"
                        value={bulkValue}
                        onChange={(e) => setBulkValue(e.target.value)}
                        className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:border-orange-500 focus:outline-none"
                      />
                    )}

                    {/* Render Gender Dropdown */}
                    {bulkField === "gender" && (
                      <select
                        value={bulkValue}
                        onChange={(e) => setBulkValue(e.target.value)}
                        className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs focus:outline-none"
                      >
                        <option value="">-- Select Gender --</option>
                        <option value="M">Male (M)</option>
                        <option value="F">Female (F)</option>
                      </select>
                    )}

                    {/* Render Squad Dropdowns */}
                    {[
                      "nationalSquadStatus",
                      "natSquadStatusJan25",
                      "natSquadStatusJul25",
                      "natSquadStatusJan26",
                      "natSquadStatusJul26",
                    ].includes(bulkField) && (
                      <select
                        value={bulkValue}
                        onChange={(e) => setBulkValue(e.target.value)}
                        className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs focus:outline-none"
                      >
                        <option value="">-- Select Status --</option>
                        <option value="CLEAR">Clear Status (None)</option>
                        <option value="Nat A">National Squad A (Nat A)</option>
                        <option value="Nat B">National Squad B (Nat B)</option>
                        <option value="DS">Development Squad (DS)</option>
                      </select>
                    )}

                    {/* Render Numbers (Rankings, Campaign Years) */}
                    {[
                      "histRankingJun24", "histRankingDec24", "histRankingJun25", "histRankingDec25", "histRankingJun26",
                      "worlds", "european", "asian", "seaGames", "weight"
                    ].includes(bulkField) && (
                      <input
                        type="number"
                        placeholder="e.g. 2026 or 12"
                        value={bulkValue}
                        onChange={(e) => setBulkValue(e.target.value)}
                        className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:border-orange-500 focus:outline-none"
                      />
                    )}

                    {/* Render normal text input for anything else (e.g. Club) */}
                    {!["goldEntryDate", "silverEntryDate", "dropDate", "dob", "gender", "nationalSquadStatus", "natSquadStatusJan25", "natSquadStatusJul25", "natSquadStatusJan26", "natSquadStatusJul26", "histRankingJun24", "histRankingDec24", "histRankingJun25", "histRankingDec25", "histRankingJun26", "worlds", "european", "asian", "seaGames", "weight"].includes(bulkField) && (
                      <input
                        type="text"
                        placeholder="Enter value"
                        value={bulkValue}
                        onChange={(e) => setBulkValue(e.target.value)}
                        className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:border-orange-500 focus:outline-none"
                      />
                    )}
                  </div>
                )}

                {/* 3. Actions Button */}
                <div className="flex items-end justify-end flex-1 pt-4">
                  <button
                    disabled={!isSuperadmin || selectedSailors.length === 0 || !bulkField}
                    onClick={handleApplyBulk}
                    className="rounded-full bg-orange-600 px-6 py-2.5 text-xs font-bold text-white hover:bg-orange-500 transition-all disabled:opacity-50 flex items-center gap-1.5"
                  >
                    <Save className="h-4 w-4" />
                    Apply Bulk Edits ({selectedSailors.length} selected)
                  </button>
                </div>

              </div>

              {bulkStatus && (
                <div className="flex items-center gap-2 text-xs font-bold text-emerald-400 border-t border-white/5 pt-3">
                  <CheckCircle className="h-4 w-4 text-emerald-500" />
                  {bulkStatus}
                </div>
              )}
            </div>

            {/* Sailors Grid Checkbox Table */}
            <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-left border-collapse text-[11px] min-w-[1700px]">
                  <thead>
                    <tr className="border-b border-white/5 bg-slate-950/60 text-[9px] font-black text-slate-500 uppercase tracking-widest text-center">
                      <th colSpan={4} className="py-2 px-4 border-r border-white/5 text-left">Competitor</th>
                      <th colSpan={4} className="py-2 px-4 border-r border-white/5 bg-orange-600/5 text-orange-400">National Squad History</th>
                      <th colSpan={5} className="py-2 px-4 border-r border-white/5 bg-blue-600/5 text-blue-400">Historical Rankings</th>
                      <th colSpan={4} className="py-2 px-4 border-r border-white/5 bg-emerald-600/5 text-emerald-400">Representative campaigns (Year)</th>
                      <th colSpan={3} className="py-2 px-4">Fleet Entry/Drop Dates</th>
                    </tr>
                    <tr className="border-b border-white/5 bg-white/5 text-[9px] font-bold text-slate-400 uppercase tracking-wider">
                      <th className="py-4 px-6 text-center w-16">
                        <input
                          type="checkbox"
                          checked={selectedSailors.length === sailorList.length && sailorList.length > 0}
                          onChange={toggleSelectAll}
                          className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                        />
                      </th>
                      <th className="py-4 px-6 text-left">Sailor Name</th>
                      <th className="py-4 px-4 text-center">Sail Number</th>
                      <th className="py-4 px-4 text-left border-r border-white/5">Club / Gender</th>

                      <th className="py-4 px-4 text-center bg-orange-600/5">Jan 25</th>
                      <th className="py-4 px-4 text-center bg-orange-600/5">Jul 25</th>
                      <th className="py-4 px-4 text-center bg-orange-600/5">Jan 26</th>
                      <th className="py-4 px-4 text-center border-r border-white/5 bg-orange-600/5">Jul 26</th>

                      <th className="py-4 px-4 text-center bg-blue-600/5">Jun 24</th>
                      <th className="py-4 px-4 text-center bg-blue-600/5">Dec 24</th>
                      <th className="py-4 px-4 text-center bg-blue-600/5">Jun 25</th>
                      <th className="py-4 px-4 text-center bg-blue-600/5">Dec 25</th>
                      <th className="py-4 px-4 text-center border-r border-white/5 bg-blue-600/5">Jun 26</th>

                      <th className="py-4 px-4 text-center bg-emerald-600/5">Worlds</th>
                      <th className="py-4 px-4 text-center bg-emerald-600/5">European</th>
                      <th className="py-4 px-4 text-center bg-emerald-600/5">Asian</th>
                      <th className="py-4 px-4 text-center border-r border-white/5 bg-emerald-600/5">SEA Games</th>

                      <th className="py-4 px-4 text-center">Gold Entry</th>
                      <th className="py-4 px-4 text-center">Silver Entry</th>
                      <th className="py-4 px-4 text-center">Drop Date</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                    {sailorList.map((sailor) => {
                      const isChecked = selectedSailors.includes(sailor.id);
                      return (
                        <tr
                          key={sailor.id}
                          className={`transition-colors text-center ${isChecked ? "bg-orange-500/5 hover:bg-orange-500/10" : "hover:bg-white/5"}`}
                        >
                          <td className="py-4 px-6 text-center">
                            <input
                              type="checkbox"
                              checked={isChecked}
                              onChange={() => toggleSelectSailor(sailor.id)}
                              className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                            />
                          </td>
                          <td className="py-4 px-6 text-left font-bold text-white">
                            {sailor.name}
                          </td>
                          <td className="py-4 px-4 font-mono text-slate-400">{sailor.sailNumber}</td>
                          <td className="py-4 px-4 text-left text-slate-400 border-r border-white/5">
                            {sailor.club} ({sailor.gender || "M"})
                          </td>

                          {/* Jan 25 */}
                          <td className="py-4 px-4 bg-orange-600/5 text-slate-400">{sailor.natSquadStatusJan25 || "-"}</td>
                          {/* Jul 25 */}
                          <td className="py-4 px-4 bg-orange-600/5 text-slate-400">{sailor.natSquadStatusJul25 || "-"}</td>
                          {/* Jan 26 */}
                          <td className="py-4 px-4 bg-orange-600/5 text-slate-400">{sailor.natSquadStatusJan26 || "-"}</td>
                          {/* Jul 26 */}
                          <td className="py-4 px-4 border-r border-white/5 bg-orange-600/5">
                            {sailor.natSquadStatusJul26 ? (
                              <span className="rounded bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[9px] text-orange-400 font-extrabold">
                                {sailor.natSquadStatusJul26}
                              </span>
                            ) : (
                              "-"
                            )}
                          </td>

                          {/* Rankings */}
                          <td className="py-4 px-4 bg-blue-600/5 text-slate-400 font-mono">{sailor.histRankingJun24 || "-"}</td>
                          <td className="py-4 px-4 bg-blue-600/5 text-slate-400 font-mono">{sailor.histRankingDec24 || "-"}</td>
                          <td className="py-4 px-4 bg-blue-600/5 text-slate-400 font-mono">{sailor.histRankingJun25 || "-"}</td>
                          <td className="py-4 px-4 bg-blue-600/5 text-slate-400 font-mono">{sailor.histRankingDec25 || "-"}</td>
                          <td className="py-4 px-4 border-r border-white/5 bg-blue-600/5 text-white font-mono font-bold">{sailor.histRankingJun26 || "-"}</td>

                          {/* Representatives */}
                          <td className="py-4 px-4 bg-emerald-600/5 text-emerald-400 font-mono">{sailor.worlds || "-"}</td>
                          <td className="py-4 px-4 bg-emerald-600/5 text-emerald-400 font-mono">{sailor.european || "-"}</td>
                          <td className="py-4 px-4 bg-emerald-600/5 text-emerald-400 font-mono">{sailor.asian || "-"}</td>
                          <td className="py-4 px-4 border-r border-white/5 bg-emerald-600/5 text-emerald-400 font-mono">{sailor.seaGames || "-"}</td>

                          {/* Fleet Dates */}
                          <td className="py-4 px-4 text-center font-mono text-slate-400">{sailor.goldEntryDate || "-"}</td>
                          <td className="py-4 px-4 text-center font-mono text-slate-400">{sailor.silverEntryDate || "-"}</td>
                          <td className="py-4 px-4 text-center font-mono text-slate-400">{sailor.dropDate || "-"}</td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* Tab 4: Database Management */}
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
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Facebook Username</label>
                        <input
                          type="text"
                          value={sailorForm.facebook || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, facebook: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="e.g. user.name.12"
                        />
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
                  <div className="p-6 border-b border-white/5 flex items-center justify-between">
                    <div>
                      <h3 className="text-base font-bold text-white">Sailors List</h3>
                      <p className="text-xs text-slate-500">Edit or delete sailor profiles and fleet dates.</p>
                    </div>
                    <button
                      onClick={() => {
                        setEditingSailorId("new");
                        setSailorForm({
                          id: "",
                          name: "",
                          handle: "",
                          sailNumber: "SGP ",
                          club: "",
                          gender: "M",
                          nationalSquadStatus: "",
                          instagram: "",
                          facebook: "",
                          dob: "",
                          weight: "",
                          bio: "",
                          goldEntryDate: "",
                          silverEntryDate: new Date().toISOString().split("T")[0],
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

                  <table className="w-full text-left border-collapse text-xs">
                    <thead>
                      <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                        <th className="py-4 px-6">Name</th>
                        <th className="py-4 px-6">Sail Number</th>
                        <th className="py-4 px-6">Gender</th>
                        <th className="py-4 px-6">Squad</th>
                        <th className="py-4 px-6 text-center">Gold Entry</th>
                        <th className="py-4 px-6 text-center">Silver Entry</th>
                        <th className="py-4 px-6 text-center">Drop Date</th>
                        <th className="py-4 px-6 text-right">Actions</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                      {sailorList.map((s) => (
                        <tr key={s.id} className="hover:bg-white/5 transition-colors">
                          <td className="py-4 px-6 font-bold text-white">
                            {s.name}
                          </td>
                          <td className="py-4 px-6 font-mono text-slate-400">{s.sailNumber}</td>
                          <td className="py-4 px-6">{s.gender || "M"}</td>
                          <td className="py-4 px-6">
                            <span className="text-[10px] text-slate-400 bg-white/5 px-2 py-0.5 rounded border border-white/5">
                              {s.nationalSquadStatus || "None"}
                            </span>
                          </td>
                          <td className="py-4 px-6 text-center font-mono">{s.goldEntryDate || "-"}</td>
                          <td className="py-4 px-6 text-center font-mono">{s.silverEntryDate || "-"}</td>
                          <td className="py-4 px-6 text-center font-mono">{s.dropDate || "-"}</td>
                          <td className="py-4 px-6 text-right">
                            <div className="flex justify-end items-center gap-2">
                              <button
                                onClick={() => {
                                  setEditingSailorId(s.id);
                                  setSailorForm({
                                    ...s,
                                    weight: s.weight ? s.weight.toString() : "",
                                    nationalSquadStatus: s.nationalSquadStatus || "",
                                    instagram: s.instagram || "",
                                    facebook: s.facebook || "",
                                    dob: s.dob || "",
                                    bio: s.bio || "",
                                    goldEntryDate: s.goldEntryDate || "",
                                    silverEntryDate: s.silverEntryDate || "",
                                    dropDate: s.dropDate || "",
                                  });
                                }}
                                className="text-slate-400 hover:text-white"
                              >
                                <Edit3 className="h-4 w-4" />
                              </button>
                              <button
                                onClick={() => handleDeleteSailor(s.id)}
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
                    <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
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
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Nett Score (Points)</label>
                        <input
                          type="number"
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
                          checked={resultForm.isDNS}
                          onChange={(e) => setResultForm({ ...resultForm, isDNS: e.target.checked })}
                          className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                        />
                        <label htmlFor="dnsCheckbox" className="text-xs font-bold text-slate-400 cursor-pointer">
                          Did Not Start (DNS)
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
                      <button
                        onClick={() => {
                          setEditingResultId("new");
                          setResultForm({
                            id: "",
                            regattaId: selectedRegattaIdForResultEdit,
                            sailorId: "",
                            rank: 1,
                            nettScore: 1,
                            isDNS: false,
                          });
                        }}
                        className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                      >
                        <Plus className="h-4 w-4" />
                        Add Score
                      </button>
                    </div>

                    <table className="w-full text-left border-collapse text-xs">
                      <thead>
                        <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                          <th className="py-4 px-6">Competitor</th>
                          <th className="py-4 px-6">Sail Number</th>
                          <th className="py-4 px-6 text-center">Nett Score</th>
                          <th className="py-4 px-6 text-center">Rank</th>
                          <th className="py-4 px-6 text-center">Status</th>
                          <th className="py-4 px-6 text-right">Actions</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                        {resultsList
                          .filter((res) => res.regattaId === selectedRegattaIdForResultEdit)
                          .map((res) => {
                            const sailor = sailorList.find((s) => s.id === res.sailorId);
                            return (
                              <tr key={res.id} className="hover:bg-white/5 transition-colors">
                                <td className="py-4 px-6 font-bold text-white">
                                  {sailor ? sailor.name : "Deleted / Unmapped Sailor"}
                                </td>
                                <td className="py-4 px-6 font-mono text-slate-400">
                                  {sailor ? sailor.sailNumber : "-"}
                                </td>
                                <td className="py-4 px-6 text-center font-mono">{res.nettScore}</td>
                                <td className="py-4 px-6 text-center font-mono">{res.rank}</td>
                                <td className="py-4 px-6 text-center">
                                  <span className={`inline-block px-2 py-0.5 rounded text-[10px] ${
                                    res.isDNS 
                                      ? "bg-rose-500/10 text-rose-500 border border-rose-500/20" 
                                      : "bg-slate-800 text-slate-400"
                                  }`}>
                                    {res.isDNS ? "DNS" : "Finished"}
                                  </span>
                                </td>
                                <td className="py-4 px-6 text-right">
                                  <div className="flex justify-end items-center gap-2">
                                    <button
                                      onClick={() => {
                                        setEditingResultId(res.id);
                                        setResultForm({
                                          ...res,
                                          nettScore: res.nettScore.toString(),
                                          rank: res.rank.toString(),
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
                            <td colSpan={6} className="text-center py-12 text-slate-500">
                              No sailor results logged for this regatta. Click "Add Score" above.
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
    </div>
  );
}
