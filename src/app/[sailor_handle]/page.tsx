import { getSailorProfile } from "@/lib/dbQueries";
import { SailorProfileView } from "@/components/SailorProfileView";
import { notFound } from "next/navigation";
import { DemoBanner } from "@/components/DemoBanner";

interface PageProps {
  params: Promise<{ sailor_handle: string }>;
}

export default async function SailorProfilePage({ params }: PageProps) {
  const resolvedParams = await params;
  const handle = resolvedParams.sailor_handle;

  const response = await getSailorProfile(handle);
  if (!response || !response.data) {
    notFound();
  }

  const { sailor, results, equipment } = response.data;

  return (
    <div className="flex-1 flex flex-col bg-[#090a0f]">
      <DemoBanner isDemo={response.isDemo} />
      <SailorProfileView
        initialSailor={sailor}
        initialResults={results}
        initialEquipment={equipment}
      />
    </div>
  );
}
