import { DbOffline } from "@/components/DbOffline";
import { GoldSailorsRegister } from "@/components/GoldSailorsRegister";
import { listSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function GoldSailorsPage() {
  try {
    const sailors = await listSailors();

    // Gold register: anyone with a gold entry (including those with drop date)
    const goldSailors = sailors.filter((s) => Boolean(s.goldEntryDate));
    goldSailors.sort((a, b) => {
      // Dropped (have drop date) after active
      const aDrop = a.dropDate ? 1 : 0;
      const bDrop = b.dropDate ? 1 : 0;
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
