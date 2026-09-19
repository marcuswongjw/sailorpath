"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { SailorProfileView } from "@/components/SailorProfileView";
import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import {
  DEMO_ROLE_COPY,
  SAMPLE_EQUIPMENT,
  SAMPLE_ILCA_STANDING,
  SAMPLE_OBSERVATIONS,
  SAMPLE_RESULTS,
  SAMPLE_SAILOR,
  SAMPLE_SERIES_STANDING,
  type DemoRole,
} from "@/lib/sampleProfile";
import {
  User,
  Sparkles,
  Settings,
  X,
  Heart,
  ClipboardList,
  ArrowRight,
} from "lucide-react";
import { trackClientUsage } from "@/lib/clientUsage";

export type SailorDemoRole = "public" | "sailor";

const SAILOR_ROLES: SailorDemoRole[] = ["public", "sailor"];

function PrivacySettingsBody({
  childLabel,
  onSave,
}: {
  childLabel?: string;
  onSave: () => void;
}) {
  const [weight, setWeight] = useState(false);
  const [fullDob, setFullDob] = useState(false);

  return (
    <div className="space-y-4">
      <p className="text-[12px] text-neutral-400 leading-relaxed">
        {childLabel
          ? `Manage ${childLabel}'s privacy. Birth year is always public when set; month and day stay private unless shared. Equipment is always private to the family.`
          : "Birth year is always public when set. Month/day and weight stay private unless shared. Equipment is always private to the sailor and linked parents."}
      </p>
      <div className="space-y-2">
        {(
          [
            {
              label: "Share weight",
              hint: "Show kg on public profile",
              checked: weight,
              set: setWeight,
            },
            {
              label: "Also share month & day",
              hint: "Year is always public; this also shows the full date",
              checked: fullDob,
              set: setFullDob,
            },
          ] as const
        ).map((row) => (
          <label
            key={row.label}
            className="flex flex-col gap-1.5 rounded-xl border border-white/[0.08] px-3 py-2.5 cursor-pointer hover:bg-white/[0.02]"
          >
            <span className="flex items-center justify-between gap-3">
              <span className="text-xs font-medium text-neutral-200">
                {row.label}
              </span>
              <input
                type="checkbox"
                checked={row.checked}
                onChange={(e) => row.set(e.target.checked)}
                className="rounded border-neutral-600 shrink-0"
              />
            </span>
            <span className="text-[10px] text-neutral-500">{row.hint}</span>
          </label>
        ))}
      </div>
      <button
        type="button"
        onClick={onSave}
        className="w-full rounded-xl bg-orange-600 py-2.5 text-[12px] font-bold text-white hover:bg-orange-500"
      >
        Save privacy (demo)
      </button>
    </div>
  );
}

