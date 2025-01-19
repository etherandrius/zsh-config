# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode shrink-path git-prompt)

source $ZSH/oh-my-zsh.sh

# User configuration
#

INSERT_MODE_INDICATOR="%{$fg[magenta]%}❯%{$reset_color%}%{$fg[blue]%}❯❯%{$reset_color%} "
MODE_INDICATOR="%{$fg[blue]%}❮❮%{$reset_color%}%{$fg[magenta]%}❮%{$reset_color%} "

PROMPT="%B\$(shrink_path -l -t) \$(vi_mode_prompt_info)"

RPROMPT='%(?..☹ %?) %{$fg_bold[blue]%}$(git_prompt_info) $(git_prompt_status)%{$reset_color%} [%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_CACHE="anyvaluetoenable"
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[blue]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[blue]%}✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[blue]%}🠞"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[blue]%}═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%}⎵"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[red]%}⬇ "
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}⬆ "

export EDITOR='nvim'

# No need to press enter twice when auto-completing
bindkey -M menuselect '^M' .accept-line

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
