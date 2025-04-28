# 🚀 Using Dagger for Reusable, Portable CI/CD Pipelines

Hey there, Platform Engineers! 👷‍♀️👷‍♂️

Welcome to the documentation on [Dagger](https://docs.dagger.io/), an **open-source runtime for composable workflows**. But what does that mean exactly? Dagger is very intriguing if you think about the current developer workflow for CI/CD pipelines. Using something like GitHub Actions, we need to define a YAML template (and we all know how much developers love YAML 😉) and push it as many times to source control as it takes to get a initial CI/CD pipeline working.

There are many factors that play into why this is challenging. To name one, the workflow agent (ie: the compute running the pipeline) where the CI/CD pipeline will run is very likely not the same as the environment you develop in, leading to ‘dependency hell’. Debugging is painful since you often have to test by pushing your code, waiting for it to run, and then troubleshooting errors from logs, making more changes, waiting again for the pipeline to run and the cycle repeats itself. This slow feedback loop makes iterations cumbersome. Additionally, declarative pipeline definitions, while powerful, can be limiting when handling complex logic, and there’s often no straightforward way to test them locally before deployment.

This is where Dagger comes in to save the day 🦸. In Dagger, CI/CD pipelines are containerized, making them incredibly portable. They run the same way locally as they do in the cloud, eliminating environmental inconsistencies. By enabling developers to run pipelines locally before committing changes, Dagger provides immediate feedback, significantly reducing the time spent debugging and improving development efficiency.

From the creators of Docker, let’s have a look at how Dagger works in practice.

## 🏗️ Introduction to Dagger’s Approach to CI/CD as Code

As mentioned above, Dagger is an **open-source runtime for composable workflows**, designed to create **repeatable, modular, observable, and cross-platform CI/CD pipelines**. By defining CI/CD workflows as code, Dagger enables:

✅ **Reusable Workflows** – Define once, use anywhere across projects and teams.

✅ **Portable Execution** – Run workflows **locally, in any CI system, or in the cloud** without modifications.

✅ **Optimized Performance** – Leverage **automatic artifact caching** for efficient execution.

✅ **Built-in Observability** – Gain real-time insights via **logs, tracing, and metrics**.

Since Dagger leverages containers, what runs locally will be the same as what runs in the cloud (ie: GitHub Actions). This solves a huge challenge for developers and makes the writing, testing, and deployment of CI/CD pipelines much easier. Dagger is also platform agnostic allowing you to switch platforms as needed, avoiding CI lock-in.

---

## 📌 Dagger Components Overview

The **Dagger Engine** is the core runtime, responsible for executing workflows using a **universal type system** and **data layer**. It runs on any OCI-compatible system and is controlled via the Dagger API. Dagger has the following key components:

- **Dagger Engine**: The core runtime that powers Dagger pipelines.
- **Dagger SDKs**: Use Python, Go, or Node.js to define pipelines.
- **Containerized Execution**: Each step runs in an isolated, reproducible environment.
- **Dagger API**: A GraphQL-based universal type system for defining workflows.
- **DaggerVerse**: An easy way to search and consume modules.
- **LLM Prompting**: Dagger allows you to interact with various LLMs and chain together complex tasks.

---

## 🤖 Dagger & Generative AI

An AI agent is an automated program that is using an LLM with a set of functions you define, that the LLM can call on demand depending on what is needed. The cool part about combining AI agents with Dagger is the agents can call any API that is apart of the Dagger API.

Dagger exposes an `LLM` core type which enables developers to interact with LLMs and send prompts and receive information back. Dagger supports integration with several LLM providers including OpenAI, Ollama, Anthropic, and the new Docker Model Runner.

The `LLM` type exposes a few functions that are handy to interact with LLMs and they boil down into the following categories:

- Prompts
- Responses and Variables
- Environments

### 📃 Prompts

The `LLM.withPrompt()` method allows you to send a prompt to a LLM. Similarly, `LLM.withPromptFile()` enables you to read a prompt from a file and send it to an LLM. This is handy if you want to tie into a version controlled prompt in your repository.

### 🗣️ Responses and Variables

The `LLM.lastReply()` API method allows you to obtain the last reply from the LLM.

Both variables and `LLM.lastReply()` enable developers to store results of previous operations and pass them to an LLM prompt. This is very powerful when we start dealing with things like agents.

You can also get a complete message history from LLM calls via `LLM.History()`.

### 🧰 Environments

**Environments** unlocks the ability for LLMs to call Dagger Functions as tools. This is a common pattern with agentic applications where you basically give an LLM access to a series of tools that the LLM can select to perform an action. A tool could be a custom integration with Gmail to send an email, or an API call to a weather service.

### Wrapping Up

This is cool that Dagger can integrate with LLMs but what does this mean from a use case perspective?

Dagger has published plenty of [examples](https://docs.dagger.io/examples/) in their documentation you can checkout to demonstrate the art of the possible.

---

## 🧑‍🏫 Examples with Dagger

Below are some real-world examples with Dagger.

### ✅ Prerequisites

Please make sure you have the below prerequisites met before running the below examples:

- [Dagger CLI](https://docs.dagger.io/ci/quickstart/cli/)
- [Dagger Cloud Account](https://dagger.io/cloud)

### 🌎 Real-World Examples

- [Deploying Terraform with Dagger](./terraform-example/README.md)

- [Dagger Agents and Terraform](./agent-example/README.md)

---

## 🎉 Conclusion

Dagger provides an innovative way to write, manage, and execute CI/CD pipelines as code. By leveraging its graph-based execution model, containerized steps, and multi-platform support, platform engineers can:

🚀 Build reusable and scalable pipelines

🌎 Run workflows anywhere (local/cloud/CI systems)

🔄 Ensure consistency across deployments

🤖 Integrate with LLMs

Whether you're streamlining local development or scaling cloud deployments, Dagger provides the control and efficiency needed to accelerate software delivery.

Give it a try and take your pipelines to the next level! 🚀
