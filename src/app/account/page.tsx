"use client";

import { useEffect, useId, useRef, useState, Suspense } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import {
  User,
  Mail,
  Calendar,
  Edit2,
  Check,
  Lock,
  LogOut,
  ChevronDown,
  Eye,
  EyeOff,
  Compass,
  Clock,
} from "lucide-react";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { useAccount } from "@/components/AccountProvider";
import { AccountWorkspaces } from "@/components/account/AccountWorkspaces";
import {
  SailorInviteAccept,
  type SailorInviteClaim,
} from "@/components/account/SailorInviteAccept";
import {
  TelegramAccountSection,
  type TelegramAccountStatus,
} from "@/components/account/TelegramAccountSection";
import {
  GoogleAccountSection,
  type GoogleAccountStatus,
} from "@/components/account/GoogleAccountSection";
import {
  TelegramUpdatesSection,
  type TelegramUpdatesStatus,
} from "@/components/account/TelegramUpdatesSection";
import { GOOGLE_ACCOUNT_NOTICES } from "@/lib/google/messages";
import { TELEGRAM_ACCOUNT_NOTICES } from "@/lib/telegram/messages";

type Owned = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  club: string;
  ownerRelation?: string | null;
};

type Claim = {
  id: string;
  status: string;
  sailorName: string;
  sailorHandle: string;
  createdAt: string;
  source?: string | null;
  relation?: string | null;
};

type UserProfileData = {
  id: string;
  fullName: string;
  email: string;
  role: string;
  createdAt: string | null;
  notifyFollowedResults?: boolean;
};

function initialsFor(name: string): string {
  const parts = name.trim().split(/\s+/).filter(Boolean);
  if (parts.length === 0) return "SP";
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
  return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
}

function formatClaimDate(value?: string | null): string | null {
  if (!value) return null;
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return null;
  return date.toLocaleDateString("en-SG", {
    day: "numeric",
    month: "short",
    year: "numeric",
  });
}

function roleLabel(role?: string | null): string {
  if (role === "superadmin") return "Admin";
  if (role === "coach") return "Coach";
  if (role === "parent") return "Parent / Guardian";
  return "Sailor account";
}

function relationBadge(relation?: string | null): string {
  if (relation === "parent") return "Parent / Guardian";
  if (relation === "sailor") return "Self";
  return "Managed";
}

function AccountSkeleton() {
  return (
    <div
      className="mx-auto max-w-3xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8 animate-pulse"
      aria-busy="true"
      aria-label="Loading account"
    >
      <div className="flex items-start justify-between gap-4">
        <div className="space-y-2">
          <div className="h-8 w-44 rounded-xl bg-cool-veil/70" />
          <div className="h-4 w-64 rounded-lg bg-cool-veil/60" />
        </div>
        <div className="h-10 w-24 rounded-full bg-cool-veil/70" />
      </div>
      <div className="space-y-3">
        <div className="h-6 w-48 rounded-lg bg-cool-veil/70" />
        <div className="grid gap-3 sm:grid-cols-2">
          <div className="h-28 rounded-2xl border border-cool-veil bg-warm-white" />
          <div className="h-28 rounded-2xl border border-cool-veil bg-warm-white" />
        </div>
      </div>
      <div className="h-40 rounded-3xl border border-cool-veil bg-warm-white" />
      <div className="h-16 rounded-3xl border border-cool-veil bg-warm-white" />
    </div>
  );
}

