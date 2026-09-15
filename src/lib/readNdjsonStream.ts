export async function readNdjsonStream(
  stream: ReadableStream<Uint8Array>,
  onMessage: (message: unknown) => void | Promise<void>
): Promise<void> {
  const reader = stream.getReader();
  const decoder = new TextDecoder();
  let buffer = "";

  const processLine = async (line: string) => {
    if (!line.trim()) return;
    let message: unknown;
    try {
      message = JSON.parse(line);
    } catch {
      throw new Error("The server returned an invalid streaming response.");
    }
    await onMessage(message);
  };

  while (true) {
    const { done, value } = await reader.read();
    if (done) break;
    buffer += decoder.decode(value, { stream: true });
    const lines = buffer.split("\n");
    buffer = lines.pop() || "";
    for (const line of lines) await processLine(line);
  }

  buffer += decoder.decode();
  await processLine(buffer);
}
