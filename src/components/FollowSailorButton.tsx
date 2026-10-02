"use client";

import { useState } from "react";

export function FollowSailorButton({
  sailorId,
  initiallyFollowing,
  disabled = false,
  disabledReason,
}: {
  sailorId: string;
  initiallyFollowing: boolean;
  disabled?: boolean;
  disabledReason?: string;
}) {
  const [following, setFollowing] = useState(initiallyFollowing);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function toggle() {
    if (disabled || busy) return;
    const next = !following;
    setBusy(true);
    setError(null);
    try {
      const response = await fetch(
        next ? "/api/following" : `/api/following?sailorId=${encodeURIComponent(sailorId)}`,
        {
          method: next ? "POST" : "DELETE",
          credentials: "include",
          headers: next ? { "Content-Type": "application/json" } : undefined,
          body: next ? JSON.stringify({ sailorId }) : undefined,
        }
      );
      const data = await response.json().catch(() => ({}));
      if (!response.ok) {
        throw new Error(data.error || "Could not update follow");
      }
      setFollowing(Boolean(data.following));
    } catch (err) {
      setError(err instanceof Error ? err.message : "Could not update follow");
    } finally {
      setBusy(false);
    }
  }

  return (
    <span className="inline-flex flex-col items-start gap-1">
      <button
        type="button"
        onClick={() => void toggle()}
        disabled={disabled || busy}
        aria-pressed={following}
        title={disabled ? disabledReason : undefined}
        className={`inline-flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-[13px] font-bold transition touch-manipulation shadow-2xs ${
          disabled
            ? "cursor-not-allowed border-cool-veil bg-sailcloth text-slate-soft"
            : following
              ? "cursor-pointer border-harbour/30 bg-aqua-mist text-harbour"
              : "cursor-pointer border-cool-veil bg-warm-white text-charcoal hover:bg-sailcloth"
        }`}
      >
        {busy ? "Saving…" : following ? "Following" : "Follow"}
      </button>
      {error ? <span className="text-[11px] font-semibold text-rose-700">{error}</span> : null}
    </span>
  );
}
