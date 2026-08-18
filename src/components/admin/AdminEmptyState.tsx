"use client";

import type { LucideIcon } from "lucide-react";
import { Inbox } from "lucide-react";

type Props = {
  title: string;
  description?: string;
  icon?: LucideIcon;
  action?: {
    label: string;
    onClick: () => void;
  };
};

/**
 * Shared empty state for admin list panels (Database / Ops).
 */
export function AdminEmptyState({
  title,
  description,
  icon: Icon = Inbox,
  action,
}: Props) {
  return (
    <div className="rounded-2xl border border-dashed border-white/10 bg-black/20 py-12 px-4 text-center space-y-3">
      <div className="mx-auto flex h-11 w-11 items-center justify-center rounded-2xl bg-white/5 border border-white/10">
        <Icon className="h-5 w-5 text-slate-500" />
      </div>
      <div className="space-y-1">
        <p className="text-sm font-bold text-white">{title}</p>
        {description && (
          <p className="text-[12px] text-slate-500 max-w-sm mx-auto leading-relaxed">
            {description}
          </p>
        )}
      </div>
      {action && (
        <button
          type="button"
          onClick={action.onClick}
          className="inline-flex rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-[11px] font-bold text-white"
        >
          {action.label}
        </button>
      )}
    </div>
  );
}
