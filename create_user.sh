#!/bin/bash

# Script should be executed with sudo/root user.
if [[ "${UID}" -ne 0 ]]
then
        echo 'Please run with sudo or root user.'
        exit 1
fi

# User should provide at least one argument as a username else guide them

if [[ "${#}" -lt 1 ]]
then
        echo "Usage: ${0} USER_NAME [COMMENT]..."
        echo 'Create a user with name USER_NAME and comments field of COMMENT'
        exit 1
fi

# Store 1st argument as the username

USER_NAME="${1}"
echo $USER_NAME

# In case of more than one argument, store it as account comments
shift
COMMENT="${@}"
echo $COMMENT

# Create password
PASSWORD=$(date +%s%N)
echo $PASSWORD

# Create the user
useradd -c "$COMMENT" -m $USER_NAME

# Check if the user is successfully created or not
if [[ $? -ne 0 ]]
then 
        echo 'The Account could not be created'
        exit 1
fi

# Set the password for the user using chpasswd
echo "$USER_NAME:$PASSWORD" | chpasswd

# Check if the password is successfully set or not
if [[ $? -ne 0 ]]
then
        echo 'Password could not be set'
        exit 1
fi

# Force password change on first login
passwd -e $USER_NAME

# Display the username, password, and the host where the user was created.
echo
echo "Username: $USER_NAME"
echo
echo "Password: $PASSWORD"
echo
echo "Hostname $(hostname)"
