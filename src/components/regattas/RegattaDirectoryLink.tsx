"use client";

import Link from "next/link";
import type { ComponentProps } from "react";

/** Keep the exact directory address for the event's return breadcrumb. */
export function RegattaDirectoryLink(props: ComponentProps<typeof Link>) {
  return <Link {...props} onClick={(event) => {
    try {
      sessionStorage.setItem("regatta-return-url", location.pathname + location.search);
    } catch {
      // Browsing still works when storage is unavailable.
    }
    props.onClick?.(event);
  }} />;
}
