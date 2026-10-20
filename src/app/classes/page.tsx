import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Class hubs | SailorPath",
  description: "X-15 and Optimist class hubs on SailorPath.",
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

export default function ClassesIndexPage() {
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
          Two class pages so far. Each one explains the class and links out to
          the records that already exist. They do not replace results or rankings.
        </p>
      </header>

      <section className="grid gap-4 md:grid-cols-2" aria-label="Class hubs">
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
      </section>
    </main>
  );
}
