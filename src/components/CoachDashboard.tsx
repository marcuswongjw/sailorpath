"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { ArrowRight, ChevronRight, GitCompareArrows, Plus, Search, Settings2, Trash2, TrendingDown, TrendingUp, Users, X } from "lucide-react";
import type { CoachSquadDashboard } from "@/lib/coachDashboard";
import { SquadPulseCards, AthleteDevelopmentDrawer } from "@/components/coach";
import { fleetPillClass } from "@/components/sailor-profile/helpers";

type SearchMatch = { id: string; name: string; handle: string; sailNumber: string; club: string };

const DEMO_SEARCH_SAILORS: SearchMatch[] = [
  { id: "demo-s1", name: "Lucas Wong", handle: "lucas-w", sailNumber: "SGP 4658", club: "SAF Yacht Club" },
  { id: "demo-s2", name: "Chloe Tan", handle: "chloe-t", sailNumber: "SGP 4612", club: "Singapore Sailing Club" },
  { id: "demo-s3", name: "Ethan Lee", handle: "ethan-l", sailNumber: "SGP 4589", club: "Changi Sailing Club" },
  { id: "demo-s4", name: "Sarah Chen", handle: "sarah-c", sailNumber: "SGP 4701", club: "National Sailing Centre" },
  { id: "demo-s5", name: "Marcus Koh", handle: "marcus-k", sailNumber: "SGP 2184", club: "Changi Sailing Club" },
];

async function readJson<T>(response: Response): Promise<T> {
  const body = await response.json();
  if (!response.ok) throw new Error(body.error || "Something went wrong");
  return body as T;
}

