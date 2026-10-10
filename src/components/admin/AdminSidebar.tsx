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
  "inline-flex min-h-11 items-center gap-2 rounded-lg px-3 text-sm font-semibold text-slate-800 hover:bg-slate-100 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600";
const childCurrent =
  "inline-flex min-h-11 items-center gap-2 rounded-lg bg-[var(--sp-harbour-teal)] px-3 text-sm font-semibold text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600";

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
      href: areaHref({ area: "insights", view: "metrics", event: null, sheet: null }),
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

  const subnav: { key: string; href: string; label: string; current: boolean; count?: number }[] =
    activeArea === "events"
      ? [
          {
            key: "missing-results",
            href: areaHref({ area: "events", view: "missing-results", event: null, sheet: null }),
            label: "Missing results",
            current: eventsView === "missing-results",
          },
          {
            key: "ready-to-publish",
            href: areaHref({ area: "events", view: "ready-to-publish", event: null, sheet: null }),
            label: "Ready to publish",
            current: eventsView === "ready-to-publish",
          },
          {
            key: "attention",
            href: areaHref({ area: "events", view: "attention", event: null, sheet: null }),
            label: "Data health",
            current: eventsView === "attention",
          },
          {
            key: "import",
            href: areaHref({ area: "events", view: "import", event: null, sheet: null }),
            label: "Import",
            current: eventsView === "import",
          },
          {
            key: "wingfoil",
            href: areaHref({ area: "events", view: "wingfoil", event: null, sheet: null }),
            label: "WingFoil scoreboard",
            current: eventsView === "wingfoil",
          },
          {
            key: "techno293",
            href: areaHref({ area: "events", view: "techno293", event: null, sheet: null }),
            label: "Techno 293 scoreboard",
            current: eventsView === "techno293",
          },
        ]
      : activeArea === "sailors"
        ? (
            [
              ["directory", "Directory"],
              ["duplicates", "Duplicates"],
              ["promotions", "Promotions"],
              ["selection", "Selection"],
              ["ilca", "ILCA 4 squad"],
            ] as const
          ).map(([view, label]) => ({
            key: view,
            href: areaHref({ area: "sailors", view, event: null, sheet: null }),
            label,
            current: sailorsView === view,
          }))
        : activeArea === "inbox"
          ? (
              [
                ["suggestions", "Suggestions"],
                ["claims", "Claims"],
                ["coaches", "Coach access"],
                ["support", "Support"],
              ] as const
            ).map(([view, label]) => ({
              key: view,
              href: areaHref({ area: "inbox", view, event: null, sheet: null }),
              label,
              current: inboxView === view,
              count: queueCounts[view],
            }))
          : activeArea === "insights"
            ? (
                [
                  ["metrics", "Platform metrics"],
                  ["user-changes", "User changes"],
                ] as const
              ).map(([view, label]) => ({
                key: view,
                href: areaHref({ area: "insights", view, event: null, sheet: null }),
                label,
                current: insightsView === view,
              }))
            : activeArea === "settings"
              ? (
                  [
                    ["audit", "Audit log"],
                  ] as const
                ).map(([view, label]) => ({
                  key: view,
                  href: areaHref({ area: "settings", view, event: null, sheet: null }),
                  label,
                  current: settingsView === view,
                }))
              : [];

  return (
    <div className="flex flex-col gap-2 p-2 sm:px-3">
      <ul className="flex flex-wrap items-center gap-1">
        {items.map((item) => (
          <li key={item.area}>
            <Link
              href={item.href}
              aria-current={item.active ? "page" : undefined}
              onClick={(event) => guardLink(item.href, event)}
              className={`inline-flex min-h-11 items-center gap-2 rounded-xl px-3 text-sm font-bold focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600 ${
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
          </li>
        ))}
      </ul>
      {subnav.length > 0 && (
        <ul className="flex flex-wrap items-center gap-1 border-t border-slate-200 pt-2">
          {subnav.map((link) => (
            <li key={link.key}>
              <Link
                href={link.href}
                aria-current={link.current ? "page" : undefined}
                onClick={(event) => guardLink(link.href, event)}
                className={link.current ? childCurrent : childIdle}
              >
                <span>{link.label}</span>
                {link.count != null && link.count > 0 ? (
                  <span
                    className={`min-w-6 rounded-full px-1.5 text-center text-[11px] font-black ${
                      link.current ? "bg-white/20 text-white" : "bg-rose-600 text-white"
                    }`}
                  >
                    {link.count > 9 ? "9+" : link.count}
                  </span>
                ) : null}
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export function adminPageTitle(area: AdminArea, view: string): string {
  if (area === "events") {
    if (view === "import") return "Import";
    if (view === "missing-results") return "Missing results";
    if (view === "ready-to-publish") return "Ready to publish";
    if (view === "attention") return "Event data health";
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
    if (view === "user-changes") return "User changes";
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
