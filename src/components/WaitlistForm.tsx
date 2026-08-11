"use client";

import { useState } from "react";

const ROLES = [
  "Sailor",
  "Parent",
  "Coach",
  "Club/Association",
] as const;

export function WaitlistForm() {
  const [email, setEmail] = useState("");
  const [role, setRole] = useState<(typeof ROLES)[number] | "">("");
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);

  const submit = async (e: React.FormEvent) => {
    e.preventDefault();
    setBusy(true);
    setMsg(null);
    setErr(null);
    try {
      const res = await fetch("/api/support", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          email,
          topic: "waitlist",
          name: role || null,
          body: `Early access waitlist signup. Role: ${role || "not specified"}.`,
          pageUrl:
            typeof window !== "undefined" ? window.location.href : "/#roadmap",
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not join waitlist");
      setMsg(data.message || "You're on the list — we'll be in touch.");
      setEmail("");
      setRole("");
    } catch (ex) {
      setErr(ex instanceof Error ? ex.message : "Something went wrong");
    } finally {
      setBusy(false);
    }
  };

  return (
    <form
      onSubmit={(e) => void submit(e)}
      className="mt-6 mx-auto max-w-md space-y-3 text-left"
    >
      <label className="block text-[11px] font-bold uppercase tracking-wide text-slate-500">
        Email
        <input
          type="email"
          required
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="you@email.com"
          className="mt-1 w-full rounded-xl border border-white/10 bg-black/40 px-3 py-2.5 text-sm text-white placeholder:text-slate-600 focus:border-orange-500/50 focus:outline-none"
        />
      </label>
      <label className="block text-[11px] font-bold uppercase tracking-wide text-slate-500">
        I am a…
        <select
          required
          value={role}
          onChange={(e) =>
            setRole(e.target.value as (typeof ROLES)[number] | "")
          }
          className="mt-1 w-full rounded-xl border border-white/10 bg-black/40 px-3 py-2.5 text-sm text-white focus:border-orange-500/50 focus:outline-none"
        >
          <option value="" disabled>
            Select…
          </option>
          {ROLES.map((r) => (
            <option key={r} value={r}>
              {r}
            </option>
          ))}
        </select>
      </label>
      <button
        type="submit"
        disabled={busy}
        className="w-full rounded-full bg-orange-600 hover:bg-orange-500 disabled:opacity-50 px-5 py-3 text-xs font-black uppercase tracking-wider text-white"
      >
        {busy ? "Submitting…" : "Get Early Access"}
      </button>
      {msg && (
        <p className="text-center text-[12px] text-emerald-400 font-medium">
          {msg}
        </p>
      )}
      {err && (
        <p className="text-center text-[12px] text-rose-400 font-medium">
          {err}
        </p>
      )}
    </form>
  );
}
