import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import { SailorProfileView } from "@/components/SailorProfileView";
import { SampleViewControls } from "@/components/sample/SampleViewControls";
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

type SampleView = "public" | "sailor";

function sampleView(value: string | undefined): SampleView | "parent" | "coach" {
  const view = (value || "public").toLowerCase();
  if (view === "sailor" || view === "parent" || view === "coach") return view;
  return "public";
}

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<{ view?: string }>;
}): Promise<Metadata> {
  const view = sampleView((await searchParams).view);
  const title =
    view === "sailor"
      ? "Kimberly Tan · SGP 115 · Sailor view | SailorPath"
      : "Kimberly Tan · SGP 115 · SailorPath Profile";
  return {
    title,
    description: "Sample SailorPath profile for Kimberly Tan (SGP 115), with public and sailor views.",
  };
}

export default async function SampleProfilePage({
  searchParams,
}: {
  searchParams: Promise<{ view?: string }>;
}) {
  const view = sampleView((await searchParams).view);
  if (view === "parent") redirect("/demo/parent");
  if (view === "coach") redirect("/demo/coach");

  const role: DemoRole = view;
  const copy = DEMO_ROLE_COPY[role];
  const isSailor = role === "sailor";

  return (
    <div className="flex flex-1 flex-col bg-sailcloth">
      <DemoNavHeader activeDemo="sailor" />
      <div className="border-b border-cool-veil bg-warm-white px-4 py-2.5">
        <div className="mx-auto flex max-w-5xl flex-col justify-between gap-2 text-xs sm:flex-row sm:items-center">
          <p className="font-medium text-charcoal">Looking for family tools or squad coach management?</p>
          <div className="flex items-center gap-3">
            <Link href="/demo/parent" className="font-bold text-harbour hover:underline">Parent Hub Demo</Link>
            <Link href="/demo/coach" className="font-bold text-racing-orange hover:underline">Coach Hub Demo</Link>
          </div>
        </div>
      </div>
      <div className="border-b border-cool-veil bg-warm-white py-4">
        <div className="mx-auto max-w-4xl space-y-3 px-4 sm:px-6">
          <div>
            <p className="text-[12px] font-bold uppercase tracking-[0.16em] text-racing-orange">Athlete Profile Demo</p>
            <h1 className="font-display text-xl font-black tracking-tight text-harbour-shadow sm:text-2xl">
              Kimberly Tan · SGP 115 · SailorPath Profile
            </h1>
            <p className="mt-0.5 text-xs text-charcoal">
              b. {SAMPLE_SAILOR.dob.slice(0, 4)} · dual-class Optimist Gold &amp; ILCA 4 · Changi Sailing Club
            </p>
          </div>
          <SampleViewControls view={view} />
          <p className="text-xs leading-snug text-slate-soft">
            <span className="font-bold text-harbour-shadow">{copy.who}.</span> {copy.value}
          </p>
        </div>
      </div>
      <SailorProfileView
        initialSailor={SAMPLE_SAILOR}
        initialResults={SAMPLE_RESULTS}
        initialEquipment={SAMPLE_EQUIPMENT}
        initialSeriesStanding={SAMPLE_SERIES_STANDING}
        initialIlcaStanding={SAMPLE_ILCA_STANDING}
        initialObservations={isSailor ? SAMPLE_OBSERVATIONS : []}
        canSeePrivate={isSailor}
        canClaim={!isSailor}
        isOwner={isSailor}
        isLoggedIn={isSailor}
        demoMode
        demoRole={role}
        hidePrivacySection={isSailor}
        profileVerified={isSailor}
      />
    </div>
  );
}
