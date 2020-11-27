#!/usr/bin/env bash

echo "init your mac..."

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]}")
CURRENT_DIR=$(cd "$CURRENT_DIR" && pwd)


if ! command -v curl &> /dev/null; then
    echo "curl could not be found"
    exit
fi

# create work's directory
dirs=("$HOME/Code/projects/shell" "$HOME/Code/env")

for dir in "${dirs[@]}"; do
    [ -d "$dir" ] || mkdir -p "$dir"
done

if ! command -v brew &>/dev/null; then
    echo "brew could not be found"
    echo "install brew, we will ask for user password"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

#echo "change default shell"

BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
#brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
#brew install findutils

# Install GNU `sed`
#brew install gnu-sed

# Install a modern version of Bash.
brew install bash
brew install bash-completion2

## Switch to using brew-installed bash as default shell
#if ! grep -F -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
#    echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
#    chsh -s "${BREW_PREFIX}/bin/bash"
#fi


cd "$CURRENT_DIR" || exit

# common tools
#brew install wget
#brew install vim
brew install grep
brew install openssh
#brew install screen
#brew install ack
brew install git
brew install curl

# openjdk
brew install --cask oracle-jdk
#brew install maven
#brew install gradle

# docker
brew install --cask docker

# terminal
brew install --cask iterm2

# IDE
brew install --cask webstorm
brew install --cask visual-studio-code

# nvm
brew install nvm

#nvm install node

echo "done.."
