#!/bin/bash

# Set PACKAGES to the packages to install
PACKAGES=("kakoune" "tmux")  # Initialize the array with default package names

# Process command-line options
# Start processing options with the -p flag
while getopts ":p:" opt; do  
    case $opt in
        # If -p is used, add package to the array
        p) PACKAGES+=("$OPTARG") ;;  
        # Handle invalid options
        ?) echo "Invalid option -$OPTARG"; exit 1 ;;  
    esac
done

# Update package list and install package

# Loop through all packages in the array
for package in "${PACKAGES[@]}"; do  
# Check if the package is not installed
  if ! pacman -Qi "$package" &>/dev/null; then  
    # Print installing message
    echo "Installing $package..."  
    # Install the package without confirmation
    sudo pacman -S --noconfirm "$package"  
  else
  # If already installed, print a message
    echo "$package is already installed."  
  fi
done
