import { ClassRegattasPage } from "@/components/ClassRegattasPage";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "ILCA 6 regatta results | SailorPath",
  description:
    "Published Singapore ILCA 6 regatta results, fleet sizes, and individual race scores.",
};

export const revalidate = 60;

export default function Ilca6Page() {
  return <ClassRegattasPage classKey="ilca6" />;
}
