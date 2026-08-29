"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { ArrowRight, BarChart3, ChevronRight, GitCompareArrows, Plus, Search, Trash2, TrendingDown, TrendingUp, Users, X } from "lucide-react";
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
  const [activeSailorId, setActiveSailorId] = useState<string | null>(null);
  const [noteDraft, setNoteDraft] = useState("");

  useEffect(() => {
    if (query.trim().length < 2) {
      return;
    }
    const controller = new AbortController();
    const timer = window.setTimeout(async () => {
      try {
        const response = await fetch(`/api/coach/sailors?q=${encodeURIComponent(query.trim())}`, { signal: controller.signal });
        const body = await readJson<{ sailors: SearchMatch[] }>(response);
        const memberIds = new Set([...data.members, ...data.following].map((member) => member.sailorId));
        setMatches(body.sailors.filter((sailor) => !memberIds.has(sailor.id)));
      } catch (error) {
        if ((error as Error).name !== "AbortError") setMessage(error instanceof Error ? error.message : "Search failed");
      }
    }, 250);
    return () => {
      controller.abort();
      window.clearTimeout(timer);
    };
  }, [query, data.members, data.following]);

  const rankedCount = data.members.filter((member) => member.ranking != null).length;
  const averageBest = useMemo(() => {
    const scores = data.members.map((member) => member.bestThreeOfFive).filter((score): score is number => score != null);
    return scores.length ? (scores.reduce((sum, score) => sum + score, 0) / scores.length).toFixed(1) : "—";
  }, [data.members]);
  const selectedMembers = selected.map((id) => data.members.find((member) => member.sailorId === id));
  const activeSailor = [...data.members, ...data.following].find((member) => member.sailorId === activeSailorId) || null;
  const actions = useMemo(() => data.members.flatMap((member) => {
    const items: Array<{ sailorId: string; sailor: string; text: string; priority: number }> = [];
    if (member.scoringEvents.some((event) => event.isDns)) items.push({ sailorId: member.sailorId, sailor: member.name, text: "DNS appears in the current ranking series", priority: 1 });
    if (member.scoringEvents.filter((event) => event.selected && !event.isDns).length < 3) items.push({ sailorId: member.sailorId, sailor: member.name, text: "Fewer than 3 completed counting events", priority: 2 });
    if (member.recentMovement != null && member.recentMovement < 0) items.push({ sailorId: member.sailorId, sailor: member.name, text: `Latest finish moved down ${Math.abs(member.recentMovement)} place${Math.abs(member.recentMovement) === 1 ? "" : "s"}`, priority: 3 });
    return items;
  }).sort((a, b) => a.priority - b.priority).slice(0, 6), [data.members]);
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

  async function mutateFollowing(method: "POST" | "DELETE", sailorId: string) {
    const queryString = method === "DELETE" ? `?sailorId=${encodeURIComponent(sailorId)}` : "";
    const response = await fetch(`/api/coach/following${queryString}`, {
      method,
      ...(method === "POST" ? { headers: { "content-type": "application/json" }, body: JSON.stringify({ sailorId }) } : {}),
    });
    setData(await readJson<CoachSquadDashboard>(response));
  }

  async function followSailor(sailorId: string) {
    setBusyId(sailorId); setMessage(null);
    try { await mutateFollowing("POST", sailorId); setQuery(""); setMatches([]); setMessage("Sailor added to Following."); }
    catch (error) { setMessage(error instanceof Error ? error.message : "Could not follow sailor"); }
    finally { setBusyId(null); }
  }

  async function unfollowSailor(sailorId: string) {
    setBusyId(sailorId); setMessage(null);
    try { await mutateFollowing("DELETE", sailorId); setMessage("Sailor removed from Following."); }
    catch (error) { setMessage(error instanceof Error ? error.message : "Could not remove sailor"); }
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

  function openSailor(sailorId: string) {
    const sailor = [...data.members, ...data.following].find((member) => member.sailorId === sailorId);
    setActiveSailorId(sailorId); setNoteDraft(sailor?.coachNote || "");
  }

  async function saveNote() {
    if (!activeSailor) return;
    setBusyId("note"); setMessage(null);
    try {
      const response = await fetch("/api/coach/notes", { method: "PUT", headers: { "content-type": "application/json" }, body: JSON.stringify({ sailorId: activeSailor.sailorId, note: noteDraft }) });
      const body = await readJson<{ note: string }>(response);
      setData((current) => ({ ...current, members: current.members.map((member) => member.sailorId === activeSailor.sailorId ? { ...member, coachNote: body.note } : member) }));
      setMessage("Private coach note saved.");
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not save note"); }
    finally { setBusyId(null); }
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

      <section className="rounded-2xl border border-amber-500/20 bg-amber-500/[0.04] p-4" aria-labelledby="action-centre-title">
        <div className="flex items-center justify-between gap-4">
          <div><p className="text-[10px] font-bold uppercase tracking-[0.16em] text-amber-400">Today</p><h2 id="action-centre-title" className="mt-1 text-base font-black text-white">Squad action centre</h2></div>
          <span className="rounded-full bg-amber-500/10 px-2.5 py-1 text-[10px] font-bold text-amber-300">{actions.length} to review</span>
        </div>
        {actions.length ? <div className="mt-3 grid gap-2 md:grid-cols-2">{actions.map((action) => <button key={`${action.sailorId}-${action.text}`} type="button" onClick={() => openSailor(action.sailorId)} className="flex items-center gap-3 rounded-xl border border-white/[0.07] bg-black/20 p-3 text-left hover:border-amber-500/30"><span className="min-w-0 flex-1"><span className="block truncate text-xs font-bold text-white">{action.sailor}</span><span className="block text-[11px] text-slate-400">{action.text}</span></span><ChevronRight className="h-4 w-4 text-slate-600" /></button>)}</div> : <p className="mt-3 text-xs text-slate-400">No ranking or attendance flags need attention.</p>}
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
                  <button type="button" onClick={() => openSailor(member.sailorId)} className="min-w-0 text-left" aria-label={`Open ${member.name} details`}>
                    <div className="flex flex-wrap items-center gap-2">
                      <Link href={`/${member.handle}`} className="truncate text-sm font-bold text-white hover:text-orange-400">{member.name}</Link>
                      {member.fleet && <span className="rounded-full border border-orange-500/25 bg-orange-500/10 px-2 py-0.5 text-[10px] font-bold text-orange-300">{member.fleet} #{member.ranking}</span>}
                      {member.squadStatus && <span className="rounded-full border border-sky-500/20 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300">{member.squadStatus}</span>}
                    </div>
                    <p className="mt-1 text-[11px] text-slate-500">{member.sailNumber} · {member.club}{member.bestThreeOfFive != null ? ` · Best 3: ${member.bestThreeOfFive}` : ""}</p>
                    {member.latestResult && <p className="mt-1 text-[11px] text-slate-400">Latest: {member.latestResult.regattaName} · #{member.latestResult.rank} of {member.latestResult.fleetSize}</p>}
                    {member.recentMovement != null && <span className={`mt-1 inline-flex items-center gap-1 text-[10px] font-bold ${member.recentMovement > 0 ? "text-emerald-400" : member.recentMovement < 0 ? "text-rose-400" : "text-slate-500"}`}>{member.recentMovement > 0 ? <TrendingUp className="h-3 w-3" /> : member.recentMovement < 0 ? <TrendingDown className="h-3 w-3" /> : null}{member.recentMovement === 0 ? "Same finish as previous event" : `${Math.abs(member.recentMovement)} place${Math.abs(member.recentMovement) === 1 ? "" : "s"} ${member.recentMovement > 0 ? "better" : "lower"} than previous event`}</span>}
                  </button>
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
              <div key={sailor.id} className="rounded-xl border border-white/[0.06] bg-black/20 p-3">
                <div className="flex items-center gap-3">
                <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-orange-500/10 text-[11px] font-black text-orange-300">
                  {sailor.name.split(/\s+/).slice(0, 2).map((part) => part[0]).join("")}
                </span>
                <span className="min-w-0 flex-1"><span className="block truncate text-xs font-bold text-white">{sailor.name}</span><span className="block truncate text-[10px] text-slate-500">{sailor.sailNumber} · {sailor.club}</span></span>
                </div>
                <div className="mt-2 grid grid-cols-2 gap-2">
                  <button type="button" onClick={() => addSailor(sailor.id)} disabled={busyId === sailor.id} className="rounded-lg bg-orange-600 px-2 py-1.5 text-[10px] font-bold text-white disabled:opacity-50"><Plus className="mr-1 inline h-3 w-3" />Squad</button>
                  <button type="button" onClick={() => followSailor(sailor.id)} disabled={busyId === sailor.id} className="rounded-lg border border-white/10 px-2 py-1.5 text-[10px] font-bold text-slate-300 disabled:opacity-50">Follow</button>
                </div>
              </div>
            ))}
            {query.trim().length >= 2 && matches.length === 0 && <p className="py-5 text-center text-[11px] text-slate-600">No new matches yet.</p>}
          </div>
        </aside>
      </section>

      <section className="rounded-2xl border border-sky-500/20 bg-sky-500/[0.025] p-4 sm:p-5" aria-labelledby="following-title">
        <div className="flex flex-col gap-1 sm:flex-row sm:items-end sm:justify-between"><div><p className="text-[10px] font-bold uppercase tracking-[0.16em] text-sky-400">Watchlist</p><h2 id="following-title" className="mt-1 text-lg font-black text-white">Following</h2><p className="mt-1 text-[11px] text-slate-500">Track sailors of personal interest or keep watching their progress after they move fleets.</p></div><span className="text-[11px] font-bold text-slate-500">{data.following.length} sailor{data.following.length === 1 ? "" : "s"}</span></div>
        {data.following.length ? <div className="mt-4 grid gap-2 md:grid-cols-2">{data.following.map((member) => <article key={member.id} className="flex items-center gap-3 rounded-xl border border-white/[0.07] bg-black/20 p-3"><button type="button" onClick={() => openSailor(member.sailorId)} aria-label={`Open ${member.name} details`} className="min-w-0 flex-1 text-left"><span className="block truncate text-xs font-bold text-white">{member.name}</span><span className="mt-0.5 block truncate text-[10px] text-slate-500">{member.fleet ? `${member.fleet} #${member.ranking}` : "Not on current ranking"} · {member.club}</span></button><button type="button" onClick={() => unfollowSailor(member.sailorId)} disabled={busyId === member.sailorId} aria-label={`Stop following ${member.name}`} className="rounded-lg p-2 text-slate-600 hover:bg-rose-500/10 hover:text-rose-400 disabled:opacity-50"><Trash2 className="h-4 w-4" /></button></article>)}</div> : <p className="mt-4 rounded-xl border border-dashed border-white/10 px-4 py-7 text-center text-xs text-slate-600">Use sailor search above and choose Follow.</p>}
      </section>

      {message && <p role="status" className="rounded-xl border border-white/10 bg-white/5 px-4 py-3 text-xs text-slate-300">{message}</p>}

      {activeSailor && <div className="fixed inset-0 z-50 flex justify-end bg-black/70" role="dialog" aria-modal="true" aria-label={`${activeSailor.name} coach details`} onMouseDown={(event) => { if (event.target === event.currentTarget) setActiveSailorId(null); }}>
        <div className="h-full w-full max-w-xl overflow-y-auto border-l border-white/10 bg-[#0b0c12] p-5 sm:p-7">
          <div className="flex items-start justify-between gap-4"><div><p className="text-[10px] font-bold uppercase tracking-[0.16em] text-orange-400">Coach view · private</p><h2 className="mt-1 text-2xl font-black text-white">{activeSailor.name}</h2><p className="mt-1 text-xs text-slate-500">{activeSailor.fleet || "Unranked"}{activeSailor.ranking ? ` #${activeSailor.ranking}` : ""} · {activeSailor.sailNumber} · {activeSailor.club}</p></div><button type="button" onClick={() => setActiveSailorId(null)} aria-label="Close sailor details" className="rounded-lg p-2 text-slate-400 hover:bg-white/5 hover:text-white"><X className="h-5 w-5" /></button></div>

          <section className="mt-6"><h3 className="text-xs font-bold uppercase tracking-wider text-slate-400">Best 3 of 5</h3><div className="mt-3 grid grid-cols-2 gap-2 sm:grid-cols-3">{activeSailor.scoringEvents.map((event) => <div key={event.regattaId} className={`rounded-xl border p-3 ${event.selected ? "border-orange-500/50 bg-orange-500/10" : "border-white/[0.07] bg-white/[0.02]"}`}><p className="truncate text-[10px] font-bold text-slate-400">{event.regattaName}</p><p className={`mt-1 text-xl font-black ${event.selected ? "text-orange-300" : "text-white"}`}>{event.score}{event.isDns ? "*" : event.isOverseas ? "†" : ""}</p>{event.selected && <p className="mt-1 text-[9px] font-bold uppercase text-orange-400">Counting</p>}</div>)}</div></section>

          <section className="mt-6 rounded-xl border border-white/[0.08] bg-white/[0.025] p-4"><h3 className="text-xs font-bold uppercase tracking-wider text-slate-400">Selection readiness</h3><p className="mt-2 text-sm font-bold text-white">{activeSailor.selectionReadiness.label}</p><p className="mt-1 text-xs leading-relaxed text-slate-400">{activeSailor.selectionReadiness.detail}</p></section>

          <section className="mt-6"><h3 className="text-xs font-bold uppercase tracking-wider text-slate-400">Recent regattas & race scores</h3><div className="mt-3 space-y-3">{activeSailor.recentResults.map((result) => <div key={result.resultId} className="rounded-xl border border-white/[0.08] p-4"><div className="flex justify-between gap-3"><div><Link href={`/regattas/${result.regattaSlug}`} className="text-sm font-bold text-white hover:text-orange-400">{result.regattaName}</Link><p className="mt-0.5 text-[10px] text-slate-500">{result.date}</p></div><p className="text-sm font-black text-white">#{result.rank}{result.nettScore != null ? <span className="ml-1 text-[10px] font-medium text-slate-500">· {result.nettScore} net</span> : null}</p></div>{result.races.length ? <div className="mt-3 flex flex-wrap gap-1.5">{result.races.map((race) => <span key={race.raceNumber} title={race.rawValue} className={`rounded-md border px-2 py-1 text-[10px] ${race.discarded ? "border-slate-700 text-slate-600 line-through" : "border-sky-500/20 bg-sky-500/5 text-sky-300"}`}>R{race.raceNumber}: {race.code || race.score}</span>)}</div> : <p className="mt-3 text-[10px] text-slate-600">No official race-by-race scores imported.</p>}</div>)}</div></section>

          <section className="mt-6"><label htmlFor="coach-note" className="text-xs font-bold uppercase tracking-wider text-slate-400">Private coach note</label><p className="mt-1 text-[10px] text-slate-600">Visible only in your coach account.</p><textarea id="coach-note" value={noteDraft} onChange={(event) => setNoteDraft(event.target.value)} maxLength={4000} rows={5} className="mt-3 w-full rounded-xl border border-white/10 bg-black/30 p-3 text-sm text-white outline-none focus:border-orange-500/50" placeholder="Focus areas, training observations, or follow-up…" /><div className="mt-2 flex items-center justify-between"><span className="text-[10px] text-slate-600">{noteDraft.length}/4000</span><button type="button" onClick={saveNote} disabled={busyId === "note"} className="rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-50">{busyId === "note" ? "Saving…" : "Save note"}</button></div></section>
        </div>
      </div>}
    </div>
  );
}
