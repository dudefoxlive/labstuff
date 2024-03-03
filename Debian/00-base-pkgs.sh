#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# Debian Base Packages
# Last Updated [03-03-2024]

# Check if the script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Configure Global Locales to en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# Update and upgrade
apt update && apt upgrade -y

# Install base packages
apt install -y \
    sudo \
    curl \
    wget \
    nload \
    vnstat \
    net-tools \
    dnsutils \
    build-essential \
    fail2ban \
    gnupg \
    locales-all \
    iptables \
    python3 \
    python3-pip \
    axel \
    bpytop \
    git \
    zsh \
    neofetch \
    htop \
    tmux \
    tmate \
    nano \
    unzip \
    zip \
    p7zip-full \
    bzip2 \
    ncdu \
    dialog\
    ruby

# Clean up
apt autoremove -y
apt autoclean -y
apt clean -y

# Done
echo "Base packages installed successfully"
