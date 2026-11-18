"use client";

import { useState, useSyncExternalStore } from "react";
import { Check, Copy, Share2 } from "lucide-react";
import { TelegramMark } from "@/components/TelegramMark";

const subscribe = () => () => {};
const getHref = () => window.location.href;
const getServerHref = () => "";

export function ShareResultBar({
  title,
  subtitle,
}: {
  title: string;
  subtitle?: string;
}) {
  const [copied, setCopied] = useState(false);
  const currentUrl = useSyncExternalStore(subscribe, getHref, getServerHref);
  const shareText = subtitle ? `${title} — ${subtitle}` : `${title} results on SailorPath`;

  const handleCopy = async () => {
    if (!currentUrl || typeof navigator === "undefined" || !navigator.clipboard) return;
    try {
      await navigator.clipboard.writeText(currentUrl);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      // Ignore clipboard failures on restricted contexts
    }
  };

  const handleNativeShare = async () => {
    if (!currentUrl || typeof navigator === "undefined" || !navigator.share) return;
    try {
      await navigator.share({ title, text: shareText, url: currentUrl });
    } catch {
      // User cancelled share sheet
    }
  };

  if (!currentUrl) return null;

  const telegramHref = `https://t.me/share/url?url=${encodeURIComponent(currentUrl)}&text=${encodeURIComponent(shareText)}`;
  const whatsappHref = `https://wa.me/?text=${encodeURIComponent(`${shareText} ${currentUrl}`)}`;

  return (
    <div className="flex flex-wrap items-center gap-2 pt-1">
      <span className="text-[11px] font-bold uppercase tracking-wide text-[var(--sp-slate-soft)]">
        Share
      </span>
      <a
        href={telegramHref}
        target="_blank"
        rel="noopener noreferrer"
        className="inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-2.5 py-1 text-[11px] font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors"
      >
        <TelegramMark className="h-3.5 w-3.5 text-[#229ED9]" />
        Telegram
      </a>
      <a
        href={whatsappHref}
        target="_blank"
        rel="noopener noreferrer"
        className="inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-2.5 py-1 text-[11px] font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors"
      >
        WhatsApp
      </a>
      <button
        type="button"
        onClick={() => void handleCopy()}
        className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-2.5 py-1 text-[11px] font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors"
      >
        {copied ? (
          <>
            <Check className="h-3 w-3 text-emerald-600" />
            Copied
          </>
        ) : (
          <>
            <Copy className="h-3 w-3 text-[var(--sp-harbour-teal)]" />
            Copy link
          </>
        )}
      </button>
      {typeof navigator !== "undefined" && typeof navigator.share === "function" && (
        <button
          type="button"
          onClick={() => void handleNativeShare()}
          aria-label="Share results"
          className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-2.5 py-1 text-[11px] font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors"
        >
          <Share2 className="h-3 w-3 text-[var(--sp-harbour-teal)]" />
          More
        </button>
      )}
    </div>
  );
}
