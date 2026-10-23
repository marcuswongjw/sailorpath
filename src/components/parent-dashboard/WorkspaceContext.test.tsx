// @vitest-environment jsdom
import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it, vi } from "vitest";
import { PrivateNotesPanel } from "./PrivateNotesPanel";
import { CoachFeedbackPanel } from "./CoachFeedbackPanel";
import { PreRaceChecklist } from "./PreRaceChecklist";
import type { Athlete } from "./types";
const athlete={id:"sailor",name:"Sailor",handle:"sailor",sailNumber:"123",club:"Club",standing:null};
describe("workspace relationship and event context",()=>{
 it.each(["sailor","other","parent"] as const)("uses the %s relationship in coach wording",(ownerRelation)=>{
  const html=renderToStaticMarkup(<CoachFeedbackPanel athlete={{...athlete,ownerRelation} as Athlete}/>);
  expect(html.includes("child")).toBe(ownerRelation==="parent");
 });
 it("keeps the sailor journal free of parent-specific privacy wording",()=>{
  const html=renderToStaticMarkup(<PrivateNotesPanel activeAthlete={athlete} isParent={false} noteDraft={{}} selectedCategory="General" noteBusy={null} onDraftChange={vi.fn()} onCategoryChange={vi.fn()} onAddNote={vi.fn()} onDeleteNote={vi.fn()}/>);
  expect(html).toContain("Private Sailing Journal");expect(html).toContain("Private to your account");expect(html).not.toContain("parent account");
 });
 it("opens each event in its own calendar context",()=>{
  const html=renderToStaticMarkup(<PreRaceChecklist activeAthlete={athlete} upcomingRegattas={[{id:"one",name:"Eastern Seaboard Regatta 2026",date:"2026-10-29",boatClass:"Optimist",division:null,slug:"eastern-seaboard-regatta-2026"}]} checklistState={{}} customChecklistItems={{}} newChecklistText="" onToggleItem={vi.fn()} onAddCustomItem={vi.fn()} onRemoveCustomItem={vi.fn()} onResetChecklist={vi.fn()} onNewChecklistTextChange={vi.fn()}/>);
  const document=new DOMParser().parseFromString(html,"text/html");
  const link=[...document.querySelectorAll("a")].find(link=>link.textContent==="Details")!;
  const url=new URL(link.getAttribute("href")!,"https://sailorpath.com");
  expect(url.searchParams.get("event")).toBe("eastern-seaboard-regatta-2026");expect(url.searchParams.has("q")).toBe(false);expect(url.searchParams.get("year")).toBe("2026");
 });
});
