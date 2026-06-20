#!/bin/bash

pacman_succ=0
pacman_fail=0
aur_succ=0
aur_fail=0

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PACMAN_TXT="$ROOT_DIR/Packages/pkg-pacman.txt"
AUR_TXT="$ROOT_DIR/Packages/pkg-aur.txt"
FAILED_TXT="$ROOT_DIR/Packages/pkg-failed.txt"

export_packages() {
  echo "==> Exporting package list..."
  # exclude debug pkg
  comm -23 <(pacman -Qeq | sort) <(pacman -Qmq | sort) | grep -v '\-debug$' >"$PACMAN_TXT"
  pacman -Qmq | grep -v '\-debug$' >"$AUR_TXT"
  echo "# Exported on $(date +%Y-%m-%d_%H:%M)" >>"$PACMAN_TXT"
  echo "# Exported on $(date +%Y-%m-%d_%H:%M)" >>"$AUR_TXT"
  echo "    -> exported to 'Packages/pkg-pacman.txt'"
  echo "    -> exported to 'Packages/pkg-aur.txt'"
  echo "==> Export done!"
}

install_packages() {
  # pre-flight checks
  if [ ! -f "$PACMAN_TXT" ] || [ ! -f "$AUR_TXT" ]; then
    echo "==> Error: package list not found, run './pkg.sh export' first!"
    exit 1
  fi

  if ! command -v yay &>/dev/null; then
    echo "==> Error: yay not found, please install yay first!"
    exit 1
  fi

  # cache sudo
  sudo -v

  # update system first
  echo "==> Updating system..."
  sudo pacman -Syu --noconfirm

  # clear previous failed log
  >"$FAILED_TXT"

  echo ""
  echo "==> Installing pacman packages..."
  while IFS= read -r pkg; do
    [[ "$pkg" =~ ^#|^$ ]] && continue
    echo "    -> installing $pkg..."
    if sudo pacman -S --needed --noconfirm "$pkg"; then
      ((pacman_succ++))
    else
      ((pacman_fail++))
      echo "[pacman] $pkg" >>"$FAILED_TXT"
    fi
  done <"$PACMAN_TXT"

  echo ""
  echo "==> Installing AUR packages..."
  while IFS= read -r pkg; do
    [[ "$pkg" =~ ^#|^$ ]] && continue
    echo "    -> installing $pkg..."
    if yay -S --needed --noconfirm "$pkg"; then
      ((aur_succ++))
    else
      ((aur_fail++))
      echo "[aur] $pkg" >>"$FAILED_TXT"
    fi
  done <"$AUR_TXT"

  echo ""
  echo "==> Packages installed!"
  echo "    pacman : $pacman_succ success, $pacman_fail failed"
  echo "    aur    : $aur_succ success, $aur_fail failed"
  echo "    total  : $((pacman_succ + aur_succ)) success, $((pacman_fail + aur_fail)) failed"

  if [ -s "$FAILED_TXT" ]; then
    echo ""
    echo "==> Failed packages logged to 'Packages/pkg-failed.txt'"
    echo "# Logged on $(date +%Y-%m-%d_%H:%M)" >>"$FAILED_TXT"
    cat "$FAILED_TXT"
  fi
}

case "$1" in
export)
  export_packages
  ;;
install)
  install_packages
  ;;
*)
  echo "Usage: ./pkg.sh [export|install]"
  echo "    export  - export current packages to txt files"
  echo "    install - install or update packages from txt files"
  ;;
esac
