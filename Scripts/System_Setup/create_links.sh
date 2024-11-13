#!/bin/bash

# Clone configuration repository
repo_url="https://github.com/Swipez1/Assignment2"
git clone "$repo_url" "$HOME/setup_files"

# Directories and files to link
links=(
  "bin:$HOME/bin"
  "config:$HOME/.config"
  "home/bashrc:$HOME/.bashrc"
)

# Create symbolic links
for link in "${links[@]}"; do
    src=$(echo "$link" | cut -d: -f1)
    dest=$(echo "$link" | cut -d: -f2)

    # Remove existing files/links to avoid conflicts
    [ -e "$dest" ] && rm -rf "$dest"

    echo "Linking $src to $dest"
    ln -s "$HOME/setup_files/$src" "$dest"
done