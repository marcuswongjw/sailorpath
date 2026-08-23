import type { Metadata } from "next";
import Link from "next/link";
import type { ReactNode } from "react";

export const metadata: Metadata = {
  title: "Privacy | SailorPath",
  description:
    "How SailorPath handles public sailing results, account information, private profile data, and support requests.",
};

export default function PrivacyPage() {
  return (
    <main className="mx-auto w-full max-w-3xl px-4 py-10 sm:py-14">
      <article className="space-y-8 text-sm leading-relaxed text-slate-300">
        <header className="space-y-3 border-b border-white/10 pb-6">
          <p className="text-xs font-bold uppercase tracking-wider text-orange-400">
            SailorPath
          </p>
          <h1 className="text-3xl font-black tracking-tight text-white">
            Privacy
          </h1>
          <p className="text-slate-500">Effective 23 August 2026</p>
          <p className="text-slate-400">
            This page explains what information SailorPath uses, what may appear
            publicly, and how sailors and families can ask for help with their
            data.
          </p>
        </header>

        <PolicySection title="Information shown publicly">
          <p>
            SailorPath may display information found in published regatta
            results or maintained for ranking purposes, including a sailor&apos;s
            name, sail number, club, nationality, gender, birth year, fleet,
            squad status, regatta results, race scores, and calculated
            standings.
          </p>
          <p>
            A claimed profile may also display information its manager chooses
            to share, such as a profile photo, biography, school, Instagram
            handle, milestones, full date of birth, or weight. Sharing controls
            should be reviewed before saving profile changes.
          </p>
        </PolicySection>

        <PolicySection title="Information kept private">
          <p>
            Account email addresses, private family notes, equipment records,
            and information not selected for public sharing are intended for
            the account holder and authorized linked users. Full dates of birth
            and weight remain private unless a profile manager chooses to share
            them. Birth year may still appear publicly when it is part of the
            sailor record.
          </p>
        </PolicySection>

        <PolicySection title="Information you provide">
          <p>
            SailorPath receives information when you create an account, claim a
            profile, edit a profile, add notes or equipment, join a waitlist, or
            contact support. Claim notes and account details may be reviewed by
            authorized administrators to decide whether an account should be
            linked to a sailor.
          </p>
        </PolicySection>

        <PolicySection title="Basic service activity">
          <p>
            SailorPath records limited technical and usage information needed to
            operate, secure, and improve the service. This can include page or
            feature activity, an anonymous browser or session identifier,
            device category, referral source, and error information. Free-text
            searches and private profile content should not be used as analytics
            event data.
          </p>
        </PolicySection>

        <PolicySection title="Why information is used">
          <ul className="list-disc space-y-2 pl-5">
            <li>To publish regatta results and calculate standings.</li>
            <li>To create, secure, and manage accounts and profile claims.</li>
            <li>To provide private logbook, family, and equipment features.</li>
            <li>To respond to support requests and correct data.</li>
            <li>To monitor reliability, prevent misuse, and improve SailorPath.</li>
          </ul>
        </PolicySection>

        <PolicySection title="Service providers">
          <p>
            SailorPath uses service providers to host the application, store
            data, authenticate accounts, and operate support and communications.
            Those providers may process information for SailorPath as needed to
            provide their services.
          </p>
        </PolicySection>

        <PolicySection title="Youth sailors and guardians">
          <p>
            SailorPath is designed around youth sailing. A parent or guardian
            should supervise a young sailor&apos;s account, profile claim, privacy
            choices, and submission of personal information. Do not add private
            information about another sailor unless you are authorized to do so.
          </p>
        </PolicySection>

        <PolicySection title="Corrections, access, and deletion">
          <p>
            To report an incorrect result, correct profile information, ask
            about the information associated with an account, or request account
            or private-data deletion, use the SailorPath support form. Some
            published result information may need to be retained or corrected
            rather than removed so that standings and regatta records remain
            accurate.
          </p>
          <Link
            href="/support"
            className="inline-flex rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white hover:bg-orange-500"
          >
            Contact support
          </Link>
        </PolicySection>

        <PolicySection title="Changes to this page">
          <p>
            This notice may change as SailorPath develops. The effective date
            above will be updated when the notice changes materially.
          </p>
        </PolicySection>
      </article>
    </main>
  );
}

function PolicySection({
  title,
  children,
}: {
  title: string;
  children: ReactNode;
}) {
  return (
    <section className="space-y-3">
      <h2 className="text-lg font-bold text-white">{title}</h2>
      {children}
    </section>
  );
}
