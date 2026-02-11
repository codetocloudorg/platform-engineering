# 🌐 Platform Engineering: Setting Up Your Local Development Environment

Welcome to the **Platform Engineering** module! This guide will help you set up your local development environment, tailored to your operating system and preferred workflow. Whether you're using **Windows**, **Linux**, **macOS**, or a **cloud-based environment**, we've got you covered.

---

## 🚀 Quick Start Options

| Environment | Best For | Setup Time | Link |
|-------------|----------|------------|------|
| **Kodra** | Ubuntu desktop users wanting a full IDE + terminal experience | ~5 min | [kodra.codetocloud.io](https://kodra.codetocloud.io) |
| **Kodra WSL** | Windows users wanting native Linux tooling | ~4 min | [kodra.wsl.codetocloud.io](https://kodra.wsl.codetocloud.io) |
| **GitHub Codespaces** | Browser-based, zero local setup | Instant | [Open Codespaces](https://github.com/codespaces/new?repo=codetocloudorg/platform-engineering) |
| **Dev Container** | VS Code users with Docker | ~2 min | Clone repo, open in VS Code |

---

## 🖥️ Windows (WSL)

We recommend **Kodra WSL** for a fully automated setup with all cloud-native tools pre-configured.

### What You Get
- Docker CE running natively in WSL2 (no Docker Desktop license required)
- Azure CLI, azd, Bicep, Terraform, OpenTofu
- GitHub CLI with Copilot integration
- Zsh with Starship prompt

### Installation
```bash
# In Windows Terminal (Ubuntu WSL)
wget -qO- https://kodra.wsl.codetocloud.io/boot.sh | bash
```

👉 **[Full Kodra WSL Setup Guide](https://kodra.wsl.codetocloud.io)**

---

## 🐧 Linux (Ubuntu)

We recommend **Kodra** for Ubuntu users wanting a complete platform engineering workstation.

### What You Get
- GNOME desktop with Blur my Shell and Dash to Dock
- Ghostty terminal with Tokyo Night theme
- VS Code with 13+ extensions pre-configured
- 30+ CLI tools: Terraform, kubectl, Helm, k9s, and more

### Installation
```bash
wget -qO- https://kodra.codetocloud.io/boot.sh | bash
```

👉 **[Full Kodra Setup Guide](https://kodra.codetocloud.io)**

---

## 🍎 macOS

For macOS users, use Homebrew to install the core tooling:

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install platform engineering tools
brew install terraform opentofu azure-cli kubectl helm k9s gh
brew install --cask visual-studio-code docker
```

Alternatively, clone this repo and open in VS Code to use the included dev container.

---

## ☁️ Cloud-Based Development

### GitHub Codespaces

The fastest way to get started—no local setup required.

1. Click **[Open in Codespaces](https://github.com/codespaces/new?repo=codetocloudorg/platform-engineering)**
2. Wait for the container to build (~2 minutes)
3. Start coding with all tools pre-installed

### Dev Container (VS Code)

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop) and [VS Code](https://code.visualstudio.com/)
2. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Clone this repo: `git clone https://github.com/codetocloudorg/platform-engineering`
4. Open in VS Code and click "Reopen in Container"

### Tools Included in Dev Container
- Terraform + OpenTofu
- Azure CLI + Bicep
- Dagger CLI
- Docker CLI
- Git

---

## 🛠️ Manual Installation

If you prefer manual setup, here are the essential tools:

| Tool | Purpose | Install |
|------|---------|---------|
| Terraform | Infrastructure as Code | [terraform.io](https://terraform.io) |
| OpenTofu | Open-source Terraform fork | [opentofu.org](https://opentofu.org) |
| Azure CLI | Azure management | [docs.microsoft.com](https://docs.microsoft.com/cli/azure/install-azure-cli) |
| kubectl | Kubernetes CLI | [kubernetes.io](https://kubernetes.io/docs/tasks/tools/) |
| Helm | Kubernetes package manager | [helm.sh](https://helm.sh) |
| Dagger | CI/CD pipelines | [dagger.io](https://dagger.io) |

---

## 🚀 Next Steps

1. Set up your environment using one of the options above
2. Explore the [IaC examples](iac.md)
3. Try the [Dagger pipeline examples](dagger/README.md)
4. Check out [Kubernetes deployment guides](kubernetes.md)

Happy coding! 🎉
