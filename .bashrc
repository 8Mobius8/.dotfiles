if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

set -o vi

function docker-rm-all() {
  docker rm -f $(docker ps -a --format {{.ID}} | paste -s -d ' ' -)
}

source mobius-prompt.sh

# Aliases for ease of use for Mobius work
alias tmux-start="tmux new -s _"

## BASH HISTORY SETUP ##

# Append to history instead of overriding.
shopt -s histappend

HISTFILE=~/.bash_history

# Setting this to a negitive number will result it the history file never
# being truncated (Unlimited history)
HISTFILESIZE=-1
# Ignore commands, each command is seperated by ':'
# Using the space and tab characters to ignore commands that start
# with spaces or tabs. Simple way to have some privacy instantly.
HISTCONTROL="ignoreboth:[ \t]*"

