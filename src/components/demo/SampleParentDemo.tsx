"use client";

import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import { ParentDashboard } from "@/components/ParentDashboard";
import { SAMPLE_FAMILY_DASHBOARD } from "@/lib/sampleParentDashboard";

export function SampleParentDemo() {
  return (
    <div className="min-h-screen bg-[var(--sp-sailcloth)] flex flex-col">
      <DemoNavHeader activeDemo="parent" />
      <main className="flex-1">
        <ParentDashboard
          initialData={SAMPLE_FAMILY_DASHBOARD}
          demoMode={true}
        />
      </main>
    </div>
  );
}
