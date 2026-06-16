#!/bin/bash

cd "$(dirname "$0")"

# funtions
backup() {
  local target=$1
  # local timestamp=$(date +%m-%d_%H.%M)

  if [ -d "$target" ]; then
    echo "    -> Backing up dir $target..."
    cp -r "$target" "${target}.backup/"
  elif [ -f "$target" ]; then
    echo "    -> Backing up file $target..."
    cp "$target" "${target}.backup"
  else
    echo "    -> $target not found, skipping backup..."
  fi
}

deploy() {
  local src=$1
  local dest=$2

  if [ -d "$src" ]; then
    echo "    -> Deploying dir $src to $dest..."
    rm -rf "$dest"
    cp -r "$src" "$dest"
  elif [ -f "$src" ]; then
    echo "    -> Deploying file $src to $dest..."
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
  else
    echo "    -> $src not found, skipping..."
  fi
}

# backup files
backup_all() {
  backup "$HOME/.config/hypr"
  backup "$HOME/.config/kitty"
  backup "$HOME/.config/nvim"
  backup "$HOME/.bashrc"
}

# deploy files {src} {dest}
deploy_all() {
  deploy "./hypr" "$HOME/.config/hypr"
  deploy "./kitty" "$HOME/.config/kitty"
  deploy "./nvim" "$HOME/.config/nvim"
  deploy "./bashrc" "$HOME/.bashrc"
}

case "$1" in
backup)
  backup_all
  echo "==> Backup all the files !"
  ;;
deploy)
  deploy_all
  echo "==> Deploy all the files !"
  ;;
*)
  echo "Usage: ./deploy.sh [deploy|backup]"
  echo "    deploy  - deploy all the settings"
  echo "    backup - backup all your files will be replaced as .backup files"
  ;;
esac
