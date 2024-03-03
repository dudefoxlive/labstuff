#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# RedHat Based Base Packages
# Last Updated [03-03-2024]

# Check if the script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Check the OS version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

# Install the EPEL Repository
yum install -y epel-release

# Install RPM Fusion's Global Repository
yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm

# Install RPM Fusion's Non-Free Repository
yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-9.noarch.rpm

# Update and upgrade
yum update -y
yum upgrade -y

# Install base packages
yum install -y \
    sudo \
    curl \
    wget \
    nload \
    vnstat \
    net-tools \
    bind-utils \
    gcc \
    make \
    fail2ban \
    gnupg \
    iptables \
    python3 \
    python3-pip \
    axel \
    git \
    zsh \
    neofetch \
    htop \
    tmux \
    nano \
    unzip \
    zip \
    p7zip \
    unrar \
    bzip2 \
    ncdu

# Clean up
yum autoremove -y
yum clean all

# Done
echo "Base packages installed successfully"
echo "OS: $OS"