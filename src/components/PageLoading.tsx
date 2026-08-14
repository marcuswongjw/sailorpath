/** Shared full-page loading skeleton for route `loading.tsx` files. */
export function PageLoading({ label = "Loading…" }: { label?: string }) {
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
