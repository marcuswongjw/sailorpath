import Link from "next/link";
import { createEditorialDraft, updateEditorialArticle } from "@/app/admin/news/actions";

type Status = "draft" | "in_review" | "published" | "archived";
type Kind =
  | "result_report"
  | "correction"
  | "class_announcement"
  | "product_update"
  | "partner_update";

export type AdminNewsWorkflowArticle = {
  id: string;
  slug: string;
  status: Status;
  kind: Kind;
  title: string;
  summary: string;
  body: string;
  authorDisplayName: string;
  relatedClass: string | null;
  relatedRegion: string | null;
  sourceUrl: string | null;
  sourceLabel: string | null;
  tags: string[];
  updatedAt: Date;
  publishedAt: Date | null;
};

const kinds: Kind[] = [
  "result_report",
  "correction",
  "class_announcement",
  "product_update",
  "partner_update",
];

const empty = {
  slug: "",
  kind: "product_update" as Kind,
  title: "",
  summary: "",
  body: "",
  authorDisplayName: "SailorPath",
  relatedClass: null,
  relatedRegion: null,
  sourceUrl: null,
  sourceLabel: null,
  tags: [] as string[],
};

function stamp(value: Date | null) {
  return value
    ? new Intl.DateTimeFormat("en-GB", {
        dateStyle: "medium",
        timeStyle: "short",
      }).format(value)
    : "—";
}

function statusClass(status: Status) {
  return status === "published"
    ? "bg-emerald-100 text-emerald-800"
    : status === "in_review"
      ? "bg-amber-100 text-amber-900"
      : status === "archived"
        ? "bg-slate-200 text-slate-700"
        : "bg-aqua-mist text-harbour";
}

