import { excelDateToIso } from "@/lib/normalize";
import { pickCol } from "@/lib/excel/pickCol";

/** One row from a gold/silver roster spreadsheet (admin bulk sailors import). */
export type RosterImportRow = {
  name: string;
  handle?: string | null;
  sailNumber?: string | null;
  club?: string | null;
  school?: string | null;
  nationality?: string | null;
  gender?: string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
  dropDate?: string | null;
  currentFleet?: string | null;
  nationalSquadStatus?: string | null;
  dob?: string | null;
  weight?: string | number | null;
  bio?: string | null;
  instagram?: string | null;
  facebook?: string | null;
  natSquadStatusJan25?: string | null;
  natSquadStatusJul25?: string | null;
  natSquadStatusJan26?: string | null;
  natSquadStatusJul26?: string | null;
  histRankingJun24?: string | number | null;
  histRankingDec24?: string | number | null;
  histRankingJun25?: string | number | null;
  histRankingDec25?: string | number | null;
  histRankingJun26?: string | number | null;
  worlds?: string | number | null;
  european?: string | number | null;
  asian?: string | number | null;
  seaGames?: string | number | null;
};

function strOrNull(v: unknown): string | null {
  if (v == null || v === "") return null;
  return String(v);
}

/** Map raw sheet objects to roster import rows. */
export function parseRosterRows(
  json: Record<string, unknown>[]
): RosterImportRow[] {
  return json
    .map((row) => {
      const name = String(
        pickCol(row, ["name", "sailor", "sailorname", "full name"]) || ""
      ).trim();
      if (!name) return null;

      const goldEntryDate = excelDateToIso(
        pickCol(row, [
          "entered gold",
          "goldentrydate",
          "gold entry",
          "gold entry date",
        ])
      );
      const silverEntryDate = excelDateToIso(
        pickCol(row, [
          "entered silver",
          "silverentrydate",
          "silver entry",
          "silver entry date",
        ])
      );
      const dropDate = excelDateToIso(
        pickCol(row, ["optimist drop", "dropdate", "drop date", "drop"])
      );
      const dob = excelDateToIso(
        pickCol(row, ["born", "dob", "date of birth", "birthdate", "birth"])
      );

      const nationalSquadStatus = pickCol(row, [
        "gold squad",
        "goldsquad",
        "nationalsquadstatus",
        "squad status",
        "nat squad",
      ]);

      const currentFleet = pickCol(row, [
        "fleet current",
        "fleetcurrent",
        "current fleet",
        "fleet",
      ]);


      const school = pickCol(row, ["school"]);

      return {
        name,
        handle: strOrNull(pickCol(row, ["handle", "slug", "username"])),
        sailNumber: strOrNull(
          pickCol(row, [
            "sailnumber",
            "sail number",
            "sail",
            "sail#",
            "sail no",
            "sail no.",
          ])
        ),
        club: strOrNull(pickCol(row, ["club", "club origin", "team"])),
        school: strOrNull(school),
        nationality: strOrNull(
          pickCol(row, [
            "nationality",
            "nation",
            "country",
            "country of origin",
            "noc",
          ])
        ),
        gender: strOrNull(pickCol(row, ["gender", "sex"])),
        goldEntryDate,
        silverEntryDate,
        dropDate,
        currentFleet: strOrNull(currentFleet),
        nationalSquadStatus:
          nationalSquadStatus != null
            ? String(nationalSquadStatus).trim()
            : null,
        dob,
        weight: strOrNull(pickCol(row, ["weight", "weight kg"])),
        bio: strOrNull(pickCol(row, ["bio", "biography"])),
        instagram: strOrNull(pickCol(row, ["instagram", "ig"])),
        facebook: strOrNull(pickCol(row, ["facebook", "fb"])),
        natSquadStatusJan25: strOrNull(
          pickCol(row, [
            "squadjan25",
            "natsquadstatusjan25",
            "nat jan 25",
            "squad jan 25",
          ])
        ),
        natSquadStatusJul25: strOrNull(
          pickCol(row, [
            "squadjul25",
            "natsquadstatusjul25",
            "nat jul 25",
            "squad jul 25",
          ])
        ),
        natSquadStatusJan26: strOrNull(
          pickCol(row, [
            "squadjan26",
            "natsquadstatusjan26",
            "nat jan 26",
            "squad jan 26",
          ])
        ),
        natSquadStatusJul26: strOrNull(
          pickCol(row, [
            "squadjul26",
            "natsquadstatusjul26",
            "nat jul 26",
            "squad jul 26",
          ])
        ),
        histRankingJun24: strOrNull(
          pickCol(row, [
            "histjun24",
            "histrankingjun24",
            "rank jun 24",
            "hist jun 24",
          ])
        ),
        histRankingDec24: strOrNull(
          pickCol(row, [
            "histdec24",
            "histrankingdec24",
            "rank dec 24",
            "hist dec 24",
          ])
        ),
        histRankingJun25: strOrNull(
          pickCol(row, [
            "histjun25",
            "histrankingjun25",
            "rank jun 25",
            "hist jun 25",
          ])
        ),
        histRankingDec25: strOrNull(
          pickCol(row, [
            "histdec25",
            "histrankingdec25",
            "rank dec 25",
            "hist dec 25",
          ])
        ),
        histRankingJun26: strOrNull(
          pickCol(row, [
            "histjun26",
            "histrankingjun26",
            "rank jun 26",
            "hist jun 26",
          ])
        ),
        worlds: strOrNull(pickCol(row, ["worlds", "worlds year"])),
        european: strOrNull(
          pickCol(row, ["euros", "european", "europeans", "europeans year"])
        ),
        asian: strOrNull(pickCol(row, ["asians", "asian", "asians year"])),
        seaGames: strOrNull(
          pickCol(row, ["sea games", "seagames", "sea games year"])
        ),
      };
    })
    .filter(Boolean) as RosterImportRow[];
}
