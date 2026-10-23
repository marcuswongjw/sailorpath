import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks=vi.hoisted(()=>({send:vi.fn(),insert:vi.fn(),returning:vi.fn()}));
vi.mock("@/lib/supportDelivery",()=>({deliverSupportEmail:mocks.send}));
vi.mock("@/lib/userChanges",()=>({withUserChangeTracking:(_area:string,handler:unknown)=>handler}));
vi.mock("@/lib/auth",()=>({getAuthContext:async()=>null,requireSuperadmin:vi.fn(),jsonError:()=>Response.json({error:"Failure"},{status:500})}));
vi.mock("@/db",()=>({db:{insert:mocks.insert},withDatabaseRetry:vi.fn()}));
vi.mock("@/lib/usage",()=>({trackUsage:vi.fn()}));
vi.mock("@/lib/rateLimit",()=>({clientIpFromRequest:()=>"test",rateLimitAsync:async()=>({ok:true}),rateLimitResponse:vi.fn()}));
import { POST } from "./route";
const id="00000000-0000-4000-8000-000000000001";
beforeEach(()=>{vi.clearAllMocks();mocks.insert.mockReturnValue({values:()=>({returning:mocks.returning})});mocks.returning.mockResolvedValue([{id}]);mocks.send.mockResolvedValue({status:"sent"});});
const request=(email="requester@example.com")=>new Request("https://sailorpath.com/api/support",{method:"POST",headers:{"content-type":"application/json"},body:JSON.stringify({email,message:"Please help with my account."})});
describe("support acknowledgement",()=>{
 it("acknowledges only a successfully saved ticket",async()=>{
  const response=await POST(request());expect(response.status).toBe(200);
  expect(await response.json()).toMatchObject({ok:true,id,acknowledgementStatus:"sent"});
  expect(mocks.send).toHaveBeenCalledWith({messageId:id,id,kind:"acknowledgement"});
 });
 it("keeps the saved request successful if email sending fails",async()=>{
  mocks.send.mockRejectedValue(new Error("Email unavailable"));
  const response=await POST(request());expect(response.status).toBe(200);
  expect(await response.json()).toMatchObject({ok:true,acknowledgementStatus:"failed",message:expect.stringContaining("do not need to submit it again")});
 });
 it("does not send for invalid submissions",async()=>{expect((await POST(request("invalid"))).status).toBe(400);expect(mocks.insert).not.toHaveBeenCalled();expect(mocks.send).not.toHaveBeenCalled();});
});
