install_required_packages() {
  # update the package repositories
  # sudo pacman -Syu 
  sudo pacman -Syu  --noconfirm

  # first thing we'll do is install the required packages for yay
  # an AUR helper that makes managing the AUR a bit easier
  if ! command -v yay >/dev/null 2>&1; then
    pacman -S --needed git base-devel  --noconfirm && \
      git clone https://aur.archlinux.org/yay.git && \
      cd yay && makepkg -si
  fi

  yay -S \
    alacritty \
    git \
    fish \
    azure-cli \
    aws-cli-v2 \
    google-cloud-cli \
    cowsay \
    lolcat \
    asciiquarium \
    terraform \
    helm \
    opentofu \
    kubectl \
    k9s \
    minikube \
    skaffold \
    helmfile \
    stern \
    kubie \
    lazy-git \
    fzf \
    ripgrep \
    bat \
    htop \
    tldr \
    eza \
    starship \
    fisher \
    ttf-jetbrains-mono \
    noto-fonts-emoji \
    # neovim \
    tmux \
    silicon \
    gcc;

    return 0
}


