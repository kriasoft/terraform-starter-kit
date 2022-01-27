/* SPDX-FileCopyrightText: 2022-present Kriasoft <hello@kriasoft.com> */
/* SPDX-License-Identifier: MIT */

import chalk from "chalk";
import spawn from "cross-spawn";
import envars from "envars";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

// Load environment variables for the target Terraform workspace
// (PROJECT, REGION, ZONE, etc)
const TF_WORKSPACE = process.env.TF_WORKSPACE ?? "test";
const envName = TF_WORKSPACE === "prod" ? "prod" : "test";
const env = envars.config({ env: envName });

const { bold, red, blue } = chalk;
const cwd = path.join(fileURLToPath(import.meta.url), "../..");
const TF_DATA_DIR = path.join(cwd, ".terraform");
const TF_CLI_CONFIG_FILE = path.join(cwd, ".terraformrc");

// Show a friendly error when Terraform CLI was not found
process.on("uncaughtException", (/** @type {NodeJS.ErrnoException} */ err) => {
  if (err.code === "ENOENT") {
    console.error(
      [
        red("╷ "),
        red("│ ") + bold(`${red("Error:")} Terraform CLI not found`),
        red("│ "),
        red("│ ") + `For more information visit:`,
        red("│ ") +
          blue(`https://learn.hashicorp.com/tutorials/terraform/install-cli`),
        red("╵ "),
      ].join("\n")
    );
    process.exitCode = 1;
  } else {
    throw err;
  }
});

const args = process.argv.slice(2);

// See `infra/variables.tf`
// https://www.terraform.io/language/values/variables
if (["plan", "apply", "import"].includes(args[0])) {
  fs.writeFileSync(
    path.join(cwd, "infra/.auto.tfvars.json"),
    JSON.stringify(
      {
        project: env.PROJECT,
        region: env.REGION,
        zone: env.ZONE,
      },
      null,
      "  "
    ),
    "utf-8"
  );
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
