/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { expect, it, vi } from "vitest";
vi.mock("next/navigation", () => ({useRouter: () => ({push:vi.fn(),replace:vi.fn(),refresh:vi.fn()})}));
vi.mock("next/dynamic", () => ({default: () => () => null}));
vi.mock("@/components/ui/FeedbackProvider", () => ({useFeedback: () => ({toast:{error:vi.fn()}, confirm:vi.fn()})}));
vi.mock("@/lib/supabase/browser", () => ({createBrowserSupabase:vi.fn()}));
import { SailorProfileView } from "@/components/SailorProfileView";

it("shows the imported X-15 rider's event and race scores without an Optimist ranking", async () => {
  render(<SailorProfileView
    initialSailor={{id:"kamil",name:"Kamil Manowiecki",handle:"kamilmanowiecki-x15",nationality:"POL",boardNumber:"116"}}
    initialEquipment={{}}
    initialResults={[{id:"x15",regattaId:"x15",regattaSlug:"x15-worlds-2026-senior-men",regattaName:"X-15 World Championships 2026 (Senior Men)",boatClass:"X-15",division:"Senior Men",regattaDate:"2026-11-04",geography:"ESP",rank:1,fleetSize:38,nettScore:1,totalScore:1,raceResults:[{raceNumber:1,score:0.5,discarded:false},{raceNumber:2,score:0.5,discarded:false}]}]}
  />);
  expect(screen.getByRole("heading",{name:"Recent X-15 regattas"})).toBeInTheDocument();
  expect(screen.queryByText("Optimist rank")).not.toBeInTheDocument();
  await userEvent.click(screen.getByRole("button",{name:"Regattas1"}));
  expect(screen.getByRole("heading",{name:"Regatta results · X-15"})).toBeInTheDocument();
  expect(screen.getByRole("group",{name:"Result: X-15 World Championships 2026 (Senior Men)"})).toBeInTheDocument();
});
