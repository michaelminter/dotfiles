source ~/.bash_powerline.sh

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

export BASH_SILENCE_DEPRECATION_WARNING=1

# For direnv to work properly it needs to be hooked into the shell.
# Make sure it appears even after rvm, git-prompt and other shell extensions that manipulate the prompt.
eval "$(direnv hook bash)"
