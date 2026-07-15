import Link from "next/link";
import { getSailors } from "@/lib/dbQueries";
import { DemoBanner } from "@/components/DemoBanner";
import { ChevronRight } from "lucide-react";

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{ query?: string }>;
}) {
  const { query = "" } = await searchParams;
  const { data: sailorsList, isDemo } = await getSailors();

  // Search filter
  const results = sailorsList.filter((s) => {
    const q = query.toLowerCase().trim();
    if (!q) return false;
    return (
      s.firstName.toLowerCase().includes(q) ||
      s.lastName.toLowerCase().includes(q) ||
      s.sailNumber.toLowerCase().includes(q) ||
      s.club.toLowerCase().includes(q)
    );
  });

  return (
    <div className="min-h-screen bg-[#090a0f] py-12 px-4 sm:px-6 lg:px-8">
      <DemoBanner isDemo={isDemo} />
      <div className="max-w-3xl mx-auto">
        <h1 className="text-3xl font-extrabold text-white tracking-tight mb-8">
          Search Results for <span className="text-orange-500">"{query}"</span>
        </h1>

        {results.length === 0 ? (
          <div className="glass-card rounded-2xl p-8 border border-white/5 text-center">
            <p className="text-slate-400 mb-6">No sailors matched your search query. Try searching for "Ashlyn" or "SGP 115".</p>
            <Link
              href="/"
              className="inline-flex rounded-full bg-slate-800 px-6 py-2 text-sm font-semibold text-slate-200 hover:bg-slate-700 transition-all border border-white/5"
            >
              Back to Home
            </Link>
          </div>
        ) : (
          <div className="space-y-4">
            {results.map((sailor) => (
              <Link
                key={sailor.id}
                href={`/${sailor.handle}`}
                className="block glass-card rounded-2xl p-6 border border-white/5 hover:border-orange-500/20 hover:scale-[1.01] transition-all group"
              >
                <div className="flex items-center justify-between">
                  <div>
                    <div className="flex items-center gap-3">
                      <span className="text-xl font-bold text-white group-hover:text-orange-500 transition-colors">
                        {sailor.firstName} {sailor.lastName}
                      </span>
                      <span className="text-xs font-semibold px-2 py-0.5 rounded bg-orange-500/10 text-orange-400 border border-orange-500/20">
                        {sailor.goldEntryDate ? "Gold Fleet" : "Silver Fleet"}
                      </span>
                    </div>
                    <div className="mt-2 flex gap-4 text-xs text-slate-400 font-medium">
                      <span>Sail: **{sailor.sailNumber}**</span>
                      <span>•</span>
                      <span>Club: {sailor.club}</span>
                    </div>
                  </div>
                  <ChevronRight className="h-5 w-5 text-slate-500 group-hover:text-orange-500 transition-colors" />
                </div>
              </Link>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
