#!/bin/bash

# Variables
shell="/bin/bash"
groups=""
homedir=""
username=""

# Parsing command-line options
while getopts ":s:g:d:u:" opt; do
  case $opt in
    s) 
    shell="$OPTARG" 
    ;;

    g) 
    groups="$OPTARG" 
    ;;

    d) 
    homedir="$OPTARG" 
    ;;

    u) 
    username="$OPTARG" 
    ;;

    \?) echo "Invalid option -$OPTARG"; exit 1 ;;
  esac
done

# Check if username was provided
if [ -z "$username" ]; then
  echo "Username is required. Use -u [username]"
  exit 1
fi

# Check if home directory is empty, sets it to the correct value if it is
[ -z "$homedir" ] && homedir="/home/$username"

# Create the new user with specified home directory and shell
echo "Creating user: $username"
sudo useradd -m -d "$homedir" -s "$shell" -G "$groups" "$username"

# Set up /etc/skel contents
echo "Copying /etc/skel to $homedir'
sudo cp -r /etc/skel/. "$homedir"
sudo chown -R "$username":"$username" "$homedir"

# Set primary group to match the username
sudo usermod -g "$username" "$username"

# Set password for the new user
echo "Set a password for $username:"
sudo passwd "$username"

echo "User $username created successfully with shell $shell and home directory $homedir."