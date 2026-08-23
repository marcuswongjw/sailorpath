import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Create account | SailorPath",
  description: "Create a SailorPath account and claim an existing sailor profile.",
};

export default function RegisterLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return children;
}
