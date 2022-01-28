/* SPDX-FileCopyrightText: 2022-present Kriasoft <hello@kriasoft.com> */
/* SPDX-License-Identifier: MIT */

import { existsSync } from "node:fs";
import { writeFile } from "node:fs/promises";

const files = {
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
    `# terraform {`,
    `#   backend "remote" {`,
    `#     organization = "example"`,
    ``,
    `#     workspaces {`,
    `#       prefix = "app-"`,
    `#     }`,
    `#   }`,
    `# }`,
    ``,
    `# locals {`,
    `#   # The primary application domain name`,
    `#   domain = "example.com"`,
    ``,
    `#   # Google Cloud Project`,
    `#   # https://cloud.google.com/resource-manager/docs/creating-managing-projects`,
    `#   project = {`,
    `#     "prod" = "example"`,
    `#     "test" = "example-test"`,
    `#     "dev"  = "example-prod"`,
    `#   }[local.env]`,
    `# }`,
    ``,
  ].join("\n"),
};

for (const filename of Object.keys(files)) {
  if (existsSync(filename)) continue;
  console.log(`Creating ${filename}`);
  await writeFile(filename, files[filename], "utf-8");
}
