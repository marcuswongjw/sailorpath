"use client";

import { useEffect, useState } from "react";
import { read, utils } from "xlsx";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { Shield, Upload, UserPlus, RefreshCw } from "lucide-react";

type Sailor = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  club: string;
  goldEntryDate: string | null;
  silverEntryDate: string | null;
};

type Unmatched = {
  rawName: string;
  rank: number | null;
  nett: number | null;
  suggestedId: string | null;
  suggestedName: string | null;
};

export function AdminDashboard({
  initialSailors,
}: {
  initialSailors: Sailor[];
}) {
  const [userEmail, setUserEmail] = useState<string | null>(null);
  const [role, setRole] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [sailors, setSailors] = useState(initialSailors);
  const [status, setStatus] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const [meta, setMeta] = useState({
    name: "",
    date: new Date().toISOString().slice(0, 10),
    division: "Gold",
    fleetSize: 50,
  });
  const [rows, setRows] = useState<
    { name: string; rank: number | null; nett: number | null }[]
  >([]);
  const [unmatched, setUnmatched] = useState<Unmatched[]>([]);
  const [regattaId, setRegattaId] = useState<string | null>(null);

  const [newSailor, setNewSailor] = useState({
    name: "",
    sailNumber: "",
    club: "",
    goldEntryDate: "",
    silverEntryDate: "",
  });

  useEffect(() => {
    let unsub: (() => void) | undefined;
    (async () => {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (!session?.user) {
          setLoading(false);
          return;
        }
        setUserEmail(session.user.email ?? null);
        const res = await fetch("/api/admin/me");
        const data = await res.json();
        setRole(data.role);
        const { data: sub } = supabase.auth.onAuthStateChange(async () => {
          const me = await fetch("/api/admin/me").then((r) => r.json());
          setRole(me.role);
          setUserEmail(me.user?.email ?? null);
        });
        unsub = () => sub.subscription.unsubscribe();
      } catch (e) {
        setError(e instanceof Error ? e.message : "Auth error");
      } finally {
        setLoading(false);
      }
    })();
    return () => unsub?.();
  }, []);

  const onFile = async (file: File) => {
    setError(null);
    const buf = await file.arrayBuffer();
    const wb = read(buf);
    const sheet = wb.Sheets[wb.SheetNames[0]];
    const json = utils.sheet_to_json<Record<string, unknown>>(sheet, {
      defval: "",
    });
    const keys = Object.keys(json[0] || {});
    const nameKey =
      keys.find((k) => /name|sailor/i.test(k)) || keys[0] || "Name";
    const rankKey =
      keys.find((k) => /rank|pos|place/i.test(k)) || keys[1] || "Rank";
    const nettKey =
      keys.find((k) => /nett|points|pts|score/i.test(k)) || keys[2] || "Nett";

    const parsed = json
      .map((row) => ({
        name: String(row[nameKey] ?? "").trim(),
        rank: row[rankKey] !== "" ? Number(row[rankKey]) : null,
        nett: row[nettKey] !== "" ? Number(row[nettKey]) : null,
      }))
      .filter((r) => r.name);
    setRows(parsed);
    setStatus(`Parsed ${parsed.length} rows from ${file.name}`);
  };

  const runImport = async () => {
    setError(null);
    setStatus("Importing…");
    const res = await fetch("/api/admin/import", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        regattaName: meta.name,
        eventDate: meta.date,
        division: meta.division,
        totalFleetSize: meta.fleetSize,
        rows,
      }),
    });
    const data = await res.json();
    if (!res.ok) {
      setError(data.error || "Import failed");
      setStatus(null);
      return;
    }
    setStatus(data.message);
    setUnmatched(data.unmatched || []);
    setRegattaId(data.regatta?.id || null);
  };

  const reconcile = async (
    item: Unmatched,
    action: "merge" | "create"
  ) => {
    const res = await fetch("/api/admin/reconcile", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        action,
        rawName: item.rawName,
        suggestedId: item.suggestedId,
        regattaId,
        rank: item.rank,
        nett: item.nett,
      }),
    });
    const data = await res.json();
    if (!res.ok) {
      setError(data.error || "Reconcile failed");
      return;
    }
    setUnmatched((u) => u.filter((x) => x.rawName !== item.rawName));
    setStatus(`Resolved ${item.rawName}`);
    const list = await fetch("/api/admin/sailors").then((r) => r.json());
    if (list.sailors) setSailors(list.sailors);
  };

  const createSailor = async () => {
    const res = await fetch("/api/admin/sailors", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(newSailor),
    });
    const data = await res.json();
    if (!res.ok) {
      setError(data.error || "Create failed");
      return;
    }
    setSailors((s) => [...s, data.sailor].sort((a, b) => a.name.localeCompare(b.name)));
    setNewSailor({
      name: "",
      sailNumber: "",
      club: "",
      goldEntryDate: "",
      silverEntryDate: "",
    });
    setStatus(`Created ${data.sailor.name}`);
  };

  if (loading) {
    return (
      <div className="flex-1 flex items-center justify-center min-h-[50vh]">
        <RefreshCw className="h-8 w-8 text-orange-500 animate-spin" />
      </div>
    );
  }

  if (!userEmail) {
    return (
      <div className="mx-auto max-w-md px-4 py-20 text-center space-y-4">
        <Shield className="h-10 w-10 text-rose-400 mx-auto" />
        <h1 className="text-xl font-black text-white">Admin login required</h1>
        <p className="text-xs text-slate-400">
          Sign in with your superadmin account, then return here.
        </p>
        <a
          href={`https://sailorpath.com/login?next=${encodeURIComponent("https://admin.sailorpath.com/")}`}
          className="inline-block rounded-full bg-orange-600 px-6 py-3 text-xs font-bold text-white"
        >
          Sign in
        </a>
      </div>
    );
  }

  if (role !== "superadmin") {
    return (
      <div className="mx-auto max-w-md px-4 py-20 text-center space-y-3">
        <h1 className="text-xl font-black text-white">Forbidden</h1>
        <p className="text-xs text-slate-400">
          Signed in as {userEmail} (role: {role || "unknown"}). Set{" "}
          <code className="text-orange-400">profiles.role = superadmin</code> or
          SUPERADMIN_EMAIL on Vercel.
        </p>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-5xl px-4 py-10 space-y-10">
      <div className="flex items-center justify-between gap-4 flex-wrap">
        <div>
          <h1 className="text-2xl font-black text-white">Admin</h1>
          <p className="text-xs text-slate-400 mt-1">
            {userEmail} · superadmin · live database
          </p>
        </div>
      </div>

      {status && (
        <p className="text-xs font-bold text-orange-400 bg-orange-500/10 border border-orange-500/20 rounded-xl px-4 py-3">
          {status}
        </p>
      )}
      {error && (
        <p className="text-xs font-bold text-rose-400 bg-rose-500/10 border border-rose-500/20 rounded-xl px-4 py-3">
          {error}
        </p>
      )}

      {/* Import */}
      <section className="glass-card rounded-3xl border border-white/5 p-6 space-y-4">
        <h2 className="font-black text-white flex items-center gap-2">
          <Upload className="h-4 w-4 text-orange-500" /> Excel import
        </h2>
        <div className="grid sm:grid-cols-2 gap-3">
          <input
            placeholder="Regatta name"
            value={meta.name}
            onChange={(e) => setMeta({ ...meta, name: e.target.value })}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white"
          />
          <input
            type="date"
            value={meta.date}
            onChange={(e) => setMeta({ ...meta, date: e.target.value })}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white"
          />
          <select
            value={meta.division}
            onChange={(e) => setMeta({ ...meta, division: e.target.value })}
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white"
          >
            <option value="Gold">Gold</option>
            <option value="Silver">Silver</option>
            <option value="Both">Both</option>
          </select>
          <input
            type="number"
            placeholder="Fleet size"
            value={meta.fleetSize}
            onChange={(e) =>
              setMeta({ ...meta, fleetSize: Number(e.target.value) || 50 })
            }
            className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white"
          />
        </div>
        <input
          type="file"
          accept=".xlsx,.xls,.csv"
          onChange={(e) => e.target.files?.[0] && onFile(e.target.files[0])}
          className="text-xs text-slate-400"
        />
        <p className="text-[10px] text-slate-500">{rows.length} rows ready</p>
        <button
          type="button"
          disabled={!meta.name || rows.length === 0}
          onClick={runImport}
          className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white disabled:opacity-40"
        >
          Import to database
        </button>

        {unmatched.length > 0 && (
          <div className="space-y-2 pt-4 border-t border-white/5">
            <p className="text-xs font-bold text-amber-400">
              Unmatched ({unmatched.length})
            </p>
            {unmatched.map((u) => (
              <div
                key={u.rawName}
                className="flex flex-wrap items-center justify-between gap-2 rounded-xl bg-white/5 px-3 py-2 text-xs"
              >
                <span className="text-white font-bold">{u.rawName}</span>
                <span className="text-slate-500">
                  {u.suggestedName
                    ? `suggest: ${u.suggestedName}`
                    : "no suggestion"}
                </span>
                <div className="flex gap-2">
                  {u.suggestedId && (
                    <button
                      type="button"
                      onClick={() => reconcile(u, "merge")}
                      className="rounded-full bg-slate-700 px-3 py-1 font-bold text-white"
                    >
                      Merge
                    </button>
                  )}
                  <button
                    type="button"
                    onClick={() => reconcile(u, "create")}
                    className="rounded-full bg-orange-600 px-3 py-1 font-bold text-white"
                  >
                    Create
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </section>

      {/* Create sailor */}
      <section className="glass-card rounded-3xl border border-white/5 p-6 space-y-4">
        <h2 className="font-black text-white flex items-center gap-2">
          <UserPlus className="h-4 w-4 text-orange-500" /> Add sailor
        </h2>
        <div className="grid sm:grid-cols-2 gap-3">
          {(
            [
              ["name", "Name"],
              ["sailNumber", "Sail number"],
              ["club", "Club"],
              ["goldEntryDate", "Gold entry (YYYY-MM-DD)"],
              ["silverEntryDate", "Silver entry (YYYY-MM-DD)"],
            ] as const
          ).map(([key, label]) => (
            <input
              key={key}
              placeholder={label}
              value={newSailor[key]}
              onChange={(e) =>
                setNewSailor({ ...newSailor, [key]: e.target.value })
              }
              className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white"
            />
          ))}
        </div>
        <button
          type="button"
          onClick={createSailor}
          disabled={!newSailor.name}
          className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white disabled:opacity-40"
        >
          Create sailor
        </button>
      </section>

      {/* List */}
      <section className="space-y-3">
        <h2 className="font-black text-white">
          Sailors ({sailors.length})
        </h2>
        <div className="overflow-x-auto rounded-2xl border border-white/5">
          <table className="w-full text-sm text-left">
            <thead className="bg-white/5 text-xs text-slate-400 uppercase">
              <tr>
                <th className="px-3 py-2">Name</th>
                <th className="px-3 py-2">Sail #</th>
                <th className="px-3 py-2">Club</th>
                <th className="px-3 py-2">Gold</th>
                <th className="px-3 py-2">Silver</th>
              </tr>
            </thead>
            <tbody>
              {sailors.map((s) => (
                <tr key={s.id} className="border-t border-white/5">
                  <td className="px-3 py-2 font-bold text-white">{s.name}</td>
                  <td className="px-3 py-2 text-slate-400">{s.sailNumber}</td>
                  <td className="px-3 py-2 text-slate-400">{s.club}</td>
                  <td className="px-3 py-2 text-slate-400">
                    {s.goldEntryDate || "—"}
                  </td>
                  <td className="px-3 py-2 text-slate-400">
                    {s.silverEntryDate || "—"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </div>
  );
}
