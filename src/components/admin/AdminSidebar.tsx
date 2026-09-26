"use client";

import Link from "next/link";
import type { MouseEvent } from "react";
import {
  BarChart3,
  Calendar,
  Inbox,
  LifeBuoy,
  Settings,
  Users,
} from "lucide-react";
import { serializeAdminArea, type AdminArea } from "@/components/admin/adminNav";

type Shell = "sidebar";

type Item = {
  area: AdminArea;
  label: string;
  href: string;
  active: boolean;
  count?: number;
};

function areaHref(
  state: Parameters<typeof serializeAdminArea>[0],
  shell: Shell
) {
  return `/admin?${serializeAdminArea(state)}&shell=${shell}`;
}

export function AdminSidebar({
  activeArea,
  sailorsView,
  inboxView,
  insightsView,
  settingsView,
  inboxCount,
  changelogUnread,
  onNavigate,
}: {
  activeArea: AdminArea;
  sailorsView: string;
  inboxView: string;
  insightsView: string;
  settingsView: string;
  inboxCount: number;
  changelogUnread: boolean;
  onNavigate: (href: string) => boolean;
}) {
  const shell: Shell = "sidebar";
  const items: Item[] = [
    {
      area: "events",
      label: "Events",
      href: areaHref({ area: "events", view: "card", event: null, sheet: null }, shell),
      active: activeArea === "events",
    },
    {
      area: "sailors",
      label: "Sailors",
      href: areaHref(
        { area: "sailors", view: "directory", event: null, sheet: null },
        shell
      ),
      active: activeArea === "sailors",
    },
    {
      area: "inbox",
      label: "Inbox",
      href: areaHref(
        { area: "inbox", view: "claims", event: null, sheet: null },
        shell
      ),
      active: activeArea === "inbox",
      count: inboxCount,
    },
    {
      area: "insights",
      label: "Insights",
      href: areaHref(
        { area: "insights", view: "optimist", event: null, sheet: null },
        shell
      ),
      active: activeArea === "insights",
    },
    {
      area: "settings",
      label: "Settings",
      href: areaHref(
        { area: "settings", view: "audit", event: null, sheet: null },
        shell
      ),
      active: activeArea === "settings",
    },
  ];

  const childLink =
    "flex min-h-11 items-center rounded-lg px-3 text-sm font-semibold text-slate-300 hover:bg-white/10 hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400";
  const guardLink = (href: string, event: MouseEvent<HTMLAnchorElement>) => {
    if (!onNavigate(href)) event.preventDefault();
  };

  return (
    <div className="flex h-full flex-col gap-1 p-3">
      <p className="px-3 pb-2 text-[11px] font-black uppercase tracking-wider text-slate-500">
        SailorPath
      </p>
      <ul className="space-y-1">
        {items.map((item) => (
          <li key={item.area}>
            <Link
              href={item.href}
              aria-current={item.active ? "page" : undefined}
              onClick={(event) => guardLink(item.href, event)}
              className={`flex min-h-11 items-center justify-between gap-2 rounded-xl px-3 text-sm font-bold focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400 ${
                item.active
                  ? "bg-[var(--sp-harbour-teal)] text-white"
                  : "text-slate-300 hover:bg-white/10 hover:text-white"
              }`}
            >
              <span className="inline-flex items-center gap-2">
                {item.area === "events" && <Calendar className="h-4 w-4" aria-hidden="true" />}
                {item.area === "sailors" && <Users className="h-4 w-4" aria-hidden="true" />}
                {item.area === "inbox" && <Inbox className="h-4 w-4" aria-hidden="true" />}
                {item.area === "insights" && <BarChart3 className="h-4 w-4" aria-hidden="true" />}
                {item.area === "settings" && <Settings className="h-4 w-4" aria-hidden="true" />}
                {item.label}
              </span>
              {item.count != null && item.count > 0 && (
                <span className="min-w-6 rounded-full bg-rose-500 px-1.5 text-center text-[11px] font-black text-white">
                  {item.count > 9 ? "9+" : item.count}
                </span>
              )}
            </Link>
            {item.active && item.area === "events" && (
              <ul className="mt-1 space-y-1 pl-3">
                <li>
                  <Link
                    href={areaHref(
                      { area: "events", view: "import", event: null, sheet: null },
                      shell
                    )}
                    onClick={(event) =>
                      guardLink(
                        areaHref(
                          { area: "events", view: "import", event: null, sheet: null },
                          shell
                        ),
                        event
                      )
                    }
                    className={childLink}
                  >
                    Import
                  </Link>
                </li>
              </ul>
            )}
            {item.active && item.area === "sailors" && (
              <ul className="mt-1 space-y-1 pl-3">
                {(
                  [
                    ["directory", "Directory"],
                    ["duplicates", "Duplicates"],
                    ["promotions", "Promotions"],
                    ["selection", "Selection"],
                  ] as const
                ).map(([view, label]) => (
                  <li key={view}>
                    <Link
                      href={areaHref(
                        { area: "sailors", view, event: null, sheet: null },
                        shell
                      )}
                      aria-current={sailorsView === view ? "page" : undefined}
                      onClick={(event) => guardLink(areaHref(
                        { area: "sailors", view, event: null, sheet: null }, shell
                      ), event)}
                      className={childLink}
                    >
                      {label}
                    </Link>
                  </li>
                ))}
              </ul>
            )}
            {item.active && item.area === "inbox" && (
              <ul className="mt-1 space-y-1 pl-3">
                {(
                  [
                    ["suggestions", "Suggestions"],
                    ["claims", "Claims"],
                    ["coaches", "Coach access"],
                    ["support", "Support"],
                  ] as const
                ).map(([view, label]) => (
                  <li key={view}>
                    <Link
                      href={areaHref(
                        { area: "inbox", view, event: null, sheet: null },
                        shell
                      )}
                      aria-current={inboxView === view ? "page" : undefined}
                      onClick={(event) => guardLink(areaHref(
                        { area: "inbox", view, event: null, sheet: null }, shell
                      ), event)}
                      className={childLink}
                    >
                      {label}
                    </Link>
                  </li>
                ))}
              </ul>
            )}
            {item.active && item.area === "insights" && (
              <ul className="mt-1 space-y-1 pl-3">
                {(
                  [
                    ["optimist", "Optimist analysis"],
                    ["ilca", "ILCA"],
                    ["wingfoil", "WingFoil workspace"],
                    ["techno293", "Techno 293 workspace"],
                    ["metrics", "Platform metrics"],
                  ] as const
                ).map(([view, label]) => (
                  <li key={view}>
                    <Link
                      href={areaHref(
                        { area: "insights", view, event: null, sheet: null },
                        shell
                      )}
                      aria-current={insightsView === view ? "page" : undefined}
                      onClick={(event) => guardLink(areaHref(
                        { area: "insights", view, event: null, sheet: null }, shell
                      ), event)}
                      className={childLink}
                    >
                      {label}
                    </Link>
                  </li>
                ))}
              </ul>
            )}
            {item.active && item.area === "settings" && (
              <ul className="mt-1 space-y-1 pl-3">
                <li>
                  <Link
                    href={areaHref(
                      { area: "settings", view: "audit", event: null, sheet: null },
                      shell
                    )}
                    aria-current={settingsView === "audit" ? "page" : undefined}
                    onClick={(event) => guardLink(areaHref(
                      { area: "settings", view: "audit", event: null, sheet: null }, shell
                    ), event)}
                    className={childLink}
                  >
                    Audit log
                  </Link>
                </li>
                <li>
                  <Link
                    href={areaHref(
                      {
                        area: "settings",
                        view: "changelog",
                        event: null,
                        sheet: null,
                      },
                      shell
                    )}
                    aria-current={settingsView === "changelog" ? "page" : undefined}
                    onClick={(event) => guardLink(areaHref(
                      { area: "settings", view: "changelog", event: null, sheet: null }, shell
                    ), event)}
                    className={childLink}
                  >
                    Changelog
                    {changelogUnread && (
                      <LifeBuoy className="ml-2 h-3.5 w-3.5" aria-hidden="true" />
                    )}
                  </Link>
                </li>
              </ul>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export function adminPageTitle(area: AdminArea, view: string): string {
  if (area === "events") return view === "import" ? "Import" : "Events";
  if (area === "sailors") {
    if (view === "duplicates") return "Duplicate sailors";
    if (view === "promotions") return "Promotions";
    if (view === "selection") return "Selection";
    return "Sailors";
  }
  if (area === "inbox") {
    if (view === "suggestions") return "Suggestions";
    if (view === "coaches") return "Coach access";
    if (view === "support") return "Support";
    return "Claims";
  }
  if (area === "insights") {
    if (view === "ilca") return "ILCA";
    if (view === "wingfoil") return "WingFoil workspace";
    if (view === "techno293") return "Techno 293 workspace";
    if (view === "metrics") return "Platform metrics";
    return "Optimist analysis";
  }
  if (area === "settings") {
    return view === "changelog" ? "Changelog" : "Audit log";
  }
  return "Overview";
}
