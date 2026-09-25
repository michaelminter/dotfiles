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
# path
#############################################
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
