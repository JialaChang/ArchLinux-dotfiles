#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

echo "==> Syncing configs..."

# sync configs
rm -rf "$SCRIPT_DIR/hypr" && cp -r ~/.config/hypr "$SCRIPT_DIR/"
rm -rf "$SCRIPT_DIR/kitty" && cp -r ~/.config/kitty "$SCRIPT_DIR/"
rm -rf "$SCRIPT_DIR/nvim" && cp -r ~/.config/nvim "$SCRIPT_DIR/"
cp ~/.bashrc "$SCRIPT_DIR/bashrc"

# export packages
echo "==> Exporting packages..."
"$SCRIPT_DIR/pkg.sh" export

echo "==> Done!"
