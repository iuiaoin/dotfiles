#!/bin/zsh

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "No macOS detected!"
  exit 1
fi

start() {
  clear

  echo "========================================================="
  echo " _____            _               ______                 "
  echo "|  __ \          | |             |  ____|                "
  echo "| |  | | ___  ___| | __ _ _ __   | |__   _ ____   __     "
  echo "| |  | |/ _ \/ __| |/ _` | '_ \  |  __| | '_ \ \ / /     "
  echo "| |__| |  __/ (__| | (_| | | | | | |____| | | \ V /      "
  echo "|_____/ \___|\___|_|\__,_|_| |_| |______|_| |_|\_/       "
  echo "                                                         "
  echo "========================================================="
  echo "        !! ATTENTION !!"
  echo "YOU ARE SETTING UP: Declan Environment (macOS)"
  echo "==========================================================="
  echo ""
  echo -n "* The setup will begin in 3 seconds... "

  sleep 3

  echo -n "Times up! Here we start!"
  echo ""

  cd $HOME
}

# xcode command tool will be installed during homebrew installation
install_homebrew() {
  echo "==========================================================="
  echo "                     Install Homebrew                      "
  echo "-----------------------------------------------------------"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

install_packages() {
  # Only install required packages for setting up enviroments
  # Later we will call brew bundle
  __pkg_to_be_installed=(
    curl
    fnm
    git
    jq
    wget
    zsh
  )

  echo "==========================================================="
  echo "* Install following packages:"
  echo ""

  for __pkg ($__pkg_to_be_installed); do
    echo "  - ${__pkg}"
  done

  echo "-----------------------------------------------------------"

  brew update

  for __pkg ($__pkg_to_be_installed); do
    brew install ${__pkg} || true
  done
}

clone_repo() {
  echo "-----------------------------------------------------------"
  echo "* Cloning iuiaoin/dotfiles Repo from GitHub.com"
  echo "-----------------------------------------------------------"

  git clone https://github.com/iuiaoin/dotfiles.git

  cd ./dotfiles
  rm -rf .git
}

setup_omz() {
  echo "==========================================================="
  echo "                      Shells Enviroment"
  echo "-----------------------------------------------------------"
  echo "* Installing Oh-My-Zsh..."
  echo "-----------------------------------------------------------"

  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

  echo "-----------------------------------------------------------"
  echo "* Installing ZSH Custom Plugins & Themes:"
  echo ""
  echo "  - zsh-autosuggestions"
  echo "  - fast-syntax-highlighting"
  echo "  - zsh-gitcd"
  echo "  - p10k zsh-theme"
  echo "  - zsh-z"
  echo "-----------------------------------------------------------"

  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/fzf-tab
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  git clone https://github.com/mafredri/zsh-async.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-async
  git clone https://github.com/sukkaw/zsh-gitcd.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-gitcd
  git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

brew_bundle() {
  brew bundle
}