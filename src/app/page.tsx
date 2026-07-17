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
      <div className="absolute top-0 left-1/4 w-[500px] h-[500px] bg-orange-600/10 rounded-full blur-[120px] pointer-events-none -z-10" />
      <div className="absolute top-[40%] right-1/4 w-[320px] h-[320px] bg-blue-600/5 rounded-full blur-[100px] pointer-events-none -z-10 hidden md:block" />

      {!dbLive && (
        <div className="border-b border-rose-500/20 bg-rose-500/10 px-4 py-2.5 text-center text-xs text-rose-200">
          Database not connected —{" "}
          <Link href="/api/health" className="font-bold underline text-white">
            /api/health
          </Link>
          . Preview a profile:{" "}
          <Link href="/sample" className="font-bold underline text-white">
            sample profile
          </Link>
          . {offlineMsg ? `(${offlineMsg.slice(0, 80)})` : null}
        </div>
      )}

      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 pt-12 sm:pt-16 lg:pt-24 pb-12 lg:pb-16 text-center">
        <p className="inline-flex items-center gap-2 px-3 py-1 rounded-full border border-white/5 bg-white/5 text-xs text-orange-400 font-bold mb-6">
          Singapore Optimist
        </p>
        <h1 className="mx-auto max-w-4xl text-4xl sm:text-5xl lg:text-7xl font-black text-white tracking-tight leading-[1.05]">
          Chart your progress.
          <br />
          <span className="bg-gradient-to-r from-orange-500 via-orange-600 to-red-500 bg-clip-text text-transparent">
            Command your pathway.
          </span>
        </h1>
        <p className="mt-5 sm:mt-6 max-w-2xl mx-auto text-slate-400 text-sm sm:text-base lg:text-lg font-semibold leading-relaxed">
          Live fleet rankings, regatta results, and sailor profiles for Singapore
          Optimist sailors.
        </p>
        <div className="mt-8 flex flex-col sm:flex-row flex-wrap justify-center gap-3">
          <Link
            href="/sg/optimist/gold"
            className="rounded-full bg-orange-600 px-8 py-3.5 text-xs font-black uppercase tracking-wider text-white hover:bg-orange-500 shadow-lg shadow-orange-950/20"
          >
            Gold standings
          </Link>
          <Link
            href="/sample"
            className="rounded-full border border-amber-500/40 bg-amber-500/10 px-8 py-3.5 text-xs font-bold text-amber-100 hover:border-amber-400/60"
          >
            View sample profile
          </Link>
          <Link
            href="/register"
            className="rounded-full border border-white/10 px-8 py-3.5 text-xs font-bold text-white hover:border-orange-500/50"
          >
            Claim your profile
          </Link>
        </div>
        <form
          action="/search"
          className="mt-10 sm:mt-12 mx-auto max-w-xl relative"
        >
          <input
            name="query"
            placeholder="Search name or sail number (e.g. SGP 115)…"
            className="w-full rounded-full border border-white/10 bg-white/5 px-6 py-4 pr-28 text-sm md:text-base text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none focus:ring-2 focus:ring-orange-500/20 shadow-xl shadow-black/30"
          />
          <button
            type="submit"
            className="absolute right-2 top-2 rounded-full bg-orange-600 px-5 py-2.5 text-xs font-bold text-white hover:bg-orange-500"
          >
            Search
          </button>
        </form>
        <p className="mt-4 text-xs text-slate-500">
          Curious how a profile looks?{" "}
          <Link href="/sample" className="text-orange-400 font-bold hover:underline">
            Open the sample profile (Ashlyn Tan style)
          </Link>
        </p>
      </section>

      <section className="border-t border-white/5 bg-[#0b0c13] py-12 lg:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3 mb-8">
            <div>
              <h2 className="text-xl sm:text-2xl font-black text-white">
                {dbLive
                  ? `Sailors in database (${sailors.length})`
                  : "Live sailors"}
              </h2>
              <p className="text-xs text-slate-500 mt-1">
                Real data only — sample profile is separate.
              </p>
            </div>
            <Link
              href="/sample"
              className="text-xs font-bold text-amber-300/90 hover:text-amber-200"
            >
              Sample profile →
            </Link>
          </div>

          {!dbLive ? (
            <p className="text-sm text-slate-500 max-w-xl">
              Connect the database (see docs/GO_LIVE.md), or{" "}
              <Link href="/sample" className="text-orange-400 font-bold">
                view the sample profile
              </Link>
              .
            </p>
          ) : featured.length === 0 ? (
            <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-8 text-center">
              <p className="text-sm text-slate-400">
                Database is live but empty. Import sailors from{" "}
                <a
                  href="https://admin.sailorpath.com/"
                  className="text-orange-400 font-bold"
                >
                  admin
                </a>
                , or{" "}
                <Link href="/sample" className="text-orange-400 font-bold">
                  preview a sample profile
                </Link>
                .
              </p>
            </div>
          ) : (
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {featured.map((s) => (
                <Link
                  key={s.id}
                  href={`/${s.handle}`}
                  className="glass-card rounded-2xl p-5 border border-white/5 hover:border-orange-500/30 transition-colors"
                >
                  <p className="font-bold text-white text-base">{s.name}</p>
                  <p className="text-xs text-slate-400 mt-1.5">
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
