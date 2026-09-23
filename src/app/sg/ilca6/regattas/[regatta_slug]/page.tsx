import { ClassRegattaDetailPage } from "@/components/ClassRegattaDetailPage";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 6 regatta results | SailorPath",
  description: "Published ILCA 6 event standings and individual race scores.",
};

export const dynamic = "force-dynamic";

export default function Ilca6RegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  return <ClassRegattaDetailPage classKey="ilca6" params={params} />;
}
