import { describe, expect, it, vi } from "vitest";
import { readNdjsonStream } from "./readNdjsonStream";

function streamChunks(chunks: string[]) {
  const encoder = new TextEncoder();
  return new ReadableStream<Uint8Array>({
    start(controller) {
      for (const chunk of chunks) controller.enqueue(encoder.encode(chunk));
      controller.close();
    },
  });
}

describe("readNdjsonStream", () => {
  it("decodes messages split across network chunks and keeps the final line", async () => {
    const onMessage = vi.fn();
    await readNdjsonStream(
      streamChunks([
        '{"type":"progress","message":"Sav',
        'ing"}\n{"type":"result","matched":2}',
      ]),
      onMessage
    );

    expect(onMessage).toHaveBeenNthCalledWith(1, {
      type: "progress",
      message: "Saving",
    });
    expect(onMessage).toHaveBeenNthCalledWith(2, {
      type: "result",
      matched: 2,
    });
  });

  it("propagates the exact server error from the message handler", async () => {
    await expect(
      readNdjsonStream(
        streamChunks(['{"type":"error","error":"Duplicate sailors found"}\n']),
        (message) => {
          const parsed = message as { type?: string; error?: string };
          if (parsed.type === "error") throw new Error(parsed.error);
        }
      )
    ).rejects.toThrow("Duplicate sailors found");
  });

  it("rejects malformed server messages explicitly", async () => {
    await expect(
      readNdjsonStream(streamChunks(["not-json\n"]), vi.fn())
    ).rejects.toThrow("invalid streaming response");
  });
});
