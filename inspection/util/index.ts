export const parseUri = (encodedMetadata: string) =>
  JSON.parse(Buffer.from(stripMimeType(encodedMetadata), "base64").toString("ascii"));

const stripMimeType = (encoding: string) => encoding.substr(encoding.indexOf(",") + 1);
