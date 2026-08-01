/**
 * Official ILCA 4 national ranking list (Singapore series).
 * Only these sailors appear on the ILCA 4 national ranking board.
 * Squad selection additionally requires SGP nationality.
 */

import { nameTokenKey } from "@/lib/nameMatch";

/** Display names as provided by the authority (Last, First …). */
export const ILCA4_NATIONAL_RANKING_NAMES: readonly string[] = [
  "Goh, Ian",
  "Chia, Ethan Han Wei",
  "Wong, Zachary Weikai",
  "Wan, Zeph",
  "Tew, Mika",
  "Lee, Nicholette Wee Wen",
  "Zahedi, Nia",
  "Lee, Desiree Yuet Chi",
  "Chang, Jemima",
  "Oh, Gabi",
  "Wong, Mildred Li Xuan",
  "Tham, Ashlea",
  "Peck, Caleb",
  "Wai, Zhi Tong",
  "Lim, Yuk Jun",
  "Wong, Kai Lun",
  "Bai, Jayden Zi Xi",
  "Pitsilis, Amandine Zoe",
  "Petracco, Julien Christian",
  "Tan, Reyes Jit Eng",
  "Kong, Charles Shing Chak",
  "Yong, Heng Yi",
  "Kong, James",
  "Yap, Isaiah Chor Hong",
  "Pee, Teck Woon",
  "Lee, Isla Zhi Xi",
  "Kiesselbach, Lukas",
  "Wong, Callum Joon Thang",
  "Yeh, Kate Zi Ning",
  "Yeo, Travis Jia Le",
  "Tan, Joash Jing En",
  "Lim, Lauren",
  "Ng, Nicholas Jiang En",
  "Tang, Kye",
  "Liao, ZhiTing",
  "Loh, Cory Zhi Hang",
  "Siwal, Preet",
  "Ong, Josh Yong Jun",
  "Kong, Cecilia Sze Sen",
  "Sim, Gerome",
  "Cao, Caleb Zhixuan",
  "Pandey, Aastha",
  "Kwok, Jonathan Kum Loong",
  "Verma, Mahi",
  "Chandrawanshi, Vasu",
  "Lim, Lucas Rui Kai",
  "Tan, Jonas Kia Jeng",
  "Rumvisai, Pacharapol",
  "Patle, Tulsi",
  "Phokaew, Thanaporn",
  "Tan, Joel Kai En",
  "Jaroenpon, Pailin",
  "Ogawa, Yunosuke",
  "Naidu, Alaric Shenthil",
  "Lee, Rayson Yin Yi",
  "Khoo, Joshua Zhuo Xi",
  "Tan, Kayden Yi Kai",
  "Xu, Jiayan",
  "Cheow, Mathias",
  "Bu, Ruiqiao",
  "Lim Laurie, Misa",
  "Sim, Germaine",
  "Bin Mohd Shahrom, Mohamed Mikail",
  "Teo, Tiffany",
  "Tay, Jamiroquai Kai Nuo",
  "Agea, Tomas",
  "Shahrom, Mikail",
  "Ha, Maximilian",
  "Chang, Rupert",
  "Sudjana, Judy",
  "Goy, Ethan",
  "Chen, Jun Jie",
  "Li, Sheng Rui",
] as const;

const NATIONAL_KEYS = new Set(
  ILCA4_NATIONAL_RANKING_NAMES.map((n) => nameTokenKey(n))
);

/** True when the sailor name matches the official ILCA 4 national list. */
export function isOnIlca4NationalList(name: string | null | undefined): boolean {
  if (!name || !String(name).trim()) return false;
  return NATIONAL_KEYS.has(nameTokenKey(name));
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
