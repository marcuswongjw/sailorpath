import { Suspense } from "react";
import type { Metadata } from "next";
import { SampleParentDemo } from "@/components/demo/SampleParentDemo";

export const metadata: Metadata = {
  title: "Parent Command Center Demo · SailorPath",
  description:
    "Interactive demo of the SailorPath Parent Command Center — multi-athlete switcher, 2026 Selection Trials status, equipment locker alerts, and pre-race morning checklists.",
};

function DemoFallback() {
  return (
    <div className="min-h-screen bg-[#0d1017] flex items-center justify-center py-24">
      <p className="text-sm font-semibold text-slate-500">Loading parent demo…</p>
    </div>
  );
}

export default function DemoParentPage() {
  return (
    <Suspense fallback={<DemoFallback />}>
      <SampleParentDemo />
    </Suspense>
  );
}
