# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="simple"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'

bindkey -v

source ~/.config/secret/secret.sh

export XDG_CONFIG_HOME=~/.config

# CD setup
# aag Sun Jan 19 03:21:14 PM GMT 2025
cdf () {
    dir=$(find ~/Projects/ -maxdepth 2 -type d -not -path '*/.*' | sed 's/\/home\/aag\/Projects\///g' | fzf --tiebreak=end --height=10)
    cd "/home/aag/Projects/$dir"
}
cdroot () {
    gitroot=$(git rev-parse --show-toplevel)
    if [ ! -z $gitroot ]
    then
        cd $gitroot
    fi
}
alias cd-="cd -"
alias cdd="cd .."

# aag Sun Jan 19 03:35:07 PM GMT 2025
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
