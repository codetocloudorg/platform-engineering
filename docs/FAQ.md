# Frequently Asked Questions

Common questions about platform engineering and this resource hub.

---

## General

### What is Platform Engineering?

Platform Engineering is the discipline of designing and building self-service toolchains and internal developer platforms (IDPs) that enable software engineering organizations to ship faster. It applies product thinking to infrastructure: platform teams build paved roads to production so developers can focus on delivering business value instead of wrangling infrastructure.

### How is Platform Engineering different from DevOps?

DevOps is a **culture and set of practices** that breaks down silos between development and operations. Platform Engineering takes DevOps principles further by creating a **dedicated product team** that builds and maintains an internal platform. Instead of expecting every developer to master infrastructure, platform engineers provide self-service tools, golden paths, and abstractions.

| Aspect | DevOps | Platform Engineering |
|--------|--------|---------------------|
| Focus | Culture, collaboration, CI/CD | Internal products for developers |
| Approach | Everyone does ops | Dedicated platform team |
| Output | Practices, pipelines | Self-service platform (IDP) |
| User | Dev + Ops teams | Developers as customers |

### Who is this resource for?

- **Platform engineers** building internal developer platforms
- **DevOps engineers** looking to scale their impact
- **Site Reliability Engineers (SREs)** improving developer experience
- **Cloud architects** designing infrastructure foundations
- **Engineering leaders** evaluating platform engineering strategy
- **Developers** wanting to learn platform engineering concepts

### Is this resource free?

Yes. Everything in this repository is free and open-source under the [MIT License](../LICENSE). We use only free, community, and open-source software.

---

## Tools & Technologies

### What tools does this hub cover?

| Category | Tools |
|----------|-------|
| **IaC** | Terraform, OpenTofu, Bicep, Pulumi |
| **Kubernetes** | kubectl, Helm, ArgoCD, Flux |
| **IDPs** | Backstage, Port, Cortex, Humanitec |
| **CI/CD** | GitHub Actions, Dagger, GitLab CI |
| **Observability** | Prometheus, Grafana, Datadog |
| **Security** | Policy-as-Code, Secret Management |
| **Cloud** | Azure, AWS, GCP |

### Do I need Kubernetes knowledge?

Not to get started. The hub covers many topics—begin with [IaC fundamentals](iac.md), [CI/CD](ci_cd.md), or the [getting started guide](GETTING_STARTED.md) and work toward Kubernetes as you grow.

### Which cloud provider do you focus on?

We cover **Azure, AWS, and GCP**. Reference architectures currently focus more on Azure, but IaC and Kubernetes content is provider-agnostic where possible.

---

## Getting Involved

### How can I contribute?

See our [Contributing Guide](../CONTRIBUTING.md). We welcome:
- Documentation improvements and corrections
- New topic guides and tutorials
- IaC template examples
- Bug reports and feature requests

### Where can I get help?

- [GitHub Discussions](https://github.com/codetocloudorg/platform-engineering/discussions) — ask questions, share ideas
- [Discord](https://discord.gg/vwfwq2EpXJ) — real-time community chat
- [GitHub Issues](https://github.com/codetocloudorg/platform-engineering/issues) — report bugs or request features

### Who created this project?

This project was created by **[Kevin Evans](https://linktr.ee/bash.sh)** and the **[Code to Cloud](https://connect.codetocloud.io)** community. It started as a personal learning journey and grew into a comprehensive platform engineering resource.
