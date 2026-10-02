"use client";

import { useState } from "react";
import Link from "next/link";
import { PersonalSeasonCard } from "@/components/PersonalSeasonCard";
import type { FollowedSailorSummary } from "@/lib/personalSeason";

export function FollowingHome({
  sailors: initialSailors,
}: {
  sailors: FollowedSailorSummary[];
}) {
  const [sailors, setSailors] = useState(initialSailors);
  const [busyId, setBusyId] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function unfollow(sailorId: string) {
    setBusyId(sailorId);
    setError(null);
    try {
      const response = await fetch(
        `/api/following?sailorId=${encodeURIComponent(sailorId)}`,
        { method: "DELETE", credentials: "include" }
      );
      const data = await response.json().catch(() => ({}));
      if (!response.ok) throw new Error(data.error || "Could not unfollow");
      setSailors((current) => current.filter((sailor) => sailor.sailorId !== sailorId));
    } catch (err) {
      setError(err instanceof Error ? err.message : "Could not unfollow");
    } finally {
      setBusyId(null);
    }
  }

  return (
    <div className="mx-auto max-w-4xl w-full px-4 py-8 sm:py-12 space-y-6">
      <header className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="text-[11px] font-bold uppercase tracking-[0.18em] text-[var(--sp-racing-orange)]">
            Your sailors
          </p>
          <h1 className="mt-1 text-3xl font-black tracking-tight text-[var(--sp-harbour-shadow)]">
            Following
          </h1>
          <p className="mt-2 text-sm text-[var(--sp-charcoal-slate)] max-w-xl">
            Track sailors without claiming their profiles. You get this half’s place, and an email when their results publish.
          </p>
        </div>
        <Link
          href="/search"
          className="inline-flex items-center justify-center rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)]"
        >
          Find a sailor
        </Link>
      </header>

      {error ? (
        <p className="text-sm font-bold text-[var(--sp-color-error)] rounded-xl border border-rose-200 bg-rose-50 px-4 py-3">
          {error}
        </p>
      ) : null}

      {sailors.length === 0 ? (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 text-center space-y-3">
          <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">
            You are not following anyone yet
          </h2>
          <p className="text-sm text-[var(--sp-charcoal-slate)] max-w-md mx-auto">
            Open a public sailor profile and choose Follow. Your own claimed sailor stays on the parent dashboard.
          </p>
          <Link href="/search" className="sp-btn-primary inline-flex">
            Search sailors
          </Link>
        </div>
      ) : (
        <div className="space-y-6">
          {sailors.map((sailor) => (
            <article key={sailor.sailorId} className="space-y-3">
              <div className="flex flex-wrap items-center justify-between gap-2">
                <p className="text-sm text-[var(--sp-charcoal-slate)]">
                  <Link
                    href={`/${sailor.handle}`}
                    className="font-bold text-[var(--sp-harbour-teal)] hover:underline"
                  >
                    {sailor.name}
                  </Link>
                  <span className="text-[var(--sp-slate-soft)]"> · {sailor.club}</span>
                </p>
                <button
                  type="button"
                  onClick={() => void unfollow(sailor.sailorId)}
                  disabled={busyId === sailor.sailorId}
                  className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-3 py-1.5 text-xs font-bold text-[var(--sp-charcoal)] hover:bg-rose-50 hover:text-rose-700 disabled:opacity-50 cursor-pointer"
                >
                  {busyId === sailor.sailorId ? "Removing…" : "Unfollow"}
                </button>
              </div>
              <PersonalSeasonCard season={sailor.season} />
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
