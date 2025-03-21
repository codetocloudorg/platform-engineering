#!/bin/bash

# Update and upgrade the system
upgrade_system() {
    sudo apt update && sudo apt upgrade -y
}

# Install essential development tools
install_dev_tools() {
    sudo apt install -y \
        git \
        vim \
        tilix \
        curl \
        wget \
        jq \
        unzip
}

# Install VS Code (via Flatpak)
install_vscode() {
    flatpak install -y flathub com.visualstudio.code
}


# Install Cloud CLIs
# ====================================
# Azure 

# AWS

# Google

#Install Infrastructure as Code tools
# ====================================
# Terraform

# OpenTofu

# Bicep

# Helm

# Instaall Kubernetes tools
# ====================================
# kubectl

# K9s

# minikube

# Oh My Posh

# VScode extensions
# ====================================
# terraform, kubernetes tools, azure tools, bicep, gitlen, spell checker

# Config git with ssh authentication

# Validate networking and permissions

# Final messages

main() {
    # upgrade_system
    # install_dev_tools
    # install_vscode

    echo "Development environment setup complete!"
    echo "Restart your terminal or run 'source ~/.bashrc' to apply changes."
}


main