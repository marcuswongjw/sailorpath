"use client";

import { useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { normalizePhone } from "./phone";

export function PhoneLoginSettings({ initialPhone = null }: { initialPhone?: string | null }) {
  const [verifiedPhone, setVerifiedPhone] = useState(initialPhone);
  const [phone, setPhone] = useState("");
  const [pending, setPending] = useState<string | null>(null);
  const [code, setCode] = useState("");
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const send = async (event: React.FormEvent) => {
    event.preventDefault();
    const number = normalizePhone(phone);
    if (!number) { setError("Enter your phone number with its country code, such as +65."); return; }
    setBusy(true); setError(null); setMessage(null);
    try {
      const { error } = await createBrowserSupabase().auth.updateUser({ phone: number });
      if (error) throw error;
      setPending(number); setMessage("Enter the code sent to your phone to finish linking it.");
    } catch { setError("We couldn’t send a code. Check your number or try again later."); }
    finally { setBusy(false); }
  };
  const verify = async (event: React.FormEvent) => {
    event.preventDefault();
    if (!pending) return;
    setBusy(true); setError(null);
    try {
      const { error } = await createBrowserSupabase().auth.verifyOtp({ phone: pending, token: code.trim(), type: "phone_change" });
      if (error) throw error;
      setVerifiedPhone(pending); setPending(null); setPhone(""); setCode(""); setMessage("Your mobile number is verified. You can use it to log in.");
    } catch { setError("The code could not be verified. Check it and try again."); }
    finally { setBusy(false); }
  };
  return <section className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-6 space-y-3">
    <h2 className="text-base font-bold text-harbour-shadow">Mobile number login</h2>
    <p className="text-sm text-slate-soft">Verify a mobile number to use SMS codes to sign in to this account.</p>
    {verifiedPhone && <p className="text-sm text-charcoal">Verified number: {verifiedPhone}</p>}
    {!pending ? <form onSubmit={send} className="space-y-3">
      <label className="block text-xs font-bold text-slate-soft">Mobile number<input type="tel" autoComplete="tel" required placeholder="+65 9123 4567" value={phone} onChange={(event) => setPhone(event.target.value)} className="sp-input mt-1 w-full text-sm font-normal" /></label>
      <button type="submit" disabled={busy} className="sp-btn-primary px-4 py-2 text-sm disabled:opacity-50">{busy ? "Sending…" : "Send verification code"}</button>
    </form> : <form onSubmit={verify} className="space-y-3">
      <label className="block text-xs font-bold text-slate-soft">SMS code<input inputMode="numeric" autoComplete="one-time-code" required value={code} onChange={(event) => setCode(event.target.value)} className="sp-input mt-1 w-full text-sm font-normal" /></label>
      <button type="submit" disabled={busy} className="sp-btn-primary px-4 py-2 text-sm disabled:opacity-50">{busy ? "Checking…" : "Verify number"}</button>{" "}
      <button type="button" onClick={() => { setPending(null); setCode(""); setMessage(null); setError(null); }} className="text-sm font-semibold text-harbour hover:underline">Change number</button>
    </form>}
    {message && <p role="status" className="text-xs text-harbour">{message}</p>}
    {error && <p role="alert" className="text-xs text-rose-700">{error}</p>}
  </section>;
}
