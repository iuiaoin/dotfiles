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
  echo "| |  | |/ _ \/ __| |/ _\` | '_ \\  |  __| | '_ \\ \\ / / "
  echo "| |__| |  __/ (__| | (_| | | | | | |____| | | \\ V /     "
  echo "|_____/ \\___|\\___|_|\\__,_|_| |_| |______|_| |_|\\_/   "
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
  echo "* Installing ZSH Custom Plugins:"
  echo ""
  echo "  - fzf-tab"
  echo "  - zsh-autosuggestions"
  echo "  - fast-syntax-highlighting"
  echo "  - zsh-z"
  echo "-----------------------------------------------------------"

  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z
}

brew_bundle() {
  brew bundle
}

install_nodejs() {
  echo "==========================================================="
  echo "              Setting up NodeJS Environment"

  eval $(fnm env --shell zsh)
  fnm install --lts

  # Set NPM Global Path
  export NPM_CONFIG_PREFIX="$HOME/.npm-global"
  # Create .npm-global folder if not exists
  [[ ! -d "$NPM_CONFIG_PREFIX" ]] && mkdir -p $NPM_CONFIG_PREFIX

  echo "-----------------------------------------------------------"
  echo "* Installing NodeJS LTS..."
  echo "-----------------------------------------------------------"

  fnm install --lts

  echo "-----------------------------------------------------------"
  echo -n "* NodeJS Version: "

  node -v

  __npm_global_pkgs=(
    hexo-cli
    vercel
    pure-prompt
    npm-why
    npm
    serve
    yarn
  )

  echo "-----------------------------------------------------------"
  echo "* npm install global packages:"
  echo ""

  for __npm_pkg ($__npm_global_pkgs); do
    echo "  - ${__npm_pkg}"
  done

  echo "-----------------------------------------------------------"

  for __npm_pkg ($__npm_global_pkgs); do
    npm i -g ${__npm_pkg}
  done
}

zshrc() {
  echo "==========================================================="
  echo "                  Import Declan env zshrc                   "
  echo "-----------------------------------------------------------"

  cat $HOME/dotfiles/_zshrc/macos.zshrc > $HOME/.zshrc
  cat $HOME/dotfiles/_alacritty/.alacritty.toml > $HOME/.alacritty.toml
}

finish() {
  echo "==========================================================="
  echo -n "* Clean up..."

  cd $HOME
  rm -rf $HOME/dotfiles

  echo "Done!"
  echo ""
  echo "> Declan Enviroment Setup finished!"
  echo "> Do not forget run those things:"
  echo ""
  echo "- chsh -s /usr/local/bin/zsh[intel based]"
  echo "- chsh -s /opt/homebrew/bin/zsh[arm based]"
  echo "- npm login"
  echo "- git-config"
  echo "- mas install 1258530160"
  echo "- mas install 1572457968"
  echo "==========================================================="

  cd $HOME
}

start
install_homebrew
install_packages
clone_repo
setup_omz
brew_bundle
install_nodejs
zshrc
finish