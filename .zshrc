
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

if which tmux >/dev/null 2>&1; then
    test -z ${TMUX} && tmux

    #attatch to sessions that might exist on exit
    while test -z ${TMUX}; do
        tmux attatch || break
    done
fi

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

source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(thefuck --alias)

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

source ~/.profile
