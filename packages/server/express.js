const express = require("express");
const { exec } = require("child_process");
const cors = require("cors");

const app = express();
app.use(cors());
const port = 3001;

app.get("/", (req, res) => {
  exec("cd ../.. && ./scripts/get_token_uri.sh", (err, stdout, stderr) => {
    if (stderr) {
      console.error(`exec error: ${stderr}`);
      return;
    }
    console.log("synthesis_engine: synthesized bibos");
    res.send(stdout);
  });
});

app.listen(port, () => {
  console.log(`bibOS/synthesis_engine.bib listening on port ${port}`);
});
