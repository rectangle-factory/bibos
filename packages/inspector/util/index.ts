import FileSaver from "file-saver";

export const decodeBase64 = (encodedMetadata: string) =>
  Buffer.from(stripMimeType(encodedMetadata), "base64").toString("ascii");

export const stripMimeType = (encoding: string) => encoding.substr(encoding.indexOf(",") + 1);

export function isOdd(num) {
  return num % 2;
}

export function downloadSVG(svgString, name) {
  var blob = new Blob([svgString], { type: "text/plain;charset=utf-8" });
  FileSaver.saveAs(blob, `${name}.svg`);
}

export function downloadPNG(canvasRef, svgString, name, width, height) {
  const canvas = canvasRef.current;
  const ctx = canvas.getContext("2d");

  var svg64 = Buffer.from(svgString).toString("base64");
  var b64Start = "data:image/svg+xml;base64,";
  var image64 = b64Start + svg64;

  const img = new Image(width, height);

  // set it as the source of the img element
  img.onload = function () {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // draw the image onto the canvas
    canvas.getContext("2d").drawImage(img, 0, 0);
    const png = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");
    FileSaver.saveAs(png, `${name}.png`);
  };
  img.src = image64;
}

export function scaleCanvas(canvasRef, dpr = 1) {
  const canvas = canvasRef.current;
  const rect = canvas.getBoundingClientRect();
  canvas.width = rect.width * dpr;
  canvas.height = rect.height * dpr;
}
