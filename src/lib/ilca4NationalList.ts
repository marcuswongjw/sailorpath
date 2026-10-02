/**
 * ILCA 4 national ranking list helpers.
 *
 * Membership is stored on sailors.ilca4_national_list (admin-managed).
 * SEED_NAMES is the official authority list used to bootstrap flags by name match.
 * Squad selection additionally requires SGP nationality.
 */

import { nameTokenKey } from "@/lib/nameMatch";

/**
 * Display names from the SSF ILCA 4 national ranking, in national-rank order.
 * Source: https://sites.google.com/singaporesailing.org.sg/ranking/classes/ilca4
 * (published table, 81 sailors, captured 2026-10-02). Used for seed only.
 */
export const ILCA4_NATIONAL_RANKING_NAMES: readonly string[] = [
  "Goh, Ian",
  "Wong, Zachary Weikai",
  "Tew, Mika",
  "Wan, Zeph",
  "Chang, Jemima",
  "Lee, Desiree Yuet Chi",
  "Peck, Caleb",
  "Wai, Zhi Tong",
  "Pee, Teck Woon",
  "Wong, Mildred Li Xuan",
  "Lim, Yuk Jun",
  "Chia, Ethan Han Wei",
  "Bai, Jayden Zi Xi",
  "Petracco, Julien Christian",
  "Lee, Isla Zhi Xi",
  "Lee, Nicholette Wee Wen",
  "Zahedi, Nia",
  "Pitsilis, Amandine Zoe",
  "Kong, Charles Shing Chak",
  "Tan, Reyes Jit Eng",
  "Tham, Ashlea",
  "Yap, Isaiah Chor Hong",
  "Oh, Gabi",
  "Yeh, Kate Zi Ning",
  "Liao, ZhiTing",
  "Lim, Lucas Rui Kai",
  "Kong, James",
  "Wong, Kai Lun",
  "Cao, Lucas Zhihong",
  "Lim, Lauren",
  "Wong, Callum Joon Thang",
  "Tan, Joash Jing En",
  "Ong, Josh Yong Jun",
  "Sim, Gerome",
  "Tang, Kye",
  "Kwok, Jonathan Kum Loong",
  "Siwal, Preet",
  "Kong, Cecilia Sze Sen",
  "Yong, Heng Yi",
  "Kiesselbach, Lukas",
  "Lin, Shin Chen Rui",
  "Cao, Caleb Zhixuan",
  "Pandey, Aastha",
  "Yeo, Travis Jia Le",
  "Ng, Nicholas Jiang En",
  "Tan, Jonas Kia Jeng",
  "Verma, Mahi",
  "Chandrawanshi, Vasu",
  "Rumvisai, Pacharapol",
  "Patle, Tulsi",
  "Loh, Cory Zhi Hang",
  "Phokaew, Thanaporn",
  "Tan, Joel Kai En",
  "Khoo, Joshua Zhuo Xi",
  "Jaroenpon, Pailin",
  "Lee, Rayson Yin Yi",
  "Li, Lyric Yuxuan",
  "Xu, Jiayan",
  "Chang, Rupert",
  "Bin Mohd Shahrom, Mohamed Mikail",
  "Cheow, Mathias",
  "Lee, Ethan",
  "Bu, Ruiqiao",
  "Lim Laurie, Misa",
  "Ogawa, Yunosuke",
  "Naidu, Alaric Shenthil",
  "Sim, Germaine",
  "Tay, Jamiroquai Kai Nuo",
  "Teo, Tiffany",
  "Agea, Tomas",
  "Chan, Aaron",
  "Goy, Ethan",
  "Liew, Jared Soon Kit",
  "Kocourek, Daniel",
  "Wu, Qiyou",
  "Zhao, Chengwei",
  "Ji, Wenxin",
  "Sudjana, Judy",
  "Wong, Febe Qi Ke",
  "Ha, Maximilian",
  "Li, Sheng Rui",
] as const;

const NATIONAL_KEYS = new Set(
  ILCA4_NATIONAL_RANKING_NAMES.map((n) => nameTokenKey(n))
);

/** True when the display name matches a seed list entry (order-insensitive). */
export function isOnIlca4NationalListByName(
  name: string | null | undefined
): boolean {
  if (!name || !String(name).trim()) return false;
  return NATIONAL_KEYS.has(nameTokenKey(name));
}

/** @deprecated use isOnIlca4NationalListByName or isSailorOnIlca4NationalList */
export function isOnIlca4NationalList(
  name: string | null | undefined
): boolean {
  return isOnIlca4NationalListByName(name);
}

/**
 * Ranking membership: prefer DB flag; fall back to seed name list when flag
 * is unset (column not migrated / not yet seeded).
 */
export function isSailorOnIlca4NationalList(s: {
  name?: string | null;
  ilca4NationalList?: boolean | null;
}): boolean {
  if (s.ilca4NationalList === true) return true;
  if (s.ilca4NationalList === false) return false;
  return isOnIlca4NationalListByName(s.name);
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
