/**
 * Browser-side privacy-light usage helpers.
 * No emails/names — session + visitor ids, coarse acquisition, device only.
 */

const SESSION_KEY = "sp_usage_sid";
const VISITOR_KEY = "sp_usage_vid";
const ACQ_KEY = "sp_usage_acq";

function uuid(): string {
  if (typeof crypto !== "undefined" && "randomUUID" in crypto) {
    return crypto.randomUUID();
  }
  return `id-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
}

export function getUsageSessionId(): string {
  if (typeof window === "undefined") return "";
  try {
    let id = sessionStorage.getItem(SESSION_KEY);
    if (!id) {
      id = uuid();
      sessionStorage.setItem(SESSION_KEY, id);
    }
    return id;
  } catch {
    return `s-${Date.now()}`;
  }
}

/** Durable visitor id (localStorage) for return-rate across sessions. */
export function getVisitorId(): string {
  if (typeof window === "undefined") return "";
  try {
    let id = localStorage.getItem(VISITOR_KEY);
    if (!id) {
      id = uuid();
      localStorage.setItem(VISITOR_KEY, id);
    }
    return id;
  } catch {
    return "";
  }
}

export type Acquisition = {
  source: string;
  device: "mobile" | "desktop";
  refHost: string | null;
};

function hostFromReferrer(ref: string): string | null {
  try {
    const u = new URL(ref);
    return u.hostname.replace(/^www\./, "").slice(0, 80) || null;
  } catch {
    return null;
  }
}

/**
 * Classify first-touch acquisition for this session (cached in sessionStorage).
 * Coarse only: utm / known hosts / direct.
 */
export function getAcquisition(): Acquisition {
  const device: "mobile" | "desktop" =
    typeof window !== "undefined" && window.matchMedia?.("(max-width: 768px)").matches
      ? "mobile"
      : "desktop";

  if (typeof window === "undefined") {
    return { source: "unknown", device: "desktop", refHost: null };
  }

  try {
    const cached = sessionStorage.getItem(ACQ_KEY);
    if (cached) {
      const parsed = JSON.parse(cached) as Acquisition;
      return {
        source: String(parsed.source || "unknown").slice(0, 40),
        device: parsed.device === "mobile" ? "mobile" : "desktop",
        refHost: parsed.refHost ? String(parsed.refHost).slice(0, 80) : null,
      };
    }
  } catch {
    /* recompute */
  }

  const params = new URLSearchParams(window.location.search);
  const utm = (params.get("utm_source") || params.get("source") || "")
    .trim()
    .toLowerCase()
    .slice(0, 40);
  const ref = document.referrer || "";
  const refHost = ref ? hostFromReferrer(ref) : null;

  let source = "direct";
  if (utm) {
    source = utm;
  } else if (refHost) {
    const h = refHost.toLowerCase();
    if (h.includes("instagram") || h.includes("ig.")) source = "instagram";
    else if (h.includes("facebook") || h.includes("fb.") || h.includes("meta"))
      source = "facebook";
    else if (h.includes("t.co") || h.includes("twitter") || h.includes("x.com"))
      source = "x";
    else if (h.includes("whatsapp") || h.includes("wa.me")) source = "whatsapp";
    else if (h.includes("telegram")) source = "telegram";
    else if (h.includes("google")) source = "google";
    else if (h.includes("bing")) source = "bing";
    else if (
      h === window.location.hostname ||
      h.endsWith(`.${window.location.hostname}`)
    ) {
      source = "internal";
    } else source = "referral";
  }

  const acq: Acquisition = { source, device, refHost };
  try {
    sessionStorage.setItem(ACQ_KEY, JSON.stringify(acq));
  } catch {
    /* ignore */
  }
  return acq;
}

export type ClientUsageMeta = Record<
  string,
  string | number | boolean | null | undefined
>;

/**
 * Fire-and-forget usage event (beacon preferred). Never throws / blocks UX.
 */
export function trackClientUsage(
  eventType: string,
  path?: string | null,
  meta?: ClientUsageMeta | null
): void {
  if (typeof window === "undefined") return;
  try {
    const sessionId = getUsageSessionId();
    const vid = getVisitorId();
    const acq = getAcquisition();
    const payload = JSON.stringify({
      eventType: String(eventType || "").slice(0, 64),
      path: path ?? window.location.pathname,
      sessionId,
      role: "public",
      meta: {
        vid: vid || null,
        source: acq.source,
        device: acq.device,
        refHost: acq.refHost,
        ...(meta || {}),
      },
    });

    const fire = () => {
      try {
        if (typeof navigator !== "undefined" && "sendBeacon" in navigator) {
          const blob = new Blob([payload], { type: "application/json" });
          if (navigator.sendBeacon("/api/usage", blob)) return;
        }
      } catch {
        /* fall through */
      }
      void fetch("/api/usage", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: payload,
        credentials: "include",
        keepalive: true,
      }).catch(() => {});
    };

    if (typeof requestIdleCallback === "function") {
      requestIdleCallback(fire, { timeout: 2000 });
    } else {
      setTimeout(fire, 0);
    }
  } catch {
    /* never break the app */
  }
}
