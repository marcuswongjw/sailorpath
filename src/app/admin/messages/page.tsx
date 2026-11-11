"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { AdminSidebar } from "@/components/admin/AdminSidebar";

type TelegramAccount = {
  userId: string;
  fullName: string;
  email: string;
  telegramName: string | null;
  username: string | null;
  optedIn: boolean;
};

export default function AdminMessagesPage() {
  const [enabled, setEnabled] = useState(true);
  const [users, setUsers] = useState<TelegramAccount[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    void (async () => {
      const res = await fetch("/api/admin/telegram/subscribers", { credentials: "include" });
      const body = (await res.json().catch(() => ({}))) as {
        error?: string;
        enabled?: boolean;
        users?: TelegramAccount[];
      };
      if (!res.ok) {
        setError(body.error || "Could not load accounts");
        return;
      }
      setEnabled(body.enabled !== false);
      setUsers(body.users || []);
    })();
  }, []);

  return (
    <div className="mx-auto flex w-full max-w-6xl gap-6 px-4 py-6">
      <AdminSidebar activeArea="messages" />
      <main className="min-w-0 flex-1 space-y-4">
        <div className="flex flex-wrap items-end justify-between gap-3">
          <div>
            <h1 className="text-2xl font-black text-[var(--sp-harbour-shadow)]">Telegram accounts</h1>
            <p className="mt-1 text-sm text-slate-600">
              Linked Telegram name, username, and whether the account opted in to bot messages.
            </p>
          </div>
          <Link href="/admin/messages/broadcast" className="sp-btn-primary text-sm">
            New broadcast
          </Link>
        </div>
        {error ? <p className="text-sm font-semibold text-rose-700">{error}</p> : null}
        {!enabled ? (
          <p className="text-sm text-slate-600">Telegram updates are not configured.</p>
        ) : (
          <div className="overflow-x-auto rounded-2xl border border-[var(--sp-cool-veil)] bg-white">
            <table className="w-full text-left text-sm">
              <thead className="bg-[var(--sp-sailcloth)] text-xs uppercase tracking-wide text-slate-500">
                <tr>
                  <th className="px-3 py-2">Account</th>
                  <th className="px-3 py-2">Telegram name</th>
                  <th className="px-3 py-2">Username</th>
                  <th className="px-3 py-2">Bot messages</th>
                </tr>
              </thead>
              <tbody>
                {users.map((user) => (
                  <tr key={user.userId} className="border-t border-[var(--sp-cool-veil)]">
                    <td className="px-3 py-2">
                      <div className="font-semibold text-[var(--sp-charcoal)]">{user.fullName}</div>
                      <div className="text-xs text-slate-500">{user.email || "No email"}</div>
                    </td>
                    <td className="px-3 py-2">{user.telegramName || "—"}</td>
                    <td className="px-3 py-2">{user.username ? `@${user.username}` : "—"}</td>
                    <td className="px-3 py-2">{user.optedIn ? "Opted in" : "Not opted in"}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </main>
    </div>
  );
}
