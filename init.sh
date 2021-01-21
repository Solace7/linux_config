#!/bin/bash

# Install Packages
sudo pacman -Syu tmux git zsh awesome neovim ranger rxvt-unicode feh w3m fzf fasd rofi wget 

if [[ ! $(which zsh) ]]; then
	printf "ZSH Not installed\n"
	sudo pacman -Syu zsh
fi

#Install ZSH
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Symlink files
printf "Symlinking files...\n"
(cd $HOME; ln -s $HOME/.config/.zshrc)
(cd $HOME; ln -s $HOME/.config/.TerminalTweaksARCH)
(cd $HOME; ln -s $HOME/.config/.profile)
(cd $HOME; ln -s $HOME/.config/.tmuxline-snapshot)
(cd $HOME; ln -s $HOME/.config/scripts/bin)
printf "...done\n"
# Misc
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PluginInstall

