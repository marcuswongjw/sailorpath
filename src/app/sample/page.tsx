import Link from "next/link";
import { SailorProfileView } from "@/components/SailorProfileView";
import {
  SAMPLE_EQUIPMENT,
  SAMPLE_RESULTS,
  SAMPLE_SAILOR,
} from "@/lib/sampleProfile";

export default function SampleProfilePage() {
  return (
    <div className="flex-1 flex flex-col">
      <div className="border-b border-amber-500/25 bg-amber-500/10 px-4 py-3">
        <div className="mx-auto max-w-7xl flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 text-center sm:text-left">
          <p className="text-xs font-semibold text-amber-100">
            <span className="font-black text-amber-300">SAMPLE PROFILE</span>
            {" — "}
            This is a fictional example (Ashlyn Tan style) so you can see how a
            real sailor profile will look. It is not live database data.
          </p>
          <Link
            href="/register"
            className="shrink-0 rounded-full bg-orange-600 px-4 py-1.5 text-[11px] font-bold text-white hover:bg-orange-500"
          >
            Claim your profile
          </Link>
        </div>
      </div>
      <SailorProfileView
        initialSailor={SAMPLE_SAILOR}
        initialResults={SAMPLE_RESULTS}
        initialEquipment={SAMPLE_EQUIPMENT}
        canSeePrivate={false}
      />
    </div>
  );
}
