"use client";

import { useState } from "react";
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

import { Plus, Trash2, Edit3, User, Medal } from "lucide-react";

interface AdminDashboardProps {
  initialSailors: any[];
  initialRegattas: any[];
  initialResults: any[];
  isDemo: boolean;
}

export function AdminDashboard({ initialSailors, initialRegattas, initialResults, isDemo }: AdminDashboardProps) {
  const [activeTab, setActiveTab] = useState<"import" | "reconciliation" | "bulk" | "edit">("import");
  
  // Auth simulation for RLS demonstration
  const [adminRole, setAdminRole] = useState<"superadmin" | "coach" | "sailor">("superadmin");

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
  const [bulkDates, setBulkDates] = useState({
    goldEntryDate: "",
    silverEntryDate: "",
    dropDate: "",
    gender: "",
    nationalSquadStatus: "",
    club: "",
  });
  const [sailorList, setSailorList] = useState(initialSailors);
  const [bulkStatus, setBulkStatus] = useState<string | null>(null);

  // Database Editor Sub-Tabs & Forms
  const [editSubTab, setEditSubTab] = useState<"sailors" | "regattas" | "results">("sailors");
  const [editingSailorId, setEditingSailorId] = useState<string | null>(null);
  const [sailorForm, setSailorForm] = useState<any>({
    id: "",
    firstName: "",
    lastName: "",
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
  });

  const [regattaList, setRegattaList] = useState(initialRegattas || []);
  const [editingRegattaId, setEditingRegattaId] = useState<string | null>(null);
  const [regattaForm, setRegattaForm] = useState<any>({
    id: "",
    name: "",
    date: "",
    totalFleetSize: 50,
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
      const json = utils.sheet_to_json(sheet);
      setParsedData(json.slice(0, 15)); // Show preview of 15 records
      setImportStatus(`Successfully parsed ${json.length} rows from Excel file.`);
    };
    reader.readAsBinaryString(file);
  };

  // Reconciliation Handlers
  const handleMerge = (queueId: string, sailorId: string) => {
    setReconciliationQueue((prev) => prev.filter((item) => item.id !== queueId));
    alert("Reconciliation complete: Merged name to existing sailor record.");
  };

  const handleCreateNew = (queueId: string, rawName: string) => {
    setReconciliationQueue((prev) => prev.filter((item) => item.id !== queueId));
    // Add to local list in bulk view
    const newHandle = rawName.toLowerCase().replace(/[^a-z0-9]+/g, "-");
    const newSailor = {
      id: `new-${Date.now()}`,
      firstName: rawName.split(" ")[0] || rawName,
      lastName: rawName.split(" ").slice(1).join(" ") || "Sailor",
      handle: newHandle,
      sailNumber: "SGP 0000",
      club: "N/A",
      goldEntryDate: null,
      silverEntryDate: new Date().toISOString().split("T")[0],
      dropDate: null,
    };
    setSailorList((prev) => [...prev, newSailor]);
    alert(`Created new sailor record: "${rawName}" with Silver fleet status.`);
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

  const handleApplyBulk = () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can update fleet properties.");
      return;
    }

    if (selectedSailors.length === 0) {
      alert("Please select at least one sailor to bulk edit.");
      return;
    }

    // Apply updates locally
    setSailorList((prev) =>
      prev.map((s) => {
        if (selectedSailors.includes(s.id)) {
          return {
            ...s,
            goldEntryDate: bulkDates.goldEntryDate || s.goldEntryDate,
            silverEntryDate: bulkDates.silverEntryDate || s.silverEntryDate,
            dropDate: bulkDates.dropDate || s.dropDate,
            gender: bulkDates.gender || s.gender,
            nationalSquadStatus: 
              bulkDates.nationalSquadStatus === "CLEAR" 
                ? null 
                : (bulkDates.nationalSquadStatus || s.nationalSquadStatus),
            club: bulkDates.club || s.club,
          };
        }
        return s;
      })
    );

    setBulkStatus(`Successfully updated properties for ${selectedSailors.length} sailors.`);
    setSelectedSailors([]);
    setBulkDates({
      goldEntryDate: "",
      silverEntryDate: "",
      dropDate: "",
      gender: "",
      nationalSquadStatus: "",
      club: "",
    });
    setTimeout(() => setBulkStatus(null), 3000);
  };

  // Sailor CRUD Handlers
  const handleSaveSailor = () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!sailorForm.firstName || !sailorForm.lastName || !sailorForm.sailNumber) {
      alert("First Name, Last Name, and Sail Number are required.");
      return;
    }

    if (editingSailorId === "new") {
      const newId = `sailor-${Date.now()}`;
      const newSailor = {
        ...sailorForm,
        id: newId,
        handle: sailorForm.handle || `${sailorForm.firstName.toLowerCase()}-${sailorForm.lastName.toLowerCase()}`,
        weight: sailorForm.weight ? parseInt(sailorForm.weight) : null,
      };
      setSailorList((prev) => [...prev, newSailor]);
      alert("Sailor created successfully!");
    } else {
      setSailorList((prev) =>
        prev.map((s) =>
          s.id === editingSailorId
            ? {
                ...s,
                ...sailorForm,
                weight: sailorForm.weight ? parseInt(sailorForm.weight) : null,
              }
            : s
        )
      );
      alert("Sailor updated successfully!");
    }
    setEditingSailorId(null);
  };

  const handleDeleteSailor = (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (confirm("Are you sure you want to delete this sailor?")) {
      setSailorList((prev) => prev.filter((s) => s.id !== id));
    }
  };

  // Regatta CRUD Handlers
  const handleSaveRegatta = () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!regattaForm.name || !regattaForm.date) {
      alert("Regatta Name and Date are required.");
      return;
    }

    if (editingRegattaId === "new") {
      const newId = `regatta-${Date.now()}`;
      const newRegatta = {
        ...regattaForm,
        id: newId,
        slug: regattaForm.name.toLowerCase().replace(/[^a-z0-9]+/g, "-"),
        totalFleetSize: parseInt(regattaForm.totalFleetSize) || 50,
      };
      setRegattaList((prev) => [...prev, newRegatta]);
      // Set default selected regatta for results if empty
      if (!selectedRegattaIdForResultEdit) {
        setSelectedRegattaIdForResultEdit(newId);
      }
      alert("Regatta created successfully!");
    } else {
      setRegattaList((prev) =>
        prev.map((r) =>
          r.id === editingRegattaId
            ? {
                ...r,
                ...regattaForm,
                totalFleetSize: parseInt(regattaForm.totalFleetSize) || 50,
              }
            : r
        )
      );
      alert("Regatta updated successfully!");
    }
    setEditingRegattaId(null);
  };

  const handleDeleteRegatta = (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (confirm("Are you sure you want to delete this regatta? All results associated with it will also be deleted.")) {
      setRegattaList((prev) => prev.filter((r) => r.id !== id));
      setResultsList((prev) => prev.filter((res) => res.regattaId !== id));
    }
  };

  // Result CRUD Handlers
  const handleSaveResult = () => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (!resultForm.sailorId || !resultForm.regattaId) {
      alert("Sailor and Regatta must be selected.");
      return;
    }

    if (editingResultId === "new") {
      const newId = `result-${Date.now()}`;
      const newResult = {
        ...resultForm,
        id: newId,
        rank: parseInt(resultForm.rank) || 1,
        nettScore: parseInt(resultForm.nettScore) || 1,
      };
      setResultsList((prev) => [...prev, newResult]);
      alert("Result added successfully!");
    } else {
      setResultsList((prev) =>
        prev.map((r) =>
          r.id === editingResultId
            ? {
                ...r,
                ...resultForm,
                rank: parseInt(resultForm.rank) || 1,
                nettScore: parseInt(resultForm.nettScore) || 1,
              }
            : r
        )
      );
      alert("Result updated successfully!");
    }
    setEditingResultId(null);
  };

  const handleDeleteResult = (id: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden. Only Superadmins can write to the database.");
      return;
    }
    if (confirm("Are you sure you want to delete this result?")) {
      setResultsList((prev) => prev.filter((r) => r.id !== id));
    }
  };

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12 flex-1 flex flex-col gap-8">
      {/* Superadmin RLS check controller */}
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
            </div>

            {/* Column Mapping Preview */}
            {parsedData && (
              <div className="glass-card rounded-2xl p-6 border border-white/5 space-y-6">
                <div>
                  <h3 className="text-base font-bold text-white">Review Column Mapping</h3>
                  <p className="text-xs text-slate-500 mt-1">
                    Verify that your Excel headers are mapped correctly to database schema columns.
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
              <div className="flex flex-wrap items-center gap-4">
                <div className="flex flex-col gap-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase">Gold Entry Date</label>
                  <input
                    type="date"
                    value={bulkDates.goldEntryDate}
                    onChange={(e) => setBulkDates((prev) => ({ ...prev, goldEntryDate: e.target.value }))}
                    className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:border-orange-500"
                  />
                </div>
                <div className="flex flex-col gap-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase">Silver Entry Date</label>
                  <input
                    type="date"
                    value={bulkDates.silverEntryDate}
                    onChange={(e) => setBulkDates((prev) => ({ ...prev, silverEntryDate: e.target.value }))}
                    className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:border-orange-500"
                  />
                </div>
                <div className="flex flex-col gap-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase">Drop Date</label>
                  <input
                    type="date"
                    value={bulkDates.dropDate}
                    onChange={(e) => setBulkDates((prev) => ({ ...prev, dropDate: e.target.value }))}
                    className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:border-orange-500"
                  />
                </div>
                <div className="flex flex-col gap-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase">Gender</label>
                  <select
                    value={bulkDates.gender}
                    onChange={(e) => setBulkDates((prev) => ({ ...prev, gender: e.target.value }))}
                    className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:outline-none"
                  >
                    <option value="">-- No Change --</option>
                    <option value="M">Male (M)</option>
                    <option value="F">Female (F)</option>
                  </select>
                </div>
                <div className="flex flex-col gap-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase">Squad Status</label>
                  <select
                    value={bulkDates.nationalSquadStatus}
                    onChange={(e) => setBulkDates((prev) => ({ ...prev, nationalSquadStatus: e.target.value }))}
                    className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:outline-none"
                  >
                    <option value="">-- No Change --</option>
                    <option value="CLEAR">Clear Status (None)</option>
                    <option value="Nat A">National A (Nat A)</option>
                    <option value="Nat B">National B (Nat B)</option>
                    <option value="DS">Development Squad (DS)</option>
                  </select>
                </div>
                <div className="flex flex-col gap-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase">Club Origin</label>
                  <input
                    type="text"
                    value={bulkDates.club}
                    onChange={(e) => setBulkDates((prev) => ({ ...prev, club: e.target.value }))}
                    placeholder="e.g. NSC Yacht Club"
                    className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-1.5 text-xs focus:border-orange-500"
                  />
                </div>

                <div className="flex items-end justify-end flex-1 pt-4">
                  <button
                    disabled={!isSuperadmin || selectedSailors.length === 0}
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
              <table className="w-full text-left border-collapse text-xs">
                <thead>
                  <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                    <th className="py-4 px-6 text-center w-16">
                      <input
                        type="checkbox"
                        checked={selectedSailors.length === sailorList.length && sailorList.length > 0}
                        onChange={toggleSelectAll}
                        className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                      />
                    </th>
                    <th className="py-4 px-6">Sailor Name</th>
                    <th className="py-4 px-6">Sail Number</th>
                    <th className="py-4 px-6">Club</th>
                    <th className="py-4 px-6 text-center">Gender</th>
                    <th className="py-4 px-6 text-center">Squad</th>
                    <th className="py-4 px-6 text-center">Gold Entry</th>
                    <th className="py-4 px-6 text-center">Silver Entry</th>
                    <th className="py-4 px-6 text-center">Drop Date</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                  {sailorList.map((sailor) => {
                    const isChecked = selectedSailors.includes(sailor.id);
                    return (
                      <tr
                        key={sailor.id}
                        className={`transition-colors ${isChecked ? "bg-orange-500/5 hover:bg-orange-500/10" : "hover:bg-white/5"}`}
                      >
                        <td className="py-4 px-6 text-center">
                          <input
                            type="checkbox"
                            checked={isChecked}
                            onChange={() => toggleSelectSailor(sailor.id)}
                            className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                          />
                        </td>
                        <td className="py-4 px-6 font-bold text-white">
                          {sailor.firstName} {sailor.lastName}
                        </td>
                        <td className="py-4 px-6 font-mono text-slate-400">{sailor.sailNumber}</td>
                        <td className="py-4 px-6 text-slate-400">{sailor.club}</td>
                        <td className="py-4 px-6 text-center">{sailor.gender || "M"}</td>
                        <td className="py-4 px-6 text-center">
                          <span className="text-[10px] text-slate-400 bg-white/5 px-2 py-0.5 rounded border border-white/5">
                            {sailor.nationalSquadStatus || "None"}
                          </span>
                        </td>
                        <td className="py-4 px-6 text-center font-mono">
                          {sailor.goldEntryDate || <span className="text-slate-600">-</span>}
                        </td>
                        <td className="py-4 px-6 text-center font-mono">
                          {sailor.silverEntryDate || <span className="text-slate-600">-</span>}
                        </td>
                        <td className="py-4 px-6 text-center font-mono">
                          {sailor.dropDate || <span className="text-slate-600">-</span>}
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
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
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">First Name</label>
                        <input
                          type="text"
                          value={sailorForm.firstName}
                          onChange={(e) => setSailorForm({ ...sailorForm, firstName: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Last Name</label>
                        <input
                          type="text"
                          value={sailorForm.lastName}
                          onChange={(e) => setSailorForm({ ...sailorForm, lastName: e.target.value })}
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
                          firstName: "",
                          lastName: "",
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
                            {s.firstName} {s.lastName}
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
                        <th className="py-4 px-6 text-right">Actions</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                      {regattaList.map((r) => (
                        <tr key={r.id} className="hover:bg-white/5 transition-colors">
                          <td className="py-4 px-6 font-bold text-white">{r.name}</td>
                          <td className="py-4 px-6 font-mono text-slate-400">{r.date}</td>
                          <td className="py-4 px-6 text-center font-mono">{r.totalFleetSize}</td>
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
                              {s.firstName} {s.lastName} ({s.sailNumber})
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
                                  {sailor ? `${sailor.firstName} ${sailor.lastName}` : "Deleted / Unmapped Sailor"}
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
