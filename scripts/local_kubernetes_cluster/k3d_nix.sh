#!/usr/bin/env bash

set -euo pipefail

# Absolute path to script directory
SCRIPT_DIR="./resources/"

# Check for Nix
if ! command -v nix-env &> /dev/null; then
  echo "❌ Nix is not installed. Please install Nix first."
  exit 1
fi

# Check for cluster name argument
CLUSTER_NAME="${1:-}"
if [ -z "$CLUSTER_NAME" ]; then
  echo "Usage: $0 <cluster-name>"
  exit 1
fi

# Ensure required tools are installed
for pkg in docker k3d kubectl helm; do
  if ! command -v "$pkg" &> /dev/null; then
    echo "📦 Installing $pkg..."
    nix-env -iA "nixpkgs.${pkg}"
  else
    echo "✅ $pkg already installed."
  fi
done

# Create k3d cluster
echo "🚀 Creating k3d cluster: $CLUSTER_NAME"
k3d cluster create "$CLUSTER_NAME" -p '80:80@loadbalancer' --agents 2

echo "⏳ Waiting for nodes to become ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=60s

# install traefik crds 
echo "📦  Install traefik CRDs..."
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.5/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

# Apply resources
echo "📦 Applying Kubernetes resources..."
kubectl apply -f "$SCRIPT_DIR/deployment.yaml"
kubectl apply -f "$SCRIPT_DIR/service.yaml"
kubectl apply -f "$SCRIPT_DIR/ingress.yaml"

# Update /etc/hosts
if grep -q "hello.example.com" /etc/hosts; then
  echo "🔁 Updating existing /etc/hosts entry for hello.example.com"
  sudo sed -i.bak "/hello.example.com/c\\127.0.0.1 hello.example.com" /etc/hosts
else
  echo "➕ Adding hello.example.com to /etc/hosts"
  echo "127.0.0.1 hello.example.com" | sudo tee -a /etc/hosts > /dev/null
fi

echo "✅ Done! Visit http://hello.example.com to see the Hello World app."
