import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks=vi.hoisted(()=>({regattas:vi.fn()}));
vi.mock("@/lib/queries",()=>({getCachedPublicRegattas:mocks.regattas}));
import { searchRegattasEnhanced } from "./search";
beforeEach(()=>mocks.regattas.mockResolvedValue([
 {id:"egat",name:"EGAT and YRAT Regatta 2026",slug:"egat-2026",date:"2026-07-04",boatClass:"Optimist"},
 {id:"other",name:"Singapore Regatta 2026",slug:"singapore-regatta",date:"2026-07-04",boatClass:"Optimist"},
 {id:"class",name:"Club Cup",slug:"club-cup",date:"2026-07-04",boatClass:"ILCA 6"},
 {id:"accent",name:"Trofeo Torbolí",slug:"trofeo",date:"2026-07-04",boatClass:"Optimist"},
]));
describe("regatta search results",()=>{
 it("returns EGAT without unrelated Regatta substring matches",async()=>expect((await searchRegattasEnhanced("EGAT")).map(row=>row.id)).toEqual(["egat"]));
 it("retains normalized class and accent matches even when raw phrase scoring is zero",async()=>{
  expect((await searchRegattasEnhanced("ILCA6")).map(row=>row.id)).toEqual(["class"]);
  expect((await searchRegattasEnhanced("Torboli")).map(row=>row.id)).toEqual(["accent"]);
 });
 it("requires all event search terms",async()=>expect(await searchRegattasEnhanced("EGAT 2025")).toHaveLength(0));
});
