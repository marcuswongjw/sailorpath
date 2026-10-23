import Link from "next/link";

export function AccountWorkspaces({ isCoach, isSuperadmin }: { isCoach: boolean; isSuperadmin: boolean }) {
  const workspaces = [
    { href: "/athlete", title: "My logbook", description: "Add regatta results, source documents and equipment." },
    ...(isCoach
      ? [{ href: "/account/coach", title: "Squad dashboard", description: "Review your squad, results and development priorities." }]
      : [{ href: "/account/parent", title: "Family dashboard", description: "See linked sailors, standings and race-day preparation." }]),
    { href: "/following", title: "Following", description: "Catch up on results for the sailors you follow." },
    ...(isSuperadmin
      ? [{ href: "https://admin.sailorpath.com/", title: "Admin console", description: "Review requests and maintain sailing records." }]
      : []),
  ];

  return (
    <section aria-labelledby="account-workspaces" className="space-y-3">
      <h2 id="account-workspaces" className="text-xl font-bold text-harbour-shadow">Continue your sailing</h2>
      <div className="grid gap-3 sm:grid-cols-2">
        {workspaces.map(({ href, title, description }) => (
          <Link key={href} href={href} className="rounded-2xl border border-cool-veil bg-warm-white p-5 transition hover:border-harbour focus-visible:outline-2 focus-visible:outline-harbour">
            <span className="block text-base font-bold text-harbour">{title} <span aria-hidden>→</span></span>
            <span className="mt-2 block text-sm leading-6 text-slate-soft">{description}</span>
          </Link>
        ))}
      </div>
      <div className="flex flex-wrap gap-x-5 gap-y-2 text-sm font-semibold text-harbour">
        <a href="#settings" className="inline-flex min-h-11 items-center hover:underline">Account settings</a>
        {!isCoach && !isSuperadmin && <Link href="/account/coach" className="inline-flex min-h-11 items-center hover:underline">Request coach access</Link>}
      </div>
    </section>
  );
}
