install_required_packages() {

apt update
apt install -y \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https

# Install packages from Debian repositories
apt install -y \
    alacritty \
    libfuse2 \
    git \
    fish \
    cowsay \
    lolcat \
    fzf \
    ripgrep \
    bat \
    htop \
    tldr \
    tmux \
    fonts-jetbrains-mono \
    fonts-noto-color-emoji \
    clangd \
    gcc \
    wget;

wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list
chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
apt update && apt install -y eza

curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage /usr/local/bin/nvim_appimage
chmod u+x /usr/local/bin/nvim_appimage
/usr/local/bin/nvim_appimage --appimage-extract && \
mv squashfs-root /opt/nvim && \
ln -s /opt/nvim/AppRun /usr/local/bin/nvim


curl -sS https://starship.rs/install.sh | sh -s -- --yes


# curl -sL https://aka.ms/InstallAzureCLIDeb | bash
#
# # Add AWS CLI v2 repository (Install from AWS's official method)
# echo "Installing AWS CLI v2"
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# ./aws/install 
#
# # Add Google Cloud SDK repository
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
# echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# apt-get update && apt install -y google-cloud-cli

echo "Installation complete!"

}
