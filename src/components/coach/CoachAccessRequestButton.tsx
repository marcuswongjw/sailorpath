"use client";

import { useState } from "react";

export function CoachAccessRequestButton({
  initiallyPending = false,
}: {
  initiallyPending?: boolean;
}) {
  const [state, setState] = useState<"idle" | "busy" | "sent">(
    initiallyPending ? "sent" : "idle"
  );
  const [error, setError] = useState<string | null>(null);

  const requestAccess = async () => {
    setState("busy");
    setError(null);
    try {
      const res = await fetch("/api/coach/access-request", { method: "POST" });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not send request");
      setState("sent");
    } catch (err) {
      setState("idle");
      setError(err instanceof Error ? err.message : "Could not send request");
    }
  };

  if (state === "sent") {
    return (
      <p className="inline-flex rounded-full border border-[var(--sp-harbour-teal)]/25 bg-[var(--sp-aqua-mist)] px-5 py-2.5 text-xs font-bold text-[var(--sp-harbour-teal)]">
        Request sent — an admin will review it
      </p>
    );
  }

  return (
    <div className="space-y-2">
      <button
        type="button"
        disabled={state === "busy"}
        onClick={() => void requestAccess()}
        className="sp-btn-primary disabled:opacity-50"
      >
        {state === "busy" ? "Sending…" : "Request coach access"}
      </button>
      {error && <p className="text-xs font-bold text-rose-700">{error}</p>}
    </div>
  );
}
