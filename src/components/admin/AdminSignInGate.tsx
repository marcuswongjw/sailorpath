import { Shield } from "lucide-react";
import { BrandMark, BrandWordmark } from "@/components/BrandMark";

type Props = {
  /** Absolute URL to return to after login (admin host or /admin). */
  nextUrl: string;
  /** Public site origin for /login */
  siteOrigin: string;
  /** Optional note when the user is signed in but not superadmin */
  reason?: "unsigned" | "forbidden";
};

/**
 * Server-rendered gate for admin.sailorpath.com guests.
 * Prefer this over a bare 404 when the session is missing.
 */
export function AdminSignInGate({
  nextUrl,
  siteOrigin,
  reason = "unsigned",
}: Props) {
  const loginHref = `${siteOrigin.replace(/\/$/, "")}/login?next=${encodeURIComponent(nextUrl)}`;

  return (
    <div className="mx-auto max-w-md w-full px-4 py-20 flex-1 flex flex-col justify-center">
      <div className="glass-card rounded-3xl p-8 border border-white/5 text-center space-y-6">
        <div className="flex justify-center">
          <BrandMark size="lg" />
        </div>
        <div className="space-y-2">
          <p className="text-[11px] font-bold uppercase tracking-wider text-slate-500">
            <BrandWordmark className="text-sm normal-case tracking-tight" />{" "}
            Admin
          </p>
          <h1 className="text-xl font-black text-white">
            {reason === "forbidden"
              ? "Admin access required"
              : "Sign in to continue"}
          </h1>
          <p className="text-xs text-slate-400 leading-relaxed">
            {reason === "forbidden"
              ? "This account is signed in but is not a superadmin. Use an authorized admin login, or ask the owner to grant access."
              : "The admin console needs a superadmin session. Sign in with your SailorPath account, then you’ll return here."}
          </p>
        </div>
        <div className="h-12 w-12 rounded-full bg-orange-500/10 border border-orange-500/20 flex items-center justify-center mx-auto text-orange-400">
          <Shield className="h-6 w-6" />
        </div>
        <a
          href={loginHref}
          className="block w-full rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-xs font-bold text-white transition-all shadow-lg shadow-orange-600/20 text-center"
        >
          Sign in to Admin Portal
        </a>
        <p className="text-[10px] text-slate-500 leading-relaxed">
          After login you return to{" "}
          <code className="text-slate-400 break-all">{nextUrl}</code>.
        </p>
      </div>
    </div>
  );
}
