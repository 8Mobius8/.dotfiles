#!/usr/bin/env bash

[ -z ${NVM_DIR} ] && . "/usr/local/opt/nvm/nvm.sh"

# Powerline Daemon and bash setup
if [ -d /usr/local/lib/python3.6/site-packages/powerline ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
fi

## iterm2 Integration 
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
