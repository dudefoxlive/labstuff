#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# Debian ufw configuration
# Last Updated [03-03-2024]

# Check if the script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Check if `ufw` is installed
if ! [ -x "$(command -v ufw)" ]; then
  echo 'ufw is not installed. Installing...' >&2
  apt-get install -y ufw
fi

# Find SSH Port and set it as a variable
SSH_PORT=$(grep -oP '(?<=Port ).*' /etc/ssh/sshd_config)

# Allow SSH
ufw allow $SSH_PORT"/tcp"

# Enable ufw
ufw enable

# Check the status of ufw
ufw status

# Done
echo "ufw has been configured"
echo "SSH is allowed on port $SSH_PORT"
echo "Make sure to add your ports!"
