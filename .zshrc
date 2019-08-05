# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="robbyrussell"

# Zsh Plugins
plugins=(
  git
)

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# Locale
export LC_ALL=en_US.UTF-8

# My private keys, that is on a private file (not shared)
source ~/.private-keys

# NVM Config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Rbenv Init
eval "$(rbenv init -)"

# JAVA HOME
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

# Python Path
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH=/usr/local/opt/python/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kersul/Develop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kersul/Develop/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kersul/Develop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kersul/Develop/google-cloud-sdk/completion.zsh.inc'; fi

