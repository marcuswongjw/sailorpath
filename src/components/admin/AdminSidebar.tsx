"use client";

import Link from "next/link";
import type { MouseEvent } from "react";
import {
  BarChart3,
  Calendar,
  Gauge,
  Inbox,
  Settings,
  Users,
} from "lucide-react";
import {
  serializeAdminArea,
  type AdminArea,
  type AdminInboxView,
} from "@/components/admin/adminNav";

type Item = {
  area: AdminArea;
  label: string;
  href: string;
  active: boolean;
  count?: number;
};

function areaHref(state: Parameters<typeof serializeAdminArea>[0]) {
  return `/admin?${serializeAdminArea(state)}`;
}

const childIdle =
  "flex min-h-11 items-center justify-between gap-2 rounded-lg px-3 text-sm font-semibold text-slate-800 hover:bg-slate-100 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600";
const childCurrent =
  "flex min-h-11 items-center justify-between gap-2 rounded-lg bg-[var(--sp-harbour-teal)] px-3 text-sm font-semibold text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600";

export function AdminSidebar({
  activeArea,
  sailorsView,
  inboxView,
  insightsView,
  settingsView,
  eventsView,
  inboxCount,
  queueCounts,
  landingView,
  onNavigate,
}: {
  activeArea: AdminArea;
  sailorsView: string;
  inboxView: string;
  insightsView: string;
  settingsView: string;
  eventsView: string;
  inboxCount: number;
  queueCounts: Partial<Record<AdminInboxView, number>>;
  landingView: AdminInboxView;
  onNavigate: (href: string) => boolean;
}) {
  const items: Item[] = [
    {
      area: "overview",
      label: "Overview",
      href: areaHref({ area: "overview", view: "home", event: null, sheet: null }),
      active: activeArea === "overview",
    },
    {
      area: "events",
      label: "Events",
      href: areaHref({ area: "events", view: "card", event: null, sheet: null }),
      active: activeArea === "events",
    },
    {
      area: "sailors",
      label: "Sailors",
      href: areaHref({ area: "sailors", view: "directory", event: null, sheet: null }),
      active: activeArea === "sailors",
    },
    {
      area: "inbox",
      label: "Inbox",
      href: areaHref({ area: "inbox", view: landingView, event: null, sheet: null }),
      active: activeArea === "inbox",
      count: inboxCount,
    },
    {
      area: "insights",
      label: "Insights",
      href: areaHref({ area: "insights", view: "optimist", event: null, sheet: null }),
      active: activeArea === "insights",
    },
    {
      area: "settings",
      label: "Settings",
      href: areaHref({ area: "settings", view: "audit", event: null, sheet: null }),
      active: activeArea === "settings",
    },
  ];

  const guardLink = (href: string, event: MouseEvent<HTMLAnchorElement>) => {
    if (!onNavigate(href)) event.preventDefault();
  };

  const child = (href: string, label: string, current: boolean, count?: number) => (
    <Link
      href={href}
      aria-current={current ? "page" : undefined}
      onClick={(event) => guardLink(href, event)}
      className={current ? childCurrent : childIdle}
    >
      <span>{label}</span>
      {count != null && count > 0 ? (
        <span
          className={`min-w-6 rounded-full px-1.5 text-center text-[11px] font-black ${
            current ? "bg-white/20 text-white" : "bg-rose-600 text-white"
          }`}
        >
          {count > 9 ? "9+" : count}
        </span>
      ) : null}
    </Link>
  );

  return (
    <div className="flex h-full flex-col gap-1 p-3">
      <p className="px-3 pb-2 text-[11px] font-black uppercase tracking-wider text-slate-600">
        SailorPath
      </p>
      <ul className="space-y-1">
        {items.map((item) => (
          <li key={item.area}>
            <Link
              href={item.href}
              aria-current={item.active ? "page" : undefined}
              onClick={(event) => guardLink(item.href, event)}
              className={`flex min-h-11 items-center justify-between gap-2 rounded-xl px-3 text-sm font-bold focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600 ${
                item.active
                  ? "bg-[var(--sp-harbour-teal)] text-white"
                  : "text-slate-900 hover:bg-slate-100"
              }`}
            >
              <span className="inline-flex items-center gap-2">
                {item.area === "overview" && <Gauge className="h-4 w-4" aria-hidden="true" />}
                {item.area === "events" && <Calendar className="h-4 w-4" aria-hidden="true" />}
                {item.area === "sailors" && <Users className="h-4 w-4" aria-hidden="true" />}
                {item.area === "inbox" && <Inbox className="h-4 w-4" aria-hidden="true" />}
                {item.area === "insights" && <BarChart3 className="h-4 w-4" aria-hidden="true" />}
                {item.area === "settings" && <Settings className="h-4 w-4" aria-hidden="true" />}
                {item.label}
              </span>
              {item.count != null && item.count > 0 && (
                <span className="min-w-6 rounded-full bg-rose-600 px-1.5 text-center text-[11px] font-black text-white">
                  {item.count > 9 ? "9+" : item.count}
                </span>
              )}
            </Link>
            {item.active && item.area === "events" && (
              <ul className="mt-1 space-y-1 pl-3">
                <li>
                  {child(
                    areaHref({ area: "events", view: "import", event: null, sheet: null }),
                    "Import",
                    eventsView === "import"
                  )}
                </li>
                <li>
                  {child(
                    areaHref({ area: "events", view: "wingfoil", event: null, sheet: null }),
                    "WingFoil scoreboard",
                    eventsView === "wingfoil"
                  )}
                </li>
                <li>
                  {child(
                    areaHref({ area: "events", view: "techno293", event: null, sheet: null }),
                    "Techno 293 scoreboard",
                    eventsView === "techno293"
                  )}
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
                    ["ilca", "ILCA 4 squad"],
                  ] as const
                ).map(([view, label]) => (
                  <li key={view}>
                    {child(
                      areaHref({ area: "sailors", view, event: null, sheet: null }),
                      label,
                      sailorsView === view
                    )}
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
                    {child(
                      areaHref({ area: "inbox", view, event: null, sheet: null }),
                      label,
                      inboxView === view,
                      queueCounts[view]
                    )}
                  </li>
                ))}
              </ul>
            )}
            {item.active && item.area === "insights" && (
              <ul className="mt-1 space-y-1 pl-3">
                {(
                  [
                    ["optimist", "Optimist analysis"],
                    ["metrics", "Platform metrics"],
                  ] as const
                ).map(([view, label]) => (
                  <li key={view}>
                    {child(
                      areaHref({ area: "insights", view, event: null, sheet: null }),
                      label,
                      insightsView === view
                    )}
                  </li>
                ))}
              </ul>
            )}
            {item.active && item.area === "settings" && (
              <ul className="mt-1 space-y-1 pl-3">
                {(
                  [
                    ["audit", "Audit log"],
                    ["changelog", "Changelog"],
                    ["tools", "Maintenance"],
                  ] as const
                ).map(([view, label]) => (
                  <li key={view}>
                    {child(
                      areaHref({ area: "settings", view, event: null, sheet: null }),
                      label,
                      settingsView === view
                    )}
                  </li>
                ))}
              </ul>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export function adminPageTitle(area: AdminArea, view: string): string {
  if (area === "events") {
    if (view === "import") return "Import";
    if (view === "wingfoil") return "WingFoil";
    if (view === "techno293") return "Techno 293";
    return "Events";
  }
  if (area === "sailors") {
    if (view === "duplicates") return "Duplicate sailors";
    if (view === "promotions") return "Promotions";
    if (view === "selection") return "Selection";
    if (view === "ilca") return "ILCA 4 squad";
    return "Sailors";
  }
  if (area === "inbox") {
    if (view === "suggestions") return "Suggestions";
    if (view === "coaches") return "Coach access";
    if (view === "support") return "Support";
    return "Claims";
  }
  if (area === "insights") {
    if (view === "metrics") return "Platform metrics";
    return "Optimist analysis";
  }
  if (area === "settings") {
    if (view === "changelog") return "Changelog";
    if (view === "tools") return "Maintenance";
    return "Audit log";
  }
  return "Overview";
}
