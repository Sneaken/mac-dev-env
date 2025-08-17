#!/usr/bin/env bash

SHELL_CONFIG_FILE='.zshrc'

function init_work_dirs() {
  echo
  echo 'init work directory...'
  local dirs=("$HOME/Code/Projects/Sneaken" "$HOME/Code/Projects/front-end" "$HOME/Code/Projects/back-end" "$HOME/Code/config" "$HOME/Code/env")
  for dir in "${dirs[@]}"; do
    [ -d "$dir" ] || mkdir -p "$dir"
  done
  echo 'work directory done...'
  echo
  echo
}

function init_brew() {
  if ! command -v brew &>/dev/null; then
    echo "brew could not be found"
    echo "install brew, we will ask for user password"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

function init_utils_by_brew() {
  if ! command -v brew &>/dev/null; then
    echo 'init utils fail...'
    return
  fi

  BREW_PREFIX=$(brew --prefix)

  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  brew install coreutils
  ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

  # Install a modern version of Zsh.
  brew install zsh zsh-completions

  brew install volta
  init_volta
  #  brew install wireguard-tools
  brew install redis
  brew install mysql
  brew install nginx

#  brew install --cask flutter
#  brew install --cask docker

#  brew install --cask iterm2
  brew install --cask warp

  # 开发相关
  brew install --cask webstorm
  brew install --cask intellij-idea
  brew install --cask visual-studio-code
  brew install --cask datagrip
  brew install ollama
#  brew install --cask transmit

# 调试相关
brew install wireshark
brew install wireshark-app
brew install --cask proxyman
brew install --cask apifox
# 需要 node 环境
# brew install whistle

# 输入法
# brew install --cask wetype

# 社交软件
#  brew install --cask qq
#  brew install --cask wechart

# 文档类
brew install --cask obsidian
brew install --cask excalidrawz
#brew install --cask tencent-docs
#brew install --cask wpsoffice-cn

# 视频
brew install --cask iina
}

function init_git() {
  if ! command -v git &>/dev/null; then
    echo 'git could not be found'
    return
  fi

  local choice
  echo -n '
Do you need to initialize git ？

Please Enter to continue Or no to abort...
'
  read -r choice
  case $choice in
  [nN]*)
    return
    ;;
  *)
    ;;
  esac
  local GIT_USER_NAME
  local GIT_USER_EMAIL

  echo 'init your git config...'
  echo
  echo
  echo -n 'please enter your username: '
  read -r GIT_USER_NAME
  git config --global user.name "$GIT_USER_NAME"
  echo
  echo
  echo -n 'please enter your email: '
  read -r GIT_USER_EMAIL
  git config --global user.email "$GIT_USER_EMAIL"
  echo
  echo
  # 生成公钥
  ssh-keygen -o

  echo 'git config done...'
}

function init_volta() {
  echo 'init volta'
  if ! [[ $VOLTA_HOME == "$HOME/.volta" ]]; then
    echo '
export VOLTA_HOME=\"$HOME/.volta\"
export PATH=\"$VOLTA_HOME/bin:$PATH\"
  ' >>"$HOME/${SHELL_CONFIG_FILE}"

    # shellcheck source=/dev/nul
    source "$HOME/${SHELL_CONFIG_FILE}"

    volta install node
    volta install node@12
    volta install node@14
    volta install node@16
  fi

  echo 'init volta done'

  if ! command -v node &>/dev/null; then
    echo 'node could not be found'
    return
  fi
  echo
  echo
  echo 'install yarn...'
  volta install yarn
  echo 'install pnpm...'
  volta install pnpm
}

#function init_java() {
#  curl -s "https://get.sdkman.io" | bash
#}

function main() {
  echo 'init your mac...'

  init_work_dirs

  if ! command -v curl &>/dev/null; then
    echo 'curl could not be found'
    exit
  fi

  init_brew
  init_utils_by_brew

  init_git


  # install oh my zsh
  # oh my zsh 一定要放到最后安装 不然貌似会出现奇怪的事情
  echo 'install oh my zsh'
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo 'oh my zsh install done...'
  echo
  echo
  echo 'done...'

  # shellcheck source=/dev/null
  source "$HOME/${SHELL_CONFIG_FILE}"
}

main
