source ~/.profile.private

if [[ -x $(which brew) ]]; then
  export BREW_PREFIX=$(brew --prefix)
fi

# GNU coreutils overriding OS X natives
if [[ $BREW_PREFIX != "" ]]; then
  PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
  MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# GO
export GOROOT=/usr/local/Cellar/go/1.11.2/libexec
export PATH=$PATH:$GOROOT/bin:$HOME/go/bin

# NodeJS
[ -d ~/.nvm ] && . "/usr/local/opt/nvm/nvm.sh"

# setup my personal bin for Mark made scripts
[[ -L "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

