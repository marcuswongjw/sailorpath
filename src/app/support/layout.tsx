import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Help and support | SailorPath",
  description: "Contact SailorPath about profile claims, data corrections, account access, or technical issues.",
};

export default function SupportLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return children;
}
