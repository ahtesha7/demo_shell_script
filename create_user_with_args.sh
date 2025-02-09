#!/bin/bash

echo "Creating User with Arguments!"

#arguments

read -p "Name of User :?"  arguser

sudo useradd -m "$arguser"

echo "Successfully created user"

echo "=======Deletion of user====="

sudo userdel aftab

echo "Deleted"

cat /etc/passwd | grep $arguser | wc
