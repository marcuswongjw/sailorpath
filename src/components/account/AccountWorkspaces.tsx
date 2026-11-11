import Link from "next/link";
import { BookOpen, Bookmark, Heart, ShieldCheck, Users } from "lucide-react";

type WorkspaceItem = {
  href: string;
  title: string;
  description: string;
  icon: typeof BookOpen;
};

export function AccountWorkspaces({
  isCoach,
  isParent,
  isSuperadmin,
  ownedCount = 0,
  primarySailorId,
  showLogbook = true,
}: {
  isCoach: boolean;
  isParent: boolean;
  isSuperadmin: boolean;
  ownedCount?: number;
  primarySailorId?: string;
  showLogbook?: boolean;
}) {
  const logbookHref =
    ownedCount === 1 && primarySailorId
      ? `/athlete?id=${encodeURIComponent(primarySailorId)}`
      : "/athlete";

  const workspaces: WorkspaceItem[] = [
    ...(showLogbook && ownedCount > 0
      ? [
          {
            href: logbookHref,
            title: "My logbook",
            description: "Add regatta results, source documents and equipment.",
            icon: BookOpen,
          },
        ]
      : []),
    ...(isCoach
      ? [
          {
            href: "/account/coach",
            title: "Squad dashboard",
            description: "Review your squad, results and development priorities.",
            icon: Users,
          },
        ]
      : []),
    ...(isParent
      ? [
          {
            href: "/account/parent",
            title: "Family dashboard",
            description: "See linked sailors, standings and race-day preparation.",
            icon: Heart,
          },
        ]
      : []),
    {
      href: "/following",
      title: "Following",
      description: "Catch up on results for the sailors you follow.",
      icon: Bookmark,
    },
    ...(isSuperadmin
      ? [
          {
            href: "https://admin.sailorpath.com/",
            title: "Admin console",
            description: "Review requests and maintain sailing records.",
            icon: ShieldCheck,
          },
        ]
      : []),
  ];

  const isSingleRow = workspaces.length === 1;

  return (
    <section
      aria-label={isSingleRow ? "Continue your sailing" : undefined}
      aria-labelledby={isSingleRow ? undefined : "account-workspaces"}
      className="space-y-3"
    >
      {!isSingleRow && (
        <h2 id="account-workspaces" className="text-sm font-bold text-charcoal uppercase tracking-wider">
          Continue your sailing
        </h2>
      )}
      <div className={isSingleRow ? "grid gap-3" : "grid gap-3 sm:grid-cols-2"}>
        {workspaces.map(({ href, title, description, icon: Icon }) => (
          <Link
            key={href}
            href={href}
            className={`group rounded-2xl border border-cool-veil bg-warm-white transition hover:border-harbour hover:shadow-xs focus-visible:outline-2 focus-visible:outline-harbour ${
              isSingleRow
                ? "flex items-center justify-between gap-4 px-5 py-4"
                : "p-5"
            }`}
          >
            {isSingleRow ? (
              <>
                <div className="flex items-center gap-3 min-w-0">
                  <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-xl bg-sailcloth text-racing-orange">
                    <Icon className="h-4 w-4" aria-hidden="true" />
                  </span>
                  <div className="min-w-0">
                    <span className="block text-sm font-bold text-harbour">
                      {title}
                    </span>
                    <span className="block text-xs text-slate-soft truncate">
                      {description}
                    </span>
                  </div>
                </div>
                <span
                  aria-hidden="true"
                  className="shrink-0 text-harbour transition-transform motion-reduce:transition-none group-hover:translate-x-0.5"
                >
                  →
                </span>
              </>
            ) : (
              <>
                <div className="flex items-center justify-between gap-2">
                  <span className="inline-flex items-center gap-2 text-base font-bold text-harbour">
                    <Icon className="h-4 w-4 shrink-0 text-racing-orange" aria-hidden="true" />
                    <span>{title}</span>
                  </span>
                  <span
                    aria-hidden="true"
                    className="text-harbour transition-transform motion-reduce:transition-none group-hover:translate-x-0.5"
                  >
                    →
                  </span>
                </div>
                <span className="mt-2 block text-sm leading-6 text-slate-soft">
                  {description}
                </span>
              </>
            )}
          </Link>
        ))}
      </div>
    </section>
  );
}
