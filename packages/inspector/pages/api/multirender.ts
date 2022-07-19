// pages/api/index.ts

import { NextApiRequest, NextApiResponse } from "next";
const { exec } = require("child_process");

const SCRIPT_PATH = "./scripts/multi_render.sh";
export default async (request: NextApiRequest, response: NextApiResponse) =>
  new Promise<void>((resolve, _) => {
    const quantity = request.body.quantity;

    const command = "cd ../.. && " + SCRIPT_PATH + ` ${quantity}`;
    exec(command, (_: any, stdout: string, stderr: string) => {
      if (stderr) {
        console.log("stderr: ", stderr);

        response.status(500);
        response.send(stderr);
        return resolve();
      }

      response.json(JSON.parse(stdout));
      resolve();
    });
  });
