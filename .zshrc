export ZSH="/home/mobius/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=(git)

export PATH=/home/linuxbrew/.linuxbrew/sbin:/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=$PATH:$HOME/bin:/usr/local/go/bin


if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

export CDPATH="$CDPATH:/d/workspace/go/src:/d/workspace"

export EDITOR="vim"
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

alias gut="godot --debug-collisions --path $PWD -d -s addons/gut/gut_cmdln.gd"

#export GOPATH="/d/workspace/go/src"
export GOPATH=""
export PATH="$(go env GOPATH)/bin":$PATH

source $ZSH/oh-my-zsh.sh

alias open=explorer.exe

function godot-dev-on() {
  pushd $1
  explorer.exe .
  explorer.exe /d/Dropbox/Assets/OvisMade/
  godot -e .
}


PROG=croc
_CLI_ZSH_AUTOCOMPLETE_HACK=1
source /etc/zsh/zsh_autocomplete_croc

