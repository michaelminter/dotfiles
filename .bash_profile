# if [[ -f ~/.bashrc ]]; then
#   source ~/.bashrc
# fi

#############################################
# highlighted prompt
#############################################
# COLOR_RED="\033[0;31m"
# COLOR_YELLOW="\033[0;33m"
# COLOR_GREEN="\033[0;32m"
# COLOR_OCHRE="\033[38;5;95m"
# COLOR_BLUE="\033[0;34m"
# COLOR_WHITE="\033[0;37m"
# COLOR_RESET="\033[0m"
#
# function git_color {
#   local git_status="$(git status 2> /dev/null)"
#
#   if [[ ! $git_status =~ "working directory clean" ]]; then
#     echo -e $COLOR_BLUE
#   elif [[ $git_status =~ "Your branch is ahead of" ]]; then
#     echo -e $COLOR_YELLOW
#   elif [[ $git_status =~ "nothing to commit" ]]; then
#     echo -e $COLOR_GREEN
#   else
#     echo -e $COLOR_OCHRE
#   fi
# }
#
# function git_branch {
#   local git_status="$(git status 2> /dev/null)"
#   local on_branch="On branch ([^${IFS}]*)"
#   local on_commit="HEAD detached at ([^${IFS}]*)"
#
#   if [[ $git_status =~ $on_branch ]]; then
#     local branch=${BASH_REMATCH[1]}
#     echo "($branch)"
#   elif [[ $git_status =~ $on_commit ]]; then
#     local commit=${BASH_REMATCH[1]}
#     echo "($commit)"
#   fi
# }
#
# PS1="\[$COLOR_WHITE\]\n[\W]"          # basename of pwd
# PS1+="\[\$(git_color)\]"        # colors git status
# PS1+="\$(git_branch)"           # prints current branch
# PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
# export PS1
source ~/.bash-powerline.sh

#############################################
# Bash ls colors
#############################################
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

#############################################
# alias
#############################################
alias ll='ls -l'
alias la='ls -la'
alias ls='ls -G'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --colour=auto'

#############################################
# NVM - for managing versions of node
#############################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(/opt/homebrew/bin/brew shellenv)"

#############################################
# Bash Completion
#############################################
# [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"
export PATH="/opt/homebrew/opt/postgresql@10/bin:$PATH"
export PATH=$(pyenv root)/shims:$PATH

eval "$(direnv hook bash)"

alias postald='docker run -p 8080:8080 clicksend/libpostal-rest'
alias kpods='kubectl get pods -A'
alias klogs='kubectl logs -n '


kbash() {
  kubectl exec -it -n "$1" "$2" -- bash
}

kconsole() {
  kubectl exec -it -n "$1" "$2" -- bin/env console
}

kvars() {
  kubectl exec -it -n "$1" "$2" -- bin/env donothing
}

kroutes() {
  kubectl exec -it -n "$1" "$2" -- bin/env rake routes
}

export GITHUB_OAUTH_TOKEN=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

