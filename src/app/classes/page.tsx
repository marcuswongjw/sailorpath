import { getCachedPublicRegattas } from "@/lib/queries";
import { publishedResultClasses } from "@/lib/classRegistry";
import { PUBLIC_CLASS_HUBS } from "@/lib/publicClassHubs";
import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Class hubs | SailorPath",
  description: "Explore sailing classes, published scorecards, Singapore standings and class guides on SailorPath.",
  alternates: { canonical: "/classes" },
};

const hubs = [
  {
    href: "/classes/x15",
    name: "X-15",
    status: "Beta",
    note: "Worlds and Asian Championship context, with class history and no SailorPath ranking.",
  },
  {
    href: "/classes/optimist",
    name: "Optimist",
    status: "Class",
    note: "The one-design pram for young sailors, with class history and links to the Singapore standings.",
  },
] as const;

export default async function ClassesIndexPage() {
  let classes: string[] = [];
  let available = true;
  try {
    classes = publishedResultClasses(await getCachedPublicRegattas());
  } catch {
    available = false;
  }
  return (
    <main className="mx-auto max-w-6xl space-y-10 px-4 py-10 sm:px-6 sm:py-14">
      <header className="rounded-3xl border border-harbour/15 bg-harbour-shadow px-6 py-8 text-sailcloth shadow-sm sm:px-10 sm:py-12">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-soft-aqua">
          Class hubs
        </p>
        <h1 className="mt-3 text-3xl font-black tracking-tight sm:text-5xl">
          Classes on SailorPath
        </h1>
        <p className="mt-4 max-w-2xl text-base leading-7 text-soft-aqua sm:text-lg">
          Browse published results by class, explore Singapore standings and
          learn about the boats and boards behind the racing.
        </p>
      </header>

      <section aria-label="Classes with published results" className="space-y-4">
        <h2 className="text-2xl font-bold text-harbour-shadow">Classes with published results</h2>
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {classes.map((name) => {
            const hub = PUBLIC_CLASS_HUBS.find((item) => item.name === name);
            return (
              <article key={name} className="rounded-2xl border border-cool-veil bg-warm-white p-6">
                <h3 className="text-xl font-bold text-harbour-shadow">{name}</h3>
                <Link href={`/results?class=${encodeURIComponent(name)}`} className="mt-3 block text-sm font-semibold text-harbour hover:underline">Browse {name} results</Link>
                {hub && <Link href={hub.href} className="mt-3 block text-sm font-semibold text-harbour hover:underline">Singapore standings and results</Link>}
              </article>
            );
          })}
        </div>
        {!classes.length && <p className="text-sm text-slate-soft">{available ? "No published class scorecards are available yet." : "Class results are temporarily unavailable. Please try again shortly."}</p>}
      </section>

      <section className="space-y-4" aria-label="Class guides">
        <h2 className="text-2xl font-bold text-harbour-shadow">Class guides</h2>
        <div className="grid gap-4 md:grid-cols-2">
        {hubs.map((hub) => (
          <Link
            key={hub.href}
            href={hub.href}
            className="rounded-2xl border border-cool-veil bg-warm-white p-6 shadow-xs hover:border-harbour"
          >
            <p className="text-xs font-bold uppercase tracking-wider text-harbour">{hub.status}</p>
            <h2 className="mt-2 text-2xl font-black text-harbour-shadow">{hub.name}</h2>
            <p className="mt-3 text-sm leading-6 text-slate-soft">{hub.note}</p>
          </Link>
        ))}
        </div>
      </section>
    </main>
  );
}
