export default function LoadingSailors() {
  return <div role="status" className="mx-auto max-w-4xl px-4 py-12 sm:px-6"><p className="text-sm font-semibold text-harbour">Loading sailor records…</p><div aria-hidden className="mt-6 space-y-3 motion-safe:animate-pulse">{[0, 1, 2].map((row) => <div key={row} className="h-28 rounded-2xl bg-cool-veil" />)}</div></div>;
}
