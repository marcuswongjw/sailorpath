import { gzip, gunzip } from "node:zlib";
import { promisify } from "node:util";

const compress = promisify(gzip);
const decompress = promisify(gunzip);

/** Server-only JSON snapshots: compact repeated keys before the 2MB Data Cache limit. */
export async function encodeServerSnapshot(value: unknown): Promise<string> {
  return (await compress(JSON.stringify(value))).toString("base64");
}

export async function decodeServerSnapshot<T>(encoded: string): Promise<T> {
  const json = await decompress(Buffer.from(encoded, "base64"));
  return JSON.parse(json.toString("utf8")) as T;
}
