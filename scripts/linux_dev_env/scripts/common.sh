#! /usr/bin/env bash

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
