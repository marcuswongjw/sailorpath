"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { ArrowRight, BarChart3, GitCompareArrows, Plus, Search, Trash2, Users } from "lucide-react";
import type { CoachSquadDashboard } from "@/lib/coachDashboard";

type SearchMatch = { id: string; name: string; handle: string; sailNumber: string; club: string };

async function readJson<T>(response: Response): Promise<T> {
  const body = await response.json();
  if (!response.ok) throw new Error(body.error || "Something went wrong");
  return body as T;
}

export function CoachDashboard({ initialData }: { initialData: CoachSquadDashboard }) {
  const [data, setData] = useState(initialData);
  const [query, setQuery] = useState("");
  const [matches, setMatches] = useState<SearchMatch[]>([]);
  const [selected, setSelected] = useState<string[]>([]);
  const [busyId, setBusyId] = useState<string | null>(null);
  const [message, setMessage] = useState<string | null>(null);
  const [squadName, setSquadName] = useState(initialData.squad?.name || "My squad");

  useEffect(() => {
    if (query.trim().length < 2) {
      return;
    }
    const controller = new AbortController();
    const timer = window.setTimeout(async () => {
      try {
        const response = await fetch(`/api/coach/sailors?q=${encodeURIComponent(query.trim())}`, { signal: controller.signal });
        const body = await readJson<{ sailors: SearchMatch[] }>(response);
        const memberIds = new Set(data.members.map((member) => member.sailorId));
        setMatches(body.sailors.filter((sailor) => !memberIds.has(sailor.id)));
      } catch (error) {
        if ((error as Error).name !== "AbortError") setMessage(error instanceof Error ? error.message : "Search failed");
      }
    }, 250);
    return () => {
      controller.abort();
      window.clearTimeout(timer);
    };
  }, [query, data.members]);

  const rankedCount = data.members.filter((member) => member.ranking != null).length;
  const averageBest = useMemo(() => {
    const scores = data.members.map((member) => member.bestThreeOfFive).filter((score): score is number => score != null);
    return scores.length ? (scores.reduce((sum, score) => sum + score, 0) / scores.length).toFixed(1) : "—";
  }, [data.members]);
  const selectedMembers = selected.map((id) => data.members.find((member) => member.sailorId === id));
  const compareFleet = selectedMembers[0]?.fleet;
  const compareHref = selected.length === 2 && compareFleet
    ? `/sg/optimist/compare?fleet=${compareFleet}&year=${data.period.year}&half=${encodeURIComponent(data.period.half)}&a=${selected[0]}&b=${selected[1]}`
    : null;

  async function mutate(method: "POST" | "PATCH" | "DELETE", payload: { sailorId?: string; name?: string }) {
    const queryString = method === "DELETE" ? `?sailorId=${encodeURIComponent(payload.sailorId || "")}` : "";
    const response = await fetch(`/api/coach/squad${queryString}`, {
      method,
      ...(method !== "DELETE" ? { headers: { "content-type": "application/json" }, body: JSON.stringify(payload) } : {}),
    });
    const next = await readJson<CoachSquadDashboard>(response);
    setData(next);
    setSquadName(next.squad?.name || "My squad");
  }

  async function addSailor(sailorId: string) {
    setBusyId(sailorId); setMessage(null);
    try {
      await mutate("POST", { sailorId });
      setQuery(""); setMatches([]); setMessage("Sailor added to your squad.");
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not add sailor"); }
    finally { setBusyId(null); }
  }

  async function removeSailor(sailorId: string) {
    setBusyId(sailorId); setMessage(null);
    try {
      await mutate("DELETE", { sailorId });
      setSelected((current) => current.filter((id) => id !== sailorId));
      setMessage("Sailor removed from your squad.");
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not remove sailor"); }
    finally { setBusyId(null); }
  }

  async function renameSquad() {
    if (!squadName.trim() || squadName.trim() === data.squad?.name) return;
    setBusyId("rename"); setMessage(null);
    try { await mutate("PATCH", { name: squadName.trim() }); setMessage("Squad name saved."); }
    catch (error) { setMessage(error instanceof Error ? error.message : "Could not rename squad"); }
    finally { setBusyId(null); }
  }

  function toggleCompare(sailorId: string) {
    setSelected((current) => {
      if (current.includes(sailorId)) return current.filter((id) => id !== sailorId);
      const nextMember = data.members.find((member) => member.sailorId === sailorId);
      const currentMember = data.members.find((member) => member.sailorId === current[0]);
      if (!nextMember?.fleet || (currentMember?.fleet && currentMember.fleet !== nextMember.fleet)) {
        return [sailorId];
      }
      return current.length === 2 ? [current[1], sailorId] : [...current, sailorId];
    });
  }

  return (
    <div className="mx-auto max-w-6xl px-4 py-8 sm:py-12 space-y-6">
      <header className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="text-[11px] font-bold uppercase tracking-[0.18em] text-orange-400">Coach workspace</p>
          <h1 className="mt-1 text-3xl font-black tracking-tight text-white sm:text-4xl">Squad dashboard</h1>
          <p className="mt-2 text-sm text-slate-400">Live public rankings and results for the sailors you follow.</p>
        </div>
        <Link href="/rankings" className="inline-flex items-center justify-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2.5 text-xs font-bold text-white hover:border-orange-500/40">
          View all rankings <ArrowRight className="h-3.5 w-3.5" />
        </Link>
      </header>

      <section className="grid grid-cols-2 gap-3 lg:grid-cols-4" aria-label="Squad summary">
        {[
          ["Squad sailors", String(data.members.length), Users],
          ["Ranked now", String(rankedCount), BarChart3],
          ["Average Best 3", averageBest, BarChart3],
          ["Ranking period", `${data.period.half} ${data.period.year}`, Users],
        ].map(([label, value, Icon]) => (
          <div key={String(label)} className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
            <Icon className="h-4 w-4 text-orange-400" />
            <p className="mt-3 text-xl font-black text-white">{String(value)}</p>
            <p className="mt-0.5 text-[11px] font-semibold text-slate-500">{String(label)}</p>
          </div>
        ))}
      </section>

      <section className="grid gap-4 lg:grid-cols-[minmax(0,1fr)_21rem]">
        <div className="overflow-hidden rounded-2xl border border-white/10 bg-[#0b0c12]">
          <div className="flex flex-col gap-3 border-b border-white/10 p-4 sm:flex-row sm:items-center sm:justify-between">
            <div className="flex items-center gap-2">
              <input value={squadName} onChange={(event) => setSquadName(event.target.value)} onBlur={renameSquad}
                onKeyDown={(event) => { if (event.key === "Enter") event.currentTarget.blur(); }}
                aria-label="Squad name" maxLength={80}
                className="min-w-0 rounded-lg border border-transparent bg-transparent px-2 py-1 text-lg font-black text-white outline-none hover:border-white/10 focus:border-orange-500/50" />
              <span className="text-[10px] text-slate-600">{busyId === "rename" ? "Saving…" : "Edit name"}</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="text-[11px] text-slate-500">Select two sailors</span>
              {compareHref ? (
                <Link href={compareHref} className="inline-flex items-center gap-1.5 rounded-full bg-orange-600 px-3 py-2 text-[11px] font-bold text-white hover:bg-orange-500">
                  <GitCompareArrows className="h-3.5 w-3.5" /> Compare
                </Link>
              ) : (
                <span className="inline-flex items-center gap-1.5 rounded-full bg-white/5 px-3 py-2 text-[11px] font-bold text-slate-600"><GitCompareArrows className="h-3.5 w-3.5" /> Compare</span>
              )}
            </div>
          </div>

          {data.members.length === 0 ? (
            <div className="px-6 py-16 text-center">
              <Users className="mx-auto h-9 w-9 text-slate-700" />
              <h2 className="mt-4 text-base font-bold text-white">Build your first squad</h2>
              <p className="mx-auto mt-1 max-w-sm text-xs leading-relaxed text-slate-500">Search for a sailor on the right. Their live ranking and latest result will appear here.</p>
            </div>
          ) : (
            <div className="divide-y divide-white/[0.06]">
              {data.members.map((member) => (
                <article key={member.id} className="grid gap-3 p-4 sm:grid-cols-[auto_minmax(0,1fr)_auto] sm:items-center">
                  <input type="checkbox" checked={selected.includes(member.sailorId)} onChange={() => toggleCompare(member.sailorId)}
                    aria-label={`Select ${member.name} for comparison`} className="h-4 w-4 accent-orange-500" />
                  <div className="min-w-0">
                    <div className="flex flex-wrap items-center gap-2">
                      <Link href={`/${member.handle}`} className="truncate text-sm font-bold text-white hover:text-orange-400">{member.name}</Link>
                      {member.fleet && <span className="rounded-full border border-orange-500/25 bg-orange-500/10 px-2 py-0.5 text-[10px] font-bold text-orange-300">{member.fleet} #{member.ranking}</span>}
                      {member.squadStatus && <span className="rounded-full border border-sky-500/20 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300">{member.squadStatus}</span>}
                    </div>
                    <p className="mt-1 text-[11px] text-slate-500">{member.sailNumber} · {member.club}{member.bestThreeOfFive != null ? ` · Best 3: ${member.bestThreeOfFive}` : ""}</p>
                    {member.latestResult && <p className="mt-1 text-[11px] text-slate-400">Latest: {member.latestResult.regattaName} · #{member.latestResult.rank} of {member.latestResult.fleetSize}</p>}
                  </div>
                  <button type="button" onClick={() => removeSailor(member.sailorId)} disabled={busyId === member.sailorId}
                    aria-label={`Remove ${member.name} from squad`} className="justify-self-end rounded-lg p-2 text-slate-600 hover:bg-rose-500/10 hover:text-rose-400 disabled:opacity-50">
                    <Trash2 className="h-4 w-4" />
                  </button>
                </article>
              ))}
            </div>
          )}
        </div>

        <aside className="h-fit rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <h2 className="text-sm font-bold text-white">Add a sailor</h2>
          <p className="mt-1 text-[11px] leading-relaxed text-slate-500">Search by name, sail number, club, school, or profile handle.</p>
          <div className="relative mt-4">
            <Search className="absolute left-3 top-3 h-4 w-4 text-slate-600" />
            <input value={query} onChange={(event) => {
              const value = event.target.value;
              setQuery(value);
              if (value.trim().length < 2) setMatches([]);
            }} placeholder="Type at least 2 characters"
              aria-label="Search sailors to add" className="w-full rounded-xl border border-white/10 bg-black/30 py-2.5 pl-9 pr-3 text-sm text-white outline-none placeholder:text-slate-700 focus:border-orange-500/50" />
          </div>
          <div className="mt-3 space-y-1.5" aria-live="polite">
            {matches.map((sailor) => (
              <button key={sailor.id} type="button" onClick={() => addSailor(sailor.id)} disabled={busyId === sailor.id}
                className="flex w-full items-center gap-3 rounded-xl border border-white/[0.06] bg-black/20 p-3 text-left hover:border-orange-500/30 disabled:opacity-50">
                <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-orange-500/10 text-[11px] font-black text-orange-300">
                  {sailor.name.split(/\s+/).slice(0, 2).map((part) => part[0]).join("")}
                </span>
                <span className="min-w-0 flex-1"><span className="block truncate text-xs font-bold text-white">{sailor.name}</span><span className="block truncate text-[10px] text-slate-500">{sailor.sailNumber} · {sailor.club}</span></span>
                <Plus className="h-4 w-4 text-orange-400" />
              </button>
            ))}
            {query.trim().length >= 2 && matches.length === 0 && <p className="py-5 text-center text-[11px] text-slate-600">No new matches yet.</p>}
          </div>
        </aside>
      </section>

      {message && <p role="status" className="rounded-xl border border-white/10 bg-white/5 px-4 py-3 text-xs text-slate-300">{message}</p>}
    </div>
  );
}
