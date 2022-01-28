/* SPDX-FileCopyrightText: 2022-present Kriasoft <hello@kriasoft.com> */
/* SPDX-License-Identifier: MIT */

import spawn from "cross-spawn";
import path from "node:path";
import { fileURLToPath } from "node:url";

const cwd = path.join(fileURLToPath(import.meta.url), "../..");
const TF_DATA_DIR = path.join(cwd, ".terraform");
const TF_CLI_CONFIG_FILE = path.join(cwd, ".terraformrc");
let TF_WORKSPACE = process.env.TF_WORKSPACE ?? "test";

// Show a friendly error when Terraform CLI was not found
process.on("uncaughtException", (/** @type {NodeJS.ErrnoException} */ err) => {
  if (err.code === "ENOENT") {
    console.error(
      [
        `╷ `,
        `│ Error: Terraform CLI not found`,
        `│ `,
        `│ For more information visit:`,
        `│ https://learn.hashicorp.com/tutorials/terraform/install-cli`,
        `╵ `,
      ].join("\n"),
    );
    process.exitCode = 1;
  } else {
    throw err;
  }
});

const args = process.argv.slice(2);

// Check for the `--env=<name>` argument
for (let i = 0; i < args.length; i++) {
  const [, envName] = args[i]?.match(/--env=(\w+)/) ?? [];
  if (envName) {
    TF_WORKSPACE = envName || TF_WORKSPACE;
    args.splice(i--, 1);
  }
}

// Use `/infra` as the root directory
if (args[0]?.match(/^[a-z]/)) {
  args.splice(0, 0, `-chdir=infra`);
}

// Spawn a Terraform CLI process
spawn("terraform", args, {
  cwd,
  // https://www.terraform.io/cli/config/environment-variables
  env: { ...process.env, TF_DATA_DIR, TF_CLI_CONFIG_FILE, TF_WORKSPACE },
  stdio: "inherit",
}).on("exit", function (code) {
  if (code) process.exitCode = code;
});
