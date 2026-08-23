import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Parent dashboard | SailorPath",
  description: "View linked sailor profiles, results, standings, milestones, and private parent notes.",
};

export default function ParentLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return children;
}
