#!/bin/bash

# Set default packages to install
PACKAGES=("kakoune" "tmux")
# Process command-line options
while getopts ":p:" opt; do
  case $opt in
    p) PACKAGES+=("$OPTARG") ;; # Add additional packages if -p flag is used
    \?) echo "Invalid option -$OPTARG"; exit 1 ;;
  esac
done

# Update package list and install packages
for package in "${PACKAGES[@]}"; do
  if ! pacman -Qi "$package" &>/dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm "$package"
  else
    echo "$package is already installed."
  fi
done