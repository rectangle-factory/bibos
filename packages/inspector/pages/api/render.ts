// pages/api/index.ts

import { NextApiRequest, NextApiResponse } from "next";
const { exec } = require("child_process");

export default async (request: NextApiRequest, response: NextApiResponse) =>
  new Promise<void>((resolve, reject) =>
    exec("cd ../.. && ./scripts/get_token_uri.sh", (err, stdout, stderr) => {
      if (stderr) {
        console.error(`exec error: ${stderr}`);
        response.json(stderr);
        response.status(405).end();
        reject();
      }
      console.log("synthesis_engine: synthesized bibos");
      response.send(stdout);
      response.end();
      resolve();
    })
  );
