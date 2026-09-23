import { ClassRegattaDetailPage } from "@/components/ClassRegattaDetailPage";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 7 regatta results | SailorPath",
  description: "Published ILCA 7 event standings and individual race scores.",
};

export const dynamic = "force-dynamic";

export default function Ilca7RegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  return <ClassRegattaDetailPage classKey="ilca7" params={params} />;
}
