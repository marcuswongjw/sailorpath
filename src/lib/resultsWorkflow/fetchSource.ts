import { lookup } from "node:dns/promises";
import { request } from "node:https";
import { isIP } from "node:net";

// Restrict the crawler to public IPv4 destinations. Pin the checked DNS result
// into the connection so a second lookup cannot rebind to an internal address.
export function isPublicResultsAddress(address: string): boolean {
  if (isIP(address) !== 4) return false;
  const [a, b, c] = address.split(".").map(Number);
  return !(a === 0 || a === 10 || a === 127 || a >= 224 ||
    (a === 100 && b >= 64 && b <= 127) || (a === 169 && b === 254) ||
    (a === 172 && b >= 16 && b <= 31) || a === 192 ||
    (a === 198 && (b === 18 || b === 19 || (b === 51 && c === 100))) ||
    (a === 203 && b === 0 && c === 113));
}

export function resultsUrl(raw: string): URL {
  const url = new URL(raw);
  if (url.protocol !== "https:" || url.username || url.password || (url.port && url.port !== "443")) throw new Error("Use a public HTTPS event/results URL.");
  return url;
}

export async function fetchResultsSource(raw: string, redirects = 0, readPdf = false): Promise<{ url: string; kind: "pdf" | "html"; body: string }> {
  const url = resultsUrl(raw);
  if (redirects > 2) throw new Error("Too many redirects.");
  const addresses = await new Promise<Array<{ address: string; family: number }>>((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error("Event site DNS lookup timed out.")), 3000);
    lookup(url.hostname, { family: 4, all: true }).then(
      (value) => { clearTimeout(timer); resolve(value); },
      (error) => { clearTimeout(timer); reject(error); },
    );
  });
  if (!addresses.length || addresses.some((a) => !isPublicResultsAddress(a.address))) throw new Error("Event site does not resolve to a public address.");
  const address = addresses[0].address;
  return new Promise((resolve, reject) => {
    const req = request(url, {
      headers: { "User-Agent": "SailorPath-Results/1.0", Accept: "text/html,application/pdf" },
      family: 4,
      lookup: (_hostname, _options, callback) => callback(null, address, 4),
    }, (res) => {
      if (res.statusCode && [301, 302, 303, 307, 308].includes(res.statusCode)) {
        res.resume();
        if (!res.headers.location) return reject(new Error("Redirect without location."));
        fetchResultsSource(new URL(res.headers.location, url).href, redirects + 1, readPdf).then(resolve, reject);
        return;
      }
      if (res.statusCode !== 200) { res.resume(); reject(new Error(`Event site returned HTTP ${res.statusCode}.`)); return; }
      const type = String(res.headers["content-type"] || "");
      const isPdf = /application\/pdf/i.test(type);
      if (isPdf && !readPdf) {
        res.destroy(); resolve({ url: url.href, kind: "pdf", body: "" }); return;
      }
      if (!isPdf && !/text\/html|application\/xhtml\+xml/i.test(type)) { res.destroy(); reject(new Error("Unsupported source format; review the event site.")); return; }
      const chunks: Buffer[] = [];
      let size = 0;
      res.on("data", (chunk: Buffer) => {
        size += chunk.length;
        if (size > (isPdf ? 4_000_000 : 750_000)) { res.destroy(); reject(new Error("Result source exceeds the download size limit.")); }
        else chunks.push(chunk);
      });
      res.on("error", reject);
      res.on("end", () => resolve({ url: url.href, kind: isPdf ? "pdf" : "html", body: Buffer.concat(chunks).toString(isPdf ? "base64" : "utf8") }));
    });
    const timer = setTimeout(() => req.destroy(new Error("Event site timed out.")), 8_000);
    req.on("close", () => clearTimeout(timer));
    req.on("error", reject);
    req.end();
  });
}
