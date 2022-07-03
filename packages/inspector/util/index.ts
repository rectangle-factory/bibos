export const decodeBase64 = (encodedMetadata: string) =>
  Buffer.from(stripMimeType(encodedMetadata), "base64").toString("ascii");

export const stripMimeType = (encoding: string) => encoding.substr(encoding.indexOf(",") + 1);

export function isOdd(num) {
  return num % 2;
}
