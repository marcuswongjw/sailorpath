"use client";

import {
  createContext,
  useCallback,
  useContext,
  useMemo,
  useRef,
  useState,
  type ReactNode,
} from "react";
import { AlertTriangle, Check, Info, X } from "lucide-react";

export type ToastTone = "success" | "error" | "info";

type ToastItem = {
  id: number;
  message: string;
  tone: ToastTone;
};

export type ConfirmOptions = {
  title: string;
  message?: string;
  confirmLabel?: string;
  cancelLabel?: string;
  /** Destructive actions use rose styling */
  tone?: "danger" | "default";
  /**
   * When set, user must type this exact string (case-sensitive) before
   * Confirm is enabled — use for irreversible bulk deletes (e.g. "DELETE").
   */
  requireTypedConfirm?: string;
};

type FeedbackApi = {
  toast: {
    success: (message: string) => void;
    error: (message: string) => void;
    info: (message: string) => void;
  };
  /** Promise-based confirm — replaces window.confirm */
  confirm: (opts: ConfirmOptions) => Promise<boolean>;
};

const FeedbackContext = createContext<FeedbackApi | null>(null);

const TOAST_MS = 3200;

export function FeedbackProvider({ children }: { children: ReactNode }) {
  const [toasts, setToasts] = useState<ToastItem[]>([]);
  const toastId = useRef(0);
  const [confirmState, setConfirmState] = useState<{
    opts: ConfirmOptions;
    resolve: (value: boolean) => void;
  } | null>(null);
  const [typedConfirm, setTypedConfirm] = useState("");

  const pushToast = useCallback((message: string, tone: ToastTone) => {
    const id = ++toastId.current;
    setToasts((prev) => [...prev.slice(-4), { id, message, tone }]);
    window.setTimeout(() => {
      setToasts((prev) => prev.filter((t) => t.id !== id));
    }, TOAST_MS);
  }, []);

  const toast = useMemo(
    () => ({
      success: (message: string) => pushToast(message, "success"),
      error: (message: string) => pushToast(message, "error"),
      info: (message: string) => pushToast(message, "info"),
    }),
    [pushToast]
  );

  const confirm = useCallback((opts: ConfirmOptions) => {
    return new Promise<boolean>((resolve) => {
      setTypedConfirm("");
      setConfirmState({ opts, resolve });
    });
  }, []);

  const closeConfirm = useCallback((value: boolean) => {
    setConfirmState((current) => {
      current?.resolve(value);
      return null;
    });
    setTypedConfirm("");
  }, []);

  const api = useMemo(() => ({ toast, confirm }), [toast, confirm]);

  return (
    <FeedbackContext.Provider value={api}>
      {children}

      {/* Toasts */}
      <div
        className="pointer-events-none fixed inset-x-0 bottom-4 z-[100] flex flex-col items-center gap-2 px-4 sm:bottom-6"
        aria-live="polite"
      >
        {toasts.map((t) => (
          <ToastPill key={t.id} message={t.message} tone={t.tone} />
        ))}
      </div>

      {/* Confirm dialog */}
      {confirmState && (
        <div
          className="fixed inset-0 z-[110] flex items-end justify-center bg-black/65 p-4 sm:items-center"
          role="dialog"
          aria-modal="true"
          aria-labelledby="sp-confirm-title"
          onClick={() => closeConfirm(false)}
          onKeyDown={(e) => {
            if (e.key === "Escape") closeConfirm(false);
          }}
        >
          <div
            className="w-full max-w-md rounded-2xl border border-white/10 bg-[#131520] p-5 shadow-2xl shadow-black/50"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-start gap-3">
              <div
                className={`mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-full border ${
                  confirmState.opts.tone === "danger"
                    ? "border-rose-500/25 bg-rose-500/10 text-rose-300"
                    : "border-orange-500/25 bg-orange-500/10 text-orange-300"
                }`}
              >
                <AlertTriangle className="h-4 w-4" />
              </div>
              <div className="min-w-0 flex-1 space-y-1.5">
                <h3
                  id="sp-confirm-title"
                  className="text-sm font-bold text-white leading-snug"
                >
                  {confirmState.opts.title}
                </h3>
                {confirmState.opts.message && (
                  <p className="text-xs text-slate-400 leading-relaxed whitespace-pre-wrap">
                    {confirmState.opts.message}
                  </p>
                )}
                {confirmState.opts.requireTypedConfirm && (
                  <div className="pt-2 space-y-1.5">
                    <label
                      htmlFor="sp-confirm-type"
                      className="block text-[10px] font-bold uppercase tracking-wider text-slate-500"
                    >
                      Type{" "}
                      <span className="font-mono text-rose-300">
                        {confirmState.opts.requireTypedConfirm}
                      </span>{" "}
                      to confirm
                    </label>
                    <input
                      id="sp-confirm-type"
                      type="text"
                      autoFocus
                      autoComplete="off"
                      value={typedConfirm}
                      onChange={(e) => setTypedConfirm(e.target.value)}
                      onKeyDown={(e) => {
                        if (e.key !== "Enter") return;
                        const required =
                          confirmState.opts.requireTypedConfirm || "";
                        if (typedConfirm === required) closeConfirm(true);
                      }}
                      className="w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs font-mono text-white focus:outline-none focus:border-rose-500/50"
                      placeholder={confirmState.opts.requireTypedConfirm}
                    />
                  </div>
                )}
              </div>
              <button
                type="button"
                onClick={() => closeConfirm(false)}
                className="rounded-full p-1 text-slate-500 hover:text-white"
                aria-label="Close"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
            <div className="mt-5 flex flex-wrap justify-end gap-2">
              <button
                type="button"
                onClick={() => closeConfirm(false)}
                className="rounded-full border border-white/10 bg-white/5 px-4 py-2 text-xs font-bold text-slate-300 hover:text-white"
              >
                {confirmState.opts.cancelLabel || "Cancel"}
              </button>
              <button
                type="button"
                autoFocus={!confirmState.opts.requireTypedConfirm}
                disabled={
                  Boolean(confirmState.opts.requireTypedConfirm) &&
                  typedConfirm !== confirmState.opts.requireTypedConfirm
                }
                onClick={() => closeConfirm(true)}
                className={`rounded-full px-4 py-2 text-xs font-bold text-white disabled:opacity-40 disabled:cursor-not-allowed ${
                  confirmState.opts.tone === "danger"
                    ? "bg-rose-600 hover:bg-rose-500"
                    : "bg-orange-600 hover:bg-orange-500"
                }`}
              >
                {confirmState.opts.confirmLabel || "Confirm"}
              </button>
            </div>
          </div>
        </div>
      )}
    </FeedbackContext.Provider>
  );
}

