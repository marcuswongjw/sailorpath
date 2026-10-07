import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { groupRegattaEvents } from "@/lib/admin/groupRegattaEvents";
import { publicationReadiness } from "@/lib/admin/publicationReadiness";

export type OverviewSheet = {
  id: string;
  name: string;
  event: string | null;
  date: string;
  boatClass: string | null;
  division: string | null;
  raceCount: number | null;
  resultCount: number;
  summary: ReturnType<typeof publicationReadiness>["summary"];
  status: string | null;
};

export function buildAdminOverview(
  regattas: RegattaAdmin[],
  results: ResultAdmin[]
) {
  const resultCounts = new Map<string, number>();
  for (const result of results) {
    resultCounts.set(result.regattaId, (resultCounts.get(result.regattaId) ?? 0) + 1);
  }

  const sheets: OverviewSheet[] = [];
  const grouped = groupRegattaEvents(regattas);
  const addSheet = (sheet: RegattaAdmin, event: string | null) => {
      const readiness = publicationReadiness({
        ...sheet,
        date: String(sheet.date).slice(0, 10),
        resultCount: resultCounts.get(sheet.id) ?? 0,
      });
      sheets.push({
        id: sheet.id,
        name: sheet.name,
        event,
        date: String(sheet.date).slice(0, 10),
        boatClass: sheet.boatClass ?? null,
        division: sheet.division ?? null,
        raceCount: typeof sheet.raceCount === "number" ? sheet.raceCount : null,
        resultCount: resultCounts.get(sheet.id) ?? 0,
        summary: readiness.summary,
        status: sheet.status ?? null,
      });
  };
  for (const event of grouped.events) {
    for (const sheet of event.sheets) {
      addSheet(sheet as RegattaAdmin, event.slug);
    }
  }
  for (const sheet of grouped.unassigned) addSheet(sheet as RegattaAdmin, null);

  return {
    sheets,
    ready: sheets.filter(
      (sheet) =>
        sheet.status !== "published" &&
        (sheet.summary === "publishable_ranking" ||
          sheet.summary === "publishable_non_ranking")
    ),
    missingResults: sheets.filter(
      (sheet) => sheet.raceCount != null && sheet.raceCount > 0 && sheet.resultCount === 0
    ),
    blocked: sheets.filter((sheet) => sheet.summary === "blocked"),
    incomplete: sheets.filter((sheet) => sheet.summary === "incomplete"),
  };
}
