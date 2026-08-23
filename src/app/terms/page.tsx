import type { Metadata } from "next";
import Link from "next/link";
import type { ReactNode } from "react";

export const metadata: Metadata = {
  title: "Terms | SailorPath",
  description:
    "Terms for using SailorPath rankings, sailor profiles, accounts, and private logbook features.",
};

export default function TermsPage() {
  return (
    <main className="mx-auto w-full max-w-3xl px-4 py-10 sm:py-14">
      <article className="space-y-8 text-sm leading-relaxed text-slate-300">
        <header className="space-y-3 border-b border-white/10 pb-6">
          <p className="text-xs font-bold uppercase tracking-wider text-orange-400">
            SailorPath
          </p>
          <h1 className="text-3xl font-black tracking-tight text-white">
            Terms of use
          </h1>
          <p className="text-slate-500">Effective 23 August 2026</p>
          <p className="text-slate-400">
            These terms describe the basic rules for using SailorPath. By using
            the service, you agree to use it responsibly and only for lawful
            purposes.
          </p>
        </header>

        <TermsSection title="Rankings and results">
          <p>
            SailorPath presents regatta information made available to the
            platform and calculates standings using the rules described in its
            ranking methodology. The original result publisher and applicable
            sailing authority remain the authoritative sources. SailorPath data
            may be delayed, incomplete, or corrected after publication.
          </p>
          <p>
            Do not rely on SailorPath alone for official entries, eligibility,
            selection decisions, protests, appeals, or other time-sensitive
            sailing decisions. Check the original notice, result, or authority
            where confirmation matters.
          </p>
        </TermsSection>

        <TermsSection title="Accounts and profile claims">
          <ul className="list-disc space-y-2 pl-5">
            <li>Provide accurate account and claim information.</li>
            <li>Keep account credentials private and secure.</li>
            <li>Claim or manage only profiles you are authorized to manage.</li>
            <li>
              Parents and guardians should supervise accounts and privacy choices
              for young sailors.
            </li>
          </ul>
          <p>
            SailorPath may reject, pause, or reverse a profile claim when the
            relationship cannot be confirmed or when access may put a sailor&apos;s
            privacy at risk.
          </p>
        </TermsSection>

        <TermsSection title="Your content and privacy choices">
          <p>
            You remain responsible for profile text, photos, notes, equipment
            information, and other content you add. Only upload content you have
            permission to use, and do not publish another person&apos;s private or
            sensitive information without authorization.
          </p>
          <p>
            Public sharing controls affect what other visitors can see. Review
            those settings carefully. Private family, logbook, and equipment
            features must not be used to harass, monitor, or expose another
            person.
          </p>
        </TermsSection>

        <TermsSection title="Acceptable use">
          <p>You must not:</p>
          <ul className="list-disc space-y-2 pl-5">
            <li>Submit false profile claims or impersonate another person.</li>
            <li>Attempt to access accounts or private information without permission.</li>
            <li>Disrupt, probe, scrape excessively, or misuse the service.</li>
            <li>Upload unlawful, harmful, infringing, or misleading content.</li>
            <li>Use SailorPath data to endanger, target, or exploit a young person.</li>
          </ul>
        </TermsSection>

        <TermsSection title="Corrections and moderation">
          <p>
            SailorPath may correct results, remove inappropriate user content,
            restrict access, or suspend an account when needed to protect users,
            data quality, or the service. If a result or profile is wrong,
            contact support with enough detail to review the source.
          </p>
        </TermsSection>

        <TermsSection title="Availability and changes">
          <p>
            Features may change, pause, or be withdrawn as SailorPath develops.
            The service may occasionally be unavailable, and no uninterrupted
            availability or error-free operation is promised. Planned features
            and roadmap dates are not guarantees of release.
          </p>
        </TermsSection>

        <TermsSection title="Privacy">
          <p>
            The <Link href="/privacy" className="font-semibold text-orange-400 hover:text-orange-300">Privacy page</Link>{" "}
            explains how SailorPath handles public results, account information,
            private profile data, and support requests.
          </p>
        </TermsSection>

        <TermsSection title="Questions or concerns">
          <p>
            Contact SailorPath support about these terms, a profile claim, or a
            data correction.
          </p>
          <Link
            href="/support"
            className="inline-flex rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white hover:bg-orange-500"
          >
            Contact support
          </Link>
        </TermsSection>
      </article>
    </main>
  );
}

function TermsSection({
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
