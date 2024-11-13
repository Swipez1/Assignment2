#!/bin/bash

# Creates variables for arguments to create new user
# New user's shell (default is "/bin/bash")
shell="/bin/bash"
# Group the new user will be in
groups=""
# New user's home directory
homedir=""
# New user's username
username=""

# Parses through the arguments provided by user
while getopts ":s:g:d:u:" opt; do
# Checks the provided arguments, s, g, d, and u for shell, group, home directory, and username
    case $opt in
        s) 
        # positional argument case s
        shell="$OPTARG" 
        ;;

        g) 
        # positional argument case g
        groups="$OPTARG" 
        ;;

        d) 
        # positional argument case d
        homedir="$OPTARG" 
        ;;

        u) 
        # positional argument case u
        username="$OPTARG" 
        ;;

        # in case of invalid option, exit with code 1, relaying "Invalid option -[option specified]""
        ?) 
        echo "Invalid option -$OPTARG"
        exit 1 
        ;;
    esac
done

# Check if username provided was empty, exists with an error message in that case
if [ -z "$username" ]; then
    echo "Username is required. Use -u [username]"
    exit 1
fi

# Checks if homedirectory provided was empty, sets to default in that case
if [ -z "$homedir" ]; then
    homedir="/home/$username"
fi

# Create the new user, using the previously acquired options the user provided
echo "Creating user: $username"
sudo useradd -m -d "$homedir" -s "$shell" -G "$groups" "$username"

# Copies default skel files from /etc/skel to the new user's home directory
echo "Copying /etc/skel to $homedir"
sudo cp -r /etc/skel/. "$homedir"
# Sets ownership of the home directory to the new user using chown
sudo chown -R "$username":"$username" "$homedir"

# Sets primary group to match the username for access control consistency
sudo usermod -g "$username" "$username"

# Prompts to set a password for the new user
echo "Set a password for $username:"
sudo passwd "$username"

# Prints a confirmation message with user details
echo "User $username created successfully with shell $shell and home directory $homedir."