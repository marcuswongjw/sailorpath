import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks=vi.hoisted(()=>({auth:vi.fn(),send:vi.fn()}));
vi.mock("@/lib/auth",()=>({requireSuperadmin:mocks.auth,jsonError:()=>Response.json({error:"Denied"},{status:403})}));
vi.mock("@/lib/supportDelivery",async(importOriginal)=>({...await importOriginal<typeof import("@/lib/supportDelivery")>(),deliverSupportEmail:mocks.send}));
import { POST } from "./route";
const body={messageId:"00000000-0000-4000-8000-000000000001",requestId:"00000000-0000-4000-8000-000000000002",text:"We have fixed it."};
const request=(origin="https://admin.sailorpath.com",data=body)=>new Request("https://admin.sailorpath.com/api/admin/support/reply",{method:"POST",headers:{origin,"content-type":"application/json"},body:JSON.stringify(data)});
beforeEach(()=>{vi.clearAllMocks();mocks.auth.mockResolvedValue({userId:"admin",email:"team@example.com"});mocks.send.mockResolvedValue({status:"sent"});});
describe("admin support reply boundary",()=>{
 it("requires superadmin before sending",async()=>{mocks.auth.mockRejectedValue(new Error("FORBIDDEN"));expect((await POST(request())).status).toBe(403);expect(mocks.send).not.toHaveBeenCalled();});
 it("rejects a cross-site send",async()=>{expect((await POST(request("https://other.example"))).status).toBe(403);expect(mocks.send).not.toHaveBeenCalled();});
 it("rejects blank replies",async()=>{expect((await POST(request(undefined,{...body,text:" "}))).status).toBe(400);expect(mocks.send).not.toHaveBeenCalled();});
 it("sends only the server-resolved ticket reply and reports failed acceptance honestly",async()=>{
  expect((await POST(request())).status).toBe(200);
  expect(mocks.send).toHaveBeenCalledWith(expect.objectContaining({messageId:body.messageId,id:body.requestId,kind:"reply",text:body.text}));
  mocks.send.mockResolvedValue({status:"failed"});expect((await POST(request())).status).toBe(503);
 });
});
