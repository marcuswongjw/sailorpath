"use client";
import Link from "next/link";
import { useRouter } from "next/navigation";
import type { ReactNode } from "react";

/** Restore the complete browsing address when returning from event/class results. */
export function RegattasBackLink({ href = "/calendar", className, children }: { href?: string; className?: string; children: ReactNode }) {
  const router = useRouter();
  return <Link href={href} className={className} onClick={(event) => {
    if (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
    const saved = sessionStorage.getItem("regatta-return-url");
    if (saved && /^\/calendar(?:\?|$)/.test(saved)) {
      event.preventDefault();
      router.push(saved);
    }
  }}>{children}</Link>;
}
