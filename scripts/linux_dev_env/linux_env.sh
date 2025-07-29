#!/usr/bin/env bash
set -euo pipefail

# determine OS
echo 'Determining OS...'
if [[ ! -f /etc/os-release ]]; then
    echo "Error: /etc/os-release not found. Cannot determine operating system."
    exit 1
fi

OS=$(awk -F '=' '/^ID=/{gsub(/"/, "", $2); print $2; exit}' /etc/os-release)
echo "Detected OS: $OS"

# if we are running on debian, make sure we are on debian 12
if [[ "$OS" == "debian" ]]; then
    VERSION=$(awk -F '=' '/^VERSION_ID=/{gsub(/"/, "", $2); print $2; exit}' /etc/os-release)
    if [[ "$VERSION" != "12" ]]; then
        echo "Error: Only Debian 12 is supported. Detected version: $VERSION"
        exit 1
    fi
    echo "Debian version $VERSION confirmed."
fi

# make sure we are running with kernel version 6.x.y
KERNEL_MAJOR=$(uname -r | cut -d. -f1)
if [[ "$KERNEL_MAJOR" -ne 6 ]]; then
    echo "Error: Kernel version 6.x.y required. Detected: $(uname -r)"
    exit 1
fi
echo "Kernel version $(uname -r) confirmed."

# source the ${OS}.sh script to get all of the functions we need
source "scripts/common.sh"
source "scripts/$OS.sh"

# install required packages 
echo "Installing required packages..."
install_required_packages


# configure tmux
# i.e just install the package manager for it
configure_tmux

echo 'All done! See the docs at \
  https://github.com/codetocloudorg/platform-engineering on using this setup!'
