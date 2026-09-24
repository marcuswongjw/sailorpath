/**
 * ILCA 6 national ranking list helpers.
 *
 * Sourced from the official Singapore Sailing Federation ILCA 6 Fleet National Ranking.
 */

import { nameTokenKey } from "@/lib/nameMatch";

/** Display names as provided by the Singapore Sailing Federation ILCA 6 national ranking. */
export const ILCA6_NATIONAL_RANKING_NAMES: readonly string[] = [
  "Tan, Kenan Kee Zen",
  "Yeo, Austin Jia Yu",
  "Carlyle, Keira",
  "Yong, Sarah Rui-En",
  "Zahedi, Nia",
  "Allan, Gordon Alexander",
  "Oh, Gabi",
  "Wong, Kai Lun",
  "Teo, Jayden",
  "Lai, Darren",
  "Seah, Cleo En Rui",
  "Foo, Yuei Jit",
  "Ang, Justiin",
  "Leow, Aurick You Shun",
  "Oh, Eitan",
  "Yeo, Travis Jia Le",
  "Lee, Charlotte Wee Shuen",
  "Behl, Rohit",
  "Teo, Tiffany",
  "Lu, Zixi",
  "Say, Elizabeth Victoria",
  "Low, Darius Xian Rui",
  "Nair, Asher James",
  "Ho, Jonathan Jian Yi",
  "Khan, Sarfraz Ahmad",
  "Zhi En Tan, Josiah",
  "van Riel, Lucien Franciscus Henricus",
  "Chan, Bryan",
  "Tan, Arabelle En Xi",
] as const;

const NATIONAL_KEYS = new Set(
  ILCA6_NATIONAL_RANKING_NAMES.map((n) => nameTokenKey(n))
);

/** True when the display name matches an ILCA 6 national ranking list entry (order-insensitive). */
export function isOnIlca6NationalListByName(
  name: string | null | undefined
): boolean {
  if (!name || !String(name).trim()) return false;
  return NATIONAL_KEYS.has(nameTokenKey(name));
}

/**
 * Ranking membership for ILCA 6:
 * If an admin flag is set, respect it; otherwise fall back to the official SSF seed list.
 */
export function isSailorOnIlca6NationalList(s: {
  name?: string | null;
  ilca6NationalList?: boolean | null;
}): boolean {
  if (s.ilca6NationalList === true) return true;
  if (s.ilca6NationalList === false) return false;
  return isOnIlca6NationalListByName(s.name);
}

export function isSingaporeNationality(
  nationality: string | null | undefined
): boolean {
  const s = String(nationality || "")
    .trim()
    .toUpperCase()
    .replace(/\./g, "");
  if (!s) return false;
  if (s === "SGP" || s === "SG" || s === "SIN") return true;
  if (s === "SINGAPORE" || s === "REPUBLIC OF SINGAPORE") return true;
  return false;
}
