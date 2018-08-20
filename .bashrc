
function docker-rm-all() {
  docker rm -f $(docker ps -a --format {{.ID}} | paste -s -d ' ' -)
}
