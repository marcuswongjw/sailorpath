"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import dynamic from "next/dynamic";
import type { ResultsScan, ResultsSource, ExtractedResultTable } from "@/lib/resultsWorkflow/types";

type Sheet = { id: string; name: string; date: string; boatClass: string; division: string; geography: string; countsForRanking: boolean };
type Event = { id: string; slug: string; name: string; startDate: string; endDate: string | null; eventUrl: string; enabled: boolean; checkedAt: string | null; report: ResultsScan | null; lastStatus?: string | null; sheets: Sheet[] };
const button = "min-h-11 rounded border border-slate-300 px-3 py-2 text-sm font-semibold disabled:opacity-40";
const AdminRegattaImport = dynamic(() => import("./AdminRegattaImport").then((m) => m.AdminRegattaImport));
type Run = { id: string; trigger: string; status: string; startedAt: string; finishedAt: string | null; checkedCount: number; failedCount: number };
type Health = { enabled: boolean; schedulerConfigured: boolean; schedule: string; batchLimit: number; lookbackDays: number; recentRuns: Run[]; lastSuccess: Run | null; lastFailure: Run | null };
const runTime = (run: Run | null) => run ? new Date(run.finishedAt || run.startedAt).toLocaleString("en-SG", { timeZone: "Asia/Singapore" }) : "None recorded";
async function readInventory(signal?: AbortSignal): Promise<{ events: Event[]; health?: Health }> {
  const res = await fetch("/api/admin/result-imports", { cache: "no-store", signal });
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Could not load regattas.");
  return data;
}

