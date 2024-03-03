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

# If Repository is already cloned, pull the latest
if [ -d /opt/harrilabstuff ]; then
    cd /opt/harrilabstuff
    git pull
fi

# Change directory to the repo
cd /opt/harrilabstuff

# Using OS Check, cd to the correct directory
if [ "$OS" = "Debian GNU/Linux" ] || [ "$OS" = "Ubuntu" ]; then
    cd Debian
elif [ "$OS" = "CentOS Linux" ] || [ "$OS" = "AlmaLinux" ] || ["$OS" = "Rocky Linux"]; then
    cd RHEL
else
    echo "OS not supported"
    exit 1
fi

# Collect list of available scripts for dialog into an array
scripts=(*.sh)

# Create a menu items array
menu_items=()
for i in "${!scripts[@]}"; do
  menu_items+=("$i" "${scripts[$i]}")
done

# Run dialog to give options to run other scripts
dialog --title "Select a script to run" \
--menu "Choose one of the following options:" 15 40 4 \
"${menu_items[@]}" 2> /tmp/selection

# Run the selected script
bash "${scripts[$(cat /tmp/selection)]}"

# If cancel is selected, exit
if [ $? -eq 1 ]; then
    echo "Scripts are located at /opt/harrilabstuff"    
    exit 1
fi

# Clean up
exit 0