# Internal Developer Platform (IDP) Comparison

A comparison of the leading internal developer platform tools. Use this guide to evaluate which IDP best fits your organization's needs.

---

## Overview

An Internal Developer Platform (IDP) provides a **self-service UI and API** that lets developers provision infrastructure, deploy applications, and manage services without filing tickets.

| Platform | Type | Open Source | Hosted Option | Best For |
|----------|------|-------------|---------------|----------|
| **Backstage** | Developer Portal Framework | Yes (Apache 2.0) | Roadie, Cortex | Large orgs wanting full customization |
| **Port** | Developer Portal | No (freemium) | Yes (SaaS) | Teams wanting fast setup with flexibility |
| **Cortex** | Internal Developer Portal | No (commercial) | Yes (SaaS) | Service catalog + scorecards |
| **Humanitec** | Platform Orchestrator | No (commercial) | Yes (SaaS) | Dynamic config generation |
| **Radius** | Cloud-native app platform | Yes (Apache 2.0) | No | Azure-centric modern app platform |

---

## Backstage

**Created by:** Spotify (donated to CNCF)  
**License:** Apache 2.0  
**Website:** [backstage.io](https://backstage.io)

### Strengths
- Fully open-source and highly extensible via plugins
- Huge community and plugin ecosystem (200+ plugins)
- CNCF incubating project — strong governance and longevity
- Software catalog for service ownership and discovery
- TechDocs for documentation-as-code
- Software Templates (golden paths)

### Considerations
- Requires significant engineering investment to set up and maintain
- Plugin quality varies — some are community-maintained
- React + TypeScript frontend requires frontend skills
- You build and host it yourself (or use managed options like Roadie)

### Best For
Organizations with 100+ developers that want full control and customization over their developer portal, and have engineering capacity to invest in building it.

**[Detailed Backstage Guide →](idps/backstage.md)**

---

## Port

**Created by:** Port (commercial)  
**License:** Proprietary (free tier available)  
**Website:** [getport.io](https://www.getport.io)

### Strengths
- Fast to set up — SaaS, no infrastructure to manage
- Flexible data model — define your own entities and relationships
- Self-service actions with workflow automation
- Scorecards for standards enforcement
- Good out-of-the-box integrations (GitHub, GitLab, Kubernetes, cloud providers)
- Feature-rich free tier for smaller teams

### Considerations
- Proprietary — less control than open-source options
- Complex customization may require support
- SaaS only — data lives in Port's infrastructure
- Advanced features require paid plans

### Best For
Teams of 20-200 developers that want a powerful IDP without the overhead of building and maintaining it themselves.

**[Detailed Port Guide →](idps/port.md)**

---

## Cortex

**Created by:** Cortex (commercial)  
**License:** Proprietary  
**Website:** [cortex.io](https://www.cortex.io)

### Strengths
- Service catalog with rich metadata and ownership tracking
- Scorecards to measure and improve engineering standards
- Initiative tracking (campaigns to drive improvements)
- CQL (Cortex Query Language) for flexible filtering
- Good for driving engineering excellence and compliance

### Considerations
- Purely commercial — no free tier for production use
- Less focus on self-service provisioning vs. catalog/scorecards
- Smaller ecosystem compared to Backstage
- Pricing can be significant for large organizations

### Best For
Organizations focused on engineering standards, service ownership accountability, and maturity scoring across their services.

**[Detailed Cortex Guide →](idps/cortex.md)**

---

## Humanitec

**Created by:** Humanitec  
**License:** Proprietary  
**Website:** [humanitec.com](https://humanitec.com)

### Strengths
- Platform Orchestrator approach — dynamically generates configs per deployment
- Eliminates static templates — configs are computed based on context (env, team, etc.)
- Score workload specification format (open-source)
- Strong focus on reducing "platform engineering as a bottleneck"
- Works alongside existing tools (Terraform, Helm, etc.)

### Considerations
- Different mental model — requires understanding dynamic configuration
- Commercial product, no self-hosted open-source option
- Newer in the market, smaller community
- Heavier lift to evaluate and adopt

### Best For
Organizations with complex deployment environments where static templates become unmanageable — many environments, teams, and resource variations.

**[Detailed Humanitec Guide →](idps/humanitec.md)**

---

## Radius

**Created by:** Microsoft  
**License:** Apache 2.0  
**Website:** [radapp.io](https://radapp.io)

### Strengths
- Open-source application platform for cloud-native apps
- Application graph for understanding dependencies
- Recipes for infrastructure provisioning (Terraform, Bicep)
- Separates app definition from infrastructure details
- Strong Azure integration

### Considerations
- Relatively new project, still maturing
- Smaller community compared to Backstage
- Strongest on Azure, growing support for other clouds
- More of an app platform than a full portal

### Best For
Azure-centric teams looking for a modern way to define applications independently from their infrastructure, with built-in support for Terraform and Bicep.

**[Detailed Radius Guide →](idps/radius.md)**

---

## Comparison Matrix

| Feature | Backstage | Port | Cortex | Humanitec | Radius |
|---------|-----------|------|--------|-----------|--------|
| **Service Catalog** | ✅ | ✅ | ✅ | ⚠️ | ✅ |
| **Self-Service Actions** | ✅ (Templates) | ✅ | ⚠️ | ✅ | ✅ (Recipes) |
| **Scorecards** | Via plugin | ✅ | ✅ | ❌ | ❌ |
| **Documentation** | ✅ (TechDocs) | ⚠️ | ⚠️ | ❌ | ❌ |
| **Plugin Ecosystem** | ✅ (200+) | ⚠️ | ⚠️ | ❌ | ❌ |
| **Dynamic Config** | ❌ | ❌ | ❌ | ✅ | ✅ |
| **Free Tier** | ✅ (OSS) | ✅ | ❌ | ❌ | ✅ (OSS) |
| **SaaS Option** | Via Roadie | ✅ | ✅ | ✅ | ❌ |
| **Setup Complexity** | High | Low | Low | Medium | Medium |
| **Customizability** | Very High | High | Medium | Medium | Medium |

**Legend:** ✅ Strong support | ⚠️ Partial / limited | ❌ Not available

---

## Decision Guide

```
Do you have dedicated frontend/platform engineers?
├─ Yes → Backstage (maximum flexibility)
├─ No
│   ├─ Do you need scorecards and standards enforcement?
│   │   ├─ Yes → Cortex
│   │   └─ No
│   │       ├─ Do you have many environment/config variations?
│   │       │   ├─ Yes → Humanitec
│   │       │   └─ No → Port (fastest to value)
│   └─ Are you Azure-centric and want app-level abstraction?
│       └─ Yes → Radius
```

---

## Further Reading

- [Internal Developer Platforms Guide](internal_development_platforms.md)
- [Platform Engineering vs DevOps](PLATFORM_ENGINEERING_VS_DEVOPS.md)
- [Architecture Guide](ARCHITECTURE.md)
