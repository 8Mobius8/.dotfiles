source ~/.profile.private

# GNU coreutils overriding OS X natives
if [[ $BREW_PREFIX != "" ]]; then
  BREW_COREUTILS=$(brew --prefix coreutils) > /dev/null 2>&1
  if [ -n $BREW_COREUTILS ]; then
    PATH="$BREW_COREUTILS/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
    MANPATH="$BREW_COREUTILS/libexec/gnuman:$MANPATH"
  fi
fi

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# GO
export GOROOT=/usr/local/Cellar/go/1.10.1/libexec
export PATH=$PATH:$GOROOT/bin:$HOME/go/bin

# NodeJS
export NVM_DIR="$HOME/.nvm"

# setup my personal bin for Mark made scripts
[[ -L "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

