#!/bin/bash

# ===============================
# User Management Script
# ===============================

while true; do
echo "=============================="
echo "User Management Script"
echo "=============================="
echo "1) Create User"
echo "2) Modify User"
echo "3) Delete User"
echo "4) Set User Password"
echo "5) Add SSH Key to User"
echo "6) Exit"
echo "=============================="

read -p "Enter your choice [1-6]: " choice

case $choice in

1)
    read -p "Enter username to create: " username
    sudo adduser "$username"
    echo "User $username created successfully."
    ;;

2)
    read -p "Enter username to modify: " username

    echo "Select what to modify:"
    echo "1) Lock account"
    echo "2) Unlock account"
    read -p "Enter option [1-2]: " mod_choice

    case $mod_choice in
        1)
            sudo usermod -L "$username"
            echo "User $username locked."
            ;;
        2)
            sudo usermod -U "$username"
            echo "User $username unlocked."
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    ;;

3)
    read -p "Enter username to delete: " username
    sudo deluser --remove-home "$username"
    echo "User $username deleted along with home directory."
    ;;

4)
    read -p "Enter username to set password: " username
    sudo passwd "$username"
    ;;

5)
    read -p "Enter username to add SSH key: " username
    read -p "Enter SSH public key: " ssh_key

    sudo mkdir -p /home/"$username"/.ssh
    echo "$ssh_key" | sudo tee -a /home/"$username"/.ssh/authorized_keys > /dev/null

    sudo chown -R "$username":"$username" /home/"$username"/.ssh
    sudo chmod 700 /home/"$username"/.ssh
    sudo chmod 600 /home/"$username"/.ssh/authorized_keys

    echo "SSH key added for $username."
    ;;

6)
    echo "Exiting..."
    exit 0
    ;;

*)
    echo "Invalid choice."
    ;;
esac

done

