#!/bin/bash

# Function to display help information
show_help() {
  echo "Usage: $0 [option] [arguments]"
  echo
  echo "Options:"
  echo "  -c, --create        Create a new user account"
  echo "  -d, --delete        Delete an existing user account"
  echo "  -r, --reset         Reset a user's password"
  echo "  -l, --list          List all user accounts"
  echo "  -h, --help          Show this help message"
}

# Function to create a new user
create_user() {
  echo "Enter the username for the new account:"
  read username
  if id "$username" &>/dev/null; then
    echo "Error: The username '$username' already exists."
    exit 1
  fi

  echo "Enter password for $username:"
  read -s password
  if [ -z "$password" ]; then
    echo "Password cannot be empty!"
    exit 1
  fi

  useradd -m "$username" && echo "$username:$password" | chpasswd
  if [ $? -eq 0 ]; then
    echo "User '$username' created successfully."
  else
    echo "Failed to create user '$username'."
    exit 1
  fi
}

# Function to delete a user
delete_user() {
  echo "Enter the username to delete:"
  read username
  if ! id "$username" &>/dev/null; then
    echo "Error: The user '$username' does not exist."
    exit 1
  fi

  userdel -r "$username"
  if [ $? -eq 0 ]; then
    echo "User '$username' deleted successfully."
  else
    echo "Failed to delete user '$username'."
    exit 1
  fi
}

# Function to reset a user's password
reset_password() {
  echo "Enter the username for password reset:"
  read username
  if ! id "$username" &>/dev/null; then
    echo "Error: The user '$username' does not exist."
    exit 1
  fi

  echo "Enter the new password for $username:"
  read -s password
  if [ -z "$password" ]; then
    echo "Password cannot be empty!"
    exit 1
  fi

  echo "$username:$password" | chpasswd
  if [ $? -eq 0 ]; then
    echo "Password for '$username' has been reset successfully."
  else
    echo "Failed to reset the password for '$username'."
    exit 1
  fi
}

# Function to list all user accounts
list_users() {
  echo "List of all user accounts on the system:"
  cut -d: -f1 /etc/passwd
}

# Main logic to handle arguments
if [ $# -eq 0 ]; then
  show_help
  exit 1
fi

case "$1" in
  -c|--create)
    create_user
    ;;
  -d|--delete)
    delete_user
    ;;
  -r|--reset)
    reset_password
    ;;
  -l|--list)
    list_users
    ;;
  -h|--help)
    show_help
    ;;
  *)
    echo "Invalid option!"
    show_help
    exit 1
    ;;
esac

