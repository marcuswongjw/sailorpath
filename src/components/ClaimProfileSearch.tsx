"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { ArrowRight, Search } from "lucide-react";

type SailorHit = {
  id: string;
  name: string;
  handle: string;
  sailNumber?: string | null;
  sailNumberIlca4?: string | null;
  club?: string | null;
};

export function ClaimProfileSearch() {
  const [query, setQuery] = useState("");
  const [hits, setHits] = useState<SailorHit[]>([]);
  const [loading, setLoading] = useState(false);
  const [searched, setSearched] = useState(false);

  const trimmed = query.trim();

  useEffect(() => {
    if (trimmed.length < 2) return;

    const controller = new AbortController();
    const timer = setTimeout(async () => {
      setLoading(true);
      try {
        const res = await fetch(
          `/api/search?type=sailors&limit=6&q=${encodeURIComponent(trimmed)}`,
          { signal: controller.signal }
        );
        if (!res.ok) throw new Error("Search failed");
        const data = (await res.json()) as { sailors?: SailorHit[] };
        setHits(data.sailors ?? []);
        setSearched(true);
      } catch (err) {
        if ((err as { name?: string })?.name !== "AbortError") {
          setHits([]);
          setSearched(true);
        }
      } finally {
        if (!controller.signal.aborted) setLoading(false);
      }
    }, 220);

    return () => {
      clearTimeout(timer);
      controller.abort();
    };
  }, [trimmed]);

  const handleQueryChange = (value: string) => {
    setQuery(value);
    if (value.trim().length < 2) {
      setHits([]);
      setSearched(false);
      setLoading(false);
    }
  };

  return (
    <div className="mt-3 space-y-2.5">
      <div className="relative">
        <Search
          className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-soft"
          aria-hidden="true"
        />
        <input
          type="search"
          value={query}
          onChange={(e) => handleQueryChange(e.target.value)}
          placeholder="Type sailor name or sail number (e.g. SGP 4652)"
          aria-label="Search sailor profile to claim"
          className="sp-input w-full pl-9 text-sm"
        />
      </div>

      {loading && (
        <p className="text-xs text-slate-soft">Searching profiles…</p>
      )}

      {!loading && hits.length > 0 && (
        <ul className="divide-y divide-cool-veil rounded-xl border border-cool-veil bg-sailcloth/40 overflow-hidden">
          {hits.map((sailor) => {
            const sail = sailor.sailNumber || sailor.sailNumberIlca4 || "";
            const meta = [sail, sailor.club].filter(Boolean).join(" · ");
            return (
              <li key={sailor.id}>
                <Link
                  href={`/sailors/${encodeURIComponent(sailor.handle)}`}
                  className="flex items-center justify-between gap-3 px-3.5 py-2.5 hover:bg-aqua-mist/50 transition-colors"
                >
                  <div className="min-w-0">
                    <p className="text-sm font-bold text-harbour-shadow truncate">
                      {sailor.name}
                    </p>
                    {meta && (
                      <p className="text-[11px] text-slate-soft truncate">
                        {meta}
                      </p>
                    )}
                  </div>
                  <span className="inline-flex shrink-0 items-center gap-1 text-xs font-bold text-harbour">
                    Open &amp; claim
                    <ArrowRight className="h-3.5 w-3.5" aria-hidden="true" />
                  </span>
                </Link>
              </li>
            );
          })}
        </ul>
      )}

      {!loading && searched && hits.length === 0 && (
        <p className="text-xs text-slate-soft">
          No matching profile found.{" "}
          <Link href="/sailors" className="font-semibold text-harbour hover:underline">
            Browse the full directory
          </Link>{" "}
          or{" "}
          <Link href="/register" className="font-semibold text-harbour hover:underline">
            create an account
          </Link>{" "}
          to start a new logbook.
        </p>
      )}
    </div>
  );
}
