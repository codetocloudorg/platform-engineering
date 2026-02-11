# 🔐 Security and Compliance

Security is a foundational concern for platform engineering teams. This guide covers DevSecOps practices, policy-as-code, and security automation.

---

## 🎯 DevSecOps Principles

DevSecOps integrates security practices into every phase of the software development lifecycle:

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│  Plan   │───▶│  Code   │───▶│  Build  │───▶│  Test   │───▶│ Deploy  │
└────┬────┘    └────┬────┘    └────┬────┘    └────┬────┘    └────┬────┘
     │              │              │              │              │
┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐
│ Threat  │   │  SAST   │   │   SCA   │   │  DAST   │   │ Runtime │
│Modeling │   │         │   │         │   │         │   │Security │
└─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘
```

---

## 🛡️ Security Tools

### Static Analysis (SAST)

| Tool | Language Support | Link |
|------|------------------|------|
| **Semgrep** | Multi-language | [semgrep.dev](https://semgrep.dev) |
| **SonarQube** | Multi-language | [sonarqube.org](https://sonarqube.org) |
| **CodeQL** | Multi-language | [codeql.github.com](https://codeql.github.com) |
| **Bandit** | Python | [bandit.readthedocs.io](https://bandit.readthedocs.io) |

### Dependency Scanning (SCA)

| Tool | Description | Link |
|------|-------------|------|
| **Dependabot** | GitHub-native dependency updates | [github.com](https://github.com/dependabot) |
| **Snyk** | Vulnerability scanning | [snyk.io](https://snyk.io) |
| **Trivy** | Container and filesystem scanning | [trivy.dev](https://trivy.dev) |
| **OWASP Dependency-Check** | Known vulnerability detection | [owasp.org](https://owasp.org/www-project-dependency-check/) |

### Container Security

| Tool | Purpose | Link |
|------|---------|------|
| **Trivy** | Image vulnerability scanning | [trivy.dev](https://trivy.dev) |
| **Falco** | Runtime threat detection | [falco.org](https://falco.org) |
| **Kyverno** | Kubernetes policy engine | [kyverno.io](https://kyverno.io) |
| **OPA/Gatekeeper** | Policy-as-code | [openpolicyagent.org](https://openpolicyagent.org) |

### Secrets Management

| Tool | Description | Link |
|------|-------------|------|
| **HashiCorp Vault** | Secrets management | [vaultproject.io](https://vaultproject.io) |
| **Azure Key Vault** | Azure secrets service | [azure.microsoft.com](https://azure.microsoft.com/services/key-vault/) |
| **AWS Secrets Manager** | AWS secrets service | [aws.amazon.com](https://aws.amazon.com/secrets-manager/) |
| **SOPS** | Encrypted files in Git | [github.com/getsops](https://github.com/getsops/sops) |

---

## 📋 Security Best Practices

### 1. Zero Trust Architecture

Never trust, always verify. Apply these principles:

- **Verify explicitly**: Authenticate and authorize based on all available data
- **Least privilege access**: Limit user and service permissions
- **Assume breach**: Minimize blast radius and segment access

### 2. Shift Left Security

Integrate security early in the development process:

```yaml
# GitHub Actions example: Security scanning on every PR
name: Security Scan
on: [pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          severity: 'HIGH,CRITICAL'
          
      - name: Run Semgrep
        uses: returntocorp/semgrep-action@v1
```

### 3. Infrastructure Security

```hcl
# Terraform: Enforce encryption at rest
resource "azurerm_storage_account" "example" {
  name                     = "storageaccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  
  # Security best practices
  min_tls_version                 = "TLS1_2"
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = false
  
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
}
```

### 4. Kubernetes Security

```yaml
# Pod Security: Non-root, read-only filesystem
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 1000
  containers:
    - name: app
      image: myapp:latest
      securityContext:
        allowPrivilegeEscalation: false
        readOnlyRootFilesystem: true
        capabilities:
          drop:
            - ALL
```

---

## 📊 Compliance Frameworks

| Framework | Focus Area |
|-----------|------------|
| **SOC 2** | Service organization controls |
| **ISO 27001** | Information security management |
| **PCI DSS** | Payment card industry |
| **HIPAA** | Healthcare data protection |
| **GDPR** | EU data protection |
| **FedRAMP** | US federal cloud security |

---

## 🔗 Related Resources

- [Infrastructure as Code](iac.md)
- [CI/CD Pipelines](ci_cd.md)
- [Observability](observability/README.md)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
