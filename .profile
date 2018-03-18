# GNU coreutils overriding OS X natives
if [[ $BREW_PREFIX != "" ]]; then
  BREW_COREUTILS=$(brew --prefix coreutils) > /dev/null 2>&1
  if [ -n $BREW_COREUTILS ]; then
    PATH="$BREW_COREUTILS/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
    MANPATH="$BREW_COREUTILS/libexec/gnuman:$MANPATH"
  fi
fi

# setup my personal bin to override all
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
