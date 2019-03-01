# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/bin/:$HOME/.config/scripts/:$HOME/.config/scripts/bin/:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"
source $HOME/.TerminalTweaksARCH
export EDITOR='vim'
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(thefuck --alias)
