# Platform Engineering Glossary

Key terms and definitions used across platform engineering, DevOps, and cloud-native ecosystems.

---

## A

**ArgoCD** — A declarative, GitOps continuous delivery tool for Kubernetes that automatically syncs application state from Git repositories.

## B

**Backstage** — An open-source developer portal framework created by Spotify. It provides a unified frontend for infrastructure tooling, services, and documentation via a software catalog and plugin system.

**Bicep** — A domain-specific language (DSL) from Microsoft for deploying Azure resources declaratively. It's a transparent abstraction over ARM templates.

## C

**CI/CD (Continuous Integration / Continuous Delivery)** — Practices that automate building, testing, and deploying code. CI merges and validates changes frequently; CD automates the release pipeline.

**Cloud-Native** — An approach to building and running applications that exploits the advantages of cloud computing delivery models. Typically involves containers, service meshes, microservices, immutable infrastructure, and declarative APIs.

**Cortex** — An internal developer portal that helps engineering teams catalog, score, and improve their services with standards and scorecards.

## D

**Dagger** — A programmable CI/CD engine that lets you define pipelines as code in your language of choice, running in containers for full portability.

**DevOps** — A set of practices, tools, and a cultural philosophy that automates and integrates the processes between software development and IT operations teams.

**DevSecOps** — An extension of DevOps that integrates security practices into every phase of the software development lifecycle, rather than treating security as an afterthought.

## F

**Flux** — A set of continuous and progressive delivery solutions for Kubernetes that are open and extensible, built to work with GitOps principles.

## G

**GitOps** — An operational framework that takes DevOps best practices used for application development and applies them to infrastructure automation. Git is the single source of truth for declarative infrastructure and applications.

**Golden Path** — A recommended, well-supported way for developers to accomplish a common task (e.g., deploy a service, create a database) using the internal developer platform.

**Grafana** — An open-source analytics and interactive visualization platform. It provides charts, graphs, and alerts for monitoring infrastructure and applications.

## H

**Helm** — A package manager for Kubernetes that helps you define, install, and upgrade complex Kubernetes applications using reusable charts.

**Humanitec** — A platform orchestrator that dynamically generates app and infrastructure configurations based on context, enabling true self-service for developers.

## I

**IaC (Infrastructure as Code)** — The practice of managing and provisioning infrastructure through machine-readable definition files rather than manual processes. Examples: Terraform, Bicep, Pulumi.

**IDP (Internal Developer Platform)** — A self-service layer built by platform teams that provides developers with everything they need to build, deploy, and operate applications independently. Examples: Backstage, Port, Cortex.

## K

**Kubernetes (K8s)** — An open-source container orchestration system that automates deploying, scaling, and managing containerized applications.

**kubectl** — The command-line tool for interacting with Kubernetes clusters.

## O

**Observability** — The ability to measure the internal states of a system by examining its outputs (logs, metrics, traces). It goes beyond traditional monitoring by enabling you to ask new questions about system behavior.

**OpenTofu** — An open-source fork of Terraform, maintained by the Linux Foundation, that provides an alternative to HashiCorp's BSL-licensed Terraform.

## P

**Platform Engineering** — The discipline of designing and building self-service toolchains and workflows that enable software engineering organizations to ship software faster and more reliably. Platform engineers build internal developer platforms as products for their developer customers.

**Platform Team** — A dedicated team responsible for building and maintaining the internal developer platform, treating developers as their customers.

**Policy as Code** — The practice of defining and managing organizational policies through code, enabling automated enforcement of compliance, security, and operational rules.

**Port** — An internal developer portal that lets teams create self-service experiences for developers with a customizable UI and workflow automation.

**Prometheus** — An open-source monitoring and alerting toolkit designed for reliability, using a dimensional time-series data model.

**Pulumi** — An IaC tool that lets you define infrastructure using general-purpose programming languages (TypeScript, Python, Go, C#) instead of domain-specific languages.

## S

**Self-Service** — The ability for developers to provision resources, deploy applications, and perform operational tasks independently, without filing tickets or waiting for another team.

**Service Mesh** — A dedicated infrastructure layer for managing service-to-service communication, typically providing traffic management, security, and observability. Examples: Istio, Linkerd.

**SRE (Site Reliability Engineering)** — A discipline that applies software engineering principles to infrastructure and operations problems, focused on creating scalable and reliable systems.

## T

**Terraform** — An open-source IaC tool by HashiCorp that lets you define infrastructure across cloud providers using a declarative configuration language (HCL).

**Toil** — Repetitive, manual, automatable operational work that scales linearly with service size. Platform engineering aims to eliminate toil.

## V

**VCluster** — A virtual Kubernetes cluster running inside a host cluster, enabling multi-tenancy and isolated development environments.
