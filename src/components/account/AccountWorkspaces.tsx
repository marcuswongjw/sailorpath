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
  onOpenSettings,
}: {
  isCoach: boolean;
  isParent: boolean;
  isSuperadmin: boolean;
  ownedCount?: number;
  primarySailorId?: string;
  onOpenSettings?: () => void;
}) {
  const logbookHref =
    ownedCount === 1 && primarySailorId
      ? `/athlete?id=${encodeURIComponent(primarySailorId)}`
      : "/athlete";

  const workspaces: WorkspaceItem[] = [
    ...(ownedCount > 0
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

  return (
    <section aria-labelledby="account-workspaces" className="space-y-3">
      <h2 id="account-workspaces" className="text-lg sm:text-xl font-bold text-harbour-shadow">
        Continue your sailing
      </h2>
      <div className="grid gap-3 sm:grid-cols-2">
        {workspaces.map(({ href, title, description, icon: Icon }) => (
          <Link
            key={href}
            href={href}
            className="group rounded-2xl border border-cool-veil bg-warm-white p-5 transition hover:border-harbour hover:shadow-xs focus-visible:outline-2 focus-visible:outline-harbour"
          >
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
          </Link>
        ))}
      </div>
      <div className="flex flex-wrap gap-x-5 gap-y-2 text-sm font-semibold text-harbour">
        <a
          href="#settings"
          onClick={() => onOpenSettings?.()}
          className="inline-flex min-h-11 items-center hover:underline"
        >
          Account settings
        </a>
        {!isCoach && !isSuperadmin && (
          <Link href="/account/coach" className="inline-flex min-h-11 items-center hover:underline">
            Request coach access
          </Link>
        )}
      </div>
    </section>
  );
}
