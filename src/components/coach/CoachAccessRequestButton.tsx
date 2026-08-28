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
      <p className="inline-flex rounded-full border border-emerald-500/25 bg-emerald-500/10 px-5 py-2.5 text-xs font-bold text-emerald-300">
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
        className="inline-flex rounded-full bg-orange-600 px-5 py-2.5 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-50"
      >
        {state === "busy" ? "Sending…" : "Request coach access"}
      </button>
      {error && <p className="text-xs text-rose-400">{error}</p>}
    </div>
  );
}
