import { Suspense } from "react";
import type { Metadata } from "next";
import { SampleDemoShell } from "@/components/SampleDemoShell";

export const metadata: Metadata = {
  title: "Ashlyn Tan · SGP 115 · SailorPath Profile",
  description:
    "Sample SailorPath profile — switch Public, Sailor, Parent, and Coach views for Ashlyn Tan (SGP 115).",
};

function SampleFallback() {
  return (
    <div className="flex-1 flex items-center justify-center py-24">
      <p className="text-sm font-semibold text-slate-500">Loading demo…</p>
    </div>
  );
}

export default function SampleProfilePage() {
  return (
    <Suspense fallback={<SampleFallback />}>
      <SampleDemoShell />
    </Suspense>
  );
}
