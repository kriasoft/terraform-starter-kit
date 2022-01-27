/* SPDX-FileCopyrightText: 2022-present Kriasoft <hello@kriasoft.com> */
/* SPDX-License-Identifier: MIT */

import { existsSync } from "node:fs";
import { writeFile } from "node:fs/promises";

const files = {
  "env/.local.override.env": [
    `# Variable overrides for the "local" environment`,
    ``,
  ].join("\n"),

  "env/.test.override.env": [
    `# Variable overrides for the "test" (QA) environment`,
    ``,
  ].join("\n"),

  "env/.prod.override.env": [
    `# Variable overrides for the "prod" (production) environment`,
    ``,
  ].join("\n"),

  ".terraformrc": [
    `# Terraform Cloud Credentials`,
    `# https://app.terraform.io/app/settings/tokens`,
    ``,
    `credentials "app.terraform.io" {`,
    `  token = "xxxxxx.atlasv1.zzzzzzzzzzzzz"`,
    `}`,
  ].join("\n"),

  "infra/override.tf": [
    `# Terraform Configuration Overrides`,
    `# https://www.terraform.io/language/files/override`,
    ``,
  ].join("\n"),
};

for (const filename of Object.keys(files)) {
  if (existsSync(filename)) continue;
  await writeFile(filename, files[filename], "utf-8");
}
