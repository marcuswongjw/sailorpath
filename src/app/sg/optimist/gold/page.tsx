import { getFleetRankings } from "@/lib/dbQueries";
import { FleetRankingsView } from "@/components/FleetRankingsView";
import { DemoBanner } from "@/components/DemoBanner";

export default async function GoldFleetPage() {
  const period = { year: 2026, half: "Jan-Jun" as const };
  const response = await getFleetRankings("Gold", period);
  const { rankings, regattasUsed } = response.data;

  return (
    <div className="flex-1 flex flex-col bg-[#090a0f]">
      <DemoBanner isDemo={response.isDemo} />
      <FleetRankingsView
        fleet="Gold"
        initialRankings={rankings}
        initialRegattasUsed={regattasUsed}
        isDemo={response.isDemo}
      />
    </div>
  );
}
