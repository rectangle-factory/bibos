const express = require("express");
const { exec } = require("child_process");
const cors = require("cors");

const app = express();
app.use(cors());
const port = 3001;

app.get("/", (req, res) => {
  exec("cd ../.. && ./scripts/get_token_uri.sh", (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    console.log("fetched token URI");
    res.send(stdout);
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
