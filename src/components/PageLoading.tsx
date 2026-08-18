/** Shared full-page loading skeleton for route `loading.tsx` files. */

type Variant = "page" | "rankings" | "profile";

export function PageLoading({
  label = "Loading…",
  variant = "page",
}: {
  label?: string;
  variant?: Variant;
}) {
  if (variant === "rankings") {
    return (
      <div
        className="mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 py-6 sm:py-12 space-y-4"
        role="status"
        aria-live="polite"
        aria-label={label}
      >
        <div className="flex items-start gap-3">
          <div className="h-10 w-10 rounded-xl bg-orange-600/10 border border-orange-500/20 animate-pulse" />
          <div className="space-y-2 flex-1 min-w-0">
            <div className="h-3 w-24 rounded bg-white/10 animate-pulse" />
            <div className="h-8 w-56 max-w-full rounded bg-white/10 animate-pulse" />
            <div className="h-3 w-40 rounded bg-white/5 animate-pulse" />
          </div>
        </div>
        <div className="h-24 rounded-xl border border-white/10 bg-white/[0.03] animate-pulse" />
        <div className="space-y-2">
          {Array.from({ length: 8 }).map((_, i) => (
            <div
              key={i}
              className="h-14 rounded-xl border border-white/5 bg-[#131520]/60 animate-pulse"
              style={{ animationDelay: `${i * 40}ms` }}
            />
          ))}
        </div>
        <p className="text-center text-xs font-semibold text-slate-600 pt-2">
          {label}
        </p>
      </div>
    );
  }

  if (variant === "profile") {
    return (
      <div
        className="mx-auto max-w-3xl px-3 sm:px-6 py-5 sm:py-10 space-y-4"
        role="status"
        aria-live="polite"
        aria-label={label}
      >
        <div className="rounded-2xl border border-white/[0.07] bg-[#090a0f] p-5 sm:p-6 flex gap-4">
          <div className="h-16 w-16 rounded-full bg-white/10 animate-pulse shrink-0" />
          <div className="flex-1 space-y-2 min-w-0 pt-1">
            <div className="h-6 w-48 max-w-full rounded bg-white/10 animate-pulse" />
            <div className="h-4 w-64 max-w-full rounded bg-white/5 animate-pulse" />
            <div className="h-3 w-40 rounded bg-white/5 animate-pulse" />
          </div>
        </div>
        <div className="h-28 rounded-2xl border border-white/[0.07] bg-white/[0.03] animate-pulse" />
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-px rounded-2xl overflow-hidden border border-white/[0.07]">
          {Array.from({ length: 4 }).map((_, i) => (
            <div key={i} className="h-24 bg-white/[0.03] animate-pulse" />
          ))}
        </div>
        <div className="h-40 rounded-2xl border border-white/[0.07] bg-white/[0.03] animate-pulse" />
        <p className="text-center text-xs font-semibold text-slate-600">
          {label}
        </p>
      </div>
    );
  }

  return (
    <div className="flex-1 flex flex-col items-center justify-center gap-4 py-24 px-4">
      <div
        className="h-1 w-40 max-w-[60vw] overflow-hidden rounded-full bg-white/10"
        role="status"
        aria-live="polite"
        aria-label={label}
      >
        <div className="h-full w-1/2 animate-pulse rounded-full bg-gradient-to-r from-orange-600 via-orange-400 to-amber-300" />
      </div>
      <p className="text-sm font-semibold text-slate-500">{label}</p>
    </div>
  );
}
