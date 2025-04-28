#!/bin/bash

# Exit immediately on error
set -e

# Colors for messages
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Update and upgrade the system
upgrade_system() {
    echo -e "${YELLOW}Updating and upgrading the system...${RESET}"
    sudo apt update && sudo apt upgrade -y
}

# Install essential development tools
install_dev_tools() {
    echo -e "${YELLOW}Installing core development tools...${RESET}"
    sudo apt install -y \
        git \
        vim \
        tilix \
        curl \
        wget \
        jq \
        unzip \
        gnupg \
        apt-transport-https \
        ca-certificates \
        software-properties-common
}

# Install VS Code (via Snap)
install_vscode() {
    echo -e "${YELLOW}Installing VS Code (via Snap) ${RESET}"
    #flatpak install -y flathub com.visualstudio.code
    #flatpak info com.visualstudio.code || echo -e "${RED}VS Code installation verification failed!${RESET}"
    sudo snap install --classic code
    code --version || echo -e "${RED}VS Code installation failed!${RESET}"
}

# Install Cloud CLIs
# ====================================
# Azure CLI
install_azure_cli() {
    echo -e "${YELLOW}Installing Azure CLI...${RESET}"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    # Verify Azure CLI has installed
    az version || echo -e "${RED}Azure CLI installation verification failed!${RESET}"
}

# AWS CLI
install_aws_cli() {
    echo -e "${YELLOW}Installing AWS CLI...${RESET}"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    # Verify AWS CLI has installed
    aws --version || echo -e "${RED}AWS CLI installation verification failed!${RESET}"
    # Remove installation "junk"
    rm -rf aws awscliv2.zip
}
   
# Google Cloud SDK
install_google_cloud_sdk() {
    echo -e "${YELLOW}Installing Google Cloud SDK...${RESET}"
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt update && sudo apt -y install google-cloud-cli
    # Verify Google Cloud SDK has installed
    gcloud version || echo -e "${RED}Google Cloud SDK installation verification failed!${RESET}"
}

# Install Infrastructure as Code tools
# ====================================
# Terraform
install_terraform() {
    echo -e "${YELLOW}Installing Terraform...${RESET}"

    wget -O- https://apt.releases.hashicorp.com/gpg | \ 
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt update && sudo apt -y install terraform
    # Verify Terraform has installed
    terraform version || echo -e "${RED}Terraform installation verification failed!${RESET}"
}

# OpenTofu
install_opentofu() {
    echo -e "${YELLOW}Installing OpenTofu...${RESET}"
    sudo snap install --classic opentofu
    # Verify OpenTofu has installed
    tofu version || echo -e "${RED}OpenTofu installation verification failed!${RESET}"
}

# Bicep
install_bicep() {
    echo -e "${YELLOW}Installing Bicep...${RESET}"
    curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
    chmod +x ./bicep
    sudo mv ./bicep /usr/local/bin/bicep
    # Verify Bicep has installed
    bicep --version || echo -e "${RED}Bicep installation verification failed!${RESET}"
}

# Helm
install_helm() {
    echo -e "${YELLOW}Installing Helm...${RESET}"
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    # Verify Helm has installed
    helm version || echo -e "${RED}Helm installation verification failed!${RESET}"

}

# Install Kubernetes tools
# ====================================
# kubectl
install_kubectl() {
    echo -e "${YELLOW}Installing Kubectl...${RESET}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    # Verify kubectl has installed
    kubectl version --client || echo -e "${RED}kubectl installation verification failed!${RESET}"
    # Remove installation "junk"
    rm -f kubectl

}

# K9s
install_k9s() {
    echo -e "${YELLOW}Installing K9s...${RESET}"
    # Find the latest K9s Debian package URL from GitHub releases
    latest_k9s=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
    # Download the latest K9s .deb package
    wget "$latest_k9s"
    # Install K9s using the .deb package
    sudo apt install ./"$(basename "$latest_k9s")"
    # Verify K9s installation
    k9s version || echo -e "${RED}K9s installation verification failed!${RESET}"
    # Remove Installation "junk"
    rm -f "$(basename "$latest_k9s")"

}

# minikube
install_minikube() {
    echo -e "${YELLOW}Installing Minikube...${RESET}"
    curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    # Verify minikube has installed
    minikube version || echo -e "${RED}minikube installation verification failed!${RESET}"
    # Remove installation "junk"
    rm -f minikube-linux-amd64

}

