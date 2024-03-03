#!/bin/bash

# ██   ██  █████  ██████  ██████  ██     ██     ██  ██████  ███████     ██   ██ ███████ ██████  ███████ 
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██     ██ ██    ██    ███      ██   ██ ██      ██   ██ ██      
# ███████ ███████ ██████  ██████  ██     ██  █  ██ ██    ██   ███       ███████ █████   ██████  █████   
# ██   ██ ██   ██ ██   ██ ██   ██ ██     ██ ███ ██ ██    ██  ███        ██   ██ ██      ██   ██ ██      
# ██   ██ ██   ██ ██   ██ ██   ██ ██      ███ ███   ██████  ███████     ██   ██ ███████ ██   ██ ███████ 
                                                                                                      
# Debian user zsh configuration
# Last Updated [03-03-2024]

# Check if zsh package is installed
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Error: zsh is not installed.' >&2
  exit 1
fi

# Automated installation of oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Set zsh as the default shell
chsh -s $(which zsh)

# Set kphoen as the default theme
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="kphoen"/g' ~/.zshrc

# Backup original copy of kphoen
cp ~/.oh-my-zsh/themes/kphoen.zsh-theme ~/.oh-my-zsh/themes/kphoen.zsh-theme.bak

# rm original kphoen
rm ~/.oh-my-zsh/themes/kphoen.zsh-theme

# Copy new kphoen from /opt/harrilabstuff/configs/zsh/kphoen.zsh-theme
cp /opt/harrilabstuff/configs/zsh/kphoen.zsh-theme ~/.oh-my-zsh/themes/kphoen.zsh-theme

# Add profile.d call to .zshrc
echo "for file in /etc/profile.d/*.sh; do" >> ~/.zshrc
echo "  source \$file" >> ~/.zshrc
echo "done" >> ~/.zshrc

# Done
echo "ZSH Configuration Complete"
