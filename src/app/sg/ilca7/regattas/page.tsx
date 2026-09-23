import { ClassRegattasPage } from "@/components/ClassRegattasPage";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 7 regatta results | SailorPath",
  description:
    "Browse published Singapore ILCA 7 regatta results, fleet sizes, and individual race scores.",
};

export const revalidate = 60;

export default function Ilca7RegattasPage() {
  return <ClassRegattasPage classKey="ilca7" />;
}
