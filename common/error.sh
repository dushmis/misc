error() {
  if [ $# != 0 ]; then
    echo -en '\e[0;31m' >&2
    echo "$@" | fold -s >&2
    echo -en '\e[0m' >&2
  fi
}