export function CoachDashboard({
  initialData,
  demoMode = false,
}: {
  initialData: CoachSquadDashboard;
  demoMode?: boolean;
}) {
  const [data, setData] = useState(initialData);
  const [query, setQuery] = useState("");
  const [matches, setMatches] = useState<SearchMatch[]>([]);
  const [selected, setSelected] = useState<string[]>([]);
  const [busyId, setBusyId] = useState<string | null>(null);
  const [message, setMessage] = useState<string | null>(null);
  const [squadName, setSquadName] = useState(initialData.squad?.name || "My squad");
  const [activeSailorId, setActiveSailorId] = useState<string | null>(null);
  const [manageOpen, setManageOpen] = useState(false);
  const [sortKey, setSortKey] = useState<"ranking" | "name" | "movement" | "best3">("ranking");

  useEffect(() => {
    const trimmed = query.trim();
    if (trimmed.length < 2) {
      const timer = window.setTimeout(() => setMatches([]), 0);
      return () => window.clearTimeout(timer);
    }
    if (demoMode) {
      const timer = window.setTimeout(() => {
        const term = trimmed.toLowerCase();
        const memberIds = new Set([...data.members, ...data.following].map((m) => m.sailorId));
        setMatches(
          DEMO_SEARCH_SAILORS.filter(
            (s) =>
              !memberIds.has(s.id) &&
              (s.name.toLowerCase().includes(term) ||
                s.sailNumber.toLowerCase().includes(term) ||
                s.club.toLowerCase().includes(term))
          )
        );
      }, 100);
      return () => window.clearTimeout(timer);
    }
    const controller = new AbortController();
    const timer = window.setTimeout(async () => {
      try {
        const response = await fetch(`/api/coach/sailors?q=${encodeURIComponent(trimmed)}`, { signal: controller.signal });
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
  }, [query, data.members, data.following, demoMode]);

  useEffect(() => {
    if (!manageOpen) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setManageOpen(false);
    };
    document.addEventListener("keydown", onKey);
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prevOverflow;
    };
  }, [manageOpen]);

  const averageBest = useMemo(() => {
    const scores = data.members.map((member) => member.bestThreeOfFive).filter((score): score is number => score != null);
    return scores.length ? (scores.reduce((sum, score) => sum + score, 0) / scores.length).toFixed(1) : "—";
  }, [data.members]);
  const selectedMembers = selected.map((id) => data.members.find((member) => member.sailorId === id));
  const activeSailor = [...data.members, ...data.following].find((member) => member.sailorId === activeSailorId) || null;
  const actions = useMemo(() => data.members.flatMap((member) => {
    const items: Array<{ key: string; sailorId: string; sailor: string; text: string; priority: number }> = [];
    const periodKey = `${data.period.year}-${data.period.half}`;
    if (member.scoringEvents.filter((event) => event.selected && !event.isDns).length < 3) items.push({ key: `${member.sailorId}:incomplete:${periodKey}`, sailorId: member.sailorId, sailor: member.name, text: "Fewer than 3 completed counting events", priority: 2 });
    if (member.recentMovement != null && member.recentMovement < 0) items.push({ key: `${member.sailorId}:rank-drop:${data.updatedThrough}`, sailorId: member.sailorId, sailor: member.name, text: `Series rank moved down ${Math.abs(member.recentMovement)} place${Math.abs(member.recentMovement) === 1 ? "" : "s"} after the latest event`, priority: 3 });
    return items;
  }).filter((action) => !data.actionReviews.some((review) => review.actionKey === action.key)).sort((a, b) => a.priority - b.priority).slice(0, 6), [data.members, data.actionReviews, data.period, data.updatedThrough]);
  const compareFleet = selectedMembers.length === 2 && selectedMembers[0]?.fleet === selectedMembers[1]?.fleet
    ? selectedMembers[0]?.fleet
    : null;
  const sortedMembers = useMemo(() => [...data.members].sort((a, b) => {
    if (sortKey === "name") return a.name.localeCompare(b.name);
    if (sortKey === "movement") return (b.recentMovement ?? -999) - (a.recentMovement ?? -999) || a.name.localeCompare(b.name);
    if (sortKey === "best3") return (a.bestThreeOfFive ?? 9999) - (b.bestThreeOfFive ?? 9999) || a.name.localeCompare(b.name);
    return (a.ranking ?? 9999) - (b.ranking ?? 9999) || a.name.localeCompare(b.name);
  }), [data.members, sortKey]);
  const compareHref = selected.length === 2 && compareFleet
    ? `/sg/optimist/compare?fleet=${compareFleet}&year=${data.period.year}&half=${encodeURIComponent(data.period.half)}&a=${selected[0]}&b=${selected[1]}`
    : null;

  async function mutate(method: "POST" | "PATCH" | "DELETE", payload: { sailorId?: string; sailorIds?: string[]; name?: string }) {
    if (demoMode) {
      if (payload.name) {
        setData((prev) => ({
          ...prev,
          squad: { id: prev.squad?.id || "demo-squad", name: payload.name! },
        }));
        setSquadName(payload.name);
      }
      return;
    }
    let queryString = "";
    if (method === "DELETE") {
      if (payload.sailorIds && payload.sailorIds.length > 0) {
        queryString = `?sailorIds=${encodeURIComponent(payload.sailorIds.join(","))}`;
      } else if (payload.sailorId) {
        queryString = `?sailorId=${encodeURIComponent(payload.sailorId)}`;
      }
    }
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
      if (demoMode) {
        const s = DEMO_SEARCH_SAILORS.find((x) => x.id === sailorId) || {
          id: sailorId,
          name: "Lucas Wong",
          handle: "lucas-w",
          sailNumber: "SGP 4658",
          club: "SAF Yacht Club",
        };
        setData((prev) => ({
          ...prev,
          members: [
            {
              id: `m-${Date.now()}`,
              sailorId: s.id,
              name: s.name,
              handle: s.handle,
              sailNumber: s.sailNumber,
              club: s.club,
              avatarUrl: null,
              fleet: "Gold",
              ranking: prev.members.length + 1,
              bestThreeOfFive: 6.0,
              squadStatus: "National Squad",
              recentMovement: 1,
              scoringEvents: [
                { regattaId: "demo-r1", regattaName: "Singapore Nationals 2026", date: "2026-06-20", score: 2, selected: true, isDns: false, isOverseas: false },
                { regattaId: "demo-r2", regattaName: "CSC Youth Championship 2026", date: "2026-03-15", score: 4, selected: true, isDns: false, isOverseas: false },
              ],
              recentResults: [],
              coachNote: "Consistently sharp on start acceleration. Working on downwind speed in chop.",
              coachNoteVisibility: "coach_only",
              developmentRecords: [
                { id: `rec-${Date.now()}`, type: "observation", category: "Technical", title: "Clean roll-tacks", detail: "Fast exit angles in 12-14kt breeze", recordDate: new Date().toISOString().slice(0, 10), status: "active", targetDate: null, visibility: "shared", sentiment: "strength" }
              ],
              selectionReadiness: { tone: "ready", label: "On track", detail: "Ranked inside qualifying quota" },
              latestResult: { regattaName: "Singapore Nationals 2026", regattaSlug: "sn-2026", date: "2026-06-20", rank: 2, fleetSize: 48 },
            },
            ...prev.members,
          ],
        }));
        setQuery(""); setMatches([]); setMessage(`${s.name} added to squad (demo).`);
        return;
      }
      await mutate("POST", { sailorId });
      setQuery(""); setMatches([]); setMessage("Sailor added to your squad.");
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not add sailor"); }
    finally { setBusyId(null); }
  }

  async function removeSailor(sailorId: string) {
    setBusyId(sailorId); setMessage(null);
    try {
      if (demoMode) {
        setData((prev) => ({
          ...prev,
          members: prev.members.filter((m) => m.sailorId !== sailorId),
        }));
        setSelected((current) => current.filter((id) => id !== sailorId));
        setMessage("Sailor removed from squad (demo).");
        return;
      }
      await mutate("DELETE", { sailorId });
      setSelected((current) => current.filter((id) => id !== sailorId));
      setMessage("Sailor removed from your squad.");
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not remove sailor"); }
    finally { setBusyId(null); }
  }

  async function removeMultipleSailors(sailorIds: string[]) {
    if (sailorIds.length === 0) return;
    setBusyId("bulk-delete"); setMessage(null);
    try {
      if (demoMode) {
        setData((prev) => ({
          ...prev,
          members: prev.members.filter((m) => !sailorIds.includes(m.sailorId)),
        }));
        setSelected([]);
        setMessage(`${sailorIds.length} sailor${sailorIds.length === 1 ? "" : "s"} removed from squad (demo).`);
        return;
      }
      await mutate("DELETE", { sailorIds });
      setSelected([]);
      setMessage(`${sailorIds.length} sailor${sailorIds.length === 1 ? "" : "s"} removed from your squad.`);
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not remove sailors"); }
    finally { setBusyId(null); }
  }

  async function mutateFollowing(method: "POST" | "DELETE", sailorId: string) {
    if (demoMode) {
      if (method === "POST") {
        const s = DEMO_SEARCH_SAILORS.find((x) => x.id === sailorId) || {
          id: sailorId,
          name: "Ethan Lee",
          handle: "ethan-l",
          sailNumber: "SGP 4589",
          club: "Changi Sailing Club",
        };
        setData((prev) => ({
          ...prev,
          following: [
            {
              id: `f-${Date.now()}`,
              sailorId: s.id,
              name: s.name,
              handle: s.handle,
              sailNumber: s.sailNumber,
              club: s.club,
              avatarUrl: null,
              fleet: "Gold",
              ranking: 12,
              bestThreeOfFive: 18.0,
              squadStatus: null,
              recentMovement: 0,
              scoringEvents: [],
              recentResults: [],
              coachNote: "",
              coachNoteVisibility: "coach_only",
              developmentRecords: [],
              selectionReadiness: { tone: "watch", label: "Watchlist", detail: "Monitoring progress" },
              latestResult: null,
            },
            ...prev.following,
          ],
        }));
      } else {
        setData((prev) => ({
          ...prev,
          following: prev.following.filter((m) => m.sailorId !== sailorId),
        }));
      }
      return;
    }
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
    setSelected((current) =>
      current.includes(sailorId) ? current.filter((id) => id !== sailorId) : [...current, sailorId]
    );
  }

  function toggleSelectAll() {
    setSelected((current) => {
      if (data.members.length > 0 && current.length === data.members.length) {
        return [];
      }
      return data.members.map((m) => m.sailorId);
    });
  }

  function openSailor(sailorId: string) {
    setActiveSailorId(sailorId);
  }

  async function handleSaveNote(note: string, visibility: "coach_only" | "shared") {
    if (!activeSailor) return;
    setBusyId("note"); setMessage(null);
    try {
      if (demoMode) {
        setData((current) => ({
          ...current,
          members: current.members.map((member) =>
            member.sailorId === activeSailor.sailorId
              ? { ...member, coachNote: note, coachNoteVisibility: visibility }
              : member
          ),
          following: current.following.map((member) =>
            member.sailorId === activeSailor.sailorId
              ? { ...member, coachNote: note, coachNoteVisibility: visibility }
              : member
          ),
        }));
        setMessage("Private coach note saved (demo).");
        return;
      }
      const response = await fetch("/api/coach/notes", {
        method: "PUT",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ sailorId: activeSailor.sailorId, note, visibility }),
      });
      const body = await readJson<{ note: string; visibility: "coach_only" | "shared" }>(response);
      setData((current) => ({
        ...current,
        members: current.members.map((member) =>
          member.sailorId === activeSailor.sailorId
            ? { ...member, coachNote: body.note, coachNoteVisibility: body.visibility }
            : member
        ),
        following: current.following.map((member) =>
          member.sailorId === activeSailor.sailorId
            ? { ...member, coachNote: body.note, coachNoteVisibility: body.visibility }
            : member
        ),
      }));
      setMessage("Private coach note saved.");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not save note");
    } finally {
      setBusyId(null);
    }
  }

  async function handleAddRecord(payload: {
    type: "observation" | "goal" | "attendance";
    category: string | null;
    title: string;
    detail: string | null;
    recordDate: string;
    targetDate: string | null;
    status: string;
    visibility: "coach_only" | "shared";
    sentiment: "strength" | "focus" | "neutral";
  }) {
    if (!activeSailor || !payload.title.trim()) return;
    setBusyId("development"); setMessage(null);
    try {
      if (demoMode) {
        const newRecord = {
          id: `dev-${Date.now()}`,
          ...payload,
        };
        setData((current) => ({
          ...current,
          members: current.members.map((member) =>
            member.sailorId === activeSailor.sailorId
              ? { ...member, developmentRecords: [newRecord, ...member.developmentRecords] }
              : member
          ),
          following: current.following.map((member) =>
            member.sailorId === activeSailor.sailorId
              ? { ...member, developmentRecords: [newRecord, ...member.developmentRecords] }
              : member
          ),
        }));
        setMessage(
          `${payload.type === "goal" ? "Goal" : payload.type === "attendance" ? "Attendance" : "Observation"} saved (demo).`
        );
        return;
      }
      const response = await fetch("/api/coach/development", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ sailorId: activeSailor.sailorId, ...payload }),
      });
      setData(await readJson<CoachSquadDashboard>(response));
      setMessage(
        `${payload.type === "goal" ? "Goal" : payload.type === "attendance" ? "Attendance" : "Observation"} saved.`
      );
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not save coaching record");
    } finally {
      setBusyId(null);
    }
  }

  async function handleUpdateRecordStatus(id: string, status: string) {
    setBusyId(id); setMessage(null);
    try {
      if (demoMode) {
        setData((current) => ({
          ...current,
          members: current.members.map((member) => ({
            ...member,
            developmentRecords: member.developmentRecords.map((r) =>
              r.id === id ? { ...r, status } : r
            ),
          })),
          following: current.following.map((member) => ({
            ...member,
            developmentRecords: member.developmentRecords.map((r) =>
              r.id === id ? { ...r, status } : r
            ),
          })),
        }));
        setMessage("Coaching record updated (demo).");
        return;
      }
      const response = await fetch("/api/coach/development", {
        method: "PATCH",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ id, status }),
      });
      setData(await readJson<CoachSquadDashboard>(response));
      setMessage("Coaching record updated.");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not update record");
    } finally {
      setBusyId(null);
    }
  }

  async function handleDeleteRecord(id: string) {
    setBusyId(id); setMessage(null);
    try {
      if (demoMode) {
        setData((current) => ({
          ...current,
          members: current.members.map((member) => ({
            ...member,
            developmentRecords: member.developmentRecords.filter((r) => r.id !== id),
          })),
          following: current.following.map((member) => ({
            ...member,
            developmentRecords: member.developmentRecords.filter((r) => r.id !== id),
          })),
        }));
        setMessage("Coaching record removed (demo).");
        return;
      }
      const response = await fetch(`/api/coach/development?id=${encodeURIComponent(id)}`, {
        method: "DELETE",
      });
      setData(await readJson<CoachSquadDashboard>(response));
      setMessage("Coaching record removed.");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not delete record");
    } finally {
      setBusyId(null);
    }
  }

  async function reviewAction(action: (typeof actions)[number], status: "reviewed" | "dismissed") {
    setBusyId(action.key); setMessage(null);
    try {
      if (demoMode) {
        setData((current) => ({
          ...current,
          actionReviews: [...current.actionReviews, { actionKey: action.key, status }],
        }));
        setMessage(status === "reviewed" ? "Action marked reviewed (demo)." : "Action dismissed (demo).");
        return;
      }
      const response = await fetch("/api/coach/action-reviews", { method: "PUT", headers: { "content-type": "application/json" }, body: JSON.stringify({ sailorId: action.sailorId, actionKey: action.key, status }) });
      setData(await readJson<CoachSquadDashboard>(response));
      setMessage(status === "reviewed" ? "Action marked reviewed." : "Action dismissed for this ranking update.");
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not update action"); }
    finally { setBusyId(null); }
  }

  return (
    <div className="mx-auto flex max-w-6xl flex-col gap-6 px-4 py-8 sm:py-12">
      <header className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="text-[11px] font-bold uppercase tracking-[0.18em] text-[var(--sp-racing-orange)]">Coach workspace</p>
          <h1 className="mt-1 text-3xl font-black tracking-tight text-[var(--sp-harbour-shadow)] sm:text-4xl">Squad dashboard</h1>
          <p className="mt-2 text-sm text-[var(--sp-charcoal-slate)]">Live rankings, development priorities, and follow-up for your sailors.</p>
          <p className="mt-1 text-[10px] font-semibold text-[var(--sp-slate-soft)]">Ranking results through {data.updatedThrough || "no published event yet"}</p>
        </div>
        <div className="flex gap-2">
          <button type="button" onClick={() => setManageOpen(true)} className="sp-btn-primary">
            <Settings2 className="h-3.5 w-3.5" /> Manage sailors
          </button>
          <Link href="/rankings" className="inline-flex items-center justify-center gap-2 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-2.5 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors">
            Rankings <ArrowRight className="h-3.5 w-3.5" />
          </Link>
        </div>
      </header>

      <div className="order-2">
        <SquadPulseCards
          members={data.members}
          actionsCount={actions.length}
          rankingPeriod={`${data.period.half} ${data.period.year}`}
          averageBest={averageBest}
        />
      </div>

      <section className="order-1 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 shadow-xs" aria-labelledby="action-centre-title">
        <div className="flex items-center justify-between gap-4">
          <div><p className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-racing-orange)]">Today</p><h2 id="action-centre-title" className="mt-1 text-base font-black text-[var(--sp-harbour-shadow)]">Squad action centre</h2></div>
          <span className="rounded-full bg-[var(--sp-racing-mist)]/50 px-2.5 py-1 text-[10px] font-bold text-[var(--sp-racing-deep)]">{actions.length} to review</span>
        </div>
        {actions.length ? (
          <div className="mt-3 grid gap-2 md:grid-cols-2">
            {actions.map((action) => (
              <div key={action.key} className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3">
                <button type="button" onClick={() => openSailor(action.sailorId)} className="flex w-full items-center gap-3 text-left">
                  <span className="min-w-0 flex-1">
                    <span className="block truncate text-xs font-bold text-[var(--sp-harbour-shadow)]">{action.sailor}</span>
                    <span className="block text-[11px] text-[var(--sp-charcoal-slate)]">{action.text}</span>
                  </span>
                  <ChevronRight className="h-4 w-4 text-[var(--sp-slate-soft)]" />
                </button>
                <div className="mt-2 flex gap-2">
                  <button type="button" onClick={() => reviewAction(action, "reviewed")} disabled={busyId === action.key} className="rounded-md bg-[var(--sp-racing-mist)]/50 px-2 py-1 text-[9px] font-bold text-[var(--sp-racing-deep)] disabled:opacity-50">
                    Mark reviewed
                  </button>
                  <button type="button" onClick={() => reviewAction(action, "dismissed")} disabled={busyId === action.key} className="rounded-md px-2 py-1 text-[9px] font-bold text-[var(--sp-slate-soft)] hover:bg-[var(--sp-warm-white)]">
                    Dismiss
                  </button>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <p className="mt-3 text-xs text-[var(--sp-slate-soft)]">No ranking or attendance flags need attention.</p>
        )}
      </section>

      <section className="order-3">
        <div className="overflow-hidden rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
          <div className="flex flex-col gap-3 border-b border-[var(--sp-cool-veil)] p-4 sm:flex-row sm:items-center sm:justify-between">
            <div className="flex items-center gap-2 min-w-0">
              <input
                value={squadName}
                onChange={(event) => setSquadName(event.target.value)}
                onBlur={renameSquad}
                onKeyDown={(event) => {
                  if (event.key === "Enter") event.currentTarget.blur();
                }}
                aria-label="Squad name"
                maxLength={80}
                className="min-w-0 rounded-lg border border-transparent bg-transparent px-2 py-1 text-lg font-black text-[var(--sp-harbour-shadow)] outline-none hover:border-[var(--sp-cool-veil)] focus:border-[var(--sp-harbour-teal)]"
              />
              <span className="text-[10px] text-[var(--sp-slate-soft)] shrink-0">
                {busyId === "rename" ? "Saving…" : "Edit name"}
              </span>
            </div>

            <div className="flex flex-wrap items-center gap-3">
              <div className="flex items-center gap-2">
                <label
                  htmlFor="squad-sort"
                  className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]"
                >
                  Sort
                </label>
                <select
                  id="squad-sort"
                  value={sortKey}
                  onChange={(event) => setSortKey(event.target.value as typeof sortKey)}
                  className="sp-select text-[11px] font-bold"
                >
                  <option value="ranking">Fleet rank</option>
                  <option value="name">Name</option>
                  <option value="movement">Movement</option>
                  <option value="best3">Best 3</option>
                </select>
              </div>

              <div className="flex items-center gap-2">
                <span className="text-[11px] text-[var(--sp-slate-soft)] hidden sm:inline">
                  Select two sailors
                </span>
                {compareHref ? (
                  <Link href={compareHref} className="sp-btn-primary px-3 py-1.5 text-[11px]">
                    <GitCompareArrows className="h-3.5 w-3.5" /> Compare
                  </Link>
                ) : (
                  <span className="inline-flex items-center gap-1.5 rounded-full bg-[var(--sp-sailcloth)] px-3 py-1.5 text-[11px] font-bold text-[var(--sp-slate-soft)]">
                    <GitCompareArrows className="h-3.5 w-3.5" /> Compare
                  </span>
                )}
              </div>
            </div>
          </div>

          {data.members.length > 0 && (
            <div className="flex flex-wrap items-center justify-between gap-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/60 px-4 py-2 text-xs">
              <div className="flex items-center gap-3">
                <label className="flex items-center gap-2 cursor-pointer select-none">
                  <input
                    type="checkbox"
                    checked={data.members.length > 0 && selected.length === data.members.length}
                    onChange={toggleSelectAll}
                    aria-label="Select all sailors"
                    className="h-4 w-4 rounded border-[var(--sp-cool-veil)] text-[var(--sp-racing-orange)] accent-[var(--sp-racing-orange)]"
                  />
                  <span className="text-[11px] font-bold text-[var(--sp-charcoal-slate)]">
                    {selected.length > 0 ? `${selected.length} of ${data.members.length} selected` : "Select all"}
                  </span>
                </label>
                {selected.length > 0 && (
                  <button
                    type="button"
                    onClick={() => setSelected([])}
                    className="text-[10px] font-semibold text-[var(--sp-slate-soft)] underline hover:text-[var(--sp-harbour-shadow)]"
                  >
                    Clear selection
                  </button>
                )}
              </div>

              {selected.length > 0 && (
                <div className="flex items-center gap-2">
                  <button
                    type="button"
                    onClick={() => removeMultipleSailors(selected)}
                    disabled={busyId === "bulk-delete"}
                    className="inline-flex items-center gap-1.5 rounded-lg border border-rose-200 bg-rose-50 px-2.5 py-1 text-[11px] font-bold text-rose-700 hover:bg-rose-100 disabled:opacity-50 transition-colors"
                  >
                    <Trash2 className="h-3.5 w-3.5" />
                    {busyId === "bulk-delete" ? "Removing…" : `Delete selected (${selected.length})`}
                  </button>
                </div>
              )}
            </div>
          )}

          {data.members.length === 0 ? (
            <div className="px-6 py-16 text-center">
              <Users className="mx-auto h-9 w-9 text-[var(--sp-slate-soft)]" />
              <h2 className="mt-4 text-base font-bold text-[var(--sp-harbour-shadow)]">Build your squad roster</h2>
              <p className="mx-auto mt-1 max-w-sm text-xs leading-relaxed text-[var(--sp-slate-soft)]">
                Add sailors to your squad to track live rankings, regatta results, and developmental priorities.
              </p>
              <button
                type="button"
                onClick={() => setManageOpen(true)}
                className="sp-btn-primary mt-4 inline-flex items-center gap-1.5 px-4 py-2 text-xs"
              >
                <Plus className="h-3.5 w-3.5" /> Add sailors to squad
              </button>
            </div>
          ) : (
            <div className="divide-y divide-[var(--sp-cool-veil)]">
              {sortedMembers.map((member) => (
                <article key={member.id} className="grid gap-3 p-4 sm:grid-cols-[auto_minmax(0,1fr)_auto] sm:items-center">
                  <input type="checkbox" checked={selected.includes(member.sailorId)} onChange={() => toggleCompare(member.sailorId)}
                    aria-label={`Select ${member.name} for comparison`} className="h-4 w-4 accent-[var(--sp-racing-orange)]" />
                  <div className="min-w-0 text-left">
                    <div className="flex flex-wrap items-center gap-2">
                      <Link href={`/${member.handle}`} className="truncate text-sm font-bold text-[var(--sp-harbour-shadow)] hover:text-[var(--sp-racing-orange)]">
                        {member.name}
                      </Link>
                      {member.fleet && <span className={`rounded-full border px-2 py-0.5 text-[10px] font-bold ${fleetPillClass(member.fleet)}`}>{member.fleet} #{member.ranking}</span>}
                      {member.squadStatus && <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-charcoal-slate)]">{member.squadStatus}</span>}
                    </div>
                    <button type="button" onClick={() => openSailor(member.sailorId)} className="mt-1 block w-full text-left" aria-label={`Open ${member.name} details`}>
                      <p className="text-[11px] text-[var(--sp-slate-soft)]">{member.sailNumber} · {member.club}{member.bestThreeOfFive != null ? ` · Best 3: ${member.bestThreeOfFive}` : ""}</p>
                      {member.latestResult && <p className="mt-1 text-[11px] text-[var(--sp-charcoal-slate)]">Latest: {member.latestResult.regattaName} · #{member.latestResult.rank} of {member.latestResult.fleetSize}</p>}
                      {member.recentMovement != null && <span className={`mt-1 inline-flex items-center gap-1 text-[10px] font-bold ${member.recentMovement > 0 ? "text-emerald-600" : member.recentMovement < 0 ? "text-rose-600" : "text-[var(--sp-slate-soft)]"}`}>{member.recentMovement > 0 ? <TrendingUp className="h-3 w-3" /> : member.recentMovement < 0 ? <TrendingDown className="h-3 w-3" /> : null}{member.recentMovement === 0 ? "Series rank unchanged" : `Series rank ${member.recentMovement > 0 ? "up" : "down"} ${Math.abs(member.recentMovement)}`}</span>}
                    </button>
                  </div>
                  <button type="button" onClick={() => removeSailor(member.sailorId)} disabled={busyId === member.sailorId}
                    aria-label={`Remove ${member.name} from squad`} className="justify-self-end rounded-lg p-2 text-[var(--sp-slate-soft)] hover:bg-rose-50 hover:text-rose-600 disabled:opacity-50">
                    <Trash2 className="h-4 w-4" />
                  </button>
                </article>
              ))}
            </div>
          )}
        </div>

        {manageOpen && (
          <aside role="dialog" aria-modal="true" aria-label="Manage sailors" className="fixed inset-0 z-40 flex items-start justify-center overflow-y-auto bg-black/60 backdrop-blur-xs p-4 sm:pt-20" onMouseDown={(event) => { if (event.target === event.currentTarget) setManageOpen(false); }}>
            <div className="w-full max-w-lg rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-2xl">
              <div className="flex items-start justify-between">
                <div>
                  <h2 className="text-sm font-bold text-[var(--sp-harbour-shadow)]">Add a sailor</h2>
                  <p className="mt-1 text-[11px] leading-relaxed text-[var(--sp-slate-soft)]">Search by name, sail number, club, school, or profile handle.</p>
                </div>
                <button type="button" onClick={() => setManageOpen(false)} aria-label="Close manage sailors" className="rounded-lg p-2 text-[var(--sp-slate-soft)] hover:bg-[var(--sp-sailcloth)] hover:text-[var(--sp-harbour-shadow)]"><X className="h-4 w-4" /></button>
              </div>

              {message && (
                <div
                  aria-live="polite"
                  className="mt-3 flex items-center justify-between rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-3 py-2 text-xs font-semibold text-[var(--sp-charcoal-slate)]"
                >
                  <span>{message}</span>
                  <button
                    type="button"
                    onClick={() => setMessage(null)}
                    className="text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
                    aria-label="Dismiss notification"
                  >
                    <X className="h-3.5 w-3.5" />
                  </button>
                </div>
              )}

              <div className="relative mt-4">
                <Search className="absolute left-3 top-3 h-4 w-4 text-[var(--sp-slate-soft)]" />
                <input value={query} onChange={(event) => {
                  const value = event.target.value;
                  setQuery(value);
                  if (value.trim().length < 2) setMatches([]);
                }} placeholder="Type at least 2 characters"
                  aria-label="Search sailors to add" className="sp-input w-full py-2.5 pl-9 pr-3 text-sm" />
              </div>
              <div className="mt-3 space-y-1.5" aria-live="polite">
                {matches.map((sailor) => (
                  <div key={sailor.id} className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3">
                    <div className="flex items-center gap-3">
                      <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-[var(--sp-racing-orange)]/10 text-[11px] font-black text-[var(--sp-racing-orange)]">
                        {sailor.name.split(/\s+/).slice(0, 2).map((part) => part[0]).join("")}
                      </span>
                      <span className="min-w-0 flex-1"><span className="block truncate text-xs font-bold text-[var(--sp-harbour-shadow)]">{sailor.name}</span><span className="block truncate text-[10px] text-[var(--sp-slate-soft)]">{sailor.sailNumber} · {sailor.club}</span></span>
                    </div>
                    <div className="mt-2 grid grid-cols-2 gap-2">
                      <button type="button" onClick={() => addSailor(sailor.id)} disabled={busyId === sailor.id} className="sp-btn-primary rounded-lg px-2 py-1.5 text-[10px] disabled:opacity-50"><Plus className="mr-1 inline h-3 w-3" />Squad</button>
                      <button type="button" onClick={() => followSailor(sailor.id)} disabled={busyId === sailor.id} className="rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-2 py-1.5 text-[10px] font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] disabled:opacity-50">Follow</button>
                    </div>
                  </div>
                ))}
                {query.trim().length >= 2 && matches.length === 0 && <p className="py-5 text-center text-[11px] text-[var(--sp-slate-soft)]">No new matches yet.</p>}
              </div>
            </div>
          </aside>
        )}
      </section>

      <section className="order-4 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-5 shadow-xs" aria-labelledby="following-title">
        <div className="flex flex-col gap-1 sm:flex-row sm:items-end sm:justify-between"><div><p className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)]">Watchlist</p><h2 id="following-title" className="mt-1 text-lg font-black text-[var(--sp-harbour-shadow)]">Following</h2><p className="mt-1 text-[11px] text-[var(--sp-slate-soft)]">Track sailors of personal interest or keep watching their progress after they move fleets.</p></div><span className="text-[11px] font-bold text-[var(--sp-slate-soft)]">{data.following.length} sailor{data.following.length === 1 ? "" : "s"}</span></div>
        {data.following.length ? (
          <div className="mt-4 grid gap-2 md:grid-cols-2">
            {data.following.map((member) => (
              <article key={member.id} className="flex items-center gap-3 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3">
                <button type="button" onClick={() => openSailor(member.sailorId)} aria-label={`Open ${member.name} details`} className="min-w-0 flex-1 text-left">
                  <span className="block truncate text-xs font-bold text-[var(--sp-harbour-shadow)]">{member.name}</span>
                  <span className="mt-0.5 block truncate text-[10px] text-[var(--sp-slate-soft)]">{member.fleet ? `${member.fleet} #${member.ranking}` : "Not on current ranking"} · {member.club}</span>
                </button>
                <button type="button" onClick={() => unfollowSailor(member.sailorId)} disabled={busyId === member.sailorId} aria-label={`Stop following ${member.name}`} className="rounded-lg p-2 text-[var(--sp-slate-soft)] hover:bg-rose-50 hover:text-rose-600 disabled:opacity-50">
                  <Trash2 className="h-4 w-4" />
                </button>
              </article>
            ))}
          </div>
        ) : (
          <div className="mt-4 rounded-xl border border-dashed border-[var(--sp-cool-veil)] px-4 py-7 text-center text-xs text-[var(--sp-slate-soft)]">
            <p>You are not following any sailors outside your squad.</p>
            <button
              type="button"
              onClick={() => setManageOpen(true)}
              className="mt-2 text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline"
            >
              Search sailors to follow &rarr;
            </button>
          </div>
        )}
      </section>

      {message && (
        <div
          role="status"
          className="flex items-center justify-between rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 text-xs text-[var(--sp-charcoal-slate)]"
        >
          <span>{message}</span>
          <button
            type="button"
            onClick={() => setMessage(null)}
            className="text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
            aria-label="Dismiss message"
          >
            <X className="h-3.5 w-3.5" />
          </button>
        </div>
      )}

      {activeSailor && (
        <AthleteDevelopmentDrawer
          key={activeSailor.sailorId}
          sailor={activeSailor}
          onClose={() => setActiveSailorId(null)}
          onSaveNote={handleSaveNote}
          onAddRecord={handleAddRecord}
          onUpdateRecordStatus={handleUpdateRecordStatus}
          onDeleteRecord={handleDeleteRecord}
          busyId={busyId}
        />
      )}
    </div>
  );
}
