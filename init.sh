#!/bin/bash

# Install Packages
sudo pacman -Syyu tmux git zsh awesome neovim ranger rxvt-unicode feh w3m fzf fasd rofi wget 

#Install ZSH
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Symlink files
(cd $HOME; ln -s $HOME/.config/.zshrc)
(cd $HOME; ln -s $HOME/.config/.TerminalTweaksARCH)
(cd $HOME; ln -s $HOME/.config/.profile)
(cd $HOME; ln -s $HOME/.config/.tmuxline-snapshot)
(cd $HOME; ln -s $HOME/.config/scripts/bin)

# Misc

