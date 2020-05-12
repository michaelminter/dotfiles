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

function rvm_ruby_version {
  # if [[ "$PWD" =~ Repositories ]]; then
    # GEM_HOME split on @, 2nd part is gemset
    local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')

    # Put @ before it again, unless its blank
    [ "$gemset" != "" ] && gemset="@$gemset"

    # MY_RUBY_HOME split on -, 2nd part is version
    local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')

    # Combine and display
    local full="$version$gemset"
    [ "$full" != "" ] && echo "$full"
  # fi
}

rvm_prompt() {
  if [[ "$PWD" =~ Repositories ]]; then
    echo " "`$HOME/.rvm/bin/rvm-prompt v g`
  fi
}

PS1='\[`echo -e $dir_listing_color`\]\w\[`echo -e $txtred`\]\[`rvm_prompt`\]\[`git_color`\]`git_branch`\[\e[0m\]$ '
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

#############################################
# git
#############################################

source ~/.git-completion.bash

alias grecent='git for-each-ref --sort=-committerdate refs/heads --format "%(HEAD) %(committerdate:relative);%(refname:short);%(objectname:short);%(authorname)" | grep -v ";HEAD$" | column -s ";" -t'

#############################################
# lookup paths
#############################################

export PATH=$PATH:/Users/michaelminter/bin

#############################################
# base directories
#############################################

export CDPATH=$CDPATH:/Users/mminter/Repositories

#############################################
# extra
#############################################

# add bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f `brew --prefix`/etc/bash_completion.d/rails.bash ]; then
  source `brew --prefix`/etc/bash_completion.d/rails.bash
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

export PATH="/usr/local/sbin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
