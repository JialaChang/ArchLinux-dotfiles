#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

echo "==> Syncing configs..."

# sync configs
cp -r ~/.config/hypr "$SCRIPT_DIR/"
cp -r ~/.config/kitty "$SCRIPT_DIR/"
cp -r ~/.config/nvim "$SCRIPT_DIR/"
cp ~/.bashrc "$SCRIPT_DIR/bashrc"

# export packages
echo "==> Exporting packages..."
"$SCRIPT_DIR/pkg.sh" export

echo "==> Done!"
