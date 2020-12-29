#!/bin/bash

BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

function printStep {
  echo -e "\n${BLUE}$1${NC}"
}

function printError {
  echo -e "\n${RED}$1${NC}"
}

function installRubyRbenv {
  brew install rbenv
  rbenv init
  printStep "Installing latest ruby..."
  rbenv install $(rbenv install --list-all | grep -v - | tail -1)
  printStep "Installing neovim gem..."
  gem install neovim
}

function installNode {
  brew install node
  printStep "Installing neovim npm package..."
  npm install -g neovim
}

function installPip {
  printStep "Installing pip2..."
  curl https://bootstrap.pypa.io/get-pip.py -o $TMPDIR/get-pip.py
  python2 $TMPDIR/get-pip.py

  printStep "Installing python3..."
  brew install python@3
  python3 $TMPDIR/get-pip.py


  printStep "Installing pip packages..."
  pip2 install neovim
  pip3 install neovim
}

function installMacOSLibs {
  which -s brew
  if [[ $? != 0 ]] ; then
    printError "You need brew installed"
    exit
  fi

  printStep "Updating brew..."
  brew update

  printStep "Installing neovim..."
  brew install neovim

  printStep "Installing tmux..."
  brew install tmux

  printStep "Installing ripgrep..."
  brew install ripgrep

  printStep "Installing rbenv..."
  installRubyRbenv

  printStep "Installing node..."
  installNode

  printStep "Installing python..."
  installPip
}

printStep "## Install required libs (Only for MacOS) ##"

if [ "$(uname)" == "Darwin" ]; then
  installMacOSLibs
else
  printError "Unsupported OS"
  exit
fi

printStep "\n## Starting to copy configuration files ##"

echo -e ""
read -p "Copy tmux config files? [~/.tmux.conf] (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp tmux/tmux.conf ~/.tmux.conf
fi

echo -e ""
read -p "Copy tmuxinator config files? [~/.config/tmuxinator/] (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp -R tmux/tmuxinator ~/.config
fi

echo -e ""
read -p "Copy nvim config files? [~/.config/nvim/] (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp -R nvim ~/.config
fi

echo -e ""
read -p "Copy zshrc file? [~/.zshrc] (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp terminal/zshrc ~/.zshrc
fi

echo -e ""
read -p "Copy vscode config files? [~/Library/Application Support/Code/User] (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp -R vscode/User ~/Library/Application\ Support/Code
fi

echo -e ""
read -p "Copy ideavimrc config file? [~/.ideavimrc] (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp intellij/ideavimrc ~/.ideavimrc
fi

