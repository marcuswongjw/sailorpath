import { describe, expect, it } from "vitest";
import { avatarObjectPath, portraitFile, profilePhotoUrl } from "./profilePhoto";
const id = "11111111-1111-4111-8111-111111111111";
const host = "https://project.supabase.co";
describe("profile photo boundaries", () => {
  it("routes real photos through the consent reader", () => {
    expect(profilePhotoUrl(id, `${host}/storage/v1/object/public/avatars/${id}/1.jpg`)).toBe(`/api/sailors/${id}/photo`);
    expect(profilePhotoUrl(id, null)).toBeNull();
    expect(profilePhotoUrl("demo", "/demo-kimberly-tan.jpg")).toBe("/demo-kimberly-tan.jpg");
  });
  it("accepts only this sailor's originals on the configured storage origin", () => {
    const url = `${host}/storage/v1/object/public/avatars/${id}/1.jpg`;
    expect(avatarObjectPath(url, id, host)).toBe(`${id}/1.jpg`);
    for (const value of [url.replace("project", "evil"), url + "?token=secret", url.replace("1.jpg", "%2e%2e%2fsecret"), url.replace("1.jpg", "x/y.jpg")]) expect(avatarObjectPath(value, id, host)).toBeNull();
    expect(avatarObjectPath(url, "22222222-2222-4222-8222-222222222222", host)).toBeNull();
  });
  it("confines bundled portraits to the fixed private directory", () => {
    expect(portraitFile("https://sailorpath.com/athlete-portraits/team-singapore/example.jpg")).toBe("example.jpg");
    expect(portraitFile("https://evil.test/athlete-portraits/team-singapore/example.jpg")).toBeNull();
    expect(portraitFile("/athlete-portraits/team-singapore/../../secret.txt")).toBeNull();
  });
});
