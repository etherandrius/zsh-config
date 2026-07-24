# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode shrink-path)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# Alias {{{

alias vim="/opt/homebrew/bin/nvim"
alias neovim="/opt/homebrew/bin/nvim"

#add GOPATH
export GOPATH="$HOME/Projects/go"
# add go to PATH
export PATH="$PATH:$GOPATH/bin"
# add ruby to PATH
# export PATH="/usr/local/opt/ruby/bin:$PATH"
# export PATH="/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
# export PATH="/usr/local/opt/go@1.14/bin:$PATH"
export PATH="$PATH:/usr/local/opt"
export PATH="$PATH:/Applications/Windsurf.app/Contents/Resources/app/bin"
# export PATH="/usr/local/Cellar:$PATH"
#eval "$(rbenv init -)"

# export JAVA_HOME="/opt/homebrew/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home"
# export JAVA_HOME=`/usr/libexec/java_home -v 19`
# export JAVA_HOME="/opt/homebrew/Cellar/openjdk@21/21.0.4/libexec/openjdk.jdk/Contents/Home"
export JAVA_HOME="/opt/homebrew/Cellar/openjdk@21/21.0.5/libexec/openjdk.jdk/Contents/Home"
# export JAVA_HOME="/opt/homebrew/opt/openjdk@25/"
# export JAVA_HOME="/opt/homebrew/Cellar/openjdk@17/17.0.7/libexec/openjdk.jdk/Contents/Home"
# export JAVA_HOME="/opt/homebrew/Cellar/openjdk@17/17.0.6/libexec/openjdk.jdk/Contents/Home"


export PATH="$JAVA_HOME/bin:$PATH"

export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# export paths
export P=~/Projects
export D=~/Projects/go/src/github.palantir.build/deployability

# bat
alias bat='bat --theme=GitHub'

# ./godelw alias
alias gow='./godelw'
# ./gradlew alias
alias grw='./gradlew'

# git
alias gits='git s'
alias gita='git a'
alias gitd='git d'
alias gitc='git c'
alias gitp='git p'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls -CF'

# }}}
# {{{ My Funcs

qload() {
    uqc load $1 | tee /dev/tty | pbcopy
}
qsave() {
    uqc save $1
}

alert() {
    osascript -e 'display notification "alert"'
}

cdfold () {
	if [ -z $1 ]
	then
		dir=$(find $P/java/foundry -maxdepth 1 -type d | sed 's/\/Users\/agrabauskas\/Projects\/java\///g' | fzf --tiebreak=end --height=10)
        dir="/Users/agrabauskas/Projects/java/$dir"
		if [ ! -z $dir ]
		then
			cd $dir
		fi
	elif [[ $1 == "ua" ]]
	then
		cd /Users/agrabauskas/Projects/java/foundry/usage-aggregator
	elif [[ $1 == "fit" ]]
	then
		cd /Users/agrabauskas/Projects/java/foundry/foundry-internal-tables
	elif [[ $1 == "rpm" ]]
	then
		cd /Users/agrabauskas/Projects/java/foundry/resource-policy-manager
	elif [[ $1 == "rmp" ]]
	then
		cd /Users/agrabauskas/Projects/java/foundry/resource-policy-manager
	elif [[ $1 == "sr" ]]
	then
		cd /Users/agrabauskas/Projects/java/foundry/spark-reporter
	fi
}

cdff () {
    dir=$((find $FEATURES_DIR -maxdepth 2 -type d) | sed "s#$FEATURES_DIR##g" | fzf --tiebreak=end --height=10)
    rcode=$?
    dir="$FEATURES_DIR/$dir"
    if [[ $rcode -eq 0 ]]
    then
        cd $dir
    fi
}

cdf () {
    local deep=(vscode-team features foundry-stemma-repos)
    dir=$((
            for d in "$PROJECT_DIR"/*(/N); do
                if (( ${deep[(Ie)${d:t}]} )); then
                    find "$d" -maxdepth 1 -type d
                else
                    echo "$d"
                fi
            done
            echo "$PROJECT_DIR/vscode-team/foundry-mcp/@palantir/mcp"
        ) | sed "s#$PROJECT_DIR##g" | fzf --tiebreak=end --height=10)
    rcode=$?
    dir="$PROJECT_DIR/$dir"
    if [[ $rcode -eq 0 ]]
    then
        cd $dir
    fi
}

# }}}

source ~/.cargo/env

export NVM_DIR="$HOME/.nvm"
nvm() {
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  nvm $@
}



# vim: set foldmethod=marker: set foldlevel=1

# pnpm
export PNPM_HOME="/Users/agrabauskas/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# # Wrap codex to invoke claude tracker register/unregister
# codex() {
#     ~/.config/tmux/plugins/claude_tracker/bin/claude-tracker register
#     ~/.config/tmux/plugins/claude_tracker/bin/claude-tracker processing
#     local exit_code
#     command codex "$@"
#     exit_code=$?
#     ~/.config/tmux/plugins/claude_tracker/bin/claude-tracker unregister
#     return $exit_code
# }
