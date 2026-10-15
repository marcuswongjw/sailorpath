import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "SailorPath updates | SailorPath",
  description: "Release notes, result coverage and public-data updates from SailorPath.",
};

const updates = [
  {
    date: "15 October 2026",
    title: "A clearer public sailing record",
    body: "SailorPath now separates public results discovery from private account, parent and coach workspaces. Public profiles use a verified-results-first default and optional profile sharing is off until an authorised owner chooses it.",
  },
  {
    date: "15 October 2026",
    title: "X-15 pilot opens ahead of Worlds",
    body: "The X-15 class hub brings together the Ibiza and Pattaya event context, verified foundation history and a transparent beta methodology without publishing a numbered ranking before official final results are available.",
  },
];

export default function NewsPage() {
  return (
    <main className="mx-auto max-w-4xl space-y-8 px-4 py-10 sm:px-6 sm:py-14">
      <header className="max-w-2xl space-y-3">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">SailorPath updates</p>
        <h1 className="text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">What&apos;s new</h1>
        <p className="text-base leading-7 text-slate-soft">Product releases, result coverage and information about how SailorPath maintains public competition records.</p>
      </header>
      <section aria-label="Updates" className="space-y-4">
        {updates.map((update) => (
          <article key={update.title} className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs sm:p-6">
            <p className="text-xs font-semibold text-harbour">{update.date}</p>
            <h2 className="mt-2 text-xl font-bold text-harbour-shadow">{update.title}</h2>
            <p className="mt-3 text-sm leading-6 text-charcoal">{update.body}</p>
          </article>
        ))}
      </section>
      <p className="text-sm text-slate-soft">Browse <Link href="/results" className="font-semibold text-harbour hover:underline">published scorecards</Link> or visit the <Link href="/calendar" className="font-semibold text-harbour hover:underline">regatta calendar</Link>.</p>
    </main>
  );
}
