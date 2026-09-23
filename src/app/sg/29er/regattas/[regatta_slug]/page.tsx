import { ClassRegattaDetailPage } from "@/components/ClassRegattaDetailPage";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "29er regatta results | SailorPath",
  description: "Published 29er event standings and individual race scores.",
};

export const dynamic = "force-dynamic";

export default function TwentyNinerRegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  return <ClassRegattaDetailPage classKey="29er" params={params} />;
}