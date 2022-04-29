// pages/api/index.ts

import { NextApiRequest, NextApiResponse } from "next";
const { exec } = require("child_process");

export default async (request: NextApiRequest, response: NextApiResponse) =>
  new Promise<void>((resolve, reject) =>
    exec("cd ../.. && ./scripts/get_token_uri.sh", (err, stdout, stderr) => {
      console.log("err: ", err);
      if (stderr) {
        console.log("err: ", err);
        console.log("stderr: ", stderr);
        response.status(500);
        response.send(stderr);
        return resolve();
      }
      console.log("synthesis_engine: synthesized bibos");
      response.send(stdout);
      resolve();
    })
  );
