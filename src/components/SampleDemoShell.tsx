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
      <p className="text-xs text-[var(--sp-charcoal-slate)] leading-relaxed">
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
            className="flex flex-col gap-1.5 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-3 py-2.5 cursor-pointer hover:border-[var(--sp-harbour-teal)] transition-colors"
          >
            <span className="flex items-center justify-between gap-3">
              <span className="text-xs font-semibold text-[var(--sp-harbour-shadow)]">
                {row.label}
              </span>
              <input
                type="checkbox"
                checked={row.checked}
                onChange={(e) => row.set(e.target.checked)}
                className="rounded accent-[var(--sp-racing-orange)] shrink-0"
              />
            </span>
            <span className="text-[10px] text-[var(--sp-slate-soft)]">{row.hint}</span>
          </label>
        ))}
      </div>
      <button
        type="button"
        onClick={onSave}
        className="w-full sp-btn-primary py-2.5 text-xs font-bold"
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
    <div className="flex-1 flex flex-col bg-[var(--sp-sailcloth)]">
      {/* Top Demo Navigation Bar */}
      <DemoNavHeader activeDemo="sailor" />

      {/* Cross-Promotion Ribbon */}
      <div className="bg-[var(--sp-warm-white)] border-b border-[var(--sp-cool-veil)] px-4 py-2.5">
        <div className="mx-auto max-w-5xl flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs">
          <p className="text-[var(--sp-charcoal-slate)] font-medium">
            Looking for multi-athlete family tools or squad coach management?
          </p>
          <div className="flex items-center gap-3 shrink-0">
            <Link
              href="/demo/parent"
              className="inline-flex items-center gap-1 font-bold text-[var(--sp-harbour-teal)] hover:underline"
            >
              <Heart className="h-3.5 w-3.5" />
              <span>Parent Hub Demo</span>
              <ArrowRight className="h-3 w-3" />
            </Link>
            <span className="text-[var(--sp-cool-veil)]">·</span>
            <Link
              href="/demo/coach"
              className="inline-flex items-center gap-1 font-bold text-[var(--sp-racing-orange)] hover:underline"
            >
              <ClipboardList className="h-3.5 w-3.5" />
              <span>Coach Hub Demo</span>
              <ArrowRight className="h-3 w-3" />
            </Link>
          </div>
        </div>
      </div>

      {/* Clean Branded Profile Chrome: title + view tabs */}
      <div className="border-b border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] py-4">
        <div className="mx-auto max-w-4xl px-4 sm:px-6 space-y-3">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <div>
              <p className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-racing-orange)]">
                Athlete Profile Demo
              </p>
              <h1 className="text-xl sm:text-2xl font-black font-display text-[var(--sp-harbour-shadow)] tracking-tight">
                Kimberly Tan · SGP 115 · SailorPath Profile
              </h1>
              <p className="text-xs text-[var(--sp-charcoal-slate)] mt-0.5">
                b. {SAMPLE_SAILOR.dob.slice(0, 4)} · dual-class Optimist Gold &amp; ILCA 4 · Changi Sailing Club
              </p>
            </div>
            {canManagePrivacy && (
              <button
                type="button"
                onClick={() => setSettingsOpen(true)}
                className="inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-3.5 py-1.5 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors self-start sm:self-center shadow-xs"
                title="Privacy settings"
              >
                <Settings className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
                Settings
              </button>
            )}
          </div>

          {/* Focused View Tabs (Public vs Sailor Private View) */}
          <div
            className="flex gap-1.5 p-1 rounded-2xl bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] max-w-md"
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
                  className={`flex-1 inline-flex items-center justify-center gap-1.5 rounded-xl px-3 py-2 text-xs font-bold transition-all ${
                    active
                      ? "bg-[var(--sp-racing-orange)] text-white shadow-sm"
                      : "text-[var(--sp-charcoal-slate)] hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-warm-white)]"
                  }`}
                >
                  <Icon className="h-3.5 w-3.5 shrink-0" />
                  <span>{label}</span>
                </button>
              );
            })}
          </div>

          <p className="text-xs text-[var(--sp-slate-soft)] leading-snug">
            <span className="font-bold text-[var(--sp-harbour-shadow)]">{copy.who}.</span>{" "}
            {copy.value}
          </p>
        </div>
      </div>

      {toast && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 rounded-full bg-[var(--sp-harbour-shadow)] text-white border border-[var(--sp-racing-orange)]/40 px-5 py-2.5 text-xs font-bold shadow-xl">
          {toast}
        </div>
      )}

      {/* Settings modal — privacy for sailor only */}
      {settingsOpen && canManagePrivacy && (
        <div
          className="fixed inset-0 z-50 flex items-end sm:items-center justify-center p-0 sm:p-4 bg-black/60 backdrop-blur-xs"
          role="dialog"
          aria-modal="true"
          aria-label="Privacy settings"
        >
          <div className="w-full sm:max-w-md rounded-t-3xl sm:rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 shadow-2xl">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-2">
                <Settings className="h-4 w-4 text-[var(--sp-racing-orange)]" />
                <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)]">
                  Privacy settings
                </h2>
              </div>
              <button
                type="button"
                onClick={() => setSettingsOpen(false)}
                className="rounded-lg p-1.5 text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
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
