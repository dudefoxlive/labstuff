#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# Debian SSH Configuration
# Last Updated [03-03-2024]

# Check if the script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Install OpenSSH Server
apt install -y openssh-server

# Backup the original sshd_config file
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Set the SSH port to 82
# sed -i 's/#Port 22/Port 82/g' /etc/ssh/sshd_config

# set root login to prohibit-password
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config

# Enable Keys
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

# Disable password authentication
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Restart the SSH service
systemctl restart ssh

# Print the SSH status
systemctl status ssh

# Done
echo "SSH Configuration Complete"
#echo "SSH Port: 82"
echo "Root Login: Prohibit Password / Key login only!"
echo "Password Authentication: Disabled"
echo "Keys: Enabled"
echo "Please make sure to open the port 82 in your firewall"
echo "Please make sure to add your public key to the authorized_keys file"
