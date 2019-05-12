#!/bin/bash

# TODO Everything here... 

function readYes() {
  until [[ $REPLY == "Y" || $REPLY == "N" ]]; do
    printf "%s [Y,N]: " "$1"
    read
  done
  if [ $REPLY = "Y" ]; then
    eval "ENABLE_$2=true" 
  else
    eval "ENABLE_$2=false" 
  fi
  unset REPLY
}

readYes "Would you like to install homebrew?" HOMEBREW
if ( $ENABLE_HOMEBREW ); then 
  echo "Installing homebrew..."
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Listing everything from the Brewfile..."
  brew bundle list --all

  readYes "Would you like to use 'brew bundle' to install the above?" HOMEBREW_BUNDLE 
  if ( $ENABLE_HOMEBREW_BUNDLE ); then
  brew bundle --file=./Brewfile
  fi
fi

