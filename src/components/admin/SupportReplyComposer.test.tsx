// @vitest-environment jsdom
import { fireEvent, render, screen, waitFor } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { SupportReplyComposer } from "./SupportReplyComposer";
afterEach(()=>vi.unstubAllGlobals());
describe("support reply composer",()=>{
 it("keeps the draft and request identity for a retry after rejection",async()=>{
  const fetcher=vi.fn().mockResolvedValueOnce(Response.json({delivery:{status:"failed"}},{status:503})).mockResolvedValueOnce(Response.json({delivery:{status:"sent"}}));
  vi.stubGlobal("fetch",fetcher); const updated=vi.fn();
  render(<SupportReplyComposer messageId="ticket" email="requester@example.com" onUpdate={updated}/>);
  fireEvent.change(screen.getByRole("textbox"),{target:{value:"We fixed the issue."}});
  fireEvent.click(screen.getByRole("button",{name:"Send reply"}));
  await screen.findByText(/Your draft is kept/);
  expect(screen.getByRole("textbox")).toHaveValue("We fixed the issue.");
  fireEvent.click(screen.getByRole("button",{name:"Send reply"}));
  await waitFor(()=>expect(screen.getByRole("textbox")).toHaveValue(""));
  expect(fetcher.mock.calls[0][1].body).toBe(fetcher.mock.calls[1][1].body);expect(updated).toHaveBeenCalledTimes(2);
 });
});
