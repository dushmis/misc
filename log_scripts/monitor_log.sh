#!/bin/bash

set -e

for_a_while=1;
this_file=${1:-/dev/null};
toemail=${2:-test@me.com}
mdir="$HOME/.moni";

if [[ ! -d "$mdir" ]]; then
  mkdir "$mdir";
fi

token_file="$mdir/$(basename "$this_file")_token";

if [[ ! -e "$this_file" ]]; then
  echo "$this_file: No such file or directory";
  exit 1;
fi

if [[ ! -e "$token_file" ]]; then
  touch "$token_file";
fi

while :;
do
  if [[ "$this_file" -nt "$token_file" ]]; then
    dt="$(date +"%c")";
    dt="${dt// /_}";
    mail -s "$this_file changed - $dt" "$toemail" <<< "$(tail -10 "$this_file")";
    cat > "$token_file" /dev/null;
    echo "file changed...";
  fi
  sleep $for_a_while;
done

