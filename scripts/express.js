const express = require("express");
const { exec } = require("child_process");

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  exec("./scripts/token_uri.sh", (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    res.send(stdout);
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
