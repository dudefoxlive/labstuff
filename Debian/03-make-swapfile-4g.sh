#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# Debian swapfile installation
# Last Updated [03-03-2024]

# Check if the script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "By default this Swapfile will be 4GB in size"

# Create a 4GB swapfile
fallocate -l 4G /swapfile

# Set the correct permissions
chmod 600 /swapfile

# Set the swapfile as a swap area
mkswap /swapfile

# Enable the swapfile
swapon /swapfile

# Add the swapfile to the fstab file
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Done
echo "Swapfile Configuration Complete"
echo "Swapfile Size: 4GB"
echo "Swapfile Location: /swapfile"
echo "Swapfile Enabled: Yes"
