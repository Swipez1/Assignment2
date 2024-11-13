#!/bin/bash

# Clones the repository stored in $repo_url into local directory setup_files
repo_url="https://gitlab.com/cit2420/2420-as2-starting-files"
git clone "$repo_url" "$HOME/setup_files"

# Sets variable "links" to directories to mappings that specify source and destination paths, separated by colons
links=(
    # link bin to ~/bin
    "bin:$HOME/bin"
    # link config to ~/.config
    "config:$HOME/.config"
    # link home/bashrc to ~/.bashrc
    "home/bashrc:$HOME/.bashrc"
)

# Create symbolic links

# iterate over each item in the links array
for link in "${links[@]}"; do
    # print current link item, cut to split the string at the colon, setting src to the part before the colon
    src=$(echo "$link" | cut -d: -f1)
    # do the same, and set dest to the part after the colon
    dest=$(echo "$link" | cut -d: -f2)

    
# Removing existing files to avoid conflicts
# Test command to check if a file/directory exists with the name equalling contents of variable "dest"
    if [ -e "$dest" ]; then
# If a file/directory with this name exists, remove it
        rm -rf "$dest"
    fi

    echo "Linking $src to $dest"
    # Creates link from "$HOME/setup_files/$src" to "$dest"
    ln -s "$HOME/setup_files/$src" "$dest"
done