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
  const [pw, setPw] = useState("");
  const [pw2, setPw2] = useState("");
  const [pwMsg, setPwMsg] = useState<string | null>(null);
  const [pwBusy, setPwBusy] = useState(false);

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

  const changePassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setPwMsg(null);
    if (pw.length < 6) {
      setPwMsg("Password must be at least 6 characters");
      return;
    }
    if (pw !== pw2) {
      setPwMsg("Passwords do not match");
      return;
    }
    setPwBusy(true);
    try {
      const supabase = createBrowserSupabase();
      const { error: err } = await supabase.auth.updateUser({ password: pw });
      if (err) throw err;
      setPwMsg("Password updated");
      setPw("");
      setPw2("");
    } catch (err) {
      setPwMsg(err instanceof Error ? err.message : "Could not update password");
    } finally {
      setPwBusy(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-[50vh] flex items-center justify-center text-sm text-slate-500 px-4">
        Loading account…
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl w-full px-4 py-8 sm:py-14 space-y-6 sm:space-y-8">
      <div>
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          My account
        </h1>
        <p className="mt-2 text-sm text-slate-400 break-all">
          Signed in as{" "}
          <span className="font-semibold text-slate-200">{email}</span>
        </p>
      </div>

      {welcome && (
        <div className="rounded-2xl border border-emerald-500/25 bg-emerald-500/10 px-4 sm:px-5 py-4">
          <p className="text-sm font-bold text-emerald-200">
            Account created — next, claim your sailor profile
          </p>
          <p className="text-xs text-emerald-100/80 mt-1 leading-relaxed">
            Creating an account does not link a ranking profile yet. Search for
            your name, open the profile, and submit a claim.
          </p>
        </div>
      )}

      {error && <p className="text-sm font-bold text-rose-400">{error}</p>}

      {/* Managed profiles */}
      <section
        id="profiles"
        className="glass-card rounded-2xl border border-white/5 p-5 sm:p-6 space-y-3 w-full"
      >
        <h2 className="text-sm font-black text-white uppercase tracking-wider">
          Profiles you manage
        </h2>
        {owned.length === 0 ? (
          <p className="text-xs text-slate-500 leading-relaxed">
            None yet. After a claim is approved, your sailor profile appears
            here. Use{" "}
            <Link href="/search" className="text-orange-400 font-bold">
              Search
            </Link>{" "}
            to find yourself and claim.
          </p>
        ) : (
          <ul className="divide-y divide-white/5">
            {owned.map((s) => (
              <li
                key={s.id}
                className="py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-2"
              >
                <div className="min-w-0">
                  <p className="text-sm font-bold text-white">{s.name}</p>
                  <p className="text-[11px] text-slate-500 truncate">
                    {s.sailNumber} · {s.club} · /{s.handle}
                  </p>
                </div>
                <Link
                  href={`/${s.handle}?edit=1`}
                  className="rounded-full bg-orange-600/90 px-4 py-2 text-[11px] font-bold text-white text-center hover:bg-orange-500 shrink-0"
                >
                  Edit profile
                </Link>
              </li>
            ))}
          </ul>
        )}
      </section>

      {/* Account settings */}
      <section className="glass-card rounded-2xl border border-white/5 p-5 sm:p-6 space-y-4 w-full">
        <h2 className="text-sm font-black text-white uppercase tracking-wider">
          Account settings
        </h2>
        <div>
          <p className="text-[10px] font-bold text-slate-500 uppercase">Email</p>
          <p className="text-sm text-slate-200 mt-1 break-all">{email}</p>
        </div>
        <form onSubmit={changePassword} className="space-y-3 border-t border-white/5 pt-4">
          <p className="text-[10px] font-bold text-slate-500 uppercase">
            Change password
          </p>
          <input
            type="password"
            value={pw}
            onChange={(e) => setPw(e.target.value)}
            placeholder="New password (min 6)"
            autoComplete="new-password"
            className="w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-sm text-white"
          />
          <input
            type="password"
            value={pw2}
            onChange={(e) => setPw2(e.target.value)}
            placeholder="Confirm password"
            autoComplete="new-password"
            className="w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-sm text-white"
          />
          <button
            type="submit"
            disabled={pwBusy}
            className="rounded-full bg-white/5 border border-white/10 px-4 py-2 text-[11px] font-bold text-slate-200 hover:text-white disabled:opacity-50"
          >
            {pwBusy ? "Updating…" : "Update password"}
          </button>
          {pwMsg && (
            <p className="text-[11px] text-emerald-300 font-semibold">{pwMsg}</p>
          )}
        </form>
      </section>

      {/* Claims */}
      <section className="glass-card rounded-2xl border border-white/5 p-5 sm:p-6 space-y-3 w-full">
        <h2 className="text-sm font-black text-white uppercase tracking-wider">
          Claim requests
        </h2>
        {claims.length === 0 ? (
          <p className="text-xs text-slate-500">
            No claim requests yet.{" "}
            <Link href="/search" className="text-orange-400 font-bold">
              Search for your profile
            </Link>
            .
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

      {/* How to claim — only if no owned */}
      {owned.length === 0 && (
        <section className="glass-card rounded-2xl border border-white/5 p-5 sm:p-6 space-y-3 w-full">
          <h2 className="text-sm font-black text-white uppercase tracking-wider">
            How to claim a profile
          </h2>
          <ol className="space-y-2 text-xs text-slate-300 font-medium list-decimal list-inside leading-relaxed">
            <li>
              Find yourself on{" "}
              <Link href="/search" className="text-orange-400 font-bold">
                Search
              </Link>
              .
            </li>
            <li>Open your public sailor page.</li>
            <li>
              Click <strong className="text-white">Claim this profile</strong>{" "}
              and add a verification note.
            </li>
            <li>Wait for admin approval — then use Edit profile.</li>
          </ol>
        </section>
      )}

      <section className="rounded-2xl border border-sky-500/20 bg-sky-500/[0.06] p-5 w-full">
        <p className="text-sm font-bold text-sky-200">Need help?</p>
        <p className="text-xs text-slate-400 mt-1 leading-relaxed">
          Login issues, claim stuck, wrong data — message us anytime.
        </p>
        <Link
          href="/support"
          className="inline-flex mt-3 rounded-full bg-sky-600/90 px-4 py-2 text-[11px] font-bold text-white"
        >
          Contact support
        </Link>
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
