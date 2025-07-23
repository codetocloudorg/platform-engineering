
install_required_packages() {
  set -euo pipefail

  # we split this up because nix cant be installed as root, and avoids us from
  # needing to use sudo in the default script.
  echo "[*] Checking for required tools (curl, xz-utils)"
  for pkg in curl xz-utils; do
    if ! command -v "${pkg%%-*}" >/dev/null 2>&1; then
      echo "[-] '$pkg' not found. Installing via apt..."
      apt-get update
      apt-get install -y "$pkg"
    else
      echo "[+] '$pkg' is already installed."
    fi
  done

  echo "[*] Installing Nix package manager..."
  install -d -m755 -o "$(id -u)" -g "$(id -g)" /nix || true
  curl -L https://nixos.org/nix/install | sh
  # shellcheck disable=SC1090
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
  export NIX_PATH="$HOME/.nix-defexpr/channels"
  export PATH="$HOME/.nix-profile/bin:$HOME/.nix-profile/sbin:$PATH"

  echo "[*] Installing packages from nixpkgs..."
  export NIXPKGS_ALLOW_UNFREE=1
  nix-env -iA nixpkgs.alacritty \
                 nixpkgs.git \
                 nixpkgs.fish \
                 nixpkgs.azure-cli \
                 nixpkgs.awscli2 \
                 nixpkgs.google-cloud-sdk \
                 nixpkgs.cowsay \
                 nixpkgs.lolcat \
                 nixpkgs.asciiquarium \
                 nixpkgs.terraform \
                 nixpkgs.helm \
                 nixpkgs.opentofu \
                 nixpkgs.kubectl \
                 nixpkgs.k9s \
                 nixpkgs.minikube \
                 nixpkgs.skaffold \
                 nixpkgs.helmfile \
                 nixpkgs.stern \
                 nixpkgs.kubie \
                 nixpkgs.lazygit \
                 nixpkgs.fzf \
                 nixpkgs.ripgrep \
                 nixpkgs.bat \
                 nixpkgs.htop \
                 nixpkgs.tldr \
                 nixpkgs.eza \
                 nixpkgs.starship \
                 nixpkgs.neovim \
                 nixpkgs.tmux \
                 nixpkgs.jetbrains-mono \
                 nixpkgs.gcc \
                 nixpkgs.noto-fonts-emoji

  echo "All tools installed successfully!"
}

