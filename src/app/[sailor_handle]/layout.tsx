import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Sailor profile | SailorPath",
  description: "View a sailor’s public regatta results, ranking record, and sailing journey.",
};

export default function SailorProfileLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return children;
}