function AccountInner() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { role, isSuperadmin, signOut } = useAccount();
  const isCoach = role === "coach";
  const welcome = searchParams.get("welcome") === "1";

  const nameId = useId();
  const emailId = useId();
  const pwId = useId();
  const pw2Id = useId();
  const pwHintId = useId();
  const pwErrId = useId();

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
  const [notifyFollowed, setNotifyFollowed] = useState(true);
  const [notifyBusy, setNotifyBusy] = useState(false);
  const [notifyMsg, setNotifyMsg] = useState<{
    type: "success" | "error";
    text: string;
  } | null>(null);

  const settingsRef = useRef<HTMLDetailsElement>(null);
  const [pw, setPw] = useState("");
  const [pw2, setPw2] = useState("");
  const [showPw, setShowPw] = useState(false);
  const [pwMsg, setPwMsg] = useState<{
    type: "success" | "error";
    text: string;
    field?: "pw" | "pw2";
  } | null>(null);
  const [pwBusy, setPwBusy] = useState(false);
  const [claimBusy, setClaimBusy] = useState<string | null>(null);
  const [claimMsg, setClaimMsg] = useState<string | null>(null);
  const [telegram, setTelegram] = useState<TelegramAccountStatus | null>(null);
  const [google, setGoogle] = useState<GoogleAccountStatus | null>(null);
  const [telegramUpdates, setTelegramUpdates] = useState<TelegramUpdatesStatus | null>(null);

  useEffect(() => {
    if (loading) return;
    if (
      searchParams.get("telegram") ||
      searchParams.get("google") ||
      (typeof window !== "undefined" && window.location.hash === "#settings")
    ) {
      settingsRef.current?.setAttribute("open", "");
    }
  }, [searchParams, loading]);

  useEffect(() => {
    (async () => {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (!session) {
          const params = searchParams.toString();
          const next = params ? `/account?${params}` : "/account";
          router.replace(`/login?next=${encodeURIComponent(next)}`);
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
        const contact =
          typeof data.email === "string"
            ? data.email
            : typeof data.user?.email === "string"
              ? data.user.email
              : session.user.email || "";
        setEmail(contact || null);
        if (data.telegram && typeof data.telegram === "object") {
          setTelegram({
            enabled: Boolean(data.telegram.enabled),
            linked: Boolean(data.telegram.linked),
            username: typeof data.telegram.username === "string" ? data.telegram.username : null,
            canDisconnect: Boolean(data.telegram.canDisconnect),
          });
        }
        if (data.google && typeof data.google === "object") {
          setGoogle({
            enabled: Boolean(data.google.enabled),
            linked: Boolean(data.google.linked),
          });
        }
        if (data.telegramUpdates && typeof data.telegramUpdates === "object") {
          setTelegramUpdates({
            enabled: Boolean(data.telegramUpdates.enabled),
            optedIn: Boolean(data.telegramUpdates.optedIn),
            username:
              typeof data.telegramUpdates.username === "string" ? data.telegramUpdates.username : null,
          });
        }

        const prof: UserProfileData = data.user || data.profile || {
          id: session.user.id,
          fullName:
            (session.user.user_metadata?.full_name as string) ||
            (session.user.user_metadata?.handle as string) ||
            data.fullName ||
            "",
          email: contact,
          role: data.role || "sailor",
          createdAt: session.user.created_at || null,
        };
        if (data.user) prof.email = contact;
        setUserProfile(prof);
        setNotifyFollowed(data.user?.notifyFollowedResults !== false);
        setEditName(prof.fullName || "");
        setEditEmail(prof.email || "");
      } catch (e) {
        setError(e instanceof Error ? e.message : "Error loading account");
      } finally {
        setLoading(false);
      }
    })();
  }, [router, searchParams]);

  const respondToInvite = async (
    claim: SailorInviteClaim,
    action: "accept" | "decline"
  ) => {
    setClaimBusy(claim.id);
    setClaimMsg(null);
    try {
      const res = await fetch("/api/account/sailor-invites", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: claim.id, action }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw new Error(data.error || "Could not update the request");
      const accountRes = await fetch("/api/account", { credentials: "include" });
      const account = await accountRes.json();
      if (accountRes.ok) {
        setOwned(account.owned || []);
        setClaims(account.claims || []);
      } else {
        setClaims((prev) =>
          prev.map((row) =>
            row.id === claim.id
              ? { ...row, status: action === "accept" ? "approved" : "rejected" }
              : row
          )
        );
      }
      setClaimMsg(
        action === "accept"
          ? `You accepted the link to ${claim.sailorName}.`
          : `You declined the link to ${claim.sailorName}.`
      );
    } catch (e) {
      setClaimMsg(e instanceof Error ? e.message : "Could not update the request");
    } finally {
      setClaimBusy(null);
    }
  };

  const saveProfileDetails = async (e: React.FormEvent) => {
    e.preventDefault();
    setProfileMsg(null);
    if (!editName.trim()) {
      setProfileMsg({ type: "error", text: "Please enter your name." });
      return;
    }
    if (editEmail.trim() && !editEmail.includes("@")) {
      setProfileMsg({
        type: "error",
        text: "Please enter a valid email address.",
      });
      return;
    }
    if (!editEmail.trim() && (userProfile?.email || email)) {
      setProfileMsg({
        type: "error",
        text: "Please enter a valid email address.",
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
          ...(editEmail.trim() ? { email: editEmail.trim() } : {}),
        }),
      });
      const resData = await res.json();
      if (!res.ok) {
        throw new Error(resData.error || "Failed to update profile");
      }

      const supabase = createBrowserSupabase();
      const trimmedEmail = editEmail.trim().toLowerCase();
      const emailChanged =
        Boolean(trimmedEmail) && trimmedEmail !== (email || "").toLowerCase();
      const updatePayload: { data: { full_name: string }; email?: string } = {
        data: { full_name: editName.trim() },
      };
      if (emailChanged) {
        updatePayload.email = trimmedEmail;
      }
      const { error: sbErr } = await supabase.auth.updateUser(updatePayload);
      if (sbErr && emailChanged) {
        setProfileMsg({
          type: "error",
          text: `Your display name was saved, but the login email change could not be completed: ${sbErr.message}`,
        });
        return;
      }

      const updated: UserProfileData = resData.user || {
        id: userProfile?.id || "",
        fullName: editName.trim(),
        email: editEmail.trim(),
        role: userProfile?.role || "sailor",
        createdAt: userProfile?.createdAt || null,
      };
      setUserProfile(updated);
      setEmail(updated.email || null);
      setIsEditingProfile(false);

      const emailNotice = updatePayload.email
        ? "Profile updated! Check your new inbox for a confirmation link to finish changing your login email."
        : "Profile details updated.";
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

  const saveNotifyPreference = async (next: boolean) => {
    setNotifyFollowed(next);
    setNotifyMsg(null);
    setNotifyBusy(true);
    try {
      const res = await fetch("/api/account", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ notifyFollowedResults: next }),
      });
      const resData = await res.json();
      if (!res.ok) throw new Error(resData.error || "Could not save preference");
      setNotifyFollowed(resData.user?.notifyFollowedResults !== false);
      setNotifyMsg({
        type: "success",
        text: next ? "Follow notification emails are on." : "Follow notification emails are off.",
      });
    } catch (err) {
      setNotifyFollowed(!next);
      setNotifyMsg({
        type: "error",
        text: err instanceof Error ? err.message : "Could not save preference",
      });
    } finally {
      setNotifyBusy(false);
    }
  };

  const changePassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setPwMsg(null);
    if (pw.length < 6) {
      setPwMsg({
        type: "error",
        text: "Password must be at least 6 characters.",
        field: "pw",
      });
      return;
    }
    if (pw !== pw2) {
      setPwMsg({
        type: "error",
        text: "Passwords do not match.",
        field: "pw2",
      });
      return;
    }
    setPwBusy(true);
    try {
      const supabase = createBrowserSupabase();
      const { error: err } = await supabase.auth.updateUser({ password: pw });
      if (err) throw err;
      setPwMsg({ type: "success", text: "Password updated." });
      setPw("");
      setPw2("");
    } catch (err) {
      setPwMsg({
        type: "error",
        text: err instanceof Error ? err.message : "Could not update password.",
      });
    } finally {
      setPwBusy(false);
    }
  };

  const handleSignOut = async () => {
    if (signOut) {
      await signOut();
      return;
    }
    try {
      await createBrowserSupabase().auth.signOut();
    } catch {
      /* ignore */
    }
    router.replace("/");
  };

  if (loading) {
    return <AccountSkeleton />;
  }

  // Pending admin invites are already surfaced prominently in SailorInviteAccept.
  const visibleClaims = claims.filter(
    (c) => !(c.status === "pending" && c.source === "admin")
  );
  const displayRole = userProfile?.role || role;
  const isParentWorkspace =
    role === "parent" || owned.some((sailor) => sailor.ownerRelation === "parent");

  return (
    <div className="mx-auto max-w-3xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div className="min-w-0">
          <div className="flex flex-wrap items-center gap-2.5">
            <h1 className="font-display text-2xl sm:text-3xl font-bold text-harbour tracking-tight">
              My account
            </h1>
            <span className="inline-flex items-center rounded-full border border-cool-veil bg-warm-white px-2.5 py-0.5 text-xs font-semibold text-charcoal">
              {roleLabel(displayRole)}
            </span>
          </div>
          <p className="mt-1.5 text-sm text-slate-soft break-words">
            Signed in as{" "}
            <span className="font-semibold text-charcoal">
              {userProfile?.fullName || email || "Telegram member"}
            </span>
            {userProfile?.fullName && email ? (
              <span className="text-slate-soft"> · {email}</span>
            ) : null}
          </p>
        </div>
        <button
          type="button"
          onClick={() => void handleSignOut()}
          className="inline-flex min-h-11 shrink-0 items-center justify-center gap-2 self-start rounded-full border border-cool-veil bg-warm-white px-4 py-2 text-xs font-semibold text-charcoal shadow-2xs transition-colors hover:border-rose-300 hover:bg-rose-50 hover:text-rose-800 cursor-pointer"
        >
          <LogOut className="h-3.5 w-3.5" aria-hidden="true" />
          Log out
        </button>
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
              ? "Open the Squad dashboard to create a squad and add sailors."
              : "Creating an account does not link a ranking profile yet. Search for your name, open the profile, and submit a claim."}
          </p>
        </div>
      )}

      {error && (
        <div
          role="alert"
          className="rounded-2xl border border-rose-200 bg-rose-50 p-4 text-xs font-semibold text-rose-800"
        >
          {error}
        </div>
      )}

      <SailorInviteAccept
        claims={claims}
        inviteId={searchParams.get("invite")}
        claimMsg={claimMsg}
        claimBusy={claimBusy}
        onRespond={respondToInvite}
      />

      <AccountWorkspaces
        isCoach={isCoach}
        isParent={isParentWorkspace}
        isSuperadmin={isSuperadmin}
        ownedCount={owned.length}
        primarySailorId={owned[0]?.id}
        onOpenSettings={() => settingsRef.current?.setAttribute("open", "")}
      />

      {/* Managed profiles / Onboarding */}
      {!isCoach && owned.length === 0 && (
        <section
          id="profiles"
          className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-4 w-full shadow-xs"
        >
          <div className="flex items-start gap-3">
            <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-2xl bg-aqua-mist text-harbour">
              <Compass className="h-5 w-5" aria-hidden="true" />
            </span>
            <div className="min-w-0">
              <h2 className="text-base font-bold text-harbour-shadow">
                Link your sailor profile
              </h2>
              <p className="mt-1 text-sm text-slate-soft leading-relaxed">
                Claiming a profile lets you update boat details, upload regatta evidence, and manage your logbook.
              </p>
            </div>
          </div>

          <ol className="grid gap-2 text-xs text-slate-soft sm:grid-cols-3 pt-1">
            <li className="rounded-2xl border border-cool-veil bg-sailcloth/50 p-3 leading-relaxed">
              <span className="font-bold text-charcoal block mb-0.5">1. Find the sailor</span>
              Search by name or sail number on SailorPath.
            </li>
            <li className="rounded-2xl border border-cool-veil bg-sailcloth/50 p-3 leading-relaxed">
              <span className="font-bold text-charcoal block mb-0.5">2. Submit claim</span>
              Tap <strong className="text-charcoal">Claim this profile</strong> with a short note.
            </li>
            <li className="rounded-2xl border border-cool-veil bg-sailcloth/50 p-3 leading-relaxed">
              <span className="font-bold text-charcoal block mb-0.5">3. Open logbook</span>
              Once approved, manage results and gear here.
            </li>
          </ol>

          <div className="flex flex-wrap items-center gap-3 pt-1">
            <Link
              href="/sailors"
              className="inline-flex min-h-11 items-center justify-center rounded-full bg-harbour hover:bg-harbour-shadow px-5 py-2.5 text-sm font-semibold text-white transition-colors shadow-xs"
            >
              Find &amp; claim a sailor profile →
            </Link>
            <Link
              href="/claim-profile"
              className="inline-flex min-h-11 items-center justify-center rounded-full border border-cool-veil bg-white hover:bg-sailcloth px-4 py-2 text-xs font-semibold text-harbour transition-colors"
            >
              How verification works
            </Link>
          </div>
        </section>
      )}

      {!isCoach && owned.length > 0 && (
        <section
          id="profiles"
          className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-3 w-full shadow-xs"
        >
          <div className="flex items-center justify-between gap-2">
            <h2 className="text-sm font-bold text-charcoal uppercase tracking-wider">
              Profiles you manage
            </h2>
            <Link
              href="/sailors"
              className="text-xs font-semibold text-harbour hover:underline"
            >
              + Link another sailor
            </Link>
          </div>
          <ul className="divide-y divide-cool-veil">
            {owned.map((s) => (
              <li
                key={s.id}
                className="py-3.5 first:pt-1 last:pb-1 flex flex-col sm:flex-row sm:items-center justify-between gap-3"
              >
                <div className="flex items-center gap-3 min-w-0">
                  <span
                    aria-hidden="true"
                    className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-aqua-mist text-xs font-bold text-harbour"
                  >
                    {initialsFor(s.name)}
                  </span>
                  <div className="min-w-0">
                    <div className="flex flex-wrap items-center gap-2">
                      <p className="text-sm font-bold text-charcoal truncate">
                        {s.name}
                      </p>
                      <span className="inline-flex items-center rounded-full border border-cool-veil bg-sailcloth/70 px-2 py-0.5 text-[11px] font-semibold text-slate-soft">
                        {relationBadge(s.ownerRelation)}
                      </span>
                    </div>
                    <p className="text-xs text-slate-soft truncate mt-0.5">
                      {s.sailNumber ? `#${s.sailNumber}` : "No sail #"} · {s.club} · /{s.handle}
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-2 shrink-0">
                  <Link
                    href={`/athlete?id=${s.id}`}
                    className="inline-flex min-h-11 flex-1 sm:flex-initial items-center justify-center rounded-full bg-harbour hover:bg-harbour-shadow px-4 py-2 text-xs font-semibold text-white text-center transition-colors shadow-2xs shrink-0"
                  >
                    Open logbook
                  </Link>
                  <Link
                    href={`/sailors/${s.handle}`}
                    className="inline-flex min-h-11 flex-1 sm:flex-initial items-center justify-center rounded-full border border-cool-veil bg-white hover:bg-sailcloth px-4 py-2 text-xs font-semibold text-harbour text-center transition-colors shadow-2xs shrink-0"
                  >
                    Public profile
                  </Link>
                </div>
              </li>
            ))}
          </ul>
        </section>
      )}

      {/* Claims */}
      {!isCoach && visibleClaims.length > 0 && (
        <section className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-3 w-full shadow-xs">
          <h2 className="text-sm font-bold text-charcoal uppercase tracking-wider">
            Claim requests
          </h2>
          <ul className="divide-y divide-cool-veil">
            {visibleClaims.map((c) => {
              const formattedDate = formatClaimDate(c.createdAt);
              return (
                <li
                  key={c.id}
                  className="py-3 first:pt-1 last:pb-1 flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs"
                >
                  <div className="min-w-0">
                    <p className="font-bold text-sm text-charcoal truncate">
                      {c.sailorName}
                    </p>
                    <div className="flex flex-wrap items-center gap-x-2 gap-y-0.5 text-slate-soft mt-0.5">
                      <Link
                        href={`/sailors/${c.sailorHandle}`}
                        className="hover:text-harbour hover:underline"
                      >
                        /{c.sailorHandle}
                      </Link>
                      {formattedDate && (
                        <>
                          <span aria-hidden="true">·</span>
                          <span>Requested {formattedDate}</span>
                        </>
                      )}
                    </div>
                  </div>
                  <div className="flex items-center gap-2 self-start sm:self-center">
                    {c.status === "pending" && (
                      <span className="inline-flex items-center gap-1 text-slate-soft">
                        <Clock className="h-3 w-3" aria-hidden="true" />
                        <span>Usually reviewed within 24h</span>
                      </span>
                    )}
                    <span
                      className={`rounded-full px-2.5 py-1 text-xs font-semibold capitalize ${
                        c.status === "approved"
                          ? "bg-emerald-50 text-emerald-800 border border-emerald-200"
                          : c.status === "rejected"
                            ? "bg-rose-50 text-rose-800 border border-rose-200"
                            : "bg-amber-50 text-amber-800 border border-amber-200"
                      }`}
                    >
                      {c.status === "rejected" ? "Not approved" : c.status}
                    </span>
                  </div>
                </li>
              );
            })}
          </ul>
        </section>
      )}

      <details
        ref={settingsRef}
        id="settings"
        className="group rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-6 shadow-xs"
      >
        <summary className="min-h-11 cursor-pointer list-none flex items-center gap-2 text-base font-bold text-harbour-shadow [&::-webkit-details-marker]:hidden">
          <ChevronDown
            className="h-4 w-4 shrink-0 text-harbour transition-transform duration-200 motion-reduce:transition-none -rotate-90 group-open:rotate-0"
            aria-hidden="true"
          />
          Account settings
        </summary>
        <p className="mt-1 pl-6 text-sm text-slate-soft">
          Your login details, linked sign-in accounts, email notifications and password.
        </p>

        <div className="mt-6 divide-y divide-cool-veil space-y-6">
          {/* User Account Profile (flattened inside settings) */}
          <section className="space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
              <div className="flex items-center gap-3.5">
                <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-racing-mist/30 border border-racing-orange/25 text-racing-orange shrink-0">
                  <User className="h-5 w-5" aria-hidden="true" />
                </div>
                <div>
                  <h2 className="text-base font-bold text-charcoal">
                    Personal login details
                  </h2>
                  <p className="text-xs text-slate-soft mt-0.5">
                    Distinct from public athlete ranking profiles.
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
                  className="inline-flex min-h-11 items-center gap-2 rounded-full border border-cool-veil bg-white hover:bg-sailcloth px-4 py-2 text-xs font-semibold text-harbour transition-colors self-start sm:self-center shadow-2xs cursor-pointer"
                >
                  <Edit2 className="h-3.5 w-3.5 text-racing-orange" aria-hidden="true" />
                  <span>Edit details</span>
                </button>
              )}
            </div>

            {profileMsg && (
              <div
                role={profileMsg.type === "error" ? "alert" : "status"}
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
                    <label
                      htmlFor={nameId}
                      className="block text-xs font-bold text-slate-soft"
                    >
                      Full name
                    </label>
                    <div className="relative">
                      <User
                        className="absolute left-3.5 top-3.5 h-4 w-4 text-slate-soft"
                        aria-hidden="true"
                      />
                      <input
                        id={nameId}
                        name="fullName"
                        type="text"
                        autoComplete="name"
                        value={editName}
                        onChange={(e) => setEditName(e.target.value)}
                        placeholder="Enter your name"
                        required
                        className="w-full min-h-11 rounded-xl bg-white border border-cool-veil pl-10 pr-3 py-2.5 text-base sm:text-sm text-charcoal placeholder:text-slate-soft/70 focus:border-harbour focus:ring-2 focus:ring-harbour/20 focus:outline-none"
                      />
                    </div>
                  </div>

                  <div className="space-y-1.5">
                    <label
                      htmlFor={emailId}
                      className="block text-xs font-bold text-slate-soft"
                    >
                      Email address
                    </label>
                    <div className="relative">
                      <Mail
                        className="absolute left-3.5 top-3.5 h-4 w-4 text-slate-soft"
                        aria-hidden="true"
                      />
                      <input
                        id={emailId}
                        name="email"
                        type="email"
                        autoComplete="email"
                        autoCorrect="off"
                        autoCapitalize="none"
                        spellCheck={false}
                        value={editEmail}
                        onChange={(e) => setEditEmail(e.target.value)}
                        placeholder="name@example.com"
                        required={Boolean(userProfile?.email || email)}
                        className="w-full min-h-11 rounded-xl bg-white border border-cool-veil pl-10 pr-3 py-2.5 text-base sm:text-sm text-charcoal placeholder:text-slate-soft/70 focus:border-harbour focus:ring-2 focus:ring-harbour/20 focus:outline-none"
                      />
                    </div>
                  </div>
                </div>

                <div className="flex items-center gap-2.5 pt-1">
                  <button
                    type="submit"
                    disabled={profileSaving}
                    className="inline-flex min-h-11 items-center gap-1.5 rounded-full bg-racing-orange hover:bg-racing-deep px-5 py-2.5 text-sm font-semibold text-white transition-colors disabled:opacity-50 shadow-xs cursor-pointer"
                  >
                    <Check className="h-3.5 w-3.5" aria-hidden="true" />
                    <span>{profileSaving ? "Saving…" : "Save changes"}</span>
                  </button>
                  <button
                    type="button"
                    disabled={profileSaving}
                    onClick={() => {
                      setIsEditingProfile(false);
                      setProfileMsg(null);
                    }}
                    className="min-h-11 rounded-full border border-cool-veil bg-white hover:bg-sailcloth px-4 py-2 text-xs font-semibold text-slate-soft transition-colors shadow-2xs cursor-pointer"
                  >
                    Cancel
                  </button>
                </div>
              </form>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 text-xs">
                <div className="rounded-2xl border border-cool-veil bg-sailcloth/50 p-3.5 space-y-1">
                  <div className="flex items-center gap-1.5 text-slate-soft text-xs font-semibold">
                    <User className="h-3.5 w-3.5 text-racing-orange" aria-hidden="true" />
                    <span>Full name</span>
                  </div>
                  <p className="text-sm font-bold text-charcoal">
                    {userProfile?.fullName || "Not set"}
                  </p>
                </div>

                <div className="rounded-2xl border border-cool-veil bg-sailcloth/50 p-3.5 space-y-1 min-w-0">
                  <div className="flex items-center gap-1.5 text-slate-soft text-xs font-semibold">
                    <Mail className="h-3.5 w-3.5 text-harbour" aria-hidden="true" />
                    <span>Email address</span>
                  </div>
                  <p className="text-sm font-bold text-charcoal truncate">
                    {userProfile?.email || email || "Not provided"}
                  </p>
                </div>

                <div className="rounded-2xl border border-cool-veil bg-sailcloth/50 p-3.5 space-y-1">
                  <div className="flex items-center gap-1.5 text-slate-soft text-xs font-semibold">
                    <Calendar className="h-3.5 w-3.5 text-harbour-mid" aria-hidden="true" />
                    <span>Member since</span>
                  </div>
                  <p className="text-sm font-bold text-charcoal">
                    {userProfile?.createdAt
                      ? new Date(userProfile.createdAt).toLocaleDateString("en-SG", {
                          month: "short",
                          year: "numeric",
                        })
                      : "Active member"}
                  </p>
                </div>
              </div>
            )}
          </section>

          <div className="pt-6 space-y-5">
            <GoogleAccountSection
              status={google}
              notice={GOOGLE_ACCOUNT_NOTICES[searchParams.get("google") || ""] ?? null}
            />

            <TelegramAccountSection
              status={telegram}
              notice={TELEGRAM_ACCOUNT_NOTICES[searchParams.get("telegram") || ""] ?? null}
              botEnabled={telegramUpdates?.enabled === true}
            />

            <TelegramUpdatesSection status={telegramUpdates} />
          </div>

          {/* Follow emails */}
          <section className="pt-6 space-y-3">
            <div className="flex items-center gap-2">
              <Mail className="h-4 w-4 text-harbour" aria-hidden="true" />
              <h2 className="text-base font-bold text-charcoal">
                Follow emails
              </h2>
            </div>
            <label className="flex items-start gap-3 cursor-pointer">
              <input
                type="checkbox"
                className="mt-1 h-4 w-4 accent-harbour"
                checked={notifyFollowed}
                disabled={notifyBusy}
                onChange={(event) => void saveNotifyPreference(event.target.checked)}
              />
              <span>
                <span className="block text-sm font-semibold text-charcoal">
                  Email me when results publish for a sailor I follow
                </span>
                <span className="block text-xs text-slate-soft mt-1 leading-relaxed">
                  On by default. One email per regatta, even if several sailors you follow are on the same board.
                </span>
              </span>
            </label>
            {notifyMsg ? (
              <p
                role={notifyMsg.type === "error" ? "alert" : "status"}
                className={`text-xs font-semibold ${
                  notifyMsg.type === "error" ? "text-rose-700" : "text-emerald-800"
                }`}
              >
                {notifyMsg.text}
              </p>
            ) : null}
          </section>

          {/* Account security */}
          <section className="pt-6 space-y-4">
            <div className="flex items-center gap-2">
              <Lock className="h-4 w-4 text-harbour" aria-hidden="true" />
              <h2 className="text-base font-bold text-charcoal">
                Change password
              </h2>
            </div>
            <form onSubmit={changePassword} className="space-y-3" noValidate>
              <p id={pwHintId} className="text-xs text-slate-soft">
                Use at least 6 characters. Pasting from a password manager is supported.
              </p>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label htmlFor={pwId} className="block text-xs font-bold text-slate-soft">
                    New password
                  </label>
                  <div className="relative">
                    <input
                      id={pwId}
                      name="newPassword"
                      type={showPw ? "text" : "password"}
                      value={pw}
                      onChange={(e) => {
                        setPw(e.target.value);
                        if (pwMsg?.type === "error") setPwMsg(null);
                      }}
                      autoComplete="new-password"
                      minLength={6}
                      aria-invalid={pwMsg?.type === "error" && pwMsg.field === "pw" ? "true" : "false"}
                      aria-describedby={
                        pwMsg?.type === "error" ? `${pwHintId} ${pwErrId}` : pwHintId
                      }
                      className="w-full min-h-11 rounded-xl bg-white border border-cool-veil pl-3.5 pr-11 py-2.5 text-base sm:text-sm text-charcoal focus:border-harbour focus:ring-2 focus:ring-harbour/20 focus:outline-none aria-[invalid=true]:border-rose-500"
                    />
                    <button
                      type="button"
                      onClick={() => setShowPw((prev) => !prev)}
                      aria-pressed={showPw}
                      aria-label={showPw ? "Hide passwords" : "Show passwords"}
                      className="absolute right-1.5 top-1/2 -translate-y-1/2 inline-flex h-9 w-9 items-center justify-center rounded-lg text-slate-soft hover:bg-sailcloth hover:text-charcoal cursor-pointer"
                    >
                      {showPw ? (
                        <EyeOff className="h-4 w-4" aria-hidden="true" />
                      ) : (
                        <Eye className="h-4 w-4" aria-hidden="true" />
                      )}
                    </button>
                  </div>
                </div>

                <div className="space-y-1">
                  <label htmlFor={pw2Id} className="block text-xs font-bold text-slate-soft">
                    Confirm password
                  </label>
                  <input
                    id={pw2Id}
                    name="confirmPassword"
                    type={showPw ? "text" : "password"}
                    value={pw2}
                    onChange={(e) => {
                      setPw2(e.target.value);
                      if (pwMsg?.type === "error") setPwMsg(null);
                    }}
                    autoComplete="new-password"
                    minLength={6}
                    aria-invalid={pwMsg?.type === "error" && pwMsg.field === "pw2" ? "true" : "false"}
                    aria-describedby={pwMsg?.type === "error" ? pwErrId : undefined}
                    className="w-full min-h-11 rounded-xl bg-white border border-cool-veil px-3.5 py-2.5 text-base sm:text-sm text-charcoal focus:border-harbour focus:ring-2 focus:ring-harbour/20 focus:outline-none aria-[invalid=true]:border-rose-500"
                  />
                </div>
              </div>
              <div className="flex flex-wrap items-center gap-3 pt-1">
                <button
                  type="submit"
                  disabled={pwBusy}
                  className="min-h-11 rounded-full border border-cool-veil bg-white hover:bg-sailcloth px-4 py-2 text-xs font-semibold text-harbour transition-colors disabled:opacity-50 shadow-2xs cursor-pointer"
                >
                  {pwBusy ? "Updating…" : "Update password"}
                </button>
                {pwMsg && (
                  <p
                    id={pwErrId}
                    role={pwMsg.type === "error" ? "alert" : "status"}
                    className={`text-xs font-semibold ${
                      pwMsg.type === "error" ? "text-rose-700" : "text-emerald-800"
                    }`}
                  >
                    {pwMsg.text}
                  </p>
                )}
              </div>
            </form>
          </section>
        </div>
      </details>

      <section className="rounded-3xl border border-cool-veil bg-sailcloth/60 p-5 sm:p-6 w-full space-y-2">
        <p className="text-sm font-bold text-harbour">Need help?</p>
        <p className="text-xs text-slate-soft leading-relaxed">
          Login issues, claim stuck, transferring a child&apos;s profile, or account deletion — message us anytime.
        </p>
        <Link
          href="/support"
          className="inline-flex min-h-11 items-center mt-2 rounded-full bg-harbour hover:bg-harbour-shadow px-4 py-2 text-xs font-semibold text-white transition-colors shadow-xs"
        >
          Contact support
        </Link>
      </section>
    </div>
  );
}

export default function AccountPage() {
  return (
    <Suspense fallback={<AccountSkeleton />}>
      <AccountInner />
    </Suspense>
  );
}
