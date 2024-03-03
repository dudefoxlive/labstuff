#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# Debian fail2ban configuration
# Last Updated [03-03-2024]

# Check if the script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Install fail2ban
apt install -y fail2ban

# Backup the original jail.local file
cp /etc/fail2ban/jail.local /etc/fail2ban/jail.local.bak

# Set the SSH port to 82
sed -i 's/port    = ssh/port    = 82/g' /etc/fail2ban/jail.local

# Send the fail2ban Logs to a file in /var/log
sed -i 's/logpath  = %(sshd_log)s/logpath  = /var/log/fail2ban.log/g' /etc/fail2ban/jail.local

# Restart the fail2ban service
systemctl restart fail2ban

# Print the fail2ban status
systemctl status fail2ban

# Done
echo "fail2ban Configuration Complete"