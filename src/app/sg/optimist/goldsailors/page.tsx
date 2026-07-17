import { DbOffline } from "@/components/DbOffline";
import { GoldSailorsRegister } from "@/components/GoldSailorsRegister";
import { listSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function GoldSailorsPage() {
  try {
    const sailors = await listSailors();

    // Gold register: gold entry OR current fleet gold OR manually dropped (kept on register)
    const goldSailors = sailors.filter((s) => {
      const fleet = (s.currentFleet || "").toLowerCase();
      return (
        Boolean(s.goldEntryDate) || fleet === "gold" || Boolean(s.manuallyDropped)
      );
    });
    goldSailors.sort((a, b) => {
      const aDrop = a.manuallyDropped ? 1 : 0;
      const bDrop = b.manuallyDropped ? 1 : 0;
      if (aDrop !== bDrop) return aDrop - bDrop;
      return a.name.localeCompare(b.name);
    });

    return <GoldSailorsRegister sailors={goldSailors} />;
  } catch (e) {
    return (
      <DbOffline
        message={e instanceof DbUnavailableError ? e.message : "DB error"}
      />
    );
  }
}
