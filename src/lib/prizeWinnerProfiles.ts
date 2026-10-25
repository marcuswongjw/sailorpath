import { prizeNameKey, type PrizeWinner } from "@/lib/regattaPrizes";

type Person = { sailorName: string; handle?: string | null; sailorId?: string | null; sailNumber?: string | null };
type Result = Person & { participants?: { sailorName?: string | null; sourceName: string; handle: string | null; sailorId: string | null; matchStatus: string }[] };
const tokens = (name: string) => prizeNameKey(name).split(" ").filter(Boolean).sort().join(" ");
const sailKey = (value?: string | null) => String(value || "").toUpperCase().replace(/^[A-Z]{3}\s*/, "").replace(/\s/g, "");

/** Resolve only one identity within this event; a reused sail number alone is insufficient. */
export function resolvePrizeWinnerProfile(winner: PrizeWinner, results: readonly Result[]): Person | null {
  const people: Person[] = results.flatMap<Person>((row) => row.participants?.length
    ? row.participants.filter((person) => person.matchStatus === "matched" && person.handle).map((person) => ({ sailorName: person.sailorName || person.sourceName, handle: person.handle, sailorId: person.sailorId, sailNumber: row.sailNumber }))
    : [row]);
  const unique = (matches: Person[]) => {
    const identities = new Map(matches.filter((person) => person.handle).map((person) => [person.sailorId || person.handle, person]));
    return identities.size === 1 ? [...identities.values()][0] : null;
  };
  if (winner.sailorHandle) return unique(people.filter((person) => person.handle === winner.sailorHandle));
  const exact = people.filter((person) => tokens(person.sailorName) === tokens(winner.sailorName));
  if (exact.length) return unique(exact);
  const sourceTokens = prizeNameKey(winner.sailorName).split(" ");
  if (!winner.sailNumber || sourceTokens.length < 2) return null;
  return unique(people.filter((person) => {
    const personTokens = prizeNameKey(person.sailorName).split(" ");
    const common = sourceTokens.filter((token) => personTokens.includes(token));
    return sailKey(person.sailNumber) === sailKey(winner.sailNumber) && common.length >= 2;
  }));
}

export function prizeWinnerProfileHandles(winners: readonly PrizeWinner[], results: readonly Result[]): Record<string, string> {
  const handles: Record<string, string> = {};
  for (const winner of winners) {
    for (const name of winner.sailorName.split("/")) {
      const person = resolvePrizeWinnerProfile({ ...winner, sailorName: name.trim(), sailorHandle: winner.sailorName.includes("/") ? undefined : winner.sailorHandle }, results);
      if (person?.handle) handles[prizeNameKey(name)] = person.handle;
    }
  }
  return handles;
}