export function SampleDemoShell() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const rawView = (searchParams.get("view") || "public").toLowerCase();

  // Redirect parent & coach views to their dedicated demo pages
  useEffect(() => {
    if (rawView === "parent") {
      router.replace("/demo/parent");
    } else if (rawView === "coach") {
      router.replace("/demo/coach");
    }
  }, [rawView, router]);

  const startRole: SailorDemoRole = SAILOR_ROLES.includes(rawView as SailorDemoRole)
    ? (rawView as SailorDemoRole)
    : "public";

  const [role, setRole] = useState<SailorDemoRole>(startRole);
  const [toast, setToast] = useState<string | null>(null);
  const [settingsOpen, setSettingsOpen] = useState(false);

  const copy = DEMO_ROLE_COPY[role as DemoRole];

  const canSeePrivate = role === "sailor";
  const isOwner = role === "sailor";
  const canManagePrivacy = role === "sailor";
  const canClaim = role === "public";

  const flash = (msg: string) => {
    setToast(msg);
    setTimeout(() => setToast(null), 2200);
  };

  const setRoleAndUrl = (r: SailorDemoRole) => {
    if (r !== role) {
      trackClientUsage("demo_role_switch", "/sample", {
        from: role,
        to: r,
      });
    }
    setRole(r);
    setSettingsOpen(false);
    if (typeof window !== "undefined") {
      const u = new URL(window.location.href);
      u.searchParams.set("view", r);
      window.history.replaceState({}, "", u.toString());
    }
  };

  return (
    <div className="flex-1 flex flex-col bg-[#0d1017]">
      {/* Top Demo Navigation Bar */}
      <DemoNavHeader
        activeDemo="sailor"
        sailorViewMode={role}
        onSailorViewChange={setRoleAndUrl}
      />

      {/* Relocation Cross-Promotion Banner */}
      <div className="bg-gradient-to-r from-emerald-950/40 via-sky-950/30 to-amber-950/30 border-b border-white/10 px-4 py-2.5">
        <div className="mx-auto max-w-5xl flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs">
          <p className="text-slate-300">
            Looking for multi-athlete management or squad tools?
          </p>
          <div className="flex items-center gap-3">
            <Link
              href="/demo/parent"
              className="inline-flex items-center gap-1 font-bold text-emerald-400 hover:text-emerald-300"
            >
              <Heart className="h-3.5 w-3.5" />
              <span>Parent Hub Demo</span>
              <ArrowRight className="h-3 w-3" />
            </Link>
            <span className="text-white/20">·</span>
            <Link
              href="/demo/coach"
              className="inline-flex items-center gap-1 font-bold text-sky-400 hover:text-sky-300"
            >
              <ClipboardList className="h-3.5 w-3.5" />
              <span>Coach Hub Demo</span>
              <ArrowRight className="h-3 w-3" />
            </Link>
          </div>
        </div>
      </div>

      {/* Demo chrome: profile title + view tabs */}
      <div className="border-b border-amber-500/20 bg-[#12100a]/90 backdrop-blur-md">
        <div className="mx-auto max-w-3xl px-3 sm:px-4 py-3 space-y-3">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <div>
              <p className="text-[10px] font-bold uppercase tracking-[0.14em] text-amber-400/90">
                Athlete Profile Demo
              </p>
              <h1 className="text-base sm:text-lg font-bold text-white tracking-tight">
                Kimberly Tan · SGP 115 · SailorPath Profile
              </h1>
              <p className="text-[11px] text-slate-400 mt-0.5">
                b. {SAMPLE_SAILOR.dob.slice(0, 4)} · dual-class Optimist + ILCA 4 ·
                switch views below
              </p>
            </div>
            {canManagePrivacy && (
              <button
                type="button"
                onClick={() => setSettingsOpen(true)}
                className="rounded-full border border-white/15 px-3 py-2 min-h-[40px] inline-flex items-center gap-1.5 text-[11px] font-bold text-slate-300 hover:bg-white/5 self-start sm:self-center"
                title="Privacy settings"
              >
                <Settings className="h-3.5 w-3.5" />
                Settings
              </button>
            )}
          </div>

          {/* Focused View Tabs (Public vs Sailor) */}
          <div
            className="flex gap-1 p-1.5 rounded-2xl bg-black/50 border border-white/15"
            role="tablist"
            aria-label="Profile view"
          >
            {SAILOR_ROLES.map((r) => {
              const active = role === r;
              const Icon = r === "public" ? Sparkles : User;
              const label =
                r === "public" ? "Public Profile View" : "Sailor Private View";
              return (
                <button
                  key={r}
                  type="button"
                  role="tab"
                  aria-selected={active}
                  onClick={() => setRoleAndUrl(r)}
                  className={`flex-1 inline-flex items-center justify-center gap-1.5 rounded-xl px-2 sm:px-3 py-2.5 min-h-[44px] text-[12px] sm:text-[13px] font-bold transition-all ${
                    active
                      ? "bg-orange-600 text-white shadow-lg shadow-orange-950/40 ring-2 ring-orange-400/40"
                      : "text-slate-400 hover:text-white hover:bg-white/5"
                  }`}
                >
                  <Icon className="h-4 w-4 shrink-0" />
                  <span>{label}</span>
                </button>
              );
            })}
          </div>
          <p className="text-[11px] text-slate-400 leading-snug px-0.5">
            <span className="font-bold text-white">{copy.who}.</span>{" "}
            {copy.value}
          </p>
        </div>
      </div>

      {toast && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 rounded-full bg-slate-900 border border-orange-500/40 px-5 py-2.5 text-xs font-bold text-white shadow-xl">
          {toast}
        </div>
      )}

      {/* Settings modal — privacy for sailor only */}
      {settingsOpen && canManagePrivacy && (
        <div
          className="fixed inset-0 z-50 flex items-end sm:items-center justify-center p-0 sm:p-4 bg-black/70"
          role="dialog"
          aria-modal="true"
          aria-label="Privacy settings"
        >
          <div className="w-full sm:max-w-md rounded-t-2xl sm:rounded-2xl border border-white/10 bg-[#12141c] p-5 shadow-2xl">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-2">
                <Settings className="h-4 w-4 text-orange-400" />
                <h2 className="text-sm font-bold text-white">
                  Privacy settings
                </h2>
              </div>
              <button
                type="button"
                onClick={() => setSettingsOpen(false)}
                className="rounded-lg p-1.5 text-slate-500 hover:text-white"
                aria-label="Close"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
            <PrivacySettingsBody
              onSave={() => {
                flash("Demo privacy saved");
                setSettingsOpen(false);
              }}
            />
          </div>
        </div>
      )}

      {/* Public & Sailor Profile Views */}
      <SailorProfileView
        initialSailor={SAMPLE_SAILOR}
        initialResults={SAMPLE_RESULTS}
        initialEquipment={SAMPLE_EQUIPMENT}
        initialSeriesStanding={SAMPLE_SERIES_STANDING}
        initialIlcaStanding={SAMPLE_ILCA_STANDING}
        initialObservations={role === "sailor" ? SAMPLE_OBSERVATIONS : []}
        canSeePrivate={canSeePrivate}
        canClaim={canClaim}
        isOwner={isOwner}
        isLoggedIn={role !== "public"}
        demoMode
        demoRole={role}
        hidePrivacySection={role === "sailor"}
        profileVerified={role === "sailor"}
        onDemoClaim={() =>
          flash("Demo: claim would submit after you register & sign in")
        }
      />
    </div>
  );
}
