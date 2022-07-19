// pages/api/index.ts

import { NextApiRequest, NextApiResponse } from "next";
const { exec } = require("child_process");

const LOCAL_RENDER_SCRIPT_PATH = "./scripts/local_render.sh";
export default async (request: NextApiRequest, response: NextApiResponse) =>
  new Promise<void>((resolve, _) =>
    exec("cd ../.. && " + LOCAL_RENDER_SCRIPT_PATH, (_: any, stdout: string, stderr: string) => {
      if (stderr) {
        // log the error to console
        console.log("stderr: ", stderr);
        // ignore errors until solmate updates their foundry.toml
        // response.status(500);
        // response.send(stderr);
        // return resolve();
      }

      response.json(JSON.parse(stdout));
      resolve();
    })
  );
