import { ClassRegattasPage } from "@/components/ClassRegattasPage";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "29er regatta results | SailorPath",
  description:
    "Browse published Singapore 29er regatta results, fleet sizes, and individual race scores.",
};

export const revalidate = 60;

export default function TwentyNinerRegattasPage() {
  return <ClassRegattasPage classKey="29er" />;
}
