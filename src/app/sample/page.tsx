import { getSailorPrizes, mergeSailorPrizes } from "@/lib/sailorPrizes";
import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { JsonLd } from "@/components/JsonLd";
import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import { SailorProfileView } from "@/components/SailorProfileView";
import { SampleViewControls } from "@/components/sample/SampleViewControls";
import { profilePageJsonLd, sailorShareModel, shareMetadata } from "@/lib/publicSeo";
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

function sampleShare() {
  return sailorShareModel({
    name: SAMPLE_SAILOR.name,
    handle: SAMPLE_SAILOR.handle,
    nationality: SAMPLE_SAILOR.nationality,
    club: SAMPLE_SAILOR.club,
    results: SAMPLE_RESULTS,
    path: "/sample",
  });
}

export async function generateMetadata(): Promise<Metadata> {
  const share = sampleShare();
  return shareMetadata({
    title: share.title,
    description: share.summary,
    canonicalPath: share.path,
  });
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

  const share = sampleShare();
  return (
    <div className="flex flex-1 flex-col bg-sailcloth">
      <JsonLd data={profilePageJsonLd(share)} />
      <DemoNavHeader activeDemo="sailor" />
      <div className="border-b border-cool-veil bg-warm-white py-3">
        <div className="mx-auto max-w-4xl space-y-2.5 px-3 sm:px-6">
          <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
            <div className="min-w-0">
              <h1 className="font-display text-sm font-black tracking-tight text-harbour-shadow truncate">
                Kimberly Tan · SGP 115 · SailorPath Profile
              </h1>
              <p className="text-xs text-slate-soft">
                b. {SAMPLE_SAILOR.dob.slice(0, 4)} · dual-class SG Gold &amp; ILCA 4
              </p>
            </div>
            <SampleViewControls view={view} />
          </div>
          <p className="text-xs leading-snug text-slate-soft">
            <span className="font-bold text-harbour-shadow">{copy.who}.</span> {copy.value}
          </p>
        </div>
      </div>
      <SailorProfileView
        initialPrizeAwards={mergeSailorPrizes(getSailorPrizes(SAMPLE_SAILOR, SAMPLE_RESULTS))}
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
