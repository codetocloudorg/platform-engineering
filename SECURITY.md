# Security Policy

## Reporting a Vulnerability

The Code to Cloud team takes security seriously. We appreciate your efforts to responsibly disclose any security issues you find.

**Please do NOT report security vulnerabilities through public GitHub issues.**

### How to Report

1. **Email**: Send a detailed report to the repository maintainers via [GitHub Security Advisories](https://github.com/codetocloudorg/platform-engineering/security/advisories/new).
2. **Include**:
   - Description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- **Acknowledgment**: We will acknowledge your report within 48 hours.
- **Assessment**: We will assess the vulnerability and determine its severity within 5 business days.
- **Resolution**: We aim to release a fix within 30 days of confirming the vulnerability.
- **Credit**: We will credit you in the fix announcement (unless you prefer to remain anonymous).

## Supported Versions

| Version | Supported          |
|---------|--------------------|
| Latest  | :white_check_mark: |

## Security Best Practices

This repository contains documentation and templates for platform engineering. When using any code or configurations from this project:

- **Review before deploying**: Always review IaC templates and configurations before deploying to production.
- **Use secrets management**: Never hardcode secrets. Use tools like Azure Key Vault, HashiCorp Vault, or sealed secrets.
- **Follow least privilege**: Apply minimum necessary permissions in all configurations.
- **Keep dependencies updated**: Regularly update tools and dependencies referenced in the documentation.
- **Scan configurations**: Use tools like `tfsec`, `checkov`, or `trivy` to scan IaC before deployment.

## Scope

This security policy covers:
- The platform-engineering repository code and configurations
- IaC templates and examples
- CI/CD workflow definitions
- Container configurations (Dockerfiles, devcontainers)

This policy does **not** cover:
- Third-party tools referenced in documentation
- External websites or services linked from this repository
