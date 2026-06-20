#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

sync_dir() {
  local src=$1
  local dest=$2
  if [ -d "$src" ]; then
    rm -rf "$dest"
    cp -r "$src" "$dest"
    echo " -> synced $src"
  else
    echo " -> $src not found, skipping..."
  fi
}

sync_file() {
  local src=$1
  local dest=$2
  if [ -f "$src" ]; then
    cp "$src" "$dest"
    echo " -> synced $src"
  else
    echo " -> $src not found, skipping..."
  fi
}

echo "==> Syncing configs..."
sync_dir ~/.config/hypr "$ROOT_DIR/config/hypr"
sync_dir ~/.config/kitty "$ROOT_DIR/config/kitty"
sync_dir ~/.config/nvim "$ROOT_DIR/config/nvim"
sync_dir ~/.config/waybar "$ROOT_DIR/config/waybar"
sync_file ~/.bashrc "$ROOT_DIR/config/bashrc"
sync_file ~/.zshrc "$ROOT_DIR/config/zshrc"

echo "==> Exporting packages..."
"$SCRIPT_DIR/pkg.sh" export

echo "==> Done!"
