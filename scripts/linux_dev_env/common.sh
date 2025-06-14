#! /usr/bin/env bash

# TODO: We should probably include tmux in here too


configure_ssh() {
  SSH_DIR="$HOME/.ssh"
  if [ ! -d "$SSH_DIR" ]; then
    echo "Creating $SSH_DIR..."
    mkdir -p "$SSH_DIR" || {
      echo "Error: Failed to create $SSH_DIR"
      return 1
    }
    chmod 700 "$SSH_DIR"
  fi

  echo "Do you want to create a new SSH keypair? [y/N]"
  read ans
  case "$ans" in
    [Yy]*)
      echo "Enter a name for the new key (e.g., id_ed25519_github):"
      read keyname

      if [ -z "$keyname" ]; then
        echo "Error: Key name cannot be empty."
        return 1
      fi

      keypath="$SSH_DIR/$keyname"

      if [ -f "$keypath" ] || [ -f "$keypath.pub" ]; then
        echo "Error: Key or public key already exists at $keypath"
        return 1
      fi

      echo "Generating key at $keypath..."
      ssh-keygen -t ed25519 -C "$(git config user.email)" -f "$keypath" || {
        echo "Error: ssh-keygen failed"
        return 1
      }

      chmod 600 "$keypath"
      chmod 644 "$keypath.pub"

      echo "SSH key created successfully."
      echo "Public key:"
      cat "$keypath.pub"
      ;;
    *)
      echo "Skipping SSH key creation."
      ;;
  esac

  return 0
}

configure_git() {
  echo "Enter your Git username:"
  read username
  if [ -z "$username" ]; then
    echo "Error: Git username cannot be empty."
    return 1
  fi

  echo "Enter your Git email:"
  read email
  if [ -z "$email" ]; then
    echo "Error: Git email cannot be empty."
    return 1
  fi

  git config --global user.name "$username"
  git config --global user.email "$email"

  return 0
}

configure_tmux() {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}
