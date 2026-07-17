import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { searchSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{ query?: string }>;
}) {
  const { query = "" } = await searchParams;
  let results: Awaited<ReturnType<typeof searchSailors>> = [];
  let offline = false;
  let msg = "";

  if (query.trim()) {
    try {
      results = await searchSailors(query);
    } catch (e) {
      offline = true;
      msg = e instanceof DbUnavailableError ? e.message : "DB error";
    }
  }

  if (offline) return <DbOffline message={msg} />;

  return (
    <div className="mx-auto max-w-3xl px-4 py-12 space-y-6">
      <h1 className="text-2xl font-black text-white">Search sailors</h1>
      <form className="flex gap-2">
        <input
          name="query"
          defaultValue={query}
          placeholder="Name, sail number, club…"
          className="flex-1 rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm text-white focus:border-orange-500 focus:outline-none"
        />
        <button
          type="submit"
          className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white"
        >
          Search
        </button>
      </form>
      {query.trim() && (
        <p className="text-xs text-slate-500">{results.length} result(s)</p>
      )}
      <ul className="space-y-2">
        {results.map((s) => (
          <li key={s.id}>
            <Link
              href={`/${s.handle}`}
              className="block glass-card rounded-xl px-4 py-3 border border-white/5 hover:border-orange-500/30"
            >
              <span className="font-bold text-white">{s.name}</span>
              <span className="text-xs text-slate-400 ml-2">
                {s.sailNumber} · {s.club}
              </span>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
