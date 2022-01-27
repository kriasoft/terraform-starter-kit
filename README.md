<h1 align="center">
  <img src="https://www.datocms-assets.com/2885/1620155113-brandhcterraformprimaryattributedcolor.svg" width="313" height="88" alt="Terraform" /><br>
  Terraform Starter Kit
  <br>
  <a href="http://patreon.com/koistya"><img src="https://img.shields.io/badge/dynamic/json?color=%23ff424d&label=Patreon&style=flat-square&query=data.attributes.patron_count&suffix=%20patrons&url=https%3A%2F%2Fwww.patreon.com%2Fapi%2Fcampaigns%2F233228" height="20"></a>
  <a href="https://discord.gg/ZwkR8E3tFm"><img src="https://img.shields.io/discord/643523529131950086?label=Chat&style=flat-square" height="20"></a>
  <a href="https://github.com/kriasoft/terraform-starter-kit/stargazers"><img src="https://img.shields.io/github/stars/kriasoft/terraform-starter-kit.svg?style=social&label=Star&maxAge=3600" height="20"></a>
  <a href="https://twitter.com/koistya"><img src="https://img.shields.io/twitter/follow/koistya.svg?style=social&label=Follow&maxAge=3600" height="20"></a>
</h1>

The basic building blocks for configuring a cloud infrastructure inside of
a monorepo project using [Terraform](https://www.terraform.io/).

## Requirements

- [Node.js](https://nodejs.org/en/) v16+ with [Yarn](https://yarnpkg.com/) package manager
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) and [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [VS Code](https://code.visualstudio.com/) editor with [recommended extensions](.vscode/extensions.json)

<details>
  <summary>How to install Terraform CLI on macOS?</summary><br>

```bash
$ brew tap hashicorp/tap
$ brew install hashicorp/tap/terraform
$ brew update
$ brew upgrade hashicorp/tap/terraform
$ yarn tf -version
```

</details>

<details>
  <summary>How to create Google Cloud Platform projects?</summary><br>

Simply navigate to [Google Cloud Resource Manager](https://console.cloud.google.com/cloud-resource-manager)
and create two GCP projects for both `test` (QA) and `prod` (production)
environments, e.g. "example" and "example-test".

Fore more information visit https://cloud.google.com/resource-manager/docs/creating-managing-projects<br>

</details>

<details>
  <summary>How to configure Terraform Cloud workspaces?</summary><br>

1. Sign in to [Terraform Cloud](https://cloud.hashicorp.com/products/terraform) dashboard.
2. Create or join an organization.
3. Create two workspaces — `app-test` and `app-prod` for test/QA and production environments.
4. In each of these workspaces create an environment variable called `GOOGLE_CREDENTIALS` with the value containing JSON key of a GCP [service account](https://cloud.google.com/iam/docs/service-accounts). Note, this GCP service account needs to have `Owner` or `Editor` + `Service Usage Admin` roles.

For more information visit https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference<br>

</details>

<details>
  <summary>How to authenticate Terraform CLI in Terraform Cloud?</summary><br>

1. Create a personal or team [API Token](https://learn.hashicorp.com/tutorials/terraform/cloud-login) via [Terraform Cloud](https://app.terraform.io/app/) dashboard → [Settings](https://app.terraform.io/app/settings/tokens).
2. Save API token to the `.terraformrc` file in root of the project:

```
credentials "app.terraform.io" {
  token = "xxxxxx.atlasv1.zzzzzzzzzzzzz"
}
```

**NOTE**: This would allow to using different Terraform credentials per software project if you want to.<br>

</details>

## Getting Started

- `yarn install` — installs project dependencies
- `yarn tf init -upgrade` — initializes a Terraform workspace
- `yarn tf plan` — creates an execution plan
- `yarn tf apply` — executes the actions proposed by the `yarn tf plan` command

**NOTE**: By default the `app-test` Terraform workspace is used. In order to use
the production workspace, set `TF_WORKSPACE` environment variable to `prod`. For
example:

```bash
$ TF_WORKSPACE=prod yarn tf plan
$ TF_WORKSPACE=prod yarn tf apply -auto-approve
```

**NOTE**: You need to run Terraform commands via `yarn tf <command> [...args]`.

<p align="center">
  <a href="https://www.youtube.com/watch?v=tomUWcQ0P3k"><img src="https://user-images.githubusercontent.com/197134/151321818-d47fe54f-c19e-4d4c-9834-c33e589a33e1.png" alt="" width="640" height="360" /></a>
</p>

Fore more information visit https://learn.hashicorp.com/terraform

## Related Projects

- [GraphQL API and Relay Starter Kit](https://github.com/kriasoft/relay-starter-kit) — full-stack monorepo template (GCP, GraphQL API, React, Relay)

## How to Contribute

Anyone and everyone is welcome to [contribute](.github/CONTRIBUTING.md). Submit
a pull request (PR) or send me a message on [Discord](https://discord.gg/ZwkR8E3tFm).

## License

Copyright © 2022-present Kriasoft. This source code is licensed under the MIT license found in the
[LICENSE](LICENSE) file.

---

<sup>Made with ♥ by Konstantin Tarkus ([@koistya](https://twitter.com/koistya), [blog](https://koistya.medium.com/))
and [contributors](https://github.com/kriasoft/terraform-starter-kit/graphs/contributors).</sup>
