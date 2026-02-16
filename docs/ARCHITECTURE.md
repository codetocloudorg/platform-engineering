# Platform Architecture Guide

How the components of a modern internal developer platform fit together. Use this as a reference when designing your own platform engineering stack.

---

## Overview

A well-designed internal developer platform provides **self-service capabilities** to developers through multiple layers working together:

```
┌─────────────────────────────────────────────────────────┐
│                   Developer Interface                    │
│         (Portal, CLI, IDE Plugins, Templates)            │
├─────────────────────────────────────────────────────────┤
│                  Platform API Layer                       │
│        (Self-Service APIs, Workflow Orchestration)        │
├───────────────┬──────────────────┬──────────────────────┤
│  Delivery     │  Infrastructure   │  Observability       │
│  CI/CD        │  IaC / GitOps     │  Monitoring / Logs   │
│  Pipelines    │  Provisioning     │  Alerting / Tracing  │
├───────────────┴──────────────────┴──────────────────────┤
│                   Runtime Platform                        │
│          (Kubernetes, Containers, Serverless)             │
├─────────────────────────────────────────────────────────┤
│                   Cloud Infrastructure                    │
│            (Azure, AWS, GCP, Bare Metal)                 │
└─────────────────────────────────────────────────────────┘
```

---

## Layers Explained

### 1. Cloud Infrastructure

The foundation. Can be public cloud, private cloud, or bare metal.

| Provider | Documentation |
|----------|--------------|
| Azure | [Azure Reference Architecture](images/azure_ref_architecture.jpg) |
| Multi-Cloud | [Cloud-Native Guide](cloud_native.md) |

**Key decisions:**
- Single cloud vs. multi-cloud
- Region strategy for latency and compliance
- Network topology and security boundaries

### 2. Runtime Platform

Where workloads execute. Kubernetes is the most common choice for platform engineering.

| Approach | Documentation |
|----------|--------------|
| Local Development | [Local Kubernetes](kubernetes/local/kubernetes_local.md) |
| Bare Metal | [Bare Metal Kubernetes](kubernetes/baremetal/kubernetes_baremetal.md) |
| Cloud-Managed | [Hyperscaler Kubernetes](kubernetes/hyperscaler/kubernentes_hyperscaler.md) |

**Key components:**
- Container orchestration (Kubernetes)
- Service mesh (Istio, Linkerd)
- Ingress and load balancing
- Namespace and multi-tenancy strategy

### 3. Infrastructure Provisioning

Infrastructure as Code and GitOps for repeatable, auditable infrastructure changes.

| Tool | Use Case | Documentation |
|------|----------|--------------|
| Terraform | Multi-cloud IaC | [IaC Guide](iac.md) |
| OpenTofu | Open-source Terraform fork | [IaC Guide](iac.md) |
| Bicep | Azure-native IaC | [IaC Guide](iac.md) |
| Pulumi | IaC with programming languages | [IaC Guide](iac.md) |
| ArgoCD / Flux | GitOps delivery | [CI/CD Guide](ci_cd.md) |

**Principles:**
- Everything in Git (GitOps)
- Declarative over imperative
- Drift detection and reconciliation
- Policy-as-code enforcement

### 4. Delivery Pipelines

Continuous integration and continuous delivery to get code from commit to production.

| Tool | Type | Documentation |
|------|------|--------------|
| GitHub Actions | Cloud-hosted CI/CD | [CI/CD Guide](ci_cd.md) |
| Dagger | Programmable pipelines | [Dagger Guide](dagger/README.md) |
| ArgoCD | GitOps-based delivery | [CI/CD Guide](ci_cd.md) |

**Pipeline stages:**
1. Build & test
2. Security scanning (SAST, SCA, container scanning)
3. Artifact publishing
4. Deployment (progressive rollouts)
5. Post-deploy verification

### 5. Observability

Monitoring, logging, and tracing to understand system behavior.

| Pillar | Tools | Documentation |
|--------|-------|--------------|
| Metrics | Prometheus, Grafana | [Observability Guide](observability/README.md) |
| Logs | ELK Stack, Loki | [Observability Guide](observability/README.md) |
| Traces | Jaeger, Tempo | [Observability Guide](observability/README.md) |

**Key practices:**
- Service Level Objectives (SLOs)
- Dashboards for platform health
- Alerting on actionable signals
- Cost monitoring (FinOps)

### 6. Platform API Layer

The abstraction that ties everything together. Developers interact with the platform through APIs and workflows rather than raw infrastructure.

**Components:**
- Resource provisioning APIs (self-service infrastructure)
- Environment management (dev, staging, production)
- Workflow orchestration (approval chains, compliance checks)
- Secrets and configuration management

### 7. Developer Interface

What developers actually see and use daily.

| Interface | Examples | Documentation |
|-----------|----------|--------------|
| Developer Portal | Backstage, Port, Cortex | [IDPs Guide](internal_development_platforms.md) |
| CLI Tools | Custom platform CLI | [Automation Guide](automation.md) |
| IDE Integration | VS Code extensions, Codespaces | [Codespaces Guide](codespaces.md) |
| Templates | Starter kits, golden paths | [Development Setup](development_setup.md) |

---

## Reference Architectures

### Azure-Based Platform

![Azure Reference Architecture](images/azure_ref_architecture.jpg)

An end-to-end platform built on Azure using AKS, Azure DevOps/GitHub Actions, Terraform, and Backstage.

### OpenShift-Based Platform

![OpenShift Reference Architecture](images/red_hat_openshift_ref_architecture.jpg)

A platform built on Red Hat OpenShift with integrated CI/CD, monitoring, and developer self-service.

---

## Design Principles

1. **Platform as a Product** — Treat the platform as a product with developers as customers. Gather feedback, iterate, and measure adoption.
2. **Self-Service First** — Every common task should be doable without filing a ticket.
3. **Golden Paths, Not Golden Cages** — Provide recommended ways to do things, but don't block alternative approaches.
4. **Automate Toil** — If a team does it more than twice, automate it into the platform.
5. **Security by Default** — Bake security into the platform so developers get it for free.
6. **Observable Everything** — Every component should emit metrics, logs, and traces.
7. **Incremental Adoption** — Build the platform incrementally; start with the highest-impact use cases.

---

## Further Reading

- [Platform Engineering Landscape](platform_engineering_landscape.md)
- [Certification Pathways](certifications.md)
- [Getting Started Guide](GETTING_STARTED.md)
