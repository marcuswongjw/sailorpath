import Link from "next/link";
import { listSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function HomePage() {
  let sailors: Awaited<ReturnType<typeof listSailors>> = [];
  let dbLive = true;
  let offlineMsg = "";

  try {
    sailors = await listSailors();
  } catch (e) {
    dbLive = false;
    offlineMsg = e instanceof DbUnavailableError ? e.message : "Database error";
  }

  const featured = sailors.slice(0, 6);

  return (
    <div className="relative flex-1">
      <div className="absolute top-0 left-1/4 w-[400px] h-[400px] bg-orange-600/10 rounded-full blur-[120px] pointer-events-none -z-10" />

      {!dbLive && (
        <div className="border-b border-rose-500/20 bg-rose-500/10 px-4 py-2.5 text-center text-xs text-rose-200">
          Database not connected yet — rankings are empty. See{" "}
          <Link href="/api/health" className="font-bold underline text-white">
            /api/health
          </Link>{" "}
          and{" "}
          <Link href="/sample" className="font-bold underline text-white">
            sample preview
          </Link>
          . {offlineMsg ? `(${offlineMsg.slice(0, 80)})` : null}
        </div>
      )}

      <section className="mx-auto max-w-7xl px-4 pt-16 pb-12 text-center">
        <p className="text-xs font-bold text-orange-400 mb-4 tracking-wide uppercase">
          Singapore Optimist
        </p>
        <h1 className="text-4xl sm:text-6xl font-black text-white tracking-tight">
          Chart your progress.
          <br />
          <span className="bg-gradient-to-r from-orange-500 to-red-500 bg-clip-text text-transparent">
            Command your pathway.
          </span>
        </h1>
        <p className="mt-5 max-w-2xl mx-auto text-slate-400 text-sm sm:text-base">
          Live fleet rankings, regatta results, and sailor profiles.
        </p>
        <div className="mt-8 flex flex-wrap justify-center gap-3">
          <Link
            href="/sg/optimist/gold"
            className="rounded-full bg-orange-600 px-6 py-3 text-xs font-black uppercase text-white hover:bg-orange-500"
          >
            Gold standings
          </Link>
          <Link
            href="/sample"
            className="rounded-full border border-amber-500/40 bg-amber-500/10 px-6 py-3 text-xs font-bold text-amber-100 hover:border-amber-400/60"
          >
            View sample project
          </Link>
          <Link
            href="/register"
            className="rounded-full border border-white/10 px-6 py-3 text-xs font-bold text-white hover:border-orange-500/50"
          >
            Create account
          </Link>
        </div>
        <form action="/search" className="mt-10 mx-auto max-w-lg relative">
          <input
            name="query"
            placeholder="Search name or sail number…"
            className="w-full rounded-full border border-white/10 bg-white/5 px-6 py-3.5 pr-28 text-sm text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none"
          />
          <button
            type="submit"
            className="absolute right-2 top-2 rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white hover:bg-orange-500"
          >
            Search
          </button>
        </form>
      </section>

      <section className="border-t border-white/5 bg-[#0b0c13] py-12">
        <div className="mx-auto max-w-7xl px-4">
          <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3 mb-6">
            <h2 className="text-lg font-black text-white">
              {dbLive
                ? `Sailors in database (${sailors.length})`
                : "Live sailors (waiting for database)"}
            </h2>
            <Link
              href="/sample"
              className="text-xs font-bold text-amber-300/90 hover:text-amber-200"
            >
              See sample project →
            </Link>
          </div>

          {!dbLive ? (
            <p className="text-sm text-slate-500 max-w-xl">
              No live data until PostgreSQL is connected on Vercel. Use{" "}
              <Link href="/sample" className="text-orange-400 font-bold">
                sample project
              </Link>{" "}
              to preview the UI, then follow docs/GO_LIVE.md.
            </p>
          ) : featured.length === 0 ? (
            <p className="text-sm text-slate-500">
              Database is live but empty. Import sailors from{" "}
              <a
                href="https://admin.sailorpath.com/"
                className="text-orange-400 font-bold"
              >
                admin
              </a>
              , or{" "}
              <Link href="/sample" className="text-orange-400 font-bold">
                view the sample project
              </Link>
              .
            </p>
          ) : (
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
              {featured.map((s) => (
                <Link
                  key={s.id}
                  href={`/${s.handle}`}
                  className="glass-card rounded-2xl p-4 border border-white/5 hover:border-orange-500/30 transition-colors"
                >
                  <p className="font-bold text-white">{s.name}</p>
                  <p className="text-xs text-slate-400 mt-1">
                    {s.sailNumber} · {s.club}
                  </p>
                </Link>
              ))}
            </div>
          )}
        </div>
      </section>
    </div>
  );
}
