import { describe, expect, it } from "vitest";
import { eventMatchesQuery } from "./eventSearch";
describe("event word matching", () => {
 it("finds EGAT without matching the middle of Regatta", () => {
  expect(eventMatchesQuery({name:"EGAT and YRAT Regatta 2026"},"EGAT")).toBe(true);
  expect(eventMatchesQuery({name:"Singapore Regatta 2026",slug:"singapore-regatta-2026"},"EGAT")).toBe(false);
 });
 it("supports prefixes, punctuation, accents and compact class names", () => {
  expect(eventMatchesQuery({name:"Admiral’s Cup 2026",boatClass:"ILCA 6"},"Admiral Cup ILCA6")).toBe(true);
  expect(eventMatchesQuery({name:"Trofeo Torbolí 2026"},"torboli")).toBe(true);
  expect(eventMatchesQuery({name:"Eastern Seaboard Regatta 2026"},"East Sea")).toBe(true);
 });
 it("requires every query word and handles empty punctuation safely", () => {
  expect(eventMatchesQuery({name:"EGAT Regatta 2026"},"EGAT 2025")).toBe(false);
  expect(eventMatchesQuery({name:"EGAT"},"  ")).toBe(true);
  expect(eventMatchesQuery({name:"EGAT"},"---")).toBe(false);
 });
});
