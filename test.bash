#!/usr/bin/env bash

function init_work_dirs() {
  echo
  echo 'init work directory...'
  local dirs=("$HOME/Code/Projects/Sneaker" "$HOME/Code/Projects/front-end" "$HOME/Code/Projects/back-end" "$HOME/Code/env")
  for dir in "${dirs[@]}"; do
    [ -d "$dir" ] || mkdir -p "$dir"
  done
  echo 'work directory done...'
}


function init_brew() {
  if ! command -v brew &>/dev/null; then
    echo "brew could not be found"
    echo "install brew, we will ask for user password"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

function init_utils_by_brew_test() {
  if ! command -v brew &>/dev/null; then
    echo 'init utils fail...'
    return
  fi

  BREW_PREFIX=$(brew --prefix)

  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
#  brew install coreutils
#  ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

  # Install some other useful utilities like `sponge`.
  #brew install moreutils

  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  #brew install findutils

  # Install GNU `sed`
  #brew install gnu-sed

  if [ $SHELL_CONFIG_FILE == '.zshrc' ]; then
    # Install a modern version of Zsh.
    brew install zsh zsh-completions
  else
    # Install a modern version of Bash.
    brew install bash bash-completion2
  fi

  # common tools
#  brew install wget
#  brew install vim
#  brew install grep
#  brew install openssh
#  brew install screen
#  brew install ack
  brew install git
#  brew install curl

#  brew install --cask oracle-jdk
  #brew install maven
  #brew install gradle

#  brew install --cask docker
#
#  brew install --cask iterm2
#
#  brew install --cask webstorm
#  brew install --cask visual-studio-code

  brew install nvm
}

function init_git_test() {
  if ! command -v git &>/dev/null; then
    echo 'git could not be found'
    return
  fi
  echo 'init your git config...'
  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"

  # 生成公钥
  ssh-keygen -o

  echo 'git config done...'
}

function init_nvm_test() {
  echo 'init nvm'

  if [ ! -e "$HOME/${SHELL_CONFIG_FILE}" ]; then
    touch "$HOME/${SHELL_CONFIG_FILE}"
    echo "file not found... create file $HOME/${SHELL_CONFIG_FILE}"
  fi

  if ! [[ $NVM_DIR == "$HOME/.nvm" ]]; then
    echo -n '
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
  ' >>"$HOME/${SHELL_CONFIG_FILE}"

    # shellcheck source=/dev/nul
    source "$HOME/${SHELL_CONFIG_FILE}"

    nvm install node
  fi

  echo 'init nvm done'
}

function test() {
  echo "test init mac ..."

  init_work_dirs
  if ! command -v curl &>/dev/null; then
    echo 'curl could not be found'
    exit
  fi

  init_brew
  init_utils_by_brew_test

  init_git_test
  init_nvm_test

  echo 'done...'
}

test
