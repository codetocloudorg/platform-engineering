# Development Environment Setup Script

## Overview
This bash script automates the setup of a complete development environment on a Linux (Ubuntu) system.
The overall goal of this script is to install and configure your development environment to work on as a platform engineer.

## Features
The following list involves all the installation in order to set up your development environment. 
1. Network Connectivity Checks
    * 
2. System Updates and Upgrades
    * 
3. Installation of Essential Development Tools:
    * git
    * vim
    * tilix
    * curl
    * wget
    * jq
    * unzip
    * gnupg
    * apt-transport-https
    * ca-certificates
    * software-properties-common
4. Installation of Major Cloud CLI Tools:
    * Azure CLI
    * AWS CLI
    * Google Cloud SDK
5. Installation of Infrastructure as Code (IaC) Tools:
    * Terraform 
    * OpenTofu
    * Bicep
    * Helm
6. Installation of Kubernetes Management Tools:
    * kubectl
    * K9s
    * Minikube
7. Installation of Oh My Posh (Cosmetic Enhancements)
8. Installation of VS Code Extentions:
    * Terraform
    * Kubernetes
    * Azure
    * Bicep
    * Gitlens
    * Spell Checker
9. Semi-Automatic Git Configuration with SSH Setup

## Prerequisites
* A Linux distribution with `sudo` privileges
* Active internet connection

## How to Use
1. Clone this repository or copy the script into your local system.
    * To copy, save the file `ubuntu_dev_env_setup.sh' onto your local machine. Remember the directory you placed it in
2. Open the terminal and head into the directory where this script is located.
3. Run the script using `./ubuntu_dev_env_setup.sh`
4. Follow along the on-screen prompts

### Git Configuration Steps
The final step of this script will need manual inputs as generating an SSH key requires:
* Git username
* Git password
* Directory to save SSH keys properly

When prompted on your terminal, ensure you fill out the following:
1. Primary email for git `Enter your primary email for git:`
2. Username for git `Enter your username for git:`
3. File Location to save the key `Enter file in which to save the key (/home/user/.ssh/id_ed25519)`
    * Simply type out the folder location as written in the brackets
4. Leave passphrase empty by pressing your enter key
5. Leave passphrase empty (again) by pressing your enter key
    #### Copying your SSH key to add into GitHub
    * The terminal will write out the command `cat ~/.ssh/id_ed25519.pub` which allows you to view that generated SSH Key
    * Highlight the following response and copy it

    1. Log into your GitHub Account through a web browser
    2. Click on your account (top-right corner)
    3. Through the Settings page, head onto the SSH and GPG keys section on the left tab
    4. Click on the green "New SSH Key"
    5. Feel free to se the Title to whatever you would like, then ensure that Key Type is set to "Authentication key"
    6. In the Key Section, paste your SSH Key from your terminal
    7. Once you click the green "Add SSH Key" button, you are finished!