export function ResultsImportInbox() {
  const [health, setHealth] = useState<Health | null>(null);
  const [events, setEvents] = useState<Event[]>([]);
  const [selected, setSelected] = useState("");
  const [url, setUrl] = useState("");
  const [enabled, setEnabled] = useState(true);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState("");
  const [preview, setPreview] = useState<ResultsScan | null>(null);
  const [reviewed, setReviewed] = useState(false);
  const [reviewNotes, setReviewNotes] = useState("");
  const [candidate, setCandidate] = useState<{ source: ResultsSource; table: ExtractedResultTable; tableIndex: number; sheet: Sheet } | null>(null);
  const [sheetId, setSheetId] = useState("");
  const event = events.find((e) => e.id === selected);
  const report = preview || event?.report;

  async function load() {
    const data = await readInventory();
    setEvents(data.events); setHealth(data.health ?? null);
  }
  useEffect(() => {
    const controller = new AbortController();
    readInventory(controller.signal).then((data) => { setEvents(data.events); setHealth(data.health ?? null); }).catch((e) => { if (!controller.signal.aborted) setMessage(e.message); });
    return () => controller.abort();
  }, []);

  async function action(kind: "configure" | "scan", dryRun = false) {
    setBusy(true); setMessage(""); setCandidate(null); setReviewed(false);
    try {
      const res = await fetch("/api/admin/result-imports", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: kind, eventId: selected, eventUrl: url, enabled, dryRun }) });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Request failed.");
      if (kind === "scan") setPreview(data.outcomes[0]?.report || null);
      else setPreview(null);
      await load();
      setMessage(kind === "configure" ? "Monitoring settings saved." : dryRun ? "Dry run complete. Nothing was saved or imported." : "Source check saved. Review the extracted scores below.");
    } catch (e) { setMessage(e instanceof Error ? e.message : "Request failed."); }
    finally { setBusy(false); }
  }

  async function selectEvent(id: string) {
    const next = events.find((e) => e.id === id);
    setSelected(id); setUrl(next?.eventUrl || ""); setEnabled(next?.enabled ?? true);
    setPreview(null); setReviewed(false); setReviewNotes(""); setCandidate(null); setSheetId(""); setMessage("");
    if (next && !next.report) {
      setBusy(true);
      try {
        const res = await fetch(`/api/admin/result-imports?eventId=${encodeURIComponent(id)}`, { cache: "no-store" });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Could not load the source report.");
        setPreview(data.report);
      } catch (error) { setMessage(error instanceof Error ? error.message : "Report failed."); }
      finally { setBusy(false); }
    }

  }

  return <main className="mx-auto max-w-6xl space-y-6 p-6 text-slate-900">
    <Link href="/admin" className="text-sm underline">← Admin dashboard</Link>
    <h1 className="text-2xl font-bold">Results import inbox</h1>
    <p>Check event websites after racing ends, extract result tables, then review and import into the correct class sheet. Publication stays under your control during the pilot.</p>
    <p className="text-sm text-slate-600">Scheduled checks cover events that ended in the past 45 days. PDFs and sites that load results dynamically need source review. An event link is a discovery starting point; it does not establish that results are final.</p>
    {health && <section aria-label="Results monitor status" className="space-y-2 rounded-xl border bg-white p-4">
      <h2 className="font-semibold">Scheduled source checks: {health.enabled && health.schedulerConfigured ? "Enabled" : "Disabled"}</h2>
      <p className="text-sm">{health.schedule} · Up to {health.batchLimit} events per run · Past {health.lookbackDays} days.</p>
      {!health.enabled && <p className="text-sm">Global monitoring is switched off. Event checkboxes take effect when it is enabled.</p>}
      {!health.schedulerConfigured && <p className="text-sm text-red-700">The scheduler credential is missing. Scheduled requests cannot run.</p>}
      <p className="text-sm">Last successful check: {runTime(health.lastSuccess)}. Last failed check: {runTime(health.lastFailure)}.</p>
      <p className="text-sm">Checks discover sources only. Imports are saved as drafts; publication requires administrator review.</p>
      <details><summary>Recent checks</summary>{health.recentRuns.length ? <ul>{health.recentRuns.map((run) => <li key={run.id} className="py-1 text-sm">{runTime(run)} · {run.trigger} · {run.status} · {run.checkedCount} events checked · {run.failedCount} source failures</li>)}</ul> : <p className="text-sm">No runs recorded yet. History starts with this release.</p>}</details>
    </section>}
    <label className="block">Regatta
      <select aria-label="Regatta" className="mt-1 block w-full rounded border p-3" value={selected} disabled={busy} onChange={(e) => selectEvent(e.target.value)}>
        <option value="">Choose an event</option>
        {events.map((e) => <option key={e.id} value={e.id}>{e.startDate} · {e.name}{(e.lastStatus || e.report?.status) ? ` · ${(e.lastStatus || e.report?.status || "").replaceAll("_", " ")}` : ""}</option>)}
      </select>
    </label>
    {event && <>
      <div className="space-y-3 rounded-xl border bg-white p-4">
        <label className="block">Event website or results URL<input type="url" className="mt-1 block w-full rounded border p-3" value={url} onChange={(e) => setUrl(e.target.value)} disabled={busy} /></label>
        <label className="flex items-center gap-2"><input type="checkbox" checked={enabled} onChange={(e) => setEnabled(e.target.checked)} disabled={busy} /> Include in scheduled source checks</label>
        <div className="flex flex-wrap gap-2">
          <button className={button} disabled={busy} onClick={() => action("configure")}>Save settings</button>
          <button className={button} disabled={busy || url !== event.eventUrl || !url} onClick={() => action("scan", true)}>Dry run</button>
          <button className={button} disabled={busy || url !== event.eventUrl || !url} onClick={() => action("scan")}>Check for results</button>
        </div>
        <p className="text-sm text-slate-600">Save URL changes before checking. Last saved check: {event.checkedAt ? new Date(event.checkedAt).toLocaleString("en-SG", { timeZone: "Asia/Singapore" }) : "Never"}.</p>
      </div>
      {busy && <p role="status">Checking sources… This can take about a minute.</p>}
      {report && <section className="space-y-4">
        <h2 className="text-xl font-semibold">{report.status === "waiting" ? "No supported results found yet" : report.status === "error" ? "Source check failed" : "Sources awaiting review"}</h2>
        <p className="rounded border border-amber-300 bg-amber-50 p-3">{report.pdfCorroboration === "visual_review_required" ? "PDF links found. Confirm which PDF contains final results, render its relevant pages, and visually compare every row, score, discard, and total before importing." : "PDF corroboration is unavailable in the pages checked. Search the organiser, host club, class association, and national authority before importing; record that search in your source review."}</p>
        <details><summary>Pages checked and errors</summary><ul className="list-disc pl-6">{report.searchedUrls.map((u) => <li key={u}><a href={u} target="_blank" rel="noreferrer" className="underline">{u}</a></li>)}</ul>{report.errors.map((e) => <p key={e} className="text-sm text-red-700">{e}</p>)}</details>
        <label className="block">Source review notes<textarea value={reviewNotes} onChange={(e) => { setReviewNotes(e.target.value); setCandidate(null); }} className="mt-1 block w-full rounded border p-3" placeholder="Record official PDF searches, the final revision, and any source comparisons." maxLength={1500} /></label>
        <label className="block">Destination class sheet<select className="mt-1 block rounded border p-3" aria-label="Destination class sheet" value={sheetId} onChange={(e) => { setSheetId(e.target.value); setCandidate(null); setReviewed(false); }}><option value="">Choose class / fleet</option>{event.sheets.map((s) => <option key={s.id} value={s.id}>{s.boatClass} · {s.division} · {s.name}</option>)}</select></label>
        {!event.sheets.length && <p>Add the event’s class sheets in <Link href={`/admin?area=events&event=${event.slug}`} className="underline">event management</Link> before importing.</p>}
        <label className="flex items-start gap-2"><input className="mt-1" type="checkbox" checked={reviewed} onChange={(e) => { setReviewed(e.target.checked); setCandidate(null); }} /> I verified the event, year, dates, class/fleet, final revision and complete fleet size against the official source; reviewed every score and discard; and completed the official PDF search and visual comparison where available.</label>
        {report.sources.map((source) => <article key={source.url} className="space-y-3 rounded-xl border bg-white p-4">
          <a href={source.url} target="_blank" rel="noreferrer" className="font-semibold underline">{source.title || source.url}</a>
          <p className="text-sm">{source.kind === "pdf" ? "PDF — read its pages and extract its table below, then verify the visible source." : source.finalLabelSeen ? "Page contains a final-results label; confirm it applies to this table." : "Final publication status needs confirmation."}</p>
          {source.kind === "pdf" && <button className={button} disabled={!sheetId} onClick={() => setCandidate({ source, table: { title: source.title, rows: [], raceCount: 0, issues: [] }, tableIndex: -1, sheet: event.sheets.find((s) => s.id === sheetId)! })}>Open PDF reader</button>}
          {source.tables.map((table, index) => <div key={index} className="space-y-2 border-t pt-3">
            <p>{table.title} · {table.rows.length} competitors · {table.raceCount} races</p>
            {table.issues.length > 0 && <details><summary className="text-red-700">{table.issues.length} validation issues — import blocked</summary>{table.issues.map((issue, i) => <p key={i} className="text-sm">{issue}</p>)}</details>}
            <details><summary>Inspect extracted scores</summary><div className="overflow-x-auto"><table className="w-full text-sm"><thead><tr><th>Rank</th><th>Name</th><th>Sail</th><th>Races (discarded in brackets)</th><th>Total</th><th>Net</th></tr></thead><tbody>{table.rows.map((row, i) => <tr key={i}><td>{row.rank}</td><td>{row.name}</td><td>{row.sailNumber}</td><td>{row.races.map((r) => r.discarded ? `[${r.rawValue}]` : r.rawValue).join(" · ")}</td><td>{row.total}</td><td>{row.nett}</td></tr>)}</tbody></table></div></details>
            <button className={button} disabled={!reviewed || !sheetId || table.issues.length > 0} onClick={() => setCandidate({ source, table, tableIndex: index, sheet: event.sheets.find((s) => s.id === sheetId)! })}>Prepare reviewed import</button>
          </div>)}
        </article>)}
      </section>}
      {candidate && <section className="rounded-xl border bg-white p-4">
        <h2 className="text-xl font-semibold">Import reviewed results</h2>
        <p>Review the populated fields and identities. The initial save is a draft; publish through the usual event review.</p>
        <AdminRegattaImport key={`${event.id}:${candidate.source.sha256}:${candidate.tableIndex}:${candidate.table.title}:${candidate.sheet.id}`} isSuperadmin remotePdfSha256={candidate.source.sha256} remotePdfUrl={candidate.source.kind === "pdf" ? candidate.source.url : undefined} targetEventSlug={event.slug} targetSheetId={candidate.sheet.id} targetEvents={[{ slug: event.slug, name: event.name, sheets: event.sheets.map((s) => ({ id: s.id, label: `${s.boatClass} ${s.division}`, date: s.date })) }]} initialExtraction={{ rows: candidate.table.rows, evidenceNotes: `Source discovery ${report?.checkedAt}; SHA-256 ${candidate.source.sha256}. Event/date/class/finality/fleet and scores reviewed by administrator. PDF status: ${report?.pdfCorroboration}. Searched: ${report?.searchedUrls.join(", ")}. Review notes: ${reviewNotes}`, meta: { name: candidate.sheet.name, date: candidate.sheet.date, boatClass: candidate.sheet.boatClass, division: candidate.sheet.division, geography: candidate.sheet.geography, countsForRanking: candidate.sheet.countsForRanking, ...(candidate.source.kind === "html" ? { fleetSize: candidate.table.rows.length, raceCount: candidate.table.raceCount } : {}), officialResultsUrl: candidate.source.url, officialResultsSourceName: candidate.source.title, publicationStatus: "draft" } }} />
      </section>}
    </>}
    {message && <p role="status" className="rounded border p-3">{message}</p>}
  </main>;
}