# Oh My Posh
install_oh_my_posh() {
    echo -e "${YELLOW}Installing Oh My Posh...${RESET}"
    curl -s https://ohmyposh.dev/install.sh | bash -s
    # Verify Oh My Posh has installed
    oh-my-posh --version || echo -e "${RED}Oh My Posh installation verification failed!${RESET}"

}

# VScode extensions
# ====================================
# terraform, kubernetes tools, azure tools, bicep, gitlen, spell checker, helm
install_vscode_extensions() {
    echo -e "${YELLOW}Installing VS Code extensions...${RESET}"
    code --install-extension hashicorp.terraform
    code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
    code --install-extension msazurermtools.azurerm-vscode-tools
    code --install-extension ms-azuretools.vscode-bicep
    code --install-extension eamodio.gitlens
    code --install-extension streetsidesoftware.code-spell-checker
}

# Config git with ssh authentication
# The following portion would require manual inputs"
configure_git() {
    echo -e "${YELLOW}Configuring Git with SSH...${RESET}"
    echo "Enter your primary email for git:"
    read git_email
    git config --global user.email "$git_email"

    echo "Enter your name for git:"
    read git_name
    git config --global user.name "$git_name"

    if [[ ! -f ~/.ssh/id_rsa ]]; then
        echo "Generating SSH key for GitHub..."
        ssh-keygen -t rsa -b 4096 -C "$git_email"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_rsa
    fi

    # Refer to Markdown Instructions
    echo "Copy your SSH key and add it to GitHub:"
    echo "cat ~/.ssh/id_rsa.pub"
}

		
# Validate networking
validate_network() {
    echo -e "${YELLOW}Checking network connectivity...${RESET}"
    if ping -c 3 google.com; then
        echo -e "${GREEN}Network connectivity: SUCCESSFUL${RESET}"
    else
        echo -e "${RED}Network connectivity: FAILED${RESET}"
        exit 1
    fi
}

# Validate Permissions and Authentication of Cloud CLI
# ====================================
# Validate AWS CLI
validate_aws_cli_permissions() {
    echo -e "${YELLOW}Checking AWS CLI authentication and permissions...${RESET}"
    if aws sts get-caller-identity &>/dev/null; then
        echo -e "${GREEN}AWS CLI authentication: SUCCESS${RESET}"
    else
        echo -e "${RED}AWS CLI authentication: FAILED${RESET}"
        exit 1
    fi
}

# Validate AZURE CLI
validate_azure_cli_permissions() {
    echo -e "${YELLOW}Checking Azure CLI authentication and permissions...${RESET}"
    if az account show &>/dev/null; then
        echo -e "${GREEN}Azure CLI authentication: SUCCESS${RESET}"
    else
        echo -e "${RED}Azure CLI authentication: FAILED${RESET}"
        exit 1
    fi
}

# Validate GOOGLE SDK
validate_google_cloud_sdk_permissions() {
    echo -e "${YELLOW}Checking Google Cloud SDK authentication and permissions...${RESET}"
    if gcloud auth list &>/dev/null; then
        echo -e "${GREEN}Google Cloud SDK authentication: SUCCESS${RESET}"
    else
        echo -e "${RED}Google Cloud SDK authentication: FAILED${RESET}"
        exit 1
    fi
}

# Validate Kubernetes 
check_kubernetes_access() {
    echo -e "${YELLOW}Checking Kubernetes cluster access...${RESET}"
    if kubectl cluster-info &>/dev/null; then
        echo -e "${GREEN}Kubernetes access: SUCCESS${RESET}"
    else
        echo -e "${RED}Kubernetes access: FAILED${RESET}"
        exit 1
    fi
}

final_messages() {
    echo -e "${GREEN}Development environment setup complete!${RESET}"
}


main() {
    # Initial validation
    validate_network

    # System update and upgrades
    upgrade_system

    # Install Development tools
    install_dev_tools
    
    # Install VS Code
    install_vscode
    
    # Install Cloud CLIs and validate them
    install_azure_cli
    validate_azure_cli_permissions

    install_aws_cli
    validate_aws_cli_permissions

    install_google_cloud_sdk
    validate_google_cloud_sdk_permissions

    # Install Infrastructure tools and validate
    install_terraform
    install_opentofu
    install_bicep
    install_helm
    
    # Install Kubernetes tools and validate
    install_kubectl
    install_k9s
    install_minikube

    # Install Oh My Posh
    install_oh_my_posh
    
    # Install VSCode Extensions
    install_vscode_extensions

    # Configure Git
    configure_git

    # Validate Kubernetes
    check_kubernetes_access


    # Final message
    final_messages
}

main