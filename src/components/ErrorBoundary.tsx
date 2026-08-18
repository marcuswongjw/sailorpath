"use client";

import { Component, type ReactNode } from "react";

type Props = {
  children: ReactNode;
  fallback?: ReactNode;
};

type State = {
  error: Error | null;
};

/**
 * Catches render errors in child components so a single broken feature
 * does not crash the entire page. Renders children normally until an
 * error is thrown, then switches to the fallback (or a default message).
 */
export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { error: null };
  }

  static getDerivedStateFromError(error: Error): State {
    return { error };
  }

  componentDidCatch(error: Error, info: React.ErrorInfo) {
    console.error("[ErrorBoundary]", error, info.componentStack);
  }

  render() {
    if (this.state.error) {
      if (this.props.fallback) return this.props.fallback;
      const isDev = process.env.NODE_ENV === "development";
      return (
        <div className="rounded-2xl border border-rose-500/20 bg-rose-500/5 p-6 text-center space-y-2">
          <p className="text-sm font-bold text-rose-300">
            This section encountered an error.
          </p>
          <p className="text-xs text-slate-500">
            {isDev
              ? this.state.error.message
              : "Please try again. If it keeps happening, contact support."}
          </p>
          <button
            type="button"
            onClick={() => this.setState({ error: null })}
            className="rounded-full bg-rose-500/10 border border-rose-500/20 px-4 py-1.5 text-xs font-bold text-rose-200 hover:bg-rose-500/20"
          >
            Retry
          </button>
        </div>
      );
    }
    return this.props.children;
  }
}
