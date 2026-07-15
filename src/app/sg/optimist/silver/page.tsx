import { getFleetRankings } from "@/lib/dbQueries";
import { FleetRankingsView } from "@/components/FleetRankingsView";
import { DemoBanner } from "@/components/DemoBanner";

export default async function SilverFleetPage() {
  const period = { year: 2026, half: "Jan-Jun" as const };
  const response = await getFleetRankings("Silver", period);
  const { rankings, regattasUsed } = response.data;

  return (
    <div className="flex-1 flex flex-col bg-[#090a0f]">
      <DemoBanner isDemo={response.isDemo} />
      <FleetRankingsView
        fleet="Silver"
        initialRankings={rankings}
        initialRegattasUsed={regattasUsed}
        isDemo={response.isDemo}
      />
    </div>
  );
}
