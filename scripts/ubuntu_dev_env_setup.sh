#!/bin/bash

# Colors for messages
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Validate network
validate_network() {
    echo -e "${YELLOW}Checking network connectivity...${RESET}"
    if ping -c 3 google.com; then
        echo -e "${GREEN}Network connectivity: SUCCESSFUL${RESET}"
    else
        echo -e "${RED}Network connectivity: FAILED${RESET}"
        exit 1
    fi
}

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
    sudo snap install --classic code
}

# Install Cloud CLIs
# ====================================
# Azure CLI
install_azure_cli() {
    echo -e "${YELLOW}Installing Azure CLI...${RESET}"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

# AWS CLI
install_aws_cli() {
    echo -e "${YELLOW}Installing AWS CLI...${RESET}"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    # Remove installation "junk"
    rm -rf aws awscliv2.zip
}
   
# Google Cloud SDK
install_google_cloud_sdk() {
    echo -e "${YELLOW}Installing Google Cloud SDK...${RESET}"
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt update && sudo apt -y install google-cloud-cli
}

# Install Infrastructure as Code tools
# ====================================
# Terraform
install_terraform() {
    echo -e "${YELLOW}Installing Terraform...${RESET}"

    wget -O- https://apt.releases.hashicorp.com/gpg |\
    gpg --dearmor |\
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt update && sudo apt -y install terraform
}

# OpenTofu
install_opentofu() {
    echo -e "${YELLOW}Installing OpenTofu...${RESET}"
    sudo snap install --classic opentofu
}

# Bicep
install_bicep() {
    echo -e "${YELLOW}Installing Bicep...${RESET}"
    curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
    chmod +x ./bicep
    sudo mv ./bicep /usr/local/bin/bicep
}

# Helm
install_helm() {
    echo -e "${YELLOW}Installing Helm...${RESET}"
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh

}

# Install Kubernetes tools
# ====================================
# kubectl
install_kubectl() {
    echo -e "${YELLOW}Installing Kubectl...${RESET}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
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
    # Remove Installation "junk"
    rm -f "$(basename "$latest_k9s")"
}

# minikube
install_minikube() {
    echo -e "${YELLOW}Installing Minikube...${RESET}"
    curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    # Remove installation "junk"
    rm -f minikube-linux-amd64
}

# Oh My Posh
install_oh_my_posh() {
    echo -e "${YELLOW}Installing Oh My Posh...${RESET}"
    curl -s https://ohmyposh.dev/install.sh | bash -s
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

check_installation() {
    local cmd=$1
    local name=$2

    if eval $cmd &>/dev/null; then
        echo -e "${GREEN}${name} Installation: SUCCESS${RESET}"
    else
        echo -e "${RED}${name} Installation: FAILED${RESET}"
    fi
}

final_verification() {
    echo -e "\n${YELLOW}Verifying all installations...${RESET}"
    check_installation "git --version" "Git"
    check_installation "vim --version" "Vim"
    check_installation "tilix --version" "Tilix"
    check_installation "curl --version" "cURL"
    check_installation "wget --version" "Wget"
    check_installation "jq --version" "jq"
    check_installation "unzip -v" "Unzip"
    check_installation "gpg --version" "GnuPG"
    check_installation "apt-config dump" "APT Transport HTTPS (Check APT Config)"
    check_installation "openssl version" "CA Certificates (Check OpenSSL)"
    check_installation "apt-cache policy software-properties-common" "Software Properties Common"
    check_installation "code --version" "VS Code"
    check_installation "az version" "Azure CLI"
    check_installation "sudo aws --version" "AWS CLI"
    check_installation "gcloud version" "Google Cloud SDK"
    check_installation "terraform version" "Terraform"
    check_installation "tofu version" "OpenTofu"
    check_installation "bicep --version" "Bicep"
    check_installation "helm version" "Helm"
    check_installation "kubectl version --client" "kubectl"
    check_installation "k9s version" "K9s"
    check_installation "minikube version" "Minikube"
    check_installation "~/.local/bin/oh-my-posh --version" "Oh My Posh"
    echo -e "${YELLOW}Listing all VS Code Extentions${RESET}"
    code --list-extensions
    echo -e "${GREEN}Development environment setup is almost complete!${RESET}"

}

# Config git with ssh authentication
# The following portion would require manual inputs"
configure_git() {
    echo -e "${YELLOW}Configuring Git with SSH...${RESET}"
    echo -e "${YELLOW}Enter your primary email for git:${RESET}"
    read git_email
    git config --global user.email "$git_email"

    echo -e "${YELLOW}Enter your name for git:${RESET}"
    read git_name
    git config --global user.name "$git_name"

    if [[ ! -f ~/.ssh/id_ed25519 ]]; then
        echo "${YELLOW}Generating SSH key for GitHub...${RESET}"
        ssh-keygen -t ed25519 -C "$git_email"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
    fi

    # Refer to Markdown/Readme Instructions
    echo -e "${YELLOW}Copy your SSH key and add it to GitHub:${RESET}"
    cat ~/.ssh/id_ed25519.pub
    echo -e "${YELLOW}Refer to README notes on the next steps${RESET}"
}

next_steps_message() {
    echo -e "${YELLOW}Last Step: SSH Authentication with GitHub${RESET}"
}

final_message() {
    echo -e "${GREEN}Congratulations! You have reached the end of this script. Refer back to the verification step and ensure that all installations did not ${RED}FAIL.${RESET}"
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
    
    # Install Cloud CLIs
    install_azure_cli
    install_aws_cli
    install_google_cloud_sdk

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

    # Verify all installations
    final_verification

    # "Step 1 - END" message
    next_steps_message

    # Configure Git
    configure_git

    # Validate Cloud CLI's and Kubernetes Access (NEEDS FIXING!!!!!)
    # validate_azure_cli_permissions
    # validate_aws_cli_permissions
    # validate_google_cloud_sdk_permissions
    # check_kubernetes_access
}

main