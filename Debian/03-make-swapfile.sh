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

# Check if `dialog` is installed
if ! [ -x "$(command -v dialog)" ]; then
  echo 'dialog is not installed. Installing...' >&2
  apt-get install -y dialog
fi

# Dialog for swapfile size (2, 4, 8, 16, 32, 64, 128)
dialog --title "Swapfile Size" --menu "Choose the size of the swapfile" 10 40 7 \
2 "2GB" \
4 "4GB" \
8 "8GB" \
16 "16GB" \
32 "32GB" \
64 "64GB" \
128 "128GB" 2> /tmp/swapfile_size

# Check the exit status of dialog
if [ $? -eq 0 ]; then
    # Get the swapfile size from the dialog
    SWAPFILE_SIZE=$(cat /tmp/swapfile_size)

    # Create the swapfile
    fallocate -l $SWAPFILE_SIZE /swapfile

    # Set the correct permissions
    chmod 600 /swapfile

    # Set up a Linux swap area
    mkswap /swapfile

    # Enable the swapfile
    swapon /swapfile

    # Add the swapfile to the /etc/fstab file
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
else
    # Exit the script if cancel was pressed
    echo "Cancel pressed, exiting."
    exit 0
fi

