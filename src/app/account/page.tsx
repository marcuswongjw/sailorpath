"use client";

import { useEffect, useState, Suspense } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { createBrowserSupabase } from "@/lib/supabase/browser";

type Owned = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  club: string;
};

type Claim = {
  id: string;
  status: string;
  sailorName: string;
  sailorHandle: string;
  createdAt: string;
};

function AccountInner() {
  const searchParams = useSearchParams();
  const welcome = searchParams.get("welcome") === "1";
  const [email, setEmail] = useState<string | null>(null);
  const [owned, setOwned] = useState<Owned[]>([]);
  const [claims, setClaims] = useState<Claim[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    (async () => {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (!session) {
          window.location.assign(
            `/login?next=${encodeURIComponent("/account")}`
          );
          return;
        }
        setEmail(session.user.email ?? null);

        try {
          await fetch("/api/auth/ensure-profile", {
            method: "POST",
            credentials: "include",
          });
        } catch {
          /* optional */
        }

        const res = await fetch("/api/account", { credentials: "include" });
        const data = await res.json();
        if (!res.ok) {
          setError(data.error || "Could not load account");
          return;
        }
        setOwned(data.owned || []);
        setClaims(data.claims || []);
        if (data.email) setEmail(data.email);
      } catch (e) {
        setError(e instanceof Error ? e.message : "Error loading account");
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  if (loading) {
    return (
      <div className="min-h-[50vh] flex items-center justify-center text-sm text-slate-500">
        Loading account…
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:py-14 space-y-8">
      <div>
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          My account
        </h1>
        <p className="mt-2 text-sm text-slate-400">
          Signed in as{" "}
          <span className="font-semibold text-slate-200">{email}</span>
        </p>
      </div>

      {welcome && (
        <div className="rounded-2xl border border-emerald-500/25 bg-emerald-500/10 px-5 py-4">
          <p className="text-sm font-bold text-emerald-200">
            Account created — next, claim your sailor profile
          </p>
          <p className="text-xs text-emerald-100/80 mt-1 leading-relaxed">
            Creating an account does not link you to a ranking profile yet.
            Search for your name or sail number, open the profile, then press{" "}
            <strong>Claim this profile</strong>. A superadmin will approve the
            request.
          </p>
        </div>
      )}

      {error && (
        <p className="text-sm font-bold text-rose-400">{error}</p>
      )}

      {/* How to claim */}
      <section className="glass-card rounded-2xl border border-white/5 p-6 space-y-4">
        <h2 className="text-sm font-black text-white uppercase tracking-wider">
          How to claim a profile
        </h2>
        <ol className="space-y-3 text-xs text-slate-300 font-medium list-decimal list-inside leading-relaxed">
          <li>
            Find yourself on the{" "}
            <Link href="/search" className="text-orange-400 font-bold hover:underline">
              search page
            </Link>{" "}
            or{" "}
            <Link
              href="/sg/optimist/goldsailors"
              className="text-orange-400 font-bold hover:underline"
            >
              Gold fleet register
            </Link>
            .
          </li>
          <li>Open your public sailor page (name / handle).</li>
          <li>
            Click <strong className="text-white">Claim this profile</strong>{" "}
            (you must be logged in).
          </li>
          <li>
            Wait for admin approval. Status shows below. Once approved, use{" "}
            <strong className="text-white">Edit profile</strong> on that page.
          </li>
        </ol>
        <div className="flex flex-wrap gap-2 pt-1">
          <Link
            href="/search"
            className="rounded-full bg-orange-600 px-4 py-2 text-[11px] font-bold text-white hover:bg-orange-500"
          >
            Search for my profile
          </Link>
          <Link
            href="/sg/optimist/gold"
            className="rounded-full border border-white/15 px-4 py-2 text-[11px] font-bold text-slate-300 hover:text-white"
          >
            Gold standings
          </Link>
        </div>
      </section>

      {/* Owned */}
      <section className="glass-card rounded-2xl border border-white/5 p-6 space-y-3">
        <h2 className="text-sm font-black text-white uppercase tracking-wider">
          Profiles you manage
        </h2>
        {owned.length === 0 ? (
          <p className="text-xs text-slate-500 leading-relaxed">
            None yet. After a claim is approved, your sailor profile will appear
            here and you can edit bio, photo, weight privacy, and more.
          </p>
        ) : (
          <ul className="divide-y divide-white/5">
            {owned.map((s) => (
              <li
                key={s.id}
                className="py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-2"
              >
                <div>
                  <p className="text-sm font-bold text-white">{s.name}</p>
                  <p className="text-[11px] text-slate-500">
                    {s.sailNumber} · {s.club} · /{s.handle}
                  </p>
                </div>
                <Link
                  href={`/${s.handle}?edit=1`}
                  className="rounded-full bg-orange-600/90 px-4 py-1.5 text-[11px] font-bold text-white text-center hover:bg-orange-500"
                >
                  Open &amp; edit
                </Link>
              </li>
            ))}
          </ul>
        )}
      </section>

      {/* Claims */}
      <section className="glass-card rounded-2xl border border-white/5 p-6 space-y-3">
        <h2 className="text-sm font-black text-white uppercase tracking-wider">
          Claim requests
        </h2>
        {claims.length === 0 ? (
          <p className="text-xs text-slate-500">
            No claim requests yet. Submit one from a sailor profile page.
          </p>
        ) : (
          <ul className="divide-y divide-white/5">
            {claims.map((c) => (
              <li
                key={c.id}
                className="py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs"
              >
                <div>
                  <p className="font-bold text-white">{c.sailorName}</p>
                  <Link
                    href={`/${c.sailorHandle}`}
                    className="text-slate-500 hover:text-orange-400"
                  >
                    /{c.sailorHandle}
                  </Link>
                </div>
                <span
                  className={`self-start rounded-full px-2.5 py-0.5 text-[10px] font-black uppercase ${
                    c.status === "approved"
                      ? "bg-emerald-500/15 text-emerald-300 border border-emerald-500/25"
                      : c.status === "rejected"
                        ? "bg-rose-500/15 text-rose-300 border border-rose-500/25"
                        : "bg-amber-500/15 text-amber-200 border border-amber-500/25"
                  }`}
                >
                  {c.status}
                </span>
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}

export default function AccountPage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-[50vh] flex items-center justify-center text-sm text-slate-500">
          Loading…
        </div>
      }
    >
      <AccountInner />
    </Suspense>
  );
}
