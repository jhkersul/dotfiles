# ZSH Theme
ZSH_THEME="robbyrussell"

# Zsh Plugins
plugins=(
  git
  vi-mode
  docker
  history-substring-search
  zsh-autosuggestions
)

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# Tmux Main Editor
export EDITOR='vim'

# My private keys, that is on a private file (not shared)
source ~/.private-keys

# Aliases
alias undo_not_pushed_commit="git reset HEAD~1"
alias reset_staging_branch="gco master && gl && gco staging && git reset --hard master && git push --force origin staging"
alias vim=nvim

