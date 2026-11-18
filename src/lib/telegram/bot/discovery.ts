import type { SailorSearchResult } from "@/lib/search";

const base = "https://sailorpath.com";
const link = (path: string, label: string) => `<a href="${base}${path}">${label}</a>`;
const escapeHtml = (text: string) => text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

export const welcomeMessage = `Welcome to SailorPath! Find a sailor by sending their name or sail number, or try /find SGP 4652.\n\n${link("/rankings", "Rankings")} · ${link("/calendar", "Regattas")} · ${link("/claim-profile", "Claim a profile")}\n\nUse /rankings or /regattas for quick links. Sending a message does not subscribe you to updates; manage those in your SailorPath account.`;
export const rankingsMessage = `<b>Rankings</b>\n${link("/sg/optimist/gold", "Optimist Gold")} · ${link("/sg/optimist/silver", "Optimist Silver")}\n${link("/sg/ilca4", "ILCA 4")} · ${link("/sg/ilca6", "ILCA 6")}\n${link("/optimist/asian-index", "Asian Index")} · ${link("/rankings", "All rankings")}`;
export const regattasMessage = `<b>Regattas</b>\n${link("/results", "Results")} · ${link("/calendar", "Regatta calendar")}`;

export function sailorSearchMessage(query: string, sailors: Pick<SailorSearchResult, "name" | "handle" | "sailNumber">[]): string {
  if (!query) return "Send /find followed by a sailor's name or sail number, for example /find SGP 4652.";
  if (query.length > 100) return "Please use a name or sail number of 100 characters or fewer.";
  if (!sailors.length) return `No matching sailors found. Try another name or sail number, or ${link("/sailors", "browse sailors")}.`;
  const matches = sailors.slice(0, 5).map((sailor) => `${link(`/sailors/${encodeURIComponent(sailor.handle)}`, escapeHtml(sailor.name))}${sailor.sailNumber ? ` — ${escapeHtml(sailor.sailNumber)}` : ""}`).join("\n");
  return `<b>Sailors</b>\n${matches}\n\nIs this your profile? ${link("/claim-profile", "Claim your profile")}.`;
}
