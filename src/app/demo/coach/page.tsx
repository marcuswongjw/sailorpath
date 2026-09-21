import { Suspense } from "react";
import type { Metadata } from "next";
import { SampleCoachDemo } from "@/components/demo/SampleCoachDemo";

export const metadata: Metadata = {
  title: "Coach Squad Hub Demo · SailorPath",
  description:
    "Interactive demo of the SailorPath Coach Squad Hub — squad roster, athlete development logs, selection readiness diagnostics, and training attendance.",
};

function DemoFallback() {
  return (
    <div className="min-h-screen bg-[var(--sp-sailcloth)] flex items-center justify-center py-24">
      <p className="text-sm font-semibold text-slate-500">Loading coach demo…</p>
    </div>
  );
}

export default function DemoCoachPage() {
  return (
    <Suspense fallback={<DemoFallback />}>
      <SampleCoachDemo />
    </Suspense>
  );
}
