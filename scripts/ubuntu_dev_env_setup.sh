#!/bin/bash

# Update and upgrade the system
upgrade_system() {
    echo "Updating and upgrading the system..."
    sudo apt update && sudo apt upgrade -y
}

# Install essential development tools
install_dev_tools() {
    echo "Installing core development tools..."
    sudo apt install -y \
        git \
        vim \
        tilix \
        curl \
        wget \
        jq \
        unzip \
        gnupg 
}

# Install VS Code (via Flatpak)
install_vscode() {
    echo "Installing VS Code..."
    flatpak install -y flathub com.visualstudio.code
}

# Install Cloud CLIs
# ====================================
# Azure CLI
install_azure_cli() {
    echo "Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

# AWS CLI
install_aws_cli() {
    echo "Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
}
   
# Google Cloud SDK
install_google_cloud_sdk() {
    echo "Installing Google Cloud SDK..."
    sudo apt install -y apt-transport-https ca-certificates gnupg

    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    
    sudo apt update && sudo apt install google-cloud-cli
}

# Install Infrastructure as Code tools
# ====================================
# Terraform
install_terraform() {
    echo "Installing Terraform..."
    sudo apt update && sudo apt install -y software-properties-common

    wget -O- https://apt.releases.hashicorp.com/gpg | \ 
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt update && sudo apt install terraform
}

# OpenTofu
install_opentofu() {
    echo "Installing OpenTofu..."
    snap install --classic opentofu
}

# Bicep
install_bicep() {
    echo "Installing Bicep..."
    curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
    chmod +x ./bicep
    sudo mv ./bicep /usr/local/bin/bicep
}

# Helm
install_helm() {
    echo "Installing Helm..."
    # curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
    # sudo apt install apt-transport-https --yes
    # echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    # sudo apt update
    # sudo apt install helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
}

# Install Kubernetes tools
# ====================================
# kubectl
install_kubectl() {
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

# K9s
install_k9s() {
    echo "Installing K9s..."

}

# minikube
install_minikube() {
    echo "Installing minikube..."
    curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
}

# Oh My Posh
install_oh_my_posh() {
    echo "Installing Oh My Posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
}

# VScode extensions
# ====================================
# terraform, kubernetes tools, azure tools, bicep, gitlen, spell checker, helm
install_vscode_extensions() {
    code --install-extension hashicorp.terraform
    code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
    code --install-extension msazurermtools.azurerm-vscode-tools
    code --install-extension bicep.bicep
    code --install-extension eamodio.gitlens
    code --install-extension streetsidesoftware.code-spell-checker
}

# Config git with ssh authentication
# The following portion would require manual inputs"
configure_git() {
		echo "Configuring Git with SSH..."
		echo "Enter your primary email for git:"
		read git_email
    git config --global user.email "$git_email"
		
		echo "Enter your name for git:"
    read git_name
    git config --global user.name "$git_name"
    
    echo "Generating SSH key for GitHub..."
    ssh-keygen -t rsa -b 4096 -C "$git_email"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    
		# Refer to Markdown Instructions
    echo "Add your SSH key to GitHub by running:"
    echo "cat ~/.ssh/id_rsa.pub"
}
		
# Validate networking
validate_network() {
		echo "Checking network connectivity..."
		if ping -c 3 google.com then
				echo "Network connectivity: SUCCESSFUL"
		else
				echo "Network connectivity: FAILED"
				exit 1
		fi
}

# Validate Permissions and Authentication of Cloud CLI
# ====================================
# Validate AWS CLI
validate_aws_cli_permissions() {
		echo "Checking AWS CLI authentication and permissions..."
	  if aws sts get-caller-identity &>/dev/null; then
	      echo "AWS CLI authentication: SUCCESS"
	  else
	      echo "AWS CLI authentication: FAILED"
	      exit 1
	  fi
}

# Validate AZURE CLI
validate_azure_cli_permissions() {
    echo "Checking Azure CLI authentication and permissions..."
    if az account show &>/dev/null; then
        echo "Azure CLI authentication: SUCCESS"
    else
        echo "Azure CLI authentication: FAILED"
        exit 1
    fi
}

# Validate GOOGLE SDK
validate_google_cloud_sdk_permissions() {
    echo "Checking Google Cloud SDK authentication and permissions..."
    if gcloud auth list &>/dev/null; then
        echo "Google Cloud SDK authentication: SUCCESS"
    else
        echo "Google Cloud SDK authentication: FAILED"
        exit 1
    fi
}

# Validate Kubernetes 
check_kubernetes_access() {
    echo "Checking Kubernetes cluster access..."
    if kubectl cluster-info &>/dev/null; then
        echo "Kubernetes access: SUCCESS"
    else
        echo "Kubernetes access: FAILED"
        exit 1
    fi
}

final_messages() {
    echo "Development environment setup complete!"
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

    # Final validation
    validate_networking_and_permissions

    # Final message
    final_messages
}

main