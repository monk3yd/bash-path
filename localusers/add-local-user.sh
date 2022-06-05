#!/bin/bash

# Adds users to same Linux system as the script is executed on.

# Enforce run with root privileges, else (status code 1)
if [[ "${UID}" -ne 0 ]]
then
  echo "Please run script as root"
  exit 1
fi

# Prompt to enter username (login)
read -p "Please enter your account username (login): " USER_NAME

# Prompt to enter name of person who will be use the account (comment)
read -p "Please enter your name: " COMMENT

# Prompt for initial passwd of account
read -p "Please enter your temp password: " PASSWORD

# Create new user with collected inputs
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check for error when creating a user
if [[ "${?}" -ne 0 ]]
then
  echo 'Account could NOT be created, please try again'
  exit 1
fi

# Set temp password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check for error when creating a password
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set'
  exit 1
fi

# Force password change on first login
passwd -e ${USER_NAME}

# Display username, password, and host where the account was created.
echo "Username: ${USER_NAME}, Password: ${PASSWORD}, Host: ${HOSTNAME}"
exit 0
