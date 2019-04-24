if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

set -o vi

function docker-rm-all() {
  docker rm -f $(docker ps -a --format {{.ID}} | paste -s -d ' ' -)
}

source mobius-prompt.sh
