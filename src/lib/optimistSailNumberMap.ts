/**
 * Master Optimist Sailor Sail Numbers & Nationalities
 * Extracted directly from official Singapore Optimist rankings tables.
 */

export type OptimistSailorInfo = {
  name: string;
  sailNumber: string;
  nationality: string;
  rank?: number;
};

export const OPTIMIST_SAILOR_SAIL_NUMBERS: OptimistSailorInfo[] = [
  // Rank 1 - 25
  { rank: 1, name: "Muhammad Rehan Bin Mohamed Salim", nationality: "SGP", sailNumber: "2059" },
  { rank: 2, name: "Moyan Han", nationality: "SGP", sailNumber: "2042" },
  { rank: 3, name: "Bryan Thian Tsek Lee", nationality: "SGP", sailNumber: "3508" },
  { rank: 4, name: "Jiaqian Wu", nationality: "SGP", sailNumber: "3424" },
  { rank: 5, name: "Ryan Feiran Zheng", nationality: "SGP", sailNumber: "2045" },
  { rank: 6, name: "Skyler Kang", nationality: "SGP", sailNumber: "2041" },
  { rank: 7, name: "Henry Shayan Mittelhauser", nationality: "SGP", sailNumber: "2052" },
  { rank: 8, name: "Jiayi Du", nationality: "CHN", sailNumber: "3141" },
  { rank: 9, name: "Adele Ziyi Chiang", nationality: "SGP", sailNumber: "3120" },
  { rank: 10, name: "Kiyansh Kanishk Singh", nationality: "SGP", sailNumber: "2046" },
  { rank: 11, name: "Axel Lin", nationality: "SGP", sailNumber: "720" },
  { rank: 12, name: "Enzo Kengsin Teo", nationality: "SGP", sailNumber: "2044" },
  { rank: 13, name: "Seraphina Kang", nationality: "SGP", sailNumber: "2040" },
  { rank: 14, name: "Hongren Wang", nationality: "SGP", sailNumber: "2039" },
  { rank: 15, name: "Jerome Puah Yang Yi", nationality: "SGP", sailNumber: "2037" },
  { rank: 16, name: "Isaac Tan", nationality: "SGP", sailNumber: "2055" },
  { rank: 17, name: "Thaddaeus Renz", nationality: "SGP", sailNumber: "2058" },
  { rank: 18, name: "Sven Xin Chen Lim", nationality: "SGP", sailNumber: "3893" },
  { rank: 19, name: "Yong Le Wai", nationality: "SGP", sailNumber: "3488" },
  { rank: 20, name: "Ezra Yi Yang Mak", nationality: "SGP", sailNumber: "3535" },
  { rank: 21, name: "Damien Seah", nationality: "SGP", sailNumber: "3825" },
  { rank: 22, name: "Oliver Rui Heng Cheong", nationality: "SGP", sailNumber: "3515" },
  { rank: 23, name: "Jae Guan Yu Toh", nationality: "SGP", sailNumber: "3311" },
  { rank: 24, name: "Emil Lam", nationality: "SGP", sailNumber: "2049" },
  { rank: 25, name: "Neel Paul Behl.", nationality: "USA", sailNumber: "88" },

  // Rank 26 - 50
  { rank: 26, name: "Ian Shao Feng Teng", nationality: "SGP", sailNumber: "718" },
  { rank: 27, name: "Nadia Zahedi", nationality: "SGP", sailNumber: "4724" },
  { rank: 28, name: "Llewellyn Ding Zhe Tay", nationality: "SGP", sailNumber: "3013" },
  { rank: 29, name: "Allison Li Xin Teh", nationality: "SGP", sailNumber: "787" },
  { rank: 30, name: "Xiang Yu Du", nationality: "CHN", sailNumber: "3761" },
  { rank: 31, name: "Ilysha Wong", nationality: "SGP", sailNumber: "2530" },
  { rank: 32, name: "Sumire Sayawaki-Kogut", nationality: "POL", sailNumber: "710" },
  { rank: 33, name: "Amelie Camille Pitsilis", nationality: "FRA", sailNumber: "702" },
  { rank: 34, name: "Nurul 'Afiya Binte Mohamed Shahrom", nationality: "SGP", sailNumber: "703" },
  { rank: 35, name: "Yu an Li", nationality: "SGP", sailNumber: "2056" },
  { rank: 36, name: "Tobias Ng", nationality: "SGP", sailNumber: "3469" },
  { rank: 37, name: "Deborah Goh", nationality: "SGP", sailNumber: "2067" },
  { rank: 38, name: "Liang Zheng Zachary Chew", nationality: "SGP", sailNumber: "3666" },
  { rank: 39, name: "Hillary Kai Hui Tan", nationality: "SGP", sailNumber: "777" },
  { rank: 40, name: "An Hu", nationality: "CHN", sailNumber: "2050" },
  { rank: 41, name: "Andrea Kwan", nationality: "SGP", sailNumber: "3745" },
  { rank: 42, name: "Jacob Jit Yeung Kok", nationality: "SGP", sailNumber: "3087" },
  { rank: 43, name: "Evan Yu", nationality: "SGP", sailNumber: "2068" },
  { rank: 44, name: "Christopher Tan", nationality: "SGP", sailNumber: "2057" },
  { rank: 45, name: "Efrem Mak", nationality: "SGP", sailNumber: "3222" },
  { rank: 46, name: "Yixia Sun", nationality: "SGP", sailNumber: "2061" },
  { rank: 47, name: "Hadrian Zi Yi Soh", nationality: "SGP", sailNumber: "3839" },
  { rank: 48, name: "Dylan Cheng", nationality: "SGP", sailNumber: "2062" },
  { rank: 49, name: "Youxun Wu", nationality: "SGP", sailNumber: "3070" },
  { rank: 50, name: "Isaias Cheow", nationality: "SGP", sailNumber: "3307" },
  { rank: 50, name: "Ethan Mathew", nationality: "SGP", sailNumber: "3841" },

  // Subsequent Ranks
  { name: "Yvette Yi Min Chow", nationality: "SGP", sailNumber: "3151" },
  { name: "Dan Guan You Toh", nationality: "SGP", sailNumber: "3811" },
  { name: "Amy Luo", nationality: "HKG", sailNumber: "194" },
  { name: "Jeremiah Rui Feng Ong", nationality: "SGP", sailNumber: "3373" },
  { name: "Yuk Pin Lim", nationality: "SGP", sailNumber: "3880" },
  { name: "Abby Yan Ying Chen", nationality: "SGP", sailNumber: "4729" },
  { name: "Katelynn Kai En Lee", nationality: "SGP", sailNumber: "3383" },
  { name: "Olivia Ting Jia Cheong", nationality: "SGP", sailNumber: "3002" },
  { name: "Christopher Soh", nationality: "SGP", sailNumber: "3168" },
  { name: "Aaron Zhiyi Chiang", nationality: "SGP", sailNumber: "3128" },
  { name: "Luke Yi Jie Loh", nationality: "SGP", sailNumber: "3322" },
  { name: "Tan Qi", nationality: "SGP", sailNumber: "3026" },
  { name: "Ashleigh Li Ying Teh", nationality: "SGP", sailNumber: "788" },
  { name: "Wangsun Chen", nationality: "MAC", sailNumber: "362" },
  { name: "Yiannis Zannikos", nationality: "GRE", sailNumber: "704" },
  { name: "Euan Hao Xuan Poh", nationality: "SGP", sailNumber: "2030" },
  { name: "Isabelle Xinyi Zhang", nationality: "SGP", sailNumber: "2035" },
  { name: "Qiheng Liu", nationality: "HKG", sailNumber: "238" },
  { name: "Wenbo Yan", nationality: "CHN", sailNumber: "146" },
  { name: "Hayley Kai En Tan", nationality: "SGP", sailNumber: "700" },
  { name: "George Kai Whittington", nationality: "GBR", sailNumber: "799" },
  { name: "Yen Yu Kai", nationality: "SGP", sailNumber: "758" },
  { name: "Valorie Bezy", nationality: "HKG", sailNumber: "156" },
  { name: "Nigel Jiang Long Ng", nationality: "SGP", sailNumber: "3363" },
  { name: "Hanyue Ouyang", nationality: "SGP", sailNumber: "5003" },
  { name: "Matthias Kai Lun Lee", nationality: "SGP", sailNumber: "3385" },
  { name: "Chen-Yi Kai", nationality: "SGP", sailNumber: "757" },
  { name: "Xavier Yang Zheng Puah", nationality: "SGP", sailNumber: "2037" },
  { name: "Kyan Chun Hong Tan", nationality: "SGP", sailNumber: "3712" },
  { name: "Quintan Rupert Low", nationality: "SGP", sailNumber: "4681" },
  { name: "Yiru Hua", nationality: "CHN", sailNumber: "3826" },
  { name: "Yasin Yusuf Yusfianshah", nationality: "SGP", sailNumber: "3575" },

  { name: "Alyssa Li Lin Wong", nationality: "SGP", sailNumber: "150" },
  { name: "Ashlyn Tham", nationality: "SGP", sailNumber: "100" },
  { name: "Rahul Rajakanth", nationality: "SGP", sailNumber: "2006" },
  { name: "Nathaniel Kaiden Ng", nationality: "SGP", sailNumber: "3344" },
  { name: "Kevin Jun Yi Ho", nationality: "SGP", sailNumber: "171" },
  { name: "Elijah Ong", nationality: "SGP", sailNumber: "140" },
  { name: "Anya Alessia Zahedi", nationality: "SGP", sailNumber: "159" },
  { name: "Rohan Maliah", nationality: "HKG", sailNumber: "197" },
  { name: "Jedd Zhi Hao Lam", nationality: "SGP", sailNumber: "2000" },
  { name: "Darian Huang", nationality: "SGP", sailNumber: "131" },
  { name: "Elliot Goh", nationality: "SGP", sailNumber: "3103" },
  { name: "Timothy Kai Zhe Ng", nationality: "SGP", sailNumber: "2023" },
  { name: "Kaelyn Dayna Zhi Yi Soh", nationality: "SGP", sailNumber: "3113" },
  { name: "Kyle Jeremy Zhi Jun Soh", nationality: "SGP", sailNumber: "3183" },
  { name: "Jaye Xi En Low", nationality: "SGP", sailNumber: "3279" },
  { name: "William Poon", nationality: "INA", sailNumber: "21" },
  { name: "Damien Huang", nationality: "SGP", sailNumber: "3300" },
  { name: "Wenyu Cheng", nationality: "CHN", sailNumber: "5051" },
  { name: "Jairus Xin Jie Teo", nationality: "SGP", sailNumber: "4073" },
  { name: "Kirsten En Ting Tan", nationality: "SGP", sailNumber: "3663" },
  { name: "Mikaela Hui Ting Wong", nationality: "SGP", sailNumber: "3029" },
  { name: "Ethan Zhi Ren Low", nationality: "SGP", sailNumber: "78" },
  { name: "Joshua Zhi Kai Tan", nationality: "SGP", sailNumber: "3036" },
  { name: "Siti Ra'idah Binte Mohd Airudin", nationality: "SGP", sailNumber: "1141" },
  { name: "Rachel Qian Hui Lim", nationality: "SGP", sailNumber: "3197" },
  { name: "Lavene Rui Xuan Lim", nationality: "SGP", sailNumber: "3553" },
  { name: "Edrei En Xu Ong", nationality: "SGP", sailNumber: "3957" },
  { name: "Meera Srihari", nationality: "SGP", sailNumber: "3889" },
  { name: "Joseph Kia Guan Tan", nationality: "SGP", sailNumber: "3688" },
  { name: "Nicole Jing Chen Wong", nationality: "SGP", sailNumber: "143" },
  { name: "Dylan Yue Teng Goh", nationality: "SGP", sailNumber: "3800" },

  { name: "Yan Cheng Loh", nationality: "SGP", sailNumber: "3717" },
  { name: "Chloe Ariane Pitsilis", nationality: "FRA", sailNumber: "708" },
  { name: "Yusen Wang", nationality: "CHN", sailNumber: "1048" },
  { name: "Iver Zhe Xi Lee", nationality: "SGP", sailNumber: "3309" },
  { name: "Auwin Zhao Hong Leow", nationality: "SGP", sailNumber: "3405" },
  { name: "Qinghe Wu", nationality: "CHN", sailNumber: "6" },
  { name: "Cyra Cama", nationality: "FRA", sailNumber: "29" },
  { name: "Kai Jie Teo", nationality: "SGP", sailNumber: "3550" },
  { name: "Arun John Behl", nationality: "USA", sailNumber: "88" },
  { name: "Hagen Goh", nationality: "SGP", sailNumber: "3600" },
  { name: "Ivor Zhuo Xi Lee", nationality: "SGP", sailNumber: "3306" },
  { name: "Zachary Zhi En Low", nationality: "SGP", sailNumber: "3369" },
  { name: "Zachary Hoo", nationality: "SGP", sailNumber: "2051" },
  { name: "Clara Siew Ning Ng", nationality: "SGP", sailNumber: "3739" },
  { name: "Yumeng Li", nationality: "CHN", sailNumber: "68" },
  { name: "Evan En Kai Ong", nationality: "SGP", sailNumber: "3955" },
  { name: "Xiaoxi Dong", nationality: "CHN", sailNumber: "112" },
  { name: "Lyric Yuxuan Li", nationality: "SGP", sailNumber: "728" },
  { name: "Ethan Jing Zhou Tan", nationality: "SGP", sailNumber: "3772" },
  { name: "Charlene Heng Ning Yong", nationality: "SGP", sailNumber: "766" },
];

/**
 * Normalizes a sailor name for robust matching.
 */
export function cleanOptimistSailorName(name: string): string {
  if (!name) return "";
  return name
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9 ]/g, "")
    .replace(/\s+/g, " ")
    .trim();
}

const SAILOR_MAP = new Map<string, OptimistSailorInfo>();
for (const item of OPTIMIST_SAILOR_SAIL_NUMBERS) {
  SAILOR_MAP.set(cleanOptimistSailorName(item.name), item);
  // Also register alias without trailing period (e.g. "Neel Paul Behl")
  if (item.name.endsWith(".")) {
    SAILOR_MAP.set(cleanOptimistSailorName(item.name.slice(0, -1)), item);
  }
}

/**
 * Looks up the verified Optimist sail number for a sailor name.
 */
export function getOptimistSailNumber(name: string): string | undefined {
  return SAILOR_MAP.get(cleanOptimistSailorName(name))?.sailNumber;
}

/**
 * Looks up the verified nationality for a sailor name.
 */
export function getOptimistNationality(name: string): string | undefined {
  return SAILOR_MAP.get(cleanOptimistSailorName(name))?.nationality;
}
