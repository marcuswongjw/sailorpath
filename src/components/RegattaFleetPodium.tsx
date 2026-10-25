import Link from "next/link";
import type { PublicRegattaResult } from "@/lib/queries";

/** Finishing positions are useful even when the organiser's prize rules are unavailable. */
export function RegattaFleetPodium({ results }: { results: readonly PublicRegattaResult[] }) {
  const leaders = results.filter((row) => row.rank >= 1 && row.rank <= 3 && !row.isDns && !row.isOverseasCommitment);
  if (!leaders.length) return null;
  return <section aria-label="Recorded fleet podium" className="space-y-3">
    <div><h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">Fleet podium</h2><p className="mt-1 text-xs text-[var(--sp-charcoal-slate)]">Top finishers in the recorded results. Official prize categories have not been verified for this fleet.</p></div>
    <ol className="grid gap-3 sm:grid-cols-3">{leaders.map((row) => <li key={row.resultId} className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4">
      <span className="mb-2 block text-xs font-bold text-[var(--sp-charcoal-slate)]">{row.rank === 1 ? "1st" : row.rank === 2 ? "2nd" : "3rd"} place</span>
      <div className="text-sm font-bold text-[var(--sp-harbour-teal)]">{row.participants?.length ? row.participants.map((person, index) => <span key={person.id}>{index > 0 && " / "}{person.handle && person.matchStatus === "matched" ? <Link href={`/sailors/${encodeURIComponent(person.handle)}`} className="hover:underline">{person.sailorName || person.sourceName}</Link> : person.sailorName || person.sourceName}</span>) : row.handle ? <Link href={`/sailors/${encodeURIComponent(row.handle)}`} className="hover:underline">{row.sailorName}</Link> : row.sailorName}</div>
    </li>)}</ol>
  </section>;
}
