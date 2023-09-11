# Structurizr Kickstarter

Setting up the [Structurizr DSL](https://github.com/structurizr/dsl) is not the most intuitive process and does not provide:

- diagram samples
- diagram documentation templates
- support for multiple workspaces in a single project
- instructions to set up the Structurizr CLI

The aim of this project is to streamline the process of setting up Structurizr locally by leveraging Structurizr docker container, `structurizr/lite`, while also providing the resources needed to start creating diagrams quickly.

Using this project, you can edit diagrams locally then view them using Structurizr's web app in the browser. The web app offers a user-friendly way to view, manipulate, and download diagrams in different formats.

## Table of contents

- [Structurizr Kickstarter](#structurizr-kickstarter)
  - [Table of contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Set environment variables](#set-environment-variables)
  - [Set up and run Docker](#set-up-and-run-docker)
  - [View the output](#view-the-output)
  - [Edit workspaces/diagrams](#edit-workspacesdiagrams)
    - [Edit `workspace.dsl`](#edit-workspacedsl)
    - [Change diagram layout using the web app](#change-diagram-layout-using-the-web-app)
  - [Generate diagrams on the command line](#generate-diagrams-on-the-command-line)

## Prerequisites

- Install and start [Docker](https://www.docker.com/) on your local machine.
- Optional: To generate diagrams using shell commands, you'll need to download the [Structurizr CLI](https://github.com/structurizr/cli/blob/master/docs/package-managers.md) as a package (highly recommended).

## Installation

Clone the repository and `cd` into the project.

## Set environment variables

The Structurizr docker command is long and not intuitive. To save you a headache, you can set variables that will be picked up when you run `./docker.sh`, which executes the docker command to start the container.

Create a `.env.user` file in the root using this template:

```shell
LOCAL_PATH=/Users/user_name/structurizr-kickstarter
WORKSPACE=samples/financial-risk-system
```

Set `LOCAL_PATH` to the absolute path to your project directory on your machine.

By default, set the `WORKSPACE` to `samples/financial-risk-system`, which tells Structurizr to look inside this directory for the workspace definition (`workspace.dsl`) that will be used to generate diagrams. `financial-risk-system` is only an example, you may also set the `WORKSPACE` to a different workspace, such as `samples/big-bank-plc`.

To create another workspace from scratch, add a new folder under `workspaces` and create a `workspace.dsl` using the sample templates provided.

Note: There is a `.env` file that contains variables you shouldn't need to change.

## Set up and run Docker

Ensure Docker is running, and pull the docker image by running:

```shell
docker pull structurizr/lite
```

Run the following command from the project root to start the container and load the workspace:

```shell
./docker.sh
```

Note: You may need to `run chmod +x docker.sh` to grant execute permissions to the script file. Disclaimer: This command is untested on non-MacO machines.

## View the output

View the generated diagrams at [http://localhost:8080](http://localhost:8080).

When you update diagrams, you may refresh the page to view the updated diagram or wait for the page to refresh (`5000` milliseconds by default).

Note that you can only view one browser/web app workspace.

You may download diagram image files, such as PNGs or SVGs, directly from the web app.

## Edit workspaces/diagrams

You can edit workspace/workspace diagrams within that workspace's associated `workspace.dsl` file or change the diagram layout using in the web app.

### Edit `workspace.dsl`

For information on how to edit `workspace.dsl`, view the [Structurizr language reference](https://github.com/structurizr/dsl/blob/master/docs/language-reference.md)

### Change diagram layout using the web app

To activate the ability to make changes through the web app, ensure that `autoLayout` is not present within a workspace view in the `views` object within the `workspace.dsl` file (default).

If a view in the `views` object within the `workspace.dsl` file contains `auto layout,` then the web app displays a limited number of options/buttons, and you won't be able to edit diagrams in the browser.

To edit a diagram in the browser, drag nodes. When you make changes, those changes are added to a `workspace.json` file that sits alongside the `workspace.dsl` file to store changes made to the browser. This file is not meant to be edited.

## Generate diagrams on the command line

Generating diagrams from the command line presents opportunities for diagrams-as-code workflows.

This assumes you installed `structurizr-cli` as a package (recommended).

You can use the `export` command to generate diagrams in different formats based on a workspace file.

For example, the following command converts a workspace to separate plantUML diagrams:

```shell
structurizr-cli export -workspace workspaces/herald/workspace.dsl -format plantuml -output workspaces/herald/output
```

In this case, the command places the generated diagrams in the directory specified by `-output`.

The export options are detailed in the [Structurizr-cli docs](https://github.com/structurizr/cli/blob/master/docs/export.md). However, you must use the package name `structurizr-cli` and not `structurizr` as it appears in the docs.
