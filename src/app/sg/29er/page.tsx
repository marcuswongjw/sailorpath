import { ClassRegattasPage } from "@/components/ClassRegattasPage";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "29er regatta results | SailorPath",
  description:
    "Published Singapore 29er regatta results, fleet sizes, and individual race scores.",
};

export const revalidate = 60;

export default function TwentyNinerPage() {
  return <ClassRegattasPage classKey="29er" />;
}
