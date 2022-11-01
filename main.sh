#!/usr/bin/env bash

source ./utils.sh

main() {
  # Cloning Dotfiles repository for install_packages_with_brewfile
  # to have access to Brewfile

  # First things first, asking for sudo credentials
  ask_for_sudo

  # Set default shell to bash
  set_bash

  # Set up profile
  install_bash_profile

  # Install gitconfig
  install_gitconfig

  # Install gitignore
  install_gitignore

  # Configure git
  configure_git

  install_vimrc

  # Create ssh keys
  generate_ssh_key

  # Install Homebrew
  install_homebrew

  # Install applications from Brewfile
  install_packages_with_brewfile

  # Install Ruby Version Manager and Ruby
  install_rvm

  # Install Node Version Manager and Node
  install_nvm
}

set_bash() {
  e_header "Setting default shell to bash..."
  if chsh -s /bin/bash; then
    success "Default shell set to bash."
  else
    error "Default shell not set to bash."
  fi
}

install_bash_profile() {
	e_header "Updating bash_profile..."
  if [ -f "$HOME/.bash_profile" ]; then
    e_arrow "bash_profile already exists."
  else
    cp ./bash_profile.sh $HOME/.bash_profile
    source ~/.bash_profile
    success "bash_profile installation succeeded."
  fi
}

install_gitconfig() {
	e_header "Installing gitconfig..."
  if [ -f "$HOME/.gitconfig" ]; then
    e_arrow "gitconfig already exists."
  else
    cp ./gitconfig $HOME/.gitconfig
    source ~/.gitconfig
    success "gitconfig install successful."
  fi
}

install_gitignore() {
	e_header "Installing gitignore..."
  if [ -f "$HOME/.gitignore" ]; then
    e_arrow "gitignore already exists."
  else
    cp ./.gitignore $HOME/.gitignore
    source ~/.gitignore
    success "gitignore install successful."
  fi
}

configure_git() {
  e_header "Configuring git..."
  if git config --global user.email "$GITHUB_EMAIL" && \
     git config --global user.name "$GITHUB_NAME"; then
       success "git configuration succeeded."
  else
     error "git configuration failed."
  fi
}

install_vimrc() {
	e_header "Installing vimrc..."
  if [ -f "$HOME/.vimrc" ]; then
    e_arrow "vimrc already exists."
  else
    cp ./vimrc $HOME/.vimrc
    source ~/.vimrc
    success "vimrc install successful."
  fi   
}

generate_ssh_key() {
  e_header "Generating SSH key..."
  if [ -f "$HOME/.ssh/id_rsa" ]; then
    e_arrow "SSH key already exists."
  else
    # add prompt for password maybe?
    ssh-keygen -t rsa -N "" -C "$GITHUB_EMAIL" -f $HOME/.ssh/id_rsa

    # Start agent in background
    eval "$(ssh-agent -s)"

    # # If OSX 10.12+
    echo "Host *
     AddKeysToAgent yes
     UseKeychain yes
     IdentityFile $HOME/.ssh/id_rsa
    " >> $HOME/.ssh/config
  fi

  e_note "Add the following SSH key to your GitHub account:"
  printf "%s\n" "$(< $HOME/.ssh/id_rsa.pub)"
}

install_homebrew() {
  e_header "Installing Homebrew..."
  if type_exists 'brew'; then
    success "Homebrew already exists."
  else
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
      success "Homebrew installation succeeded."
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.bash_profile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      error "Homebrew installation failed."
      exit 1
    fi
  fi
}

install_packages_with_brewfile() {
  e_header "Installing packages within ./Brewfile..."
  if brew bundle --file=./Brewfile; then
    success "Brewfile installation succeeded."
  else
    error "Brewfile installation failed."
    exit 1
  fi
}

install_rvm() {
    e_header "Installing rvm, ruby..."
    source $HOME/.bash_profile

    if ! type_exists 'rvm'; then
      # install gpg
      gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

      # Install RVM
      curl -sSL https://get.rvm.io | bash

      source ~/.rvm/scripts/rvm
      source ~/.bash_profile
    else
       e_arrow "Nothing to install. You've already got them all."
    fi

    # install current used version of Ruby
    rvm install 3.0.4 --default
}

install_nvm() {
    e_header "Installing nvm, node, npm..."
    source $HOME/.bash_profile

    if ! type_exists 'nvm'; then
      # Install NVM
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
      
	    source ~/.bashrc 
      source ~/.bash_profile

      # install current used version of Node
      nvm install 16.13.1

      # set default Node version
      nvm alias default 16.13.1

      # update npm
      npm install -g npm@latest      
    else
       e_arrow "Nothing to install. You've already got them all."
    fi
}

main "$@"