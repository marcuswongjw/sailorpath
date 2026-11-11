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
import { ProfileOwnerEditor, type ProfileOwnerForm } from "./ProfileOwnerEditor";

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

  it("omits Add note on public regatta rows and renders unified Edit profile modal dialog", async () => {
    const onSave = vi.fn();
    const onClose = vi.fn();
    const user = userEvent.setup();
    const emptyForm: ProfileOwnerForm = {
      bio: "Optimist Gold sailor",
      instagram: "",
      handle: "owner-sailor",
      school: "Test School",
      club: "CSC",
      sailNumber: "3029",
      sailNumberIlca4: "",
      boardNumber: "",
      dob: "",
      weight: "",
      hullBrand: "",
      sailMake: "",
      foilBrand: "",
      mast: "",
      equipmentNotes: "",
      hullBrandIlca4: "",
      sailMakeIlca4: "",
      foilBrandIlca4: "",
      mastIlca4: "",
      equipmentNotesIlca4: "",
    };

    render(
      <>
        <SailorProfileView
          initialSailor={{ id: "s1", name: "Owner Sailor", handle: "owner-sailor", nationality: "SGP" }}
          initialResults={[
            {
              id: "res-1",
              regattaId: "r1",
              regattaName: "Singapore Nationals",
              regattaDate: "2026-09-01",
              rank: 4,
              totalFleetSize: 80,
              geography: "SGP",
              countsForRanking: true,
            },
          ]}
          initialEquipment={{}}
          isOwner
          isLoggedIn
          profileClaimed
        />
        <ProfileOwnerEditor
          isOpen
          onClose={onClose}
          form={emptyForm}
          setForm={vi.fn()}
          publicVisibility={{
            showSchoolOnPublicProfile: true,
            showEquipmentOnPublicProfile: false,
            showSocialLinksOnPublicProfile: false,
            showSailingMilestonesOnPublicProfile: true,
          }}
          setPublicVisibility={vi.fn()}
          saveBusy={false}
          saveMsg={null}
          onSave={onSave}
        />
      </>
    );

    expect(screen.queryByRole("button", { name: /Add note/i })).not.toBeInTheDocument();
    const dialogTitle = screen.getByText("Edit profile", { selector: "h2" });
    expect(dialogTitle.closest("dialog")).toHaveAttribute("open");
    await user.click(screen.getByRole("button", { name: "Save changes" }));
    expect(onSave).toHaveBeenCalledTimes(1);
  });
});
