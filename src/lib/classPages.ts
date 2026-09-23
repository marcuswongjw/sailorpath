/** Public results pages for dinghy classes that are not Optimist or ILCA 4. */

export type DinghyClassKey = "ilca6" | "ilca7" | "29er";

export type DinghyClassPage = {
  key: DinghyClassKey;
  label: string;
  homePath: string;
  regattasPath: string;
  badgeLabel: string;
  description: string;
};

export const DINGHY_CLASS_PAGES: DinghyClassPage[] = [
  {
    key: "ilca6",
    label: "ILCA 6",
    homePath: "/sg/ilca6",
    regattasPath: "/sg/ilca6/regattas",
    badgeLabel: "SG ILCA 6",
    description:
      "Published Singapore ILCA 6 regatta results and race scores. A national ranking series is not published for this class yet.",
  },
  {
    key: "ilca7",
    label: "ILCA 7",
    homePath: "/sg/ilca7",
    regattasPath: "/sg/ilca7/regattas",
    badgeLabel: "SG ILCA 7",
    description:
      "Published Singapore ILCA 7 regatta results and race scores. A national ranking series is not published for this class yet.",
  },
  {
    key: "29er",
    label: "29er",
    homePath: "/sg/29er",
    regattasPath: "/sg/29er/regattas",
    badgeLabel: "SG 29er",
    description:
      "Published Singapore 29er regatta results and race scores. A national ranking series is not published for this class yet.",
  },
];

export function dinghyClassPage(key: DinghyClassKey): DinghyClassPage {
  const found = DINGHY_CLASS_PAGES.find((page) => page.key === key);
  if (!found) throw new Error(`Unknown dinghy class: ${key}`);
  return found;
}

function compactBoatClass(boatClass: string | null | undefined): string {
  return String(boatClass || "")
    .trim()
    .toLowerCase()
    .replace(/[\s._-]+/g, "");
}

/** Which class page owns this regatta boat-class label, if any. */
export function dinghyClassForBoatClass(
  boatClass: string | null | undefined
): DinghyClassPage | null {
  const a = compactBoatClass(boatClass);
  if (!a) return null;
  if (a === "ilca6" || a === "laserradial" || a === "radial") {
    return dinghyClassPage("ilca6");
  }
  if (a === "ilca7" || a === "laserstandard") {
    return dinghyClassPage("ilca7");
  }
  if (a === "29er") return dinghyClassPage("29er");
  return null;
}

/** Public results URL for a regatta, by boat class. */
export function regattaResultsHref(
  boatClass: string | null | undefined,
  slug: string
): string {
  const encoded = encodeURIComponent(slug);
  const dinghy = dinghyClassForBoatClass(boatClass);
  if (dinghy) return `${dinghy.regattasPath}/${encoded}`;
  const bc = String(boatClass || "").toLowerCase();
  if (bc.includes("ilca")) return `/sg/ilca4/regattas/${encoded}`;
  return `/sg/optimist/regattas/${encoded}`;
}
