#!/usr/bin/env bash

set -euo pipefail

echo "🚀 Starting Nix install and setup..."

# Detect OS and install prerequisites
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Detected macOS."
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  echo "Installing prerequisites with brew..."
  brew install curl xz
elif command -v apt-get &>/dev/null; then
  echo "Detected Debian/Ubuntu."
  sudo apt-get update
  sudo apt-get install -y curl xz-utils
elif command -v yum &>/dev/null; then
  echo "Detected yum-based Linux."
  sudo yum install -y curl xz
else
  echo "Unsupported OS or package manager. This script should only be used on MacOS or a Debian based system."
  exit 1
fi

# Install Nix multi-user daemon
if ! command -v nix &>/dev/null; then
  echo "Installing Nix..."
  sh <(curl -L https://nixos.org/nix/install) --daemon
else
  echo "Nix is already installed."
fi

# Source nix profile to have nix command available
if [ -f /etc/profile.d/nix.sh ]; then
  # shellcheck disable=SC1091
  source /etc/profile.d/nix.sh
elif [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  # shellcheck disable=SC1091
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Start nix-daemon if not running (for containers without systemd)
if ! pgrep -x nix-daemon > /dev/null; then
  echo "Starting nix-daemon..."
  sudo /nix/var/nix/profiles/default/bin/nix-daemon &
  sleep 2
fi

echo "Configuring Nix channel to stable..."
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs || true
nix-channel --update

echo "✅ Nix installed and configured."

# Check for two arguments: cluster name and setup type (k3d or kind)
if [ $# -ne 2 ]; then
  echo "Usage: $0 <cluster-name> {k3d|kind}"
  exit 1
fi

cluster_name=$1
setup_type=$2

case $setup_type in
  k3d)
    echo "Running k3d setup for cluster '$cluster_name'..."
    # You can pass the cluster name to the k3d script if needed
    bash ./k3d_nix.sh "$cluster_name"
    ;;
  kind)
    echo "Running kind setup for cluster '$cluster_name'..."
    # You can pass the cluster name to the kind script if needed
    bash ./kind_nix.sh "$cluster_name"
    ;;
  *)
    echo "Invalid setup type: $setup_type. Please use 'k3d' or 'kind'."
    exit 1
    ;;
esac

echo "🎉 Done!"

