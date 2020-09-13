
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=true
export ZSH_TMUX_AUTOCONNECT=false

ZSH_THEME="af-magic"
#ZSH_THEME="gnzh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git tmux
)

source $ZSH/oh-my-zsh.sh

# User configuration


if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

source ~/.profile

unalias grv
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
