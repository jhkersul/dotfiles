# Kersul Dotfiles

These are my dotfiles.

It doesn't have the purpose to be general used,
but maybe you can get some insights to create yours.

## Installation Script (Only OSX)

The installation script is responsible to install packages (using brew).

It also copy the configuration files to the correct folders.

```bash
./install.sh
```

## Required Packages

- Python 2 and 3
- pip 2 and 3
- ripgrep

## Commands to run after installation

### Install NeoVim Plugins

Run inside NeoVim:

```vim
:PlugInstall
```

