"use client";

import { DemoNavHeader } from "@/components/demo/DemoNavHeader";
import { CoachDashboard } from "@/components/CoachDashboard";
import { SAMPLE_COACH_SQUAD_DASHBOARD } from "@/lib/sampleCoachDashboard";

export function SampleCoachDemo() {
  return (
    <div className="min-h-screen bg-[var(--sp-sailcloth)] flex flex-col">
      <DemoNavHeader activeDemo="coach" />
      <main className="flex-1">
        <CoachDashboard
          initialData={SAMPLE_COACH_SQUAD_DASHBOARD}
          demoMode={true}
        />
      </main>
    </div>
  );
}
