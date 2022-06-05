#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the root user or not.

# Display the UID built-in
echo "Your UID  is ${UID}"

# Display username
# USER_NAME=$(id -un)
# USER_NAME=`id -un`

USER_NAME=$(whoami)
echo "Your username is ${USER_NAME}"

# Display if the user is the root user or not
if [[ "${UID}" -eq 0 ]]
then
  echo 'Your are root'
else
  echo 'You are not root'
fi