export function AdminNewsWorkflow({
  articles,
  selected,
  errorMessage,
  savedMessage,
}: {
  articles: AdminNewsWorkflowArticle[];
  selected: AdminNewsWorkflowArticle | null;
  errorMessage?: string | null;
  savedMessage?: string | null;
}) {
  const article = selected ?? empty;
  const isNew = !selected;
  const formKey = selected ? `${selected.id}:${selected.updatedAt.getTime()}` : "new";
  const tagsList = Array.isArray(article.tags) ? article.tags : [];

  return (
    <main className="mx-auto max-w-7xl space-y-6 px-4 py-8 sm:px-6 lg:px-8">
      <nav aria-label="Admin editorial navigation" className="flex flex-wrap items-center justify-between gap-3 text-xs font-bold text-harbour">
        <Link href="/admin?area=settings&view=audit" className="hover:underline">
          ← Back to Admin Console
        </Link>
        <Link href="/news" className="hover:underline">
          View public Updates (/news) →
        </Link>
      </nav>

      <header className="flex flex-col gap-4 border-b border-cool-veil pb-6 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">
            Admin · editorial
          </p>
          <h1 className="mt-2 text-3xl font-black tracking-tight text-harbour-shadow">
            Author, review and publish
          </h1>
          <p className="mt-2 max-w-2xl text-sm leading-6 text-slate-soft">
            Save articles as drafts or publish directly to the public Updates index. Only published articles appear on /news.
          </p>
        </div>
        <Link
          href="/admin/news?article=new"
          className="sp-primary px-4 py-2.5 text-center text-sm font-bold"
        >
          New draft
        </Link>
      </header>

      {errorMessage ? (
        <div
          role="alert"
          aria-live="assertive"
          className="rounded-2xl border border-rose-300 bg-rose-50 px-4 py-3 text-sm font-semibold text-rose-900"
        >
          {errorMessage}
        </div>
      ) : null}

      {savedMessage ? (
        <div
          role="status"
          aria-live="polite"
          className="rounded-2xl border border-emerald-300 bg-emerald-50 px-4 py-3 text-sm font-semibold text-emerald-900"
        >
          {savedMessage}
        </div>
      ) : null}

      <div className="grid gap-6 lg:grid-cols-[20rem_minmax(0,1fr)]">
        <aside className="rounded-2xl border border-cool-veil bg-warm-white p-3">
          <div className="px-2 py-2 text-sm font-black text-harbour-shadow">
            Articles ({articles.length})
          </div>
          {articles.length === 0 ? (
            <p className="px-2 py-6 text-sm text-slate-soft">
              No editorial drafts yet.
            </p>
          ) : (
            <div className="space-y-1">
              {articles.map((item) => (
                <Link
                  key={item.id}
                  href={`/admin/news?article=${encodeURIComponent(item.id)}`}
                  aria-current={selected?.id === item.id ? "page" : undefined}
                  className={`block rounded-xl px-3 py-3 ${
                    selected?.id === item.id ? "bg-aqua-mist" : "hover:bg-sand"
                  }`}
                >
                  <div className="flex items-start justify-between gap-2">
                    <span className="line-clamp-2 text-sm font-bold text-harbour-shadow">
                      {item.title}
                    </span>
                    <span
                      className={`shrink-0 rounded-full px-2 py-0.5 text-[10px] font-bold ${statusClass(
                        item.status
                      )}`}
                    >
                      {item.status.replace(/_/g, " ")}
                    </span>
                  </div>
                  <p className="mt-1 truncate text-xs text-slate-soft">
                    /{item.slug}
                  </p>
                </Link>
              ))}
            </div>
          )}
        </aside>

        <section className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6">
          <div className="mb-5 flex flex-wrap items-start justify-between gap-3">
            <div>
              <h2 className="text-xl font-black text-harbour-shadow">
                {isNew ? "New editorial draft" : "Edit article"}
              </h2>
              {selected ? (
                <p className="mt-1 text-xs text-slate-soft">
                  Last changed {stamp(selected.updatedAt)} · Published{" "}
                  {stamp(selected.publishedAt)}
                </p>
              ) : null}
            </div>
            <div className="flex items-center gap-2">
              {selected?.status === "published" ? (
                <Link
                  href={`/news/${selected.slug}`}
                  className="text-xs font-bold text-harbour hover:underline"
                >
                  Open public article →
                </Link>
              ) : null}
              {selected ? (
                <span
                  className={`rounded-full px-2.5 py-1 text-xs font-bold ${statusClass(
                    selected.status
                  )}`}
                >
                  {selected.status.replace(/_/g, " ")}
                </span>
              ) : null}
            </div>
          </div>

          <form
            key={formKey}
            action={isNew ? createEditorialDraft : updateEditorialArticle}
            className="space-y-4"
          >
            <input type="hidden" name="id" value={selected?.id ?? ""} />

            <fieldset className="space-y-4">
              <legend className="sr-only">Article content</legend>
              <div className="grid gap-4 sm:grid-cols-2">
                <Field
                  id="editorial-slug"
                  label="Slug"
                  name="slug"
                  value={article.slug}
                  placeholder="event-result-update"
                  required
                />
                <div>
                  <label
                    htmlFor="editorial-kind"
                    className="block text-sm font-semibold text-charcoal"
                  >
                    Type
                  </label>
                  <select
                    id="editorial-kind"
                    name="kind"
                    defaultValue={article.kind}
                    className="mt-1.5 w-full rounded-lg border border-cool-veil bg-white px-3 py-2 text-sm font-normal text-charcoal"
                  >
                    {kinds.map((kind) => (
                      <option key={kind} value={kind}>
                        {kind.replace(/_/g, " ")}
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              <Field
                id="editorial-title"
                label="Title"
                name="title"
                value={article.title}
                required
              />
              <Area
                id="editorial-summary"
                label="Summary"
                name="summary"
                value={article.summary}
                rows={3}
                required
              />
              <Area
                id="editorial-body"
                label="Body"
                name="body"
                value={article.body}
                rows={14}
                required
              />
            </fieldset>

            <fieldset className="grid gap-4 sm:grid-cols-2">
              <legend className="sr-only">Metadata and provenance</legend>
              <Field
                id="editorial-author"
                label="Author display name"
                name="authorDisplayName"
                value={article.authorDisplayName}
              />
              <Field
                id="editorial-tags"
                label="Tags"
                name="tags"
                value={tagsList.join(", ")}
                placeholder="results, singapore"
              />
              <Field
                id="editorial-class"
                label="Related class"
                name="relatedClass"
                value={article.relatedClass ?? ""}
              />
              <Field
                id="editorial-region"
                label="Related region"
                name="relatedRegion"
                value={article.relatedRegion ?? ""}
              />
              <Field
                id="editorial-source-url"
                label="Source URL"
                name="sourceUrl"
                value={article.sourceUrl ?? ""}
                placeholder="https://…"
              />
              <Field
                id="editorial-source-label"
                label="Source label"
                name="sourceLabel"
                value={article.sourceLabel ?? ""}
                placeholder="Official results"
              />
            </fieldset>

            <div className="flex flex-wrap gap-3 border-t border-cool-veil pt-5">
              <button
                type="submit"
                name="action"
                value="save_draft"
                className="rounded-xl border border-harbour px-4 py-2.5 text-sm font-bold text-harbour hover:bg-aqua-mist"
              >
                Save as draft
              </button>
              <button
                type="submit"
                name="action"
                value="publish"
                className="sp-primary px-4 py-2.5 text-sm font-bold"
              >
                {selected?.status === "published" ? "Update published" : "Publish"}
              </button>
              {selected?.status === "draft" ? (
                <button
                  type="submit"
                  name="action"
                  value="submit_review"
                  className="rounded-xl border border-amber-500 bg-amber-50 px-4 py-2.5 text-sm font-bold text-amber-900"
                >
                  Submit for review
                </button>
              ) : null}
              {selected && selected.status !== "archived" ? (
                <button
                  type="submit"
                  name="action"
                  value="archive"
                  className="rounded-xl border border-slate-300 px-4 py-2.5 text-sm font-bold text-slate-700"
                >
                  Archive
                </button>
              ) : null}
            </div>
            <p className="text-xs leading-5 text-slate-soft">
              Save as draft keeps the article private inside Editorial. Publishing records the reviewing administrator and timestamp, invalidates the public Updates cache, and makes the article live on /news.
            </p>
          </form>
        </section>
      </div>
    </main>
  );
}

function Field({
  id,
  label,
  name,
  value,
  placeholder,
  required,
}: {
  id: string;
  label: string;
  name: string;
  value: string;
  placeholder?: string;
  required?: boolean;
}) {
  return (
    <div>
      <label htmlFor={id} className="block text-sm font-semibold text-charcoal">
        {label}
      </label>
      <input
        id={id}
        name={name}
        defaultValue={value}
        placeholder={placeholder}
        required={required}
        className="mt-1.5 w-full rounded-lg border border-cool-veil bg-white px-3 py-2 text-sm font-normal text-charcoal"
      />
    </div>
  );
}

function Area({
  id,
  label,
  name,
  value,
  rows,
  required,
}: {
  id: string;
  label: string;
  name: string;
  value: string;
  rows: number;
  required?: boolean;
}) {
  return (
    <div>
      <label htmlFor={id} className="block text-sm font-semibold text-charcoal">
        {label}
      </label>
      <textarea
        id={id}
        name={name}
        defaultValue={value}
        rows={rows}
        required={required}
        className="mt-1.5 w-full rounded-lg border border-cool-veil bg-white px-3 py-2 text-sm font-normal text-charcoal"
      />
    </div>
  );
}
