#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# Quick Run Script
# Last Updated [03-03-2024]
# Designed to be curled and other scripts can be run from it from the repo

# Check if the script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# OS Check
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

# Install git using OS package manager (Debian based and RHEL Based only)
if [ "$OS" = "Debian GNU/Linux" ] || [ "$OS" = "Ubuntu" ]; then
    apt update && apt install -y git
elif [ "$OS" = "CentOS Linux" ] || [ "$OS" = "AlmaLinux" ] || ["$OS" = "Rocky Linux"]; then
    yum install -y git
else
    echo "OS not supported"
    exit 1 
fi

# Clone the repo to /opt
git clone https://github.com/ao554/harrilabstuff.git /opt/harrilabstuff

# Change directory to the repo
cd /opt/harrilabstuff

# Using OS Check, cd to the correct directory
if [ "$OS" = "Debian GNU/Linux" ] || [ "$OS" = "Ubuntu" ]; then
    cd debian
elif [ "$OS" = "CentOS Linux" ] || [ "$OS" = "AlmaLinux" ] || ["$OS" = "Rocky Linux"]; then
    cd rhel
else
    echo "OS not supported"
    exit 1
fi

# Run the script
bash 00-base-pkgs.sh

# Collect list of available scripts for dialog into a vairable
scripts=$(ls *.sh)

# Run dialog to give options to run other scripts
dialog --title "Select a script to run" \
--menu "Choose one of the following options:" 15 40 4 \
$scripts 2> /tmp/selection

# Run the selected script
bash $(cat /tmp/selection)

# If cancel is selected, exit
if [ $? -eq 1 ]; then
    echo "Scripts are located at /opt/harrilabstuff"    
    exit 1
fi

# Clean up
exit 0