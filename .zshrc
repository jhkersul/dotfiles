# ZSH Theme
ZSH_THEME="robbyrussell"

# Zsh Plugins
plugins=(git vi-mode docker history-substring-search)

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# My private keys, that is on a private file (not shared)
source ~/.private-keys

# Aliases
alias undo_not_pushed_commit="git reset HEAD~1"

