import type { SailorSearchResult } from "@/lib/search";

const base = "https://sailorpath.com";
const link = (path: string, label: string) => `<a href="${base}${path}">${label}</a>`;
const escapeHtml = (text: string) => text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

export const menuLabels = {
  find: "🔎 Find a sailor",
  rankings: "🏆 Rankings",
  regattas: "⛵ Regattas",
  claim: "📌 Claim a profile",
  settings: "⚙️ Update settings",
  help: "❓ Help",
} as const;

export const menuKeyboard = {
  keyboard: [
    [{ text: menuLabels.find }, { text: menuLabels.rankings }],
    [{ text: menuLabels.regattas }, { text: menuLabels.claim }],
    [{ text: menuLabels.settings }, { text: menuLabels.help }],
  ],
  resize_keyboard: true,
  input_field_placeholder: "Type a sailor name or sail number",
};

export const rankingsKeyboard = { inline_keyboard: [
  [{ text: "Optimist Gold", url: `${base}/sg/optimist/gold` }, { text: "Optimist Silver", url: `${base}/sg/optimist/silver` }],
  [{ text: "ILCA 4", url: `${base}/sg/ilca4` }, { text: "ILCA 6", url: `${base}/sg/ilca6` }],
  [{ text: "Asian Index", url: `${base}/optimist/asian-index` }, { text: "All rankings", url: `${base}/rankings` }],
] };
export const regattasKeyboard = { inline_keyboard: [[
  { text: "Results", url: `${base}/results` }, { text: "Calendar", url: `${base}/calendar` },
]] };
export const claimKeyboard = { inline_keyboard: [[{ text: "Claim a profile", url: `${base}/claim-profile` }]] };
export const settingsKeyboard = { inline_keyboard: [[{ text: "Open account settings", url: `${base}/account` }]] };

export const welcomeMessage = `Welcome to SailorPath! Choose an option below, or send a sailor's name or sail number to search.\n\nSending a message does not subscribe you to updates; manage those in your SailorPath account. You can return to this menu with /menu.`;
export const rankingsMessage = "<b>Rankings</b>\nChoose a ranking to open it on SailorPath.";
export const regattasMessage = "<b>Regattas</b>\nChoose results or the calendar to open it on SailorPath.";

export function sailorSearchMessage(query: string, sailors: Pick<SailorSearchResult, "name" | "handle" | "sailNumber">[]): string {
  if (!query) return "Type a sailor's name or sail number, for example SGP 4652, and send it here.";
  if (query.length > 100) return "Please use a name or sail number of 100 characters or fewer.";
  if (!sailors.length) return `No matching sailors found. Try another name or sail number, or ${link("/sailors", "browse sailors")}.`;
  const matches = sailors.slice(0, 5).map((sailor) => `${link(`/sailors/${encodeURIComponent(sailor.handle)}`, escapeHtml(sailor.name))}${sailor.sailNumber ? ` — ${escapeHtml(sailor.sailNumber)}` : ""}`).join("\n");
  return `<b>Sailors</b>\n${matches}\n\nIs this your profile? ${link("/claim-profile", "Claim your profile")}.`;
}
