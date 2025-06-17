### Env Variables ###
set -gx TERM xterm-256color
set -gx KUBECONFIG ~/.kube/config
set -gx MANPAGER "nvim +Man!"
set -gx SYSTEMD_EDITOR "nvim"
set -gx DISABLE_AUTO_TITLE 'true'
set -gx PATH $PATH ~/.nix-profile/bin
set -gx XDG_SCREENSHOTS_DIR "$HOME/Pictures/Screenshots"
set -gx XDG_PICTURES_DIR "$HOME/Pictures"
set -gx MOZ_ENABLE_WAYLAND 1

### Aliases ###
alias update="yay -Syu"
alias p="yay"
alias t="tmux"
alias ts="tailscale status"
alias cts="ssh -p 50005 deinum@192.168.0.5"
alias ctcp="ssh deinum@192.168.0.6"
alias l="eza"
alias ls="eza"
alias ll="eza -l"
alias lll="eza -la"
alias c="cargo"
alias cat="bat"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias k="kubectl"
alias d="delta"
alias du="dust"
alias df="duf"
alias ps="procs"
alias ct="cargo test"
alias cb="cargo build"
alias cr="cargo run"

### Custom Functions ###
function wgd
    wg-quick down wg0
end

function wgu
    wg-quick up wg0
end

function wgr
    wgd; and wgu
end

fish_add_path "$HOME/.nix-profile/bin"
fish_add_path "$HOME/.nix-profile/sbin"

# set starship as our default prompt
starship init fish | source

