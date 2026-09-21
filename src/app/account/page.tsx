"use client";

import { useEffect, useState, Suspense } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { User, Mail, Calendar, Edit2, Check, Lock, Trophy, ArrowRight, ExternalLink } from "lucide-react";
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
      <div className="min-h-[50vh] flex items-center justify-center text-sm text-[var(--sp-slate-soft)] px-4">
        Loading account…
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      <div>
        <h1 className="font-display text-2xl sm:text-3xl font-bold text-[var(--sp-harbour-teal)] tracking-tight">
          My account
        </h1>
        <p className="mt-1 text-sm text-[var(--sp-slate-soft)] break-all">
          Signed in as{" "}
          <span className="font-semibold text-[var(--sp-charcoal)]">
            {userProfile?.fullName || email}
          </span>
          {userProfile?.fullName && email ? (
            <span className="text-[var(--sp-slate-soft)]"> ({email})</span>
          ) : null}
        </p>
      </div>

      {welcome && (
        <div className="rounded-2xl border border-emerald-300 bg-emerald-50/90 px-4 sm:px-5 py-4">
          <p className="text-sm font-bold text-emerald-950">
            {isCoach
              ? "Coach account approved — your dashboard is ready"
              : "Account created — next, claim your sailor profile"}
          </p>
          <p className="text-xs text-emerald-900/80 mt-1 leading-relaxed">
            {isCoach
              ? "Open the Coach Dashboard to create a squad and add sailors."
              : "Creating an account does not link a ranking profile yet. Search for your name, open the profile, and submit a claim."}
          </p>
        </div>
      )}

      {error && (
        <div className="rounded-2xl border border-rose-200 bg-rose-50 p-4 text-xs font-semibold text-rose-800">
          {error}
        </div>
      )}

      {/* User Account Profile Card (distinct from athlete sailor profile) */}
      <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-7 shadow-xs space-y-5">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-[var(--sp-cool-veil)] pb-5">
          <div className="flex items-center gap-3.5">
            <div className="flex h-12 w-12 sm:h-14 sm:w-14 items-center justify-center rounded-2xl bg-[var(--sp-racing-mist)]/30 border border-[var(--sp-racing-orange)]/25 text-[var(--sp-racing-orange)] shadow-2xs shrink-0">
              <User className="h-6 w-6 sm:h-7 sm:w-7" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <span className="text-[10px] font-bold uppercase tracking-widest text-[var(--sp-racing-orange)]">
                  User Account Profile
                </span>
                <span className="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wide bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] border border-[var(--sp-cool-veil)]">
                  {userProfile?.role === "superadmin"
                    ? "Admin"
                    : userProfile?.role === "coach"
                    ? "Coach"
                    : userProfile?.role === "parent"
                    ? "Parent / Guardian"
                    : "Registered User"}
                </span>
              </div>
              <h2 className="text-xl sm:text-2xl font-bold text-[var(--sp-charcoal)] tracking-tight mt-0.5">
                {userProfile?.fullName || "User Profile"}
              </h2>
              <p className="text-xs text-[var(--sp-slate-soft)] mt-0.5">
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
              className="inline-flex items-center gap-2 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-teal)] transition-colors self-start sm:self-center shadow-2xs"
            >
              <Edit2 className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
              <span>Edit Details</span>
            </button>
          )}
        </div>

        {profileMsg && (
          <div
            className={`rounded-2xl p-4 text-xs font-semibold border leading-relaxed ${
              profileMsg.type === "success"
                ? "bg-emerald-50 border-emerald-200 text-emerald-900"
                : "bg-rose-50 border-rose-200 text-rose-900"
            }`}
          >
            {profileMsg.text}
          </div>
        )}

        {isEditingProfile ? (
          <form onSubmit={saveProfileDetails} className="space-y-4 pt-1">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <label className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
                  Full Name / Display Name
                </label>
                <div className="relative">
                  <User className="absolute left-3.5 top-3 h-4 w-4 text-[var(--sp-slate-soft)]" />
                  <input
                    type="text"
                    value={editName}
                    onChange={(e) => setEditName(e.target.value)}
                    placeholder="Enter your name"
                    required
                    className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] pl-10 pr-3 py-2.5 text-sm text-[var(--sp-charcoal)] placeholder-slate-400 focus:border-[var(--sp-harbour-teal)] focus:ring-2 focus:ring-[var(--sp-harbour-teal)]/20 focus:outline-none"
                  />
                </div>
              </div>

              <div className="space-y-1.5">
                <label className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
                  Email Address
                </label>
                <div className="relative">
                  <Mail className="absolute left-3.5 top-3 h-4 w-4 text-[var(--sp-slate-soft)]" />
                  <input
                    type="email"
                    value={editEmail}
                    onChange={(e) => setEditEmail(e.target.value)}
                    placeholder="name@example.com"
                    required
                    className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] pl-10 pr-3 py-2.5 text-sm text-[var(--sp-charcoal)] placeholder-slate-400 focus:border-[var(--sp-harbour-teal)] focus:ring-2 focus:ring-[var(--sp-harbour-teal)]/20 focus:outline-none"
                  />
                </div>
              </div>
            </div>

            <div className="flex items-center gap-2.5 pt-2">
              <button
                type="submit"
                disabled={profileSaving}
                className="inline-flex items-center gap-1.5 rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] px-5 py-2.5 text-[15px] font-semibold text-white transition-colors disabled:opacity-50 shadow-xs"
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
                className="rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-semibold text-[var(--sp-slate-soft)] transition-colors shadow-2xs"
              >
                Cancel
              </button>
            </div>
          </form>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3.5 text-xs">
            <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/70 p-4 space-y-1">
              <div className="flex items-center gap-1.5 text-[var(--sp-slate-soft)] text-[10px] font-bold uppercase tracking-wider">
                <User className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
                <span>Full Name</span>
              </div>
              <p className="text-sm font-bold text-[var(--sp-charcoal)]">
                {userProfile?.fullName || "Not set"}
              </p>
            </div>

            <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/70 p-4 space-y-1 min-w-0">
              <div className="flex items-center gap-1.5 text-[var(--sp-slate-soft)] text-[10px] font-bold uppercase tracking-wider">
                <Mail className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                <span>Email Address</span>
              </div>
              <p className="text-sm font-bold text-[var(--sp-charcoal)] truncate">
                {userProfile?.email || email}
              </p>
            </div>

            <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/70 p-4 space-y-1">
              <div className="flex items-center gap-1.5 text-[var(--sp-slate-soft)] text-[10px] font-bold uppercase tracking-wider">
                <Calendar className="h-3.5 w-3.5 text-[var(--sp-harbour-mid)]" />
                <span>Member Since</span>
              </div>
              <p className="text-sm font-bold text-[var(--sp-charcoal)]">
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

      {/* Athlete Hub & Logbook Card */}
      <section className="rounded-3xl border border-[var(--sp-racing-orange)]/25 bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
        <div className="flex items-center justify-between gap-3">
          <div className="flex items-center gap-2">
            <Trophy className="h-4 w-4 text-[var(--sp-racing-orange)]" />
            <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
              Athlete Hub &amp; Logbook
            </h2>
          </div>
          <span className="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wide bg-[var(--sp-racing-mist)]/30 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/30">
            Sailor Tools
          </span>
        </div>
        <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
          Log non-ranking &amp; overseas regatta results, attach official evidence documents, and manage your equipment locker.
        </p>
        <div>
          <Link
            href="/athlete"
            className="inline-flex items-center gap-1.5 rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] px-5 py-2.5 text-[15px] font-semibold text-white transition-colors shadow-xs"
          >
            <span>Open Athlete Hub</span>
            <ArrowRight className="h-3.5 w-3.5" />
          </Link>
        </div>
      </section>

      {isCoach && (
        <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
          <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
            Coach dashboard
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
            Manage your private squad roster and review live rankings and regatta results.
          </p>
          <Link
            href="/coach-tools"
            className="inline-flex items-center gap-1.5 rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-shadow)] px-5 py-2.5 text-[15px] font-semibold text-white transition-colors shadow-xs"
          >
            <span>Open Coach Dashboard</span>
            <ArrowRight className="h-3.5 w-3.5" />
          </Link>
        </section>
      )}

      {!isCoach && !isSuperadmin && (
        <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
          <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
            Are you a coach?
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
            Request coach access for this account. An admin will review it before
            the private squad dashboard is enabled.
          </p>
          <Link
            href="/coach-tools"
            className="inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-teal)] transition-colors shadow-2xs"
          >
            <span>Request coach access</span>
          </Link>
        </section>
      )}

      {isSuperadmin && (
        <section className="rounded-3xl border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
          <h2 className="text-sm font-bold text-[var(--sp-racing-orange)] uppercase tracking-wider">
            Superadmin
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
            Full console access. Owner tools only apply on profiles linked to
            this account — not every athlete.
          </p>
          <a
            href="https://admin.sailorpath.com/"
            className="inline-flex items-center gap-1.5 rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] px-5 py-2.5 text-[15px] font-semibold text-white transition-colors shadow-xs"
          >
            <span>Open admin console</span>
            <ExternalLink className="h-3.5 w-3.5" />
          </a>
        </section>
      )}

      {!isCoach && (
        <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
          <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
            Parent / family dashboard
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
            Rankings snapshot, linked athletes, and claim status in one place.
          </p>
          <Link
            href="/parent"
            className="inline-flex items-center gap-1.5 rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-shadow)] px-5 py-2.5 text-[15px] font-semibold text-white transition-colors shadow-xs"
          >
            <span>Open parent dashboard</span>
            <ArrowRight className="h-3.5 w-3.5" />
          </Link>
        </section>
      )}

      {/* Managed profiles */}
      {!isCoach && (
        <section
          id="profiles"
          className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs"
        >
          <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
            Profiles you manage
          </h2>
          {owned.length === 0 ? (
            <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
              None yet. After a claim is approved, your sailor profile appears
              here. Use{" "}
              <Link href="/search" className="text-[var(--sp-harbour-teal)] font-semibold hover:underline">
                Search
              </Link>{" "}
              to find yourself and claim.
            </p>
          ) : (
            <ul className="divide-y divide-[var(--sp-cool-veil)]">
              {owned.map((s) => (
                <li
                  key={s.id}
                  className="py-3.5 flex flex-col sm:flex-row sm:items-center justify-between gap-2"
                >
                  <div className="min-w-0">
                    <p className="text-sm font-bold text-[var(--sp-charcoal)]">{s.name}</p>
                    <p className="text-[11px] text-[var(--sp-slate-soft)] truncate">
                      {s.sailNumber} · {s.club} · /{s.handle}
                    </p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Link
                      href={`/athlete?id=${s.id}`}
                      className="rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-3.5 py-1.5 text-xs font-semibold text-[var(--sp-harbour-teal)] text-center transition-colors shadow-2xs shrink-0"
                    >
                      Manage &amp; Log
                    </Link>
                    <Link
                      href={`/${s.handle}`}
                      className="rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-shadow)] px-3.5 py-1.5 text-xs font-semibold text-white text-center transition-colors shadow-2xs shrink-0"
                    >
                      Public profile
                    </Link>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </section>
      )}

      {/* Account security */}
      <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-4 w-full shadow-xs">
        <div className="flex items-center gap-2">
          <Lock className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
          <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
            Account Security &amp; Password
          </h2>
        </div>
        <form onSubmit={changePassword} className="space-y-3">
          <p className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Change password
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <input
              type="password"
              value={pw}
              onChange={(e) => setPw(e.target.value)}
              placeholder="New password (min 6)"
              autoComplete="new-password"
              className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2.5 text-sm text-[var(--sp-charcoal)] placeholder-slate-400 focus:border-[var(--sp-harbour-teal)] focus:ring-2 focus:ring-[var(--sp-harbour-teal)]/20 focus:outline-none"
            />
            <input
              type="password"
              value={pw2}
              onChange={(e) => setPw2(e.target.value)}
              placeholder="Confirm password"
              autoComplete="new-password"
              className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2.5 text-sm text-[var(--sp-charcoal)] placeholder-slate-400 focus:border-[var(--sp-harbour-teal)] focus:ring-2 focus:ring-[var(--sp-harbour-teal)]/20 focus:outline-none"
            />
          </div>
          <div className="flex items-center gap-3 pt-1">
            <button
              type="submit"
              disabled={pwBusy}
              className="rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-teal)] transition-colors disabled:opacity-50 shadow-2xs"
            >
              {pwBusy ? "Updating…" : "Update password"}
            </button>
            {pwMsg && (
              <p className="text-xs text-emerald-800 font-semibold">{pwMsg}</p>
            )}
          </div>
        </form>
      </section>

      {/* Claims */}
      {!isCoach && (
        <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
          <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
            Claim requests
          </h2>
          {claims.length === 0 ? (
            <p className="text-xs text-[var(--sp-slate-soft)]">
              No claim requests yet.{" "}
              <Link href="/search" className="text-[var(--sp-harbour-teal)] font-semibold hover:underline">
                Search for your profile
              </Link>
              .
            </p>
          ) : (
            <ul className="divide-y divide-[var(--sp-cool-veil)]">
              {claims.map((c) => (
                <li
                  key={c.id}
                  className="py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs"
                >
                  <div>
                    <p className="font-bold text-[var(--sp-charcoal)]">{c.sailorName}</p>
                    <Link
                      href={`/${c.sailorHandle}`}
                      className="text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-teal)]"
                    >
                      /{c.sailorHandle}
                    </Link>
                  </div>
                  <span
                    className={`self-start rounded-full px-2.5 py-0.5 text-[10px] font-bold uppercase tracking-wider ${
                      c.status === "approved"
                        ? "bg-emerald-50 text-emerald-800 border border-emerald-200"
                        : c.status === "rejected"
                          ? "bg-rose-50 text-rose-800 border border-rose-200"
                          : "bg-amber-50 text-amber-800 border border-amber-200"
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
        <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
          <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
            How to claim a profile
          </h2>
          <ol className="space-y-2 text-xs text-[var(--sp-slate-soft)] font-medium list-decimal list-inside leading-relaxed">
            <li>
              Find yourself on{" "}
              <Link href="/search" className="text-[var(--sp-harbour-teal)] font-semibold hover:underline">
                Search
              </Link>
              .
            </li>
            <li>Open your public sailor page.</li>
            <li>
              Click <strong className="text-[var(--sp-charcoal)] font-bold">Claim this profile</strong>{" "}
              and add a short note to help us review the claim.
            </li>
            <li>Wait for admin approval — then use your Athlete Hub to manage results.</li>
          </ol>
        </section>
      )}

      <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/60 p-5 sm:p-6 w-full space-y-2">
        <p className="text-sm font-bold text-[var(--sp-harbour-teal)]">Need help?</p>
        <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
          Login issues, claim stuck, wrong data — message us anytime.
        </p>
        <Link
          href="/support"
          className="inline-flex mt-2 rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-shadow)] px-4 py-2 text-xs font-semibold text-white transition-colors shadow-xs"
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
