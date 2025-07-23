{
  description = "Dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Use toPath to resolve the local .config path properly
        configDir = builtins.toPath ../.config;
      in {
        devShells.default = pkgs.mkShell {
          name = "dev-env";

          packages = with pkgs; [
            alacritty
            git
            fish
            azure-cli
            awscli2
            google-cloud-sdk
            cowsay
            lolcat
            asciiquarium
            terraform
            helm
            opentofu
            kubectl
            k9s
            minikube
            skaffold
            helmfile
            stern
            kubie
            lazygit
            fzf
            ripgrep
            bat
            htop
            tldr
            eza
            starship
            neovim
            tmux
            jetbrains-mono
            noto-fonts-emoji
          ];

          shellHook = ''
            export ORIGINAL_HOME="$HOME"
            export HOME=$(mktemp -d)
            mkdir -p "$HOME/.config"
            cp -r ${configDir}/. "$HOME/.config/"
            chmod -R u+w "$HOME/.config"
            echo "run nvim to install all of the plugins :) , happy coding"
            export EDITOR=nvim
            exec fish
          '';
        };

        packages.default = pkgs.writeTextFile {
          name = "placeholder";
          text = "This flake is only for devShell use.";
        };
      });
}

