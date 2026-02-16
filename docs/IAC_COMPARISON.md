# Infrastructure as Code (IaC) Tool Comparison

A comparison of the leading IaC tools: Terraform, OpenTofu, Bicep, and Pulumi. Use this guide to choose the right tool for your platform engineering needs.

---

## Quick Comparison

| Feature | Terraform | OpenTofu | Bicep | Pulumi |
|---------|-----------|----------|-------|--------|
| **License** | BSL 1.1 | MPL 2.0 (open-source) | MIT (open-source) | Apache 2.0 (open-source) |
| **Language** | HCL | HCL (compatible) | Bicep DSL | Python, TypeScript, Go, C#, Java, YAML |
| **Multi-Cloud** | ✅ | ✅ | ❌ (Azure only) | ✅ |
| **State Management** | Remote backends, Terraform Cloud | Remote backends, self-managed | Azure Resource Manager (stateless) | Pulumi Cloud, self-managed backends |
| **Provider Ecosystem** | 4,000+ providers | Compatible with Terraform providers | Azure resources only | 150+ providers |
| **Created By** | HashiCorp | Linux Foundation | Microsoft | Pulumi Inc. |
| **First Release** | 2014 | 2023 (fork of Terraform) | 2020 | 2018 |

---

## Terraform

**Created by:** HashiCorp  
**License:** BSL 1.1 (changed from MPL 2.0 in August 2023)  
**Language:** HCL (HashiCorp Configuration Language)  
**Website:** [terraform.io](https://www.terraform.io)

### Strengths
- Industry standard for multi-cloud IaC — massive adoption
- 4,000+ providers covering every major cloud and service
- Mature ecosystem with modules, registries, and tooling
- Terraform Cloud / Enterprise for team collaboration
- Plan/Apply workflow gives clear preview of changes
- Extensive documentation and community resources

### Considerations
- BSL license change raised concerns about long-term openness
- HCL is a new language to learn (neither general-purpose nor purely declarative)
- State file management requires care (locking, remote backends, secrets in state)
- Complex modules can become hard to maintain
- Provider version pinning needed to avoid breaking changes

### Best For
Organizations with multi-cloud infrastructure that want the broadest ecosystem and provider support, and are comfortable with the BSL license.

### Example
```hcl
resource "azurerm_resource_group" "example" {
  name     = "platform-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "platform-aks"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "platform"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
```

**[Detailed IaC Guide →](iac.md)** | **[Terraform Examples →](terraform/README.md)**

---

## OpenTofu

**Created by:** Linux Foundation  
**License:** MPL 2.0 (fully open-source)  
**Language:** HCL (Terraform-compatible)  
**Website:** [opentofu.org](https://opentofu.org)

### Strengths
- Fully open-source fork of Terraform under Linux Foundation governance
- Drop-in compatible with Terraform (same HCL syntax, same providers)
- State encryption built-in (not available in Terraform OSS)
- Community-governed roadmap — no single-vendor control
- Growing ecosystem and community support
- CNCF and major cloud providers backing the project

### Considerations
- Younger project — some features may lag behind Terraform
- Smaller (but growing) community than Terraform
- Some HashiCorp-specific features won't be ported
- Enterprise tooling ecosystem still developing
- Migration from Terraform is simple but still a change to manage

### Best For
Organizations that want Terraform compatibility with a truly open-source license and community governance, or those concerned about the BSL license change.

### Migration from Terraform
```bash
# OpenTofu is designed as a drop-in replacement
# 1. Install OpenTofu
brew install opentofu

# 2. In your existing Terraform project:
tofu init    # instead of terraform init
tofu plan    # instead of terraform plan
tofu apply   # instead of terraform apply
```

---

## Bicep

**Created by:** Microsoft  
**License:** MIT (open-source)  
**Language:** Bicep DSL  
**Website:** [learn.microsoft.com/azure/azure-resource-manager/bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview)

### Strengths
- First-class Azure experience — day-zero support for new Azure resources
- Clean, concise syntax — dramatically simpler than ARM templates
- No state file to manage (compiles to ARM; Azure RM tracks state)
- Strong VS Code / IDE tooling with intellisense and validation
- Free, no commercial tiers or licensing concerns
- Seamless integration with Azure DevOps and GitHub Actions
- Modules and registries for reusable components

### Considerations
- Azure only — cannot manage AWS, GCP, or third-party resources
- Less mature ecosystem than Terraform (fewer modules, examples)
- Transpiles to ARM templates — debugging sometimes requires understanding ARM
- No `plan` equivalent that shows exact diff before deployment (What-If exists but is less mature)
- Smaller community than Terraform

### Best For
Azure-centric organizations that want the simplest, most native IaC experience for Azure resources without managing state files.

### Example
```bicep
param location string = resourceGroup().location
param clusterName string = 'platform-aks'

resource aks 'Microsoft.ContainerService/managedClusters@2024-01-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: 'platform'
    agentPoolProfiles: [
      {
        name: 'default'
        count: 3
        vmSize: 'Standard_D2_v2'
        mode: 'System'
      }
    ]
  }
}
```

---

## Pulumi

**Created by:** Pulumi Inc.  
**License:** Apache 2.0 (open-source)  
**Language:** Python, TypeScript, Go, C#, Java, YAML  
**Website:** [pulumi.com](https://www.pulumi.com)

### Strengths
- Use real programming languages — no new DSL to learn
- Full expressiveness: loops, conditions, functions, classes, testing
- Multi-cloud support with 150+ providers
- Pulumi AI for generating IaC from natural language
- Built-in testing frameworks (unit tests, integration tests)
- Pulumi Cloud for state management and team collaboration
- Crosswalk libraries for opinionated best-practice patterns

### Considerations
- Requires software engineering skills (may not suit pure ops teams)
- Smaller provider ecosystem than Terraform
- Code complexity can grow if not well-structured
- Pulumi Cloud is the recommended state backend (self-managed is possible)
- Mixing imperative and declarative patterns requires discipline

### Best For
Engineering teams that prefer using familiar programming languages for infrastructure, want advanced logic and testing capabilities, and are comfortable with software engineering practices.

### Example (Python)
```python
import pulumi
import pulumi_azure_native as azure

resource_group = azure.resources.ResourceGroup("platform-rg",
    location="eastus")

cluster = azure.containerservice.ManagedCluster("platform-aks",
    resource_group_name=resource_group.name,
    location=resource_group.location,
    dns_prefix="platform",
    agent_pool_profiles=[{
        "name": "default",
        "count": 3,
        "vm_size": "Standard_D2_v2",
        "mode": "System",
    }],
    identity={"type": "SystemAssigned"})
```

---

## Decision Guide

```
What clouds do you need to manage?
├─ Azure only → Bicep (simplest) or Terraform/OpenTofu (if you might go multi-cloud)
├─ Multi-cloud
│   ├─ Do you prefer general-purpose programming languages?
│   │   ├─ Yes → Pulumi
│   │   └─ No → Terraform or OpenTofu
│   └─ Is open-source licensing important?
│       ├─ Yes → OpenTofu or Pulumi
│       └─ No → Terraform
```

---

## Feature Comparison Matrix

| Feature | Terraform | OpenTofu | Bicep | Pulumi |
|---------|-----------|----------|-------|--------|
| **Multi-Cloud** | ✅ | ✅ | ❌ | ✅ |
| **State Management** | Remote backends | Remote backends + encryption | Stateless (Azure RM) | Pulumi Cloud / backends |
| **Plan/Preview** | ✅ (terraform plan) | ✅ (tofu plan) | ⚠️ (What-If) | ✅ (pulumi preview) |
| **Module Registry** | ✅ (registry.terraform.io) | ✅ (compatible) | ✅ (Bicep registry) | ✅ (Pulumi registry) |
| **IDE Support** | Good | Good | Excellent (VS Code) | Excellent (full language) |
| **Testing** | ⚠️ (terraform test) | ⚠️ (tofu test) | ⚠️ (deployment stacks) | ✅ (native unit tests) |
| **Learning Curve** | Medium (HCL) | Medium (HCL) | Low (if you know Azure) | Low (if you know the language) |
| **Community Size** | Very Large | Growing | Medium | Medium |
| **Secret Handling** | ⚠️ (in state) | ✅ (state encryption) | ✅ (Key Vault native) | ✅ (built-in) |

---

## Further Reading

- [IaC Guide](iac.md) — In-depth infrastructure as code documentation
- [Terraform Examples](terraform/README.md) — Hands-on Terraform templates
- [Architecture Guide](ARCHITECTURE.md) — How IaC fits into platform architecture
