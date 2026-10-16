import Link from "next/link";
import { createEditorialDraft, updateEditorialArticle } from "@/app/admin/news/actions";

type Status = "draft" | "in_review" | "published" | "archived";
type Kind = "result_report" | "correction" | "class_announcement" | "product_update" | "partner_update";
export type AdminNewsWorkflowArticle = {
  id: string; slug: string; status: Status; kind: Kind; title: string; summary: string; body: string;
  authorDisplayName: string; relatedClass: string | null; relatedRegion: string | null;
  sourceUrl: string | null; sourceLabel: string | null; tags: string[]; updatedAt: Date; publishedAt: Date | null;
};

const kinds: Kind[] = ["result_report", "correction", "class_announcement", "product_update", "partner_update"];
const empty = { slug: "", kind: "product_update" as Kind, title: "", summary: "", body: "", authorDisplayName: "SailorPath", relatedClass: null, relatedRegion: null, sourceUrl: null, sourceLabel: null, tags: [] };

function stamp(value: Date | null) { return value ? new Intl.DateTimeFormat("en-GB", { dateStyle: "medium", timeStyle: "short" }).format(value) : "—"; }
function statusClass(status: Status) { return status === "published" ? "bg-emerald-100 text-emerald-800" : status === "in_review" ? "bg-amber-100 text-amber-900" : status === "archived" ? "bg-slate-200 text-slate-700" : "bg-aqua-mist text-harbour"; }

export function AdminNewsWorkflow({ articles, selected }: { articles: AdminNewsWorkflowArticle[]; selected: AdminNewsWorkflowArticle | null }) {
  const article = selected ?? empty;
  const isNew = !selected;
  const canSaveDraft = isNew || selected.status === "draft" || selected.status === "in_review";
  return <main className="mx-auto max-w-7xl space-y-6 px-4 py-8 sm:px-6 lg:px-8">
    <header className="flex flex-col gap-4 border-b border-cool-veil pb-6 sm:flex-row sm:items-end sm:justify-between">
      <div><p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Admin · editorial</p><h1 className="mt-2 text-3xl font-black tracking-tight text-harbour-shadow">Author, review and publish</h1><p className="mt-2 max-w-2xl text-sm leading-6 text-slate-soft">Draft first, submit for review, then publish. Only published articles appear on the public Updates index.</p></div>
      <Link href="/admin/news" className="sp-primary px-4 py-2.5 text-center text-sm font-bold">New draft</Link>
    </header>
    <div className="grid gap-6 lg:grid-cols-[20rem_minmax(0,1fr)]">
      <aside className="rounded-2xl border border-cool-veil bg-warm-white p-3"><div className="px-2 py-2 text-sm font-black text-harbour-shadow">Articles</div>{articles.length === 0 ? <p className="px-2 py-6 text-sm text-slate-soft">No editorial drafts yet.</p> : <div className="space-y-1">{articles.map((item) => <Link key={item.id} href={`/admin/news?article=${encodeURIComponent(item.id)}`} className={`block rounded-xl px-3 py-3 ${selected?.id === item.id ? "bg-aqua-mist" : "hover:bg-sand"}`}><div className="flex items-start justify-between gap-2"><span className="line-clamp-2 text-sm font-bold text-harbour-shadow">{item.title}</span><span className={`shrink-0 rounded-full px-2 py-0.5 text-[10px] font-bold ${statusClass(item.status)}`}>{item.status.replace(/_/g, " ")}</span></div><p className="mt-1 truncate text-xs text-slate-soft">/{item.slug}</p></Link>)}</div>}</aside>
      <section className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6"><div className="mb-5 flex flex-wrap items-start justify-between gap-3"><div><h2 className="text-xl font-black text-harbour-shadow">{isNew ? "New editorial draft" : "Edit article"}</h2>{selected ? <p className="mt-1 text-xs text-slate-soft">Last changed {stamp(selected.updatedAt)} · Published {stamp(selected.publishedAt)}</p> : null}</div>{selected ? <span className={`rounded-full px-2.5 py-1 text-xs font-bold ${statusClass(selected.status)}`}>{selected.status.replace(/_/g, " ")}</span> : null}</div>
        <form action={isNew ? createEditorialDraft : updateEditorialArticle} className="space-y-4"><input type="hidden" name="id" value={selected?.id ?? ""} />
          <div className="grid gap-4 sm:grid-cols-2"><Field label="Slug" name="slug" value={article.slug} placeholder="event-result-update" /><label className="block text-sm font-semibold text-charcoal">Type<select name="kind" defaultValue={article.kind} className="mt-1.5 w-full rounded-lg border border-cool-veil bg-white px-3 py-2 font-normal">{kinds.map((kind) => <option key={kind} value={kind}>{kind.replace(/_/g, " ")}</option>)}</select></label></div>
          <Field label="Title" name="title" value={article.title} /><Area label="Summary" name="summary" value={article.summary} rows={3} /><Area label="Body" name="body" value={article.body} rows={12} />
          <div className="grid gap-4 sm:grid-cols-2"><Field label="Author display name" name="authorDisplayName" value={article.authorDisplayName} /><Field label="Tags" name="tags" value={article.tags.join(", ")} placeholder="results, singapore" /><Field label="Related class" name="relatedClass" value={article.relatedClass ?? ""} /><Field label="Related region" name="relatedRegion" value={article.relatedRegion ?? ""} /><Field label="Source URL" name="sourceUrl" value={article.sourceUrl ?? ""} placeholder="https://…" /><Field label="Source label" name="sourceLabel" value={article.sourceLabel ?? ""} placeholder="Official results" /></div>
          <div className="flex flex-wrap gap-3 border-t border-cool-veil pt-5">{canSaveDraft ? <button type="submit" name="action" value="save_draft" className="rounded-xl border border-harbour px-4 py-2.5 text-sm font-bold text-harbour hover:bg-aqua-mist">{isNew ? "Create draft" : "Save as draft"}</button> : null}{selected?.status === "draft" ? <button type="submit" name="action" value="submit_review" className="rounded-xl border border-amber-500 bg-amber-50 px-4 py-2.5 text-sm font-bold text-amber-900">Submit for review</button> : null}{selected?.status === "in_review" ? <button type="submit" name="action" value="publish" className="sp-primary px-4 py-2.5 text-sm font-bold">Publish update</button> : null}{selected && selected.status !== "archived" ? <button type="submit" name="action" value="archive" className="rounded-xl border border-slate-300 px-4 py-2.5 text-sm font-bold text-slate-700">Archive</button> : null}</div>
          <p className="text-xs leading-5 text-slate-soft">Publishing records the reviewing administrator and timestamp, invalidates the public Updates cache, and keeps the audit trail. Published content must be archived before it can be replaced by a revised draft.</p>
        </form></section>
    </div>
  </main>;
}
function Field({ label, name, value, placeholder }: { label: string; name: string; value: string; placeholder?: string }) { return <label className="block text-sm font-semibold text-charcoal">{label}<input name={name} defaultValue={value} placeholder={placeholder} className="mt-1.5 w-full rounded-lg border border-cool-veil bg-white px-3 py-2 font-normal" /></label>; }
function Area({ label, name, value, rows }: { label: string; name: string; value: string; rows: number }) { return <label className="block text-sm font-semibold text-charcoal">{label}<textarea name={name} defaultValue={value} rows={rows} className="mt-1.5 w-full rounded-lg border border-cool-veil bg-white px-3 py-2 font-normal" /></label>; }
