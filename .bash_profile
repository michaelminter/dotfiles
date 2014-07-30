#############################################
# RVM - for managing versions of ruby
#############################################

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#############################################
# GIT completions & highlighted prompt 
#############################################

# Changes PS1
# export PS1='\[\033[00;35m\]\w\[\033[00m\]\[\033[01;33m\]`git branch 2>/dev/null|cut -f2 -d\* -s`\[\033[00m\]\$ '
# Git status bash prompt
#
# In addition to printing the current working directory, this prompt will 
# show a number of things if you are in a git repository:
# - The current branch you are in
# - Whether there are untracked files in the repository (there will be an 
#   asterisk after the branch nome if there are)
# - Whether there are any unmerged/unstaged/staged changes or if the directory
#   is clean. See below for the colors that will be used, and change them if 
#   you'd like.

# Storing these color codes for later use
txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan

# Set color for the directory listing in the prompt
dir_listing_color=$txtpur

# Set colors for different repository states
unmerged_color=$bldpur
unstaged_color=$bldred
staged_color=$bldcyn
clean_color=$bldblu

function git_color {
  git_status=`git status 2> /dev/null`
  
  if [ -n "`echo $git_status | grep "# Unmerged paths:"`" ]; then
    echo -e $unmerged_color
  elif [ -n "`echo $git_status | grep "# Changes not staged for commit:"`" ]; then
    echo -e $unstaged_color
  elif [ -n "`echo $git_status | grep "# Changes to be committed:"`" ]; then
    echo -e $staged_color
  else
    echo -e $clean_color
  fi
}

function git_branch {
  git_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ -n  "`git status 2> /dev/null | grep "# Untracked files:"`" ]; then
    untracked="*"
  fi
  if [ "`expr "$git_branch" : '.*'`" -gt "0" ]; then 
    echo " "$git_branch$untracked
  fi
}

PS1='\[`echo -e $dir_listing_color`\]\w\[`git_color`\]`git_branch`\[\e[0m\]$ '
PS2="> "

#############################################
# Bash ls colors
#############################################

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad


#############################################
# aliases
#############################################

alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -la'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --colour=auto'
alias e="gem env gemdir"
alias be='bundle exec'
alias h='cat ~/.ssh/config'
alias r='cd /Users/michaelminter/Google\ Drive/Repos'
alias mongod='sudo mongod --fork --logpath=/Users/michaelminter/Library/Logs/mongo.log --logappend'

########
## git

source ~/git-completion.bash

alias g='git status'
alias gg='git log'
alias gst='git status'

alias gb='git branch'
alias gba='git branch -a'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gce="git commit --amend" # fix last commit message
alias gco='git checkout'

alias gd='git diff | bbedit'
alias gdm='git diff master'

alias gl='git pull'
alias gp='git push'

alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

alias gs='git-sweep preview'

# SET NEW LOOKUP PATHS
export PATH=${PATH}:/Applications/mmonit-3.2/bin

# define base directory for cd command
export CDPATH=$CDPATH:/Users/michaelminter/Google\ Drive/Repos

# add bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

