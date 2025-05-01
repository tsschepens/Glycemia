import { LibreLinkClient } from "libre-link-unofficial-api";
import fs from "fs";
import path from "path";
const cacheFile = path.join("/home/user/.cache/", "your-cache-file");
async function fetchGlycemia() {
  const client = new LibreLinkClient({ email: "your-email", password: "your-password" });
  await client.login();
  const reading = await client.read();
  const valeurGlycemie = reading.value;
  let previousValue = null;
  if (fs.existsSync(cacheFile)) {
    previousValue = parseFloat(fs.readFileSync(cacheFile, "utf8"));
  }
  fs.writeFileSync(cacheFile, valeurGlycemie.toString());
  const d = previousValue - valeurGlycemie;
  let trendSymbol = " ";
  if (previousValue !== null) {
    if (d > 20) {
      trendSymbol = "";
    } else if (d > 0) {
      trendSymbol = "";
    } else if (d < -20) {
      trendSymbol = "";
    } else if (d < 0) {
      trendSymbol = "";
    } else {
      trendSymbol = "";
    }
  }
  console.log(trendSymbol, valeurGlycemie, "mg/dL");
  fs.appendFileSync(cacheFile, trendSymbol.toString());
}
fetchGlycemia();

