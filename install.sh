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

function installMacOSLibs {
  which -s brew
  if [[ $? != 0 ]] ; then
    printError "You need brew installed"
    exit
  fi

  printStep "Updating brew..."
  brew update
  printStep "Installing ripgrep..."
  brew install ripgrep
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
read -p "Copy tmux config files? (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp tmux/tmux.conf ~/.tmux.conf
fi

echo -e ""
read -p "Copy tmuxinator config files? (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp -R tmux/tmuxinator ~/.config
fi

echo -e ""
read -p "Copy nvim config files? (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp -R nvim ~/.config
fi

echo -e ""
read -p "Copy zshrc file? (y/n)? " choice
if [ "$choice" = "y" ]; then
  cp terminal/zshrc ~/.zshrc
fi

