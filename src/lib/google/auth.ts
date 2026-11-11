/** Public flag. The Google client secret stays in the Supabase dashboard. */
export function isGoogleAuthEnabled(): boolean {
  return process.env.NEXT_PUBLIC_GOOGLE_AUTH_ENABLED?.trim().toLowerCase() === "true";
}

export const GOOGLE_CALLBACK_PATH = "/auth/callback";

/** App callback Supabase redirects to after Google. The host must match the browser. */
export function googleAppCallbackUrl(origin: string, nextPath: string): string {
  const url = new URL(GOOGLE_CALLBACK_PATH, origin);
  url.searchParams.set("next", nextPath);
  return url.toString();
}

export type GoogleOAuthRequest = {
  provider: "google";
  options: {
    redirectTo: string;
    queryParams: { prompt: "select_account" };
  };
};

/** Built-in Google provider. No custom scopes, so a phone number is not requested. */
export function googleOAuthRequest(origin: string, nextPath: string): GoogleOAuthRequest {
  return {
    provider: "google",
    options: {
      redirectTo: googleAppCallbackUrl(origin, nextPath),
      queryParams: { prompt: "select_account" },
    },
  };
}

export const GOOGLE_CONNECT_NEXT = "/account?google=connected#settings";

type OAuthClient = {
  auth: {
    signInWithOAuth: (credentials: GoogleOAuthRequest) => Promise<{ error: { message: string } | null }>;
    linkIdentity: (credentials: GoogleOAuthRequest) => Promise<{ error: { message: string } | null }>;
  };
};

export async function startGoogleSignIn(
  supabase: OAuthClient,
  origin: string,
  nextPath: string
): Promise<void> {
  const { error } = await supabase.auth.signInWithOAuth(googleOAuthRequest(origin, nextPath));
  if (error) throw new Error(googleAuthErrorMessage(error.message));
}

export async function startGoogleConnect(supabase: OAuthClient, origin: string): Promise<void> {
  const { error } = await supabase.auth.linkIdentity(
    googleOAuthRequest(origin, GOOGLE_CONNECT_NEXT)
  );
  if (error) throw new Error(googleAuthErrorMessage(error.message));
}

export function googleAuthErrorMessage(message: string): string {
  if (/manual linking is disabled/i.test(message)) {
    return "Connecting Google is not switched on for this project yet.";
  }
  if (/already linked|identity already exists|already been registered/i.test(message)) {
    return "That Google account is already used by a different SailorPath account.";
  }
  if (/provider is not enabled|unsupported provider/i.test(message)) {
    return "Google sign-in is not available right now.";
  }
  return "We couldn’t start Google sign-in. Please try again.";
}

/**
 * Where a failed Google return should land.
 * A connect attempt that started from account settings goes back there.
 */
export function googleCallbackFailureTarget(input: {
  origin: string;
  next: string | null;
  oauthError: string | null;
}): string {
  const next = input.next?.trim() ?? "";
  if (next === "/account" || next.startsWith("/account?") || next.startsWith("/account#")) {
    const url = new URL(next, input.origin);
    url.searchParams.set("google", input.oauthError === "access_denied" ? "denied" : "failed");
    return url.toString();
  }
  const code = input.oauthError === "access_denied" ? "google_denied" : "Could not authenticate";
  return `${input.origin}/login?error=${encodeURIComponent(code)}`;
}
