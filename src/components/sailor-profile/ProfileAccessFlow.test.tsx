/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
const {push} = vi.hoisted(() => ({push:vi.fn()}));
vi.mock("next/navigation",()=>({useRouter:()=>({push,replace:vi.fn(),refresh:vi.fn()})}));
vi.mock("next/dynamic",()=>({default:()=>()=>null}));
vi.mock("@/components/ui/FeedbackProvider",()=>({useFeedback:()=>({toast:{error:vi.fn()},confirm:vi.fn()})}));
vi.mock("@/lib/supabase/browser",()=>({createBrowserSupabase:vi.fn()}));
import { SailorProfileView } from "@/components/SailorProfileView";

describe("public profile access",()=>{
  it("leads with the sailor and distinguishes following from reviewed profile access",async()=>{
    render(<SailorProfileView initialSailor={{id:"s1",name:"Public Sailor",handle:"public-sailor",nationality:"SGP"}} initialResults={[]} initialEquipment={{}} followControl={{sailorId:"s1",following:false,disabled:false}} />);
    const identity=screen.getByRole("heading",{name:"Public Sailor"});
    const request=screen.getByRole("button",{name:"Request profile access"});
    expect(identity.compareDocumentPosition(request) & Node.DOCUMENT_POSITION_FOLLOWING).toBeTruthy();
    expect(screen.getByText(/We review requests before granting access/)).toBeVisible();
    expect(screen.getByText(/Follow to keep this sailor’s results in your Following feed/)).toBeVisible();
    expect(screen.getByRole("button",{name:"Follow"})).toBeEnabled();
    await userEvent.click(request);
    expect(push).toHaveBeenCalledWith("/login?next=%2Fsailors%2Fpublic-sailor");
  });
});
