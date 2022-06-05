#!/bin/bash

# Improve script that adds users to the same linux system as the script is executed on.


# Enforce root user
if [[ "${UID}" -ne 0 ]]
then
  echo 'Must be run as root.'
  exit 1
fi

# Provide usage statement
# echo "USAGE: add-new-local-user USERNAME [COMMENT...]"
echo "USAGE: ${0}  USERNAME [COMMENT...]"

# If the user doesn't supply an account name on the CLI, return exit status 1
if [[ "${1}" -ne 0 ]]
then echo 'You must enter a username as the first argument'
  exit 1
fi

# Use first argument provided on the CLI as the USERNAME
USERNAME="${1}"
shift

# Any other arguments will be treated as COMMENT
COMMENT="${*}"

# Automatically generate a password for the account PASSWORD
PASSWORD=$(date +%s%N | sha256sum | head -c16)

# Inform the user if the account wasn't able to be created for some reason, return exit status 1
useradd -c "${COMMENT}" -m "${USERNAME}"

if [[ "${?}" -ne 0 ]]
then
  echo 'Error creating your account user, please try again.'
  exit 1
fi

echo ${PASSWORD} | passwd --stdin ${USERNAME}

if [[ "${?}" -ne 0 ]]
then
  echo 'Error setting your automatic password, please try again.'
  exit 1
fi

# Display username, password, and host where the account was created.
echo "Username: ${USERNAME}"
echo
echo "Password: ${PASSWORD}"
echo
echo "Host: ${HOSTNAME}"
echo
exit 0