function ToastPill({ message, tone }: { message: string; tone: ToastTone }) {
  const styles =
    tone === "success"
      ? "border-emerald-500/30 bg-emerald-500/15 text-emerald-100"
      : tone === "error"
        ? "border-rose-500/30 bg-rose-500/15 text-rose-100"
        : "border-sky-500/30 bg-sky-500/15 text-sky-100";
  const Icon = tone === "success" ? Check : tone === "error" ? AlertTriangle : Info;
  return (
    <div
      className={`pointer-events-auto flex max-w-md items-start gap-2 rounded-2xl border px-3.5 py-2.5 text-[12px] font-semibold shadow-lg shadow-black/40 backdrop-blur-sm ${styles}`}
    >
      <Icon className="mt-0.5 h-3.5 w-3.5 shrink-0 opacity-90" />
      <span className="min-w-0 whitespace-pre-wrap leading-snug">{message}</span>
    </div>
  );
}

export function useFeedback(): FeedbackApi {
  const ctx = useContext(FeedbackContext);
  if (!ctx) {
    throw new Error("useFeedback must be used within FeedbackProvider");
  }
  return ctx;
}

/** Convenience aliases */
export function useToast() {
  return useFeedback().toast;
}

export function useConfirm() {
  return useFeedback().confirm;
}
