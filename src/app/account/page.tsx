"use client";

import { useEffect, useState, Suspense } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { User, Mail, Calendar, Edit2, Check, Lock } from "lucide-react";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { useAccount } from "@/components/AccountProvider";

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

type UserProfileData = {
  id: string;
  fullName: string;
  email: string;
  role: string;
  createdAt: string | null;
};

function AccountInner() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { role, isSuperadmin } = useAccount();
  const isCoach = role === "coach";
  const welcome = searchParams.get("welcome") === "1";
  const [email, setEmail] = useState<string | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfileData | null>(null);
  const [isEditingProfile, setIsEditingProfile] = useState(false);
  const [editName, setEditName] = useState("");
  const [editEmail, setEditEmail] = useState("");
  const [profileMsg, setProfileMsg] = useState<{
    type: "success" | "error";
    text: string;
  } | null>(null);
  const [profileSaving, setProfileSaving] = useState(false);

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
          router.replace(`/login?next=${encodeURIComponent("/account")}`);
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

        const prof: UserProfileData = data.user || data.profile || {
          id: session.user.id,
          fullName:
            (session.user.user_metadata?.full_name as string) ||
            (session.user.user_metadata?.handle as string) ||
            data.fullName ||
            "",
          email: session.user.email || data.email || "",
          role: data.role || "sailor",
          createdAt: session.user.created_at || null,
        };
        setUserProfile(prof);
        setEditName(prof.fullName || "");
        setEditEmail(prof.email || session.user.email || "");
      } catch (e) {
        setError(e instanceof Error ? e.message : "Error loading account");
      } finally {
        setLoading(false);
      }
    })();
  }, [router]);

  const saveProfileDetails = async (e: React.FormEvent) => {
    e.preventDefault();
    setProfileMsg(null);
    if (!editName.trim()) {
      setProfileMsg({ type: "error", text: "Please enter your name" });
      return;
    }
    if (!editEmail.trim() || !editEmail.includes("@")) {
      setProfileMsg({
        type: "error",
        text: "Please enter a valid email address",
      });
      return;
    }

    setProfileSaving(true);
    try {
      const res = await fetch("/api/account", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          fullName: editName.trim(),
          email: editEmail.trim(),
        }),
      });
      const resData = await res.json();
      if (!res.ok) {
        throw new Error(resData.error || "Failed to update profile");
      }

      const supabase = createBrowserSupabase();
      const updatePayload: { data: { full_name: string }; email?: string } = {
        data: { full_name: editName.trim() },
      };
      if (editEmail.trim().toLowerCase() !== email?.toLowerCase()) {
        updatePayload.email = editEmail.trim().toLowerCase();
      }
      const { error: sbErr } = await supabase.auth.updateUser(updatePayload);
      if (sbErr) {
        console.warn("[account] Supabase auth notice:", sbErr.message);
      }

      const updated: UserProfileData = resData.user || {
        id: userProfile?.id || "",
        fullName: editName.trim(),
        email: editEmail.trim(),
        role: userProfile?.role || "sailor",
        createdAt: userProfile?.createdAt || null,
      };
      setUserProfile(updated);
      setEmail(updated.email);
      setIsEditingProfile(false);

      const emailNotice = updatePayload.email
        ? "Profile updated! A confirmation link may have been sent to your new email to verify the address change."
        : "Profile details updated successfully!";
      setProfileMsg({ type: "success", text: emailNotice });
    } catch (err) {
      setProfileMsg({
        type: "error",
        text: err instanceof Error ? err.message : "Failed to update profile",
      });
    } finally {
      setProfileSaving(false);
    }
  };

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
          <span className="font-semibold text-slate-200">
            {userProfile?.fullName || email}
          </span>
          {userProfile?.fullName && email ? (
            <span className="text-slate-400"> ({email})</span>
          ) : null}
        </p>
      </div>

      {welcome && (
        <div className="rounded-2xl border border-emerald-500/25 bg-emerald-500/10 px-4 sm:px-5 py-4">
          <p className="text-sm font-bold text-emerald-200">
            {isCoach
              ? "Coach account approved — your dashboard is ready"
              : "Account created — next, claim your sailor profile"}
          </p>
          <p className="text-xs text-emerald-100/80 mt-1 leading-relaxed">
            {isCoach
              ? "Open the Coach Dashboard to create a squad and add sailors."
              : "Creating an account does not link a ranking profile yet. Search for your name, open the profile, and submit a claim."}
          </p>
        </div>
      )}

      {error && <p className="text-sm font-bold text-rose-400">{error}</p>}

      {/* User Account Profile Card (distinct from athlete sailor profile) */}
      <section className="glass-card rounded-3xl border border-white/10 bg-slate-900/60 p-5 sm:p-7 shadow-lg space-y-5">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-white/10 pb-5">
          <div className="flex items-center gap-3.5">
            <div className="flex h-12 w-12 sm:h-14 sm:w-14 items-center justify-center rounded-2xl bg-gradient-to-br from-orange-500/20 to-teal-500/20 border border-white/15 text-orange-400 shadow-inner shrink-0">
              <User className="h-6 w-6 sm:h-7 sm:w-7" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <span className="text-[10px] font-black uppercase tracking-widest text-orange-400">
                  User Account Profile
                </span>
                <span className="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-extrabold uppercase tracking-wide bg-white/10 text-slate-300 border border-white/10">
                  {userProfile?.role === "superadmin"
                    ? "Admin"
                    : userProfile?.role === "coach"
                    ? "Coach"
                    : userProfile?.role === "parent"
                    ? "Parent / Guardian"
                    : "Registered User"}
                </span>
              </div>
              <h2 className="text-xl sm:text-2xl font-black text-white tracking-tight mt-0.5">
                {userProfile?.fullName || "User Profile"}
              </h2>
              <p className="text-xs text-slate-400 mt-0.5">
                Your personal login account details — distinct from public athlete ranking profiles.
              </p>
            </div>
          </div>

          {!isEditingProfile && (
            <button
              type="button"
              onClick={() => {
                setEditName(userProfile?.fullName || "");
                setEditEmail(userProfile?.email || email || "");
                setProfileMsg(null);
                setIsEditingProfile(true);
              }}
              className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/10 hover:bg-white/15 px-4 py-2 text-xs font-bold text-white transition-colors self-start sm:self-center shadow-xs"
            >
              <Edit2 className="h-3.5 w-3.5 text-orange-400" />
              <span>Edit Details</span>
            </button>
          )}
        </div>

        {profileMsg && (
          <div
            className={`rounded-2xl p-4 text-xs font-medium border leading-relaxed ${
              profileMsg.type === "success"
                ? "bg-emerald-500/15 border-emerald-500/30 text-emerald-200"
                : "bg-rose-500/15 border-rose-500/30 text-rose-200"
            }`}
          >
            {profileMsg.text}
          </div>
        )}

        {isEditingProfile ? (
          <form onSubmit={saveProfileDetails} className="space-y-4 pt-1">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <label className="text-[11px] font-bold uppercase tracking-wider text-slate-400">
                  Full Name / Display Name
                </label>
                <div className="relative">
                  <User className="absolute left-3.5 top-3 h-4 w-4 text-slate-500" />
                  <input
                    type="text"
                    value={editName}
                    onChange={(e) => setEditName(e.target.value)}
                    placeholder="Enter your name"
                    required
                    className="w-full rounded-xl bg-slate-950 border border-white/15 pl-10 pr-3 py-2.5 text-sm text-white placeholder-slate-600 focus:border-orange-500 focus:outline-none"
                  />
                </div>
              </div>

              <div className="space-y-1.5">
                <label className="text-[11px] font-bold uppercase tracking-wider text-slate-400">
                  Email Address
                </label>
                <div className="relative">
                  <Mail className="absolute left-3.5 top-3 h-4 w-4 text-slate-500" />
                  <input
                    type="email"
                    value={editEmail}
                    onChange={(e) => setEditEmail(e.target.value)}
                    placeholder="name@example.com"
                    required
                    className="w-full rounded-xl bg-slate-950 border border-white/15 pl-10 pr-3 py-2.5 text-sm text-white placeholder-slate-600 focus:border-orange-500 focus:outline-none"
                  />
                </div>
              </div>
            </div>

            <div className="flex items-center gap-2.5 pt-2">
              <button
                type="submit"
                disabled={profileSaving}
                className="inline-flex items-center gap-1.5 rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2 text-xs font-bold text-white transition-colors disabled:opacity-50 shadow-sm"
              >
                <Check className="h-3.5 w-3.5" />
                <span>{profileSaving ? "Saving changes…" : "Save changes"}</span>
              </button>
              <button
                type="button"
                disabled={profileSaving}
                onClick={() => {
                  setIsEditingProfile(false);
                  setProfileMsg(null);
                }}
                className="rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-300 transition-colors"
              >
                Cancel
              </button>
            </div>
          </form>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3.5 text-xs">
            <div className="rounded-2xl border border-white/5 bg-slate-950/50 p-4 space-y-1">
              <div className="flex items-center gap-1.5 text-slate-500 text-[10px] font-bold uppercase tracking-wider">
                <User className="h-3 w-3 text-orange-400" />
                <span>Full Name</span>
              </div>
              <p className="text-sm font-black text-white">
                {userProfile?.fullName || "Not set"}
              </p>
            </div>

            <div className="rounded-2xl border border-white/5 bg-slate-950/50 p-4 space-y-1 min-w-0">
              <div className="flex items-center gap-1.5 text-slate-500 text-[10px] font-bold uppercase tracking-wider">
                <Mail className="h-3 w-3 text-teal-400" />
                <span>Email Address</span>
              </div>
              <p className="text-sm font-bold text-slate-200 truncate">
                {userProfile?.email || email}
              </p>
            </div>

            <div className="rounded-2xl border border-white/5 bg-slate-950/50 p-4 space-y-1">
              <div className="flex items-center gap-1.5 text-slate-500 text-[10px] font-bold uppercase tracking-wider">
                <Calendar className="h-3 w-3 text-sky-400" />
                <span>Member Since</span>
              </div>
              <p className="text-sm font-bold text-slate-300">
                {userProfile?.createdAt
                  ? new Date(userProfile.createdAt).toLocaleDateString("en-SG", {
                      month: "short",
                      year: "numeric",
                    })
                  : "Active Member"}
              </p>
            </div>
          </div>
        )}
      </section>

      {isCoach && (
        <section className="rounded-2xl border border-orange-500/25 bg-orange-500/[0.07] p-5 sm:p-6 space-y-3 w-full">
          <h2 className="text-sm font-black text-white uppercase tracking-wider">
            Coach dashboard
          </h2>
          <p className="text-xs text-slate-400 leading-relaxed">
            Manage your private squad roster and review live rankings and regatta results.
          </p>
          <Link
            href="/coach-tools"
            className="inline-flex rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-[11px] font-bold text-white"
          >
            Open Coach Dashboard
          </Link>
        </section>
      )}

      {!isCoach && !isSuperadmin && (
        <section className="rounded-2xl border border-sky-500/20 bg-sky-500/[0.06] p-5 sm:p-6 space-y-3 w-full">
          <h2 className="text-sm font-black text-white uppercase tracking-wider">
            Are you a coach?
          </h2>
          <p className="text-xs text-slate-400 leading-relaxed">
            Request coach access for this account. An admin will review it before
            the private squad dashboard is enabled.
          </p>
          <Link
            href="/coach-tools"
            className="inline-flex rounded-full bg-sky-600 hover:bg-sky-500 px-4 py-2 text-[11px] font-bold text-white"
          >
            Request coach access
          </Link>
        </section>
      )}

      {isSuperadmin && (
        <section className="glass-card rounded-2xl border border-orange-500/20 bg-orange-500/5 p-5 sm:p-6 space-y-3 w-full">
          <h2 className="text-sm font-black text-white uppercase tracking-wider">
            Superadmin
          </h2>
          <p className="text-xs text-slate-400 leading-relaxed">
            Full console access. Owner tools only apply on profiles linked to
            this account — not every athlete.
          </p>
          <a
            href="https://admin.sailorpath.com/"
            className="inline-flex rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white hover:bg-orange-500"
          >
            Open admin console
          </a>
        </section>
      )}

      {!isCoach && (
      <section className="rounded-2xl border border-emerald-500/20 bg-emerald-500/[0.06] p-5 sm:p-6 space-y-3 w-full">
        <h2 className="text-sm font-black text-white uppercase tracking-wider">
          Parent / family dashboard
        </h2>
        <p className="text-xs text-slate-400 leading-relaxed">
          Rankings snapshot, linked athletes, and claim status in one place.
        </p>
        <Link
          href="/parent"
          className="inline-flex rounded-full bg-emerald-600 hover:bg-emerald-500 px-4 py-2 text-[11px] font-bold text-white"
        >
          Open dashboard
        </Link>
      </section>
      )}

      {/* Managed profiles */}
      {!isCoach && (
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
                  href={`/${s.handle}`}
                  className="rounded-full bg-orange-600/90 px-4 py-2 text-[11px] font-bold text-white text-center hover:bg-orange-500 shrink-0"
                >
                  Open profile
                </Link>
              </li>
            ))}
          </ul>
        )}
      </section>
      )}

      {/* Account security */}
      <section className="glass-card rounded-2xl border border-white/5 p-5 sm:p-6 space-y-4 w-full">
        <div className="flex items-center gap-2">
          <Lock className="h-4 w-4 text-orange-400" />
          <h2 className="text-sm font-black text-white uppercase tracking-wider">
            Account Security &amp; Password
          </h2>
        </div>
        <form onSubmit={changePassword} className="space-y-3">
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
      {!isCoach && (
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
      )}

      {/* How to claim — only if no owned */}
      {!isCoach && owned.length === 0 && (
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
              and add a short note to help us review the claim.
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
