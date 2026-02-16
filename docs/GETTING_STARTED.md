# Getting Started with Platform Engineering

Welcome! This guide helps you navigate the Platform Engineering Hub and start learning, regardless of your experience level.

---

## Who Is This For?

| Experience Level | Start Here |
|-----------------|------------|
| **Beginner** — New to platform engineering | [What is Platform Engineering?](#what-is-platform-engineering) below, then [Core Concepts](#core-concepts) |
| **Intermediate** — Familiar with DevOps, want to go deeper | [Key Components](#explore-key-components) and [Reference Architectures](#reference-architectures) |
| **Advanced** — Building an IDP at your organization | [IDP Guides](internal_development_platforms.md), [IaC Templates](iac.md), and [Dagger Pipelines](dagger/README.md) |

---

## What is Platform Engineering?

Platform Engineering is the discipline of building **internal developer platforms** — self-service systems that let developers build, deploy, and operate applications without needing deep infrastructure expertise.

Think of it this way:
- **DevOps** says "you build it, you run it"
- **Platform Engineering** says "we build the platform so you can build and run it easily"

Platform teams treat **developers as their customers** and the platform as a **product**.

---

## Prerequisites

You don't need all of these to start — pick the path that matches your interest:

| Topic | Why It Helps | Learn More |
|-------|-------------|------------|
| **Git & GitHub** | All resources are in Git | [GitHub Docs](https://docs.github.com) |
| **Linux CLI basics** | Most tools run on Linux | [Linux Journey](https://linuxjourney.com) |
| **Containers (Docker)** | Foundation for cloud-native | [Docker Get Started](https://docs.docker.com/get-started/) |
| **YAML** | Used by Kubernetes, CI/CD, IaC | Learn by reading examples in this repo |

---

## Set Up Your Environment

The fastest way to get started is with a pre-configured environment:

### Option 1: GitHub Codespaces (Recommended)
Zero setup — everything runs in your browser.

[![Open in Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?repo=codetocloudorg/platform-engineering)

### Option 2: VS Code Dev Container
Clone the repo and open in VS Code — the devcontainer includes all tools.

```bash
git clone https://github.com/codetocloudorg/platform-engineering
code platform-engineering
# VS Code will prompt: "Reopen in Container" → click Yes
```

### Option 3: Kodra Local Environment
Full Linux desktop with 30+ platform engineering tools pre-installed.

- [Kodra Desktop](https://kodra.codetocloud.io) — Ubuntu with GNOME, Ghostty, VS Code
- [Kodra WSL](https://kodra.wsl.codetocloud.io) — Windows + WSL2 with Docker CE

---

## Core Concepts

Start with these foundational topics:

### 1. Infrastructure as Code (IaC)
Define your infrastructure in files that can be versioned, reviewed, and automated.

- **[IaC Guide](iac.md)** — Overview of Terraform, OpenTofu, Bicep, and Pulumi
- **[Terraform Examples](terraform/README.md)** — Hands-on IaC templates

### 2. CI/CD Pipelines
Automate building, testing, and deploying your applications.

- **[CI/CD Guide](ci_cd.md)** — GitHub Actions, Dagger, GitOps workflows
- **[Dagger Examples](dagger/README.md)** — Programmable CI/CD pipelines

### 3. Kubernetes
Container orchestration for running workloads at scale.

- **[Kubernetes Guide](kubernetes.md)** — Local, baremetal, and cloud deployments
- **[Local Kubernetes](kubernetes/local/kubernetes_local.md)** — Practice clusters on your laptop

### 4. Security & DevSecOps
Embed security into every stage of the development lifecycle.

- **[Security Guide](security.md)** — Policy-as-code, secrets management, supply chain security

### 5. Internal Developer Platforms
Build self-service portals for your developers.

- **[IDP Guide](internal_development_platforms.md)** — Backstage, Port, Cortex, and more

---

## Explore Key Components

| Category | Resources |
|----------|----------|
| **Infrastructure** | [IaC](iac.md) · [CI/CD](ci_cd.md) · [Kubernetes](kubernetes.md) · [Cloud-Native](cloud_native.md) |
| **Developer Experience** | [Codespaces](codespaces.md) · [IDPs](internal_development_platforms.md) · [Automation](automation.md) |
| **Operations** | [Observability](observability/README.md) · [Security](security.md) · [AI Infrastructure](ai_infrastructure.md) |
| **Learning** | [Certifications](certifications.md) · [Landscape Overview](platform_engineering_landscape.md) · [Glossary](GLOSSARY.md) |

---

## Reference Architectures

See how everything fits together:

- [Azure Reference Architecture](images/azure_ref_architecture.jpg) — Azure-based IDP with IaC, GitOps, and Kubernetes
- [OpenShift Reference Architecture](images/red_hat_openshift_ref_architecture.jpg) — Red Hat OpenShift-based platform

---

## Recommended Learning Path

```
Week 1-2:  IaC Fundamentals (Terraform or Bicep)
Week 3-4:  CI/CD with GitHub Actions or Dagger
Week 5-6:  Kubernetes Basics (local cluster)
Week 7-8:  Observability & Security
Week 9-10: Internal Developer Platforms
Week 11+:  Build your own platform / Certifications
```

---

## Certifications

Validate your platform engineering knowledge:

- **[Certification Pathways](certifications.md)** — CNPA and related certifications
- **[CNPA Study Guide](certifications/cnpa/readme.md)** — Cloud Native Platform Architect prep

---

## Get Help

- **[FAQ](FAQ.md)** — Common questions answered
- **[Glossary](GLOSSARY.md)** — Platform engineering terminology
- **[Discord](https://discord.gg/vwfwq2EpXJ)** — Ask questions, share ideas
- **[GitHub Discussions](https://github.com/codetocloudorg/platform-engineering/discussions)** — Longer-form Q&A
- **[GitHub Issues](https://github.com/codetocloudorg/platform-engineering/issues)** — Report bugs or request new content
